Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6DAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87D1214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="fyYSVivn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87D1214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeHVMUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:20:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42414 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbeHVMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:20:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so849688ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DMU8n02wNjUCcxENd6tSC6Gpe4nfhk7LhQGRpvDp1nA=;
        b=fyYSVivn07xUsaHvWzxUH1VGcyzChkNqHCAOrmw4Gei+0RArdvYq1aMDIDo2aNy4J3
         ersAjItpL1s/BoK0Tuwf/IOZ0fAZXKJI3152/gj7rpIUuvygwigQ7A0ePZeeE29JC7AU
         25GLG1rLKsKpYyj6mshMlhbnpgWROflvAe6P+tzUBTqtO6f4+3F6t9pHB5ullsGDawdP
         w7dWtelTdq9257QK7d3bJftFcWFf1oOyYXZMa9sG2kBWgpcDD7bjkcOR8OI+ihXxQme2
         KvGjou+O/Qrr8N8gYFIQm1W9y+/3cSQmTUsBRvrb2PMUlWMLwH3dD8Vb4cG8o6TbNpDz
         BoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DMU8n02wNjUCcxENd6tSC6Gpe4nfhk7LhQGRpvDp1nA=;
        b=UN57HiMQxFZ318MIRX9lbwQPRBc9H6MUFa7XG614Rnq5D1/02X0Yq0sEX+EfVUhuAU
         v4t6qwTAWsPRDLg406+tbxi16GDdOXNlcIv/o8r3V4RoynwXg8K/QtCGGVFvDp6WEwHX
         FjCq0EOYCAeghVLqd97ibIoEmzPTZ90M5eL5D8TakUzjybfr+1zJFdaGcz6dwi+/W8vp
         8gJg7qNPYJGxO/LZ5zZWJBP6bIcgrrIV0Eq9gPALzqKOyco28pz062tpKC1uFoGBIcj0
         c8CX1tgxNDjoqH++MsU5qkLrFuMoZ0NJ6VLzpowgwaOlyihz1idtK/cU9Fwlzgp6Pha2
         2DZw==
X-Gm-Message-State: APzg51BhH3D2q6xQsYwRU46k2TO/Xh0dZCeBGk3JxHiej+sKtmGhK7H4
        zaxF2T7o13fMcexoDDmm1/eLSSBngEI=
X-Google-Smtp-Source: ANB0VdZvSprveFT0q4D1Z5jhSEtJ6HirjhyWf/Z5pzh3RNOIYgRqQbCWx8wxql1HraXxBej6oAnq/w==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr1410911lji.17.1534928188809;
        Wed, 22 Aug 2018 01:56:28 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.82.136])
        by smtp.gmail.com with ESMTPSA id g16-v6sm211429lfb.5.2018.08.22.01.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 01:56:27 -0700 (PDT)
Subject: Re: [PATCH 06/11] net: ethernet: renesas: use SPDX identifier for
 Renesas drivers
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-7-wsa+renesas@sang-engineering.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <cfec965a-5a6a-8277-3f67-58be912f73a0@cogentembedded.com>
Date:   Wed, 22 Aug 2018 11:56:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821220233.9202-7-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 8/22/2018 1:02 AM, Wolfram Sang wrote:

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

[...]

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
