Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD150C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A6620855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD69Tp2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfBHRV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:21:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33403 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBHRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:21:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id z8so1996144plo.0;
        Fri, 08 Feb 2019 09:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dA62nlra0/aD+kLMcQn/LMHtOYaUk7vnUUfqDLXBMmU=;
        b=YD69Tp2HqQT1F4vKzuZ4hZvG+/wtIp9voUeB4kMqvQP1VDAgEjv0MPUsqS8FLGMfh1
         FhbcOX3JUmqNn7Ba0vhuDrPp3+j3vGhQpyscpz9+RZ7P/LAVpMWNfDcMGSzVc7HHjEiM
         fsbwY+4z1pt9mMdZHrfW9ZQmYmnbflO21JDr6yeQ1FRajk1ArHWKZbR5SSwsbYidEnXt
         MtUOCFMJm4Y1/NF2YB6pvxcT0j72pWRruZdJuTzatUAvsa4ZbYBvhpCIPgiMnZipe/Zv
         9oAwbiVCw5JhmZZzbLCa6PBb6ikDkZiFcs5jbfyP1vMweNM/D+J09UwnEAP6By44LaCm
         dZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dA62nlra0/aD+kLMcQn/LMHtOYaUk7vnUUfqDLXBMmU=;
        b=GOc4b3SdkrKgAgrJTrTenowjtaTAfNFpYQ5rjkP8vhtaYURxVOI/hjWYJ7vAq41gqb
         jBMUNpZGRazfZ3zTrt4IDQjHlduyHm1tst/K0YSq9xnJvgcNkm9W04Qwvytv8dgsD17J
         CvUM9tmDOpNkzGZAZ7XPCaYWobY1P5a0RaMyu5+AD88nTwRvW4zX8rzAfxF0Mb9EbgDG
         BLyH/PQRGajOTEyEUeo8aTnpyGaT4BAWG3BRfd1u3c7tnAgLVQUNS76JlO90N0RrFN5t
         F9JI/0Qgo+rsDOHkf61bgF6bQAycGluyBecI70ChrEihzHzIivRWjGu4LymBL1P0OlUI
         TwKw==
X-Gm-Message-State: AHQUAuYpYwkz5I1QxQQI2ctrfGSDllNUudk0wChu+XDjoo3BFWTKXgjO
        sL5uNidYxm+a1piDEfYMhaJq+5NH
X-Google-Smtp-Source: AHgI3IbwBd/p+9FJK8Lvk/Ugun7pJz8qYBh68FAbehB1MEuhorTU5VvwrUjjDy6w6tjlEAKQLLNstg==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr24034124plr.128.1549646486668;
        Fri, 08 Feb 2019 09:21:26 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id o4sm10775576pgs.12.2019.02.08.09.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:21:26 -0800 (PST)
Subject: Re: [PATCH V16 4/6] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549644314-1481-1-git-send-email-skomatineni@nvidia.com>
 <1549644314-1481-4-git-send-email-skomatineni@nvidia.com>
 <dd2899ab-1a5f-834c-ab97-1654845c7de2@gmail.com>
 <BYAPR12MB33980494FB2E5C439210124FC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33987BF143F5903AE5DA196AC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ba38a07-1953-9393-8756-ce555557017a@gmail.com>
Date:   Fri, 8 Feb 2019 20:21:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33987BF143F5903AE5DA196AC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 20:06, Sowjanya Komatineni пишет:
> 
>> I'm still also suggesting to squash "fix maximum transfer size" into this patch because it is really part of DMA-support enabling.
> 
> Max transfer length limits apply to PIO also but for DMA its more needed to prevent crash.
> So had this as patch before DMA as its applicable for both DMA & PIO.

Oh, so the packet_header size also shall be excluded for the PIO as well, really? It looked to me that PIO doesn't have that restriction and we only need to exclude the header size for DMA..

> We exchanged on this yesterday, so thought the reason you want to squash separate patch and include in this is due to max msg len limit and when moved into hw feature.

If PIO limits are incorrect, then it's absolutely fine to do it in the separate patch. I probably just misunderstood your point.

> Sorry should have verified before sending. Please confirm if I leave max transfer as separate patch or add to this DMA support. Will update along with dma buf size fix.
> 
> But max transfer limit applied to PIO also and that’s why added it before DMA patch to show its dependency
> 

And then you need to explicitly tell in the commit message that PIO limits are incorrect.

It also probably worth to add a stable-tag to the commit message to request backporting of the limits-fixing patch to the stable kernels:

Cc: stable@vger.kernel.org
