Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55239C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033232098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="dMMUbJqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033232098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJDQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:42:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42708 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJDQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:42:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id s10-v6so6288708lfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DDeY0dPWDxSpK367n5h+aKcVcNLKZpfVz1OOA/1NiqU=;
        b=dMMUbJqykFl4n4qA0+oB9OE7EmksGT9CJka7+3BbLOkiKbAk3iQ6Zzud6N7v0oa6zv
         XKLv2buTsMYi4HZZCfI67Ehs0hyuaZZWA+KXzHV+A6fpqRojWidHudeiuiZcqEWddYtY
         w4+R8Qs7o5RJQB6yJnAxplcY5zeeVWNCzbppMgvEo1mvbE7mZauRUdhTD1Fcq3Dbqw6K
         Xh9oYHvgBQdQLlDOP3xw1l5ysnz4aK8pH7qpJd07OIqqGBakNaI2gDD1X4eyHbYC+f08
         c+upFQb7EYZJI0i5544evMnRFsbp2UqTnccsmrJP8Is/izWYxxP2sI56x5l6+7WAaHrq
         mwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DDeY0dPWDxSpK367n5h+aKcVcNLKZpfVz1OOA/1NiqU=;
        b=cVgSsX3aap3m2nZrzoi9H1Eiq0Q2kIbU0QZfIC95huG1m3SWS6Tso55zeuCEwhbchg
         mlldnGxYTBU6wj1VnrWcg6wDV2QWp1ami3gfp7tYx2d2eVQTpjS3C0u5LWXYbMB3th2p
         uxkWeWWVdzviVQft4yVj9xmlEVgz1easgho7TOl05FSXL0KVMOV52/SjgnvZNa4L1D1V
         ydUGR5yaK4n5/SRlhtN4a5IwAZlD0KKZ87iXX5ANekFhc0bdxIjZJ8yVRRy974hktQAo
         1mp2SMXsLhCCGBU8lXWGWGpydaza0Wa3SZ3VhClU0iTwpRjsMtMmG1ngrPEFWcslOCtn
         o9iA==
X-Gm-Message-State: ABuFfogo5J0NTXsKPiPCNd9YFe8P+2F8q+7/jD48Li9pHZzHX/7mXXTc
        s4yxbXsr31TxlNYuw+AJnP5jKzkZ/fA=
X-Google-Smtp-Source: ACcGV60kWpN/e9EujE/c7bdBhbGKu8/xgNru6bGcQbtRpALMsnoA6EpRxfZgcVVOe6ppwusD2Dz0uQ==
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr3184141lfg.149.1538646618612;
        Thu, 04 Oct 2018 02:50:18 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.83.191])
        by smtp.gmail.com with ESMTPSA id v18-v6sm881731lja.26.2018.10.04.02.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:50:17 -0700 (PDT)
Subject: Re: [PATCH net] net: mvpp2: Extract the correct ethtype from the skb
 for tx csum offload
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
References: <20181004080308.7687-1-maxime.chevallier@bootlin.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <13fb6bd4-db67-6c35-9e6d-09ed89e10a45@cogentembedded.com>
Date:   Thu, 4 Oct 2018 12:50:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004080308.7687-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/4/2018 11:03 AM, Maxime Chevallier wrote:

> When offloading the L3 and L4 csum computation on TX, we need to extract
> the l3_proto from the ethtype, independently of the presence of a vlan
> tag.
> 
> The actual driver uses skb->protocol as-is, resulting in packets with
> the wrong L4 checksum being sent when there's a vlan tag in the packet
> header and checksum offloading is enabled.
> 
> This commit makes use of vlan_protocol_get() to get the correct ethtype
> regardless the presence of a vlan tag.
             ^ of?

> Fixes: 3f51850 ("ethernet: Add new driver for Marvell Armada 375 network unit")

     12 hex digits needed here.

> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

[...]

MBR, Sergei
