Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC8C4151A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622972190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="n6EQosBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfBGNAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:00:42 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53075 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfBGNAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:00:42 -0500
Received: by mail-it1-f194.google.com with SMTP id d11so14552000itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 05:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jdwtFVHtqcTomwKecTvSfX3MWcOsI2t00sw8LWYIymc=;
        b=n6EQosBNT26TT+SF8OI320OBiRfw6S2DKdjf16oDZkYk21d1HPHOYKB3/t/L4+4Fvp
         pVk0biAY+8U0RYMzhi+trHo4LENjkluh48Bkua9qxOPFRjolLau+nF2kLTac2dhG2tBt
         KUCAr5NnUCOA1uesxyZWkVB+a2iPSKXPMAeF/i90RsAGzM5022EPT9qgyIUpT+pujjxZ
         STds0gAELmwoZ+JN845gHwlFPNpfAarf2wJV40/DBFpeXTuT2XK0sOazUGkRVrTtLyZ1
         OA6Gf/DHOKQ+GD/U2AlIiAr8dM+TCnoIYuZG9ZFN+3q5+oVubpVc3apoup4kbg9AWIIY
         JBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jdwtFVHtqcTomwKecTvSfX3MWcOsI2t00sw8LWYIymc=;
        b=MUkCZJ25972gjI8k1rPKREDPMnvdLXQnzr8DmEO821vVk8MN7hcI7tsRBGtzF1E6Pi
         l7wnFl+IJNMdzQmmZd1V//eypeRQY18ouwg0acJCEzJuWDj/3IHcLAFEgVHl3/APidbq
         y/YUfBazJ4Ik63mHfVu5KQaE1LuFIyOjcvgCpwdD0nqUBuuljV59pfI8hnfvnlCHXuF/
         JRf3fdDG3e0+tpqdKRLcXhan8oGO1zf0WRw2lkylLtAEi+ePO9Un716GQd3nZzyuMAcy
         D6y+ARJq5hoAVGM9i9c9XcCKuXrouGm+pM9noOoq8iKVYcc7WK5ViaBGL1U4rzi1J2+h
         9dDg==
X-Gm-Message-State: AHQUAubA+2pJZnQJaNOZsJzHvi3KtjjQjagl/wfzq+3f+KuIP7HAEZx+
        UA8pNmRTrJZORmQ00twT3ZyPQA==
X-Google-Smtp-Source: AHgI3IagHFVnIw7L7pxm0p26JsUWreHsDih0Q5lotVAp408L7IHAFpUKkG3xzuItCCrEW7W1Vm6cOg==
X-Received: by 2002:a24:710:: with SMTP id f16mr4396585itf.121.1549544441327;
        Thu, 07 Feb 2019 05:00:41 -0800 (PST)
Received: from [10.0.0.135] (24-212-162-241.cable.teksavvy.com. [24.212.162.241])
        by smtp.googlemail.com with ESMTPSA id z133sm5748342itb.36.2019.02.07.05.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 05:00:40 -0800 (PST)
Subject: Re: [PATCH net-next 0/2] Change tc action identifiers to be more
 consistent
To:     Eli Cohen <eli@mellanox.com>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     simon.horman@netronome.com, jakub.kicinski@netronome.com,
        dirk.vandermerwe@netronome.com, francois.theron@netronome.com,
        quentin.monnet@netronome.com, john.hurley@netronome.com,
        edwin.peer@netronome.com
References: <20190207074549.29861-1-eli@mellanox.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <7a113460-5a0f-85c6-b42d-42468967b6f6@mojatatu.com>
Date:   Thu, 7 Feb 2019 08:00:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190207074549.29861-1-eli@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-07 2:45 a.m., Eli Cohen wrote:
> This two patch series modifies TC actions identifiers to be more consistent and
> also puts them in one place so new identifiers numbers can be chosen more
> easily.
> 

For the series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
