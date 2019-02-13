Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC25C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7CD222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUPhqm1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbfBMNNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:13:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39204 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbfBMNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:13:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id f132so1129763pfa.6;
        Wed, 13 Feb 2019 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=by+dIfRiuPGq7tbK2RGKZv3zqNZs5vOV8fxeOpQykvs=;
        b=hUPhqm1nZGhm7fxQKUNuons56DFgcONcrsc+L1PRP/DkCFLHQOfkiyO32HSyuFWITk
         YEKkfuIO363JP10VdbXxrduNzQkv/hWhJzDKONOKrpgKCUz+q/CKtBnp4nDfO4AlJiTr
         ND68eMkX3nrxTrd4QTuYfs5op5IIvG10TjLgnDUq44QZAo0bZEKOrLBbudsuEXY4AE/6
         Rbg30Xeijrjee+UcyU8Vzvqx5nvvxgICc/qQVYIMoX3JBR9QIYwSPw5LavNq3dZGS8dl
         wqNwuUQGkv39Fic6ni7V1iXTgNUpFjxJEGGKcJUVE+0bmOGzLy0coVmyyJM9OAJUmjvY
         rR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=by+dIfRiuPGq7tbK2RGKZv3zqNZs5vOV8fxeOpQykvs=;
        b=m0AY6GJS2AQhi2X9Pv0+8jPdYWzyYPuVqGhc7AL9/bomxHyv//9Bn2iXFeBYAfP0JA
         nEy7khADEuDIUezefF92/SKkvSPZ/3n9MolTPtdSkIr0m2mt8X+3jIjNOHwYnH414Zqg
         CI0tfVFqY7goS92/pvtWJohsbF89DhbrBteO78YP2LoHmZBuGSaF/q8Q4SUz+frorKZv
         0pBpiLnXC73J0beEBhvP1cZl9mxCyghIY1L+bc7iewngXW43e9Sco4BQsJ509DONoJD+
         aHGpBqRUtWcntu0c7uTHWX4attLmzR7lULbQMWJIU+etgfwS2umT9/f6U1r3zXY2IZa9
         Iqcw==
X-Gm-Message-State: AHQUAuYp6cuIkvC4sq7KkjnHH6luZhT8hys8bugYZb5xgw1eeyENIKUp
        9zmVJIwtT1x8s/8rfHe/4cvWAinz
X-Google-Smtp-Source: AHgI3Ibjk6yIb1DCqynv+vnBgAMWxFbsSgJN4MP5KyFg/7cQV2PYNalfa+mx9OODQNeqlkBiQY9nzw==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr438306pfm.63.1550063632092;
        Wed, 13 Feb 2019 05:13:52 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id p12sm39279274pfj.81.2019.02.13.05.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:13:51 -0800 (PST)
Subject: Re: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Peter Rosin <peda@axentia.se>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mkarthik@nvidia.com" <mkarthik@nvidia.com>,
        "smohammed@nvidia.com" <smohammed@nvidia.com>,
        "talho@nvidia.com" <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
 <de27b8f8-ba8e-fca7-6bdc-cdd580d959e6@axentia.se>
 <cdb66da2-4886-e3ba-e78e-264bd4b5b73c@gmail.com>
 <20190213083519.tynjs3ef6tnvvsms@ninjato>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b299217a-454d-6d3a-9c48-3500a95040a7@gmail.com>
Date:   Wed, 13 Feb 2019 16:13:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213083519.tynjs3ef6tnvvsms@ninjato>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.02.2019 11:35, Wolfram Sang пишет:
> 
>>> "^ Header removal should be mentioned in the commit message, I think."
>>> - Wolfram Sang [0]
>>>
>>> Cheers,
>>> Peter
>>>
>>> [0] https://lkml.org/lkml/2019/2/11/375
>>>
>>
>> It could make sense to adjust the comment only if there will be
>> anything else worthwhile a new revision, otherwise it is
>> not-so-important. 
> 
> Not quite. Addressing review comments and proper commit messages are
> both important. So, it needs to be fixed. Yes, I can fix this small
> issue locally here (and I will do this, so no need to resend), but this
> is ultimately my decision (which you can surely ask for but not
> rely on).
> 
> I'll apply this series later today.
> 

Fixing up minor itches while applying patches is the right approach, thank you!
