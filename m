Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78341C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F370219A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qciUDuAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F370219A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeHRAUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:20:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36001 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeHRAUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:20:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so4015126pfo.3;
        Fri, 17 Aug 2018 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a7/0f8BsyiC8LpzPDcgZYwjLsnyDEFbIn8KHZIQb0ws=;
        b=qciUDuAGF2RiGhLSvZf2MsrYquNeH40PyE9naqWQClfV5qd+B47mn/pX3G2Vs0jXuA
         ZScAS2Ak3Fdmn4hUTZobevGi4RRR7ycd6pd/DA0LquPm/uhey7NkduIMyxJMkUL7xdVp
         FYJQ/CxSJyclh82k4+z37i3o9Py/yTDBIkjHUMM8fEMbZeTLLMLxsVQYeBb+zAnyoJsX
         7k3yLl4CwIDgjpuixibW1+FvTOiSwh50xu4JZ9WHq1zhZjTlmoOdubdpiiRkomdS07wx
         LHUSEXcg94X6ZtHKTZl0CBc6Ic+ot6PXNBJ7R+dltXUNWI7DzG3ogDvGM7k357WUg0B+
         Qt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a7/0f8BsyiC8LpzPDcgZYwjLsnyDEFbIn8KHZIQb0ws=;
        b=O0BqihMFJL+Kyz5Vq6aBSbh1WUlOmmVunPGyDDxsa2iL81wfgCRPPjywHu1c3llWkH
         8fwjoeA9Rtdiprf98TznVrXV6CytTYOeN/IPt+eHo/fCmWfv8+Xejy/mo0w9/Eo85dBD
         fFly1RVhtAQqqFBxRuHlMrsfI2YSUemSLbe7ZVZaqZMQSmBTmlGap/iLVVjcpbxgBGGW
         TQcyn9twunqmJj0bWsmhWAPvNCoIJzD0kLdnd4WagJWTvkZd43+C6ToM24Dw318gkRG/
         8p2BBiQcI5gjgi2B4qJyuvOPGowXylDXOG5MmikoR6cDX83rb9Dw0Tx9SH2RGhtrfDE/
         AT4w==
X-Gm-Message-State: AOUpUlHk66IAO197pmbEUhWbw14h6GH43iQAquBXislcAbdOV8kUrTkI
        hP8Cel50a3fD3wUacsujCKE=
X-Google-Smtp-Source: AA+uWPwD3G1Gu6+8y0IQeviBTDTazVFO5cgTDsq2bm0zv4hGAe39kCQSRSRScCWldWQ6yLXD+H+S5w==
X-Received: by 2002:a63:b349:: with SMTP id x9-v6mr34432368pgt.337.1534540504651;
        Fri, 17 Aug 2018 14:15:04 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:94ef:9ac:271f:7a47])
        by smtp.googlemail.com with ESMTPSA id i62-v6sm4514691pge.66.2018.08.17.14.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 14:15:03 -0700 (PDT)
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
To:     Jason Wang <jasowang@redhat.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
 <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
 <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
 <20180814121734.105769fa@redhat.com>
 <03ab3b18-9b13-8169-7e68-ada307694bc1@redhat.com>
 <08bf7aec-078a-612d-833f-5b3d09a289d0@gmail.com>
 <aa9cf883-7822-70a7-5ab5-c873b69c2098@redhat.com>
 <f4c0346d-6665-5312-0310-ffbda505b7ec@gmail.com>
 <2792239a-ed3b-d66e-0c1c-e99455311eff@redhat.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <ae0e09a1-a20a-a2fc-36a0-82e109216bf4@gmail.com>
Date:   Fri, 17 Aug 2018 15:15:01 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2792239a-ed3b-d66e-0c1c-e99455311eff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/18 9:34 PM, Jason Wang wrote:
> I may miss something but BPF forbids loop. Without a loop how can we
> make sure all stacked devices is enumerated correctly without knowing
> the topology in advance?

netdev_for_each_upper_dev_rcu

BPF helpers allow programs to do lookups in kernel tables, in this case
the ability to find an upper device that would receive the packet.
