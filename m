Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C9FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F162081B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogsw52H8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfBLVPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:15:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32856 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfBLVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:15:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id f24-v6so142920ljk.0;
        Tue, 12 Feb 2019 13:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mHZWjaWpov+eOnVxPGUutgiqxlKsZD0elRhNY9G0A58=;
        b=ogsw52H8Yt5XHxP6pjW71WTDjcwaQ2lGDG2OrLi0I6wGYO3aUCA8Qxs1dy3KwNKQcg
         lpjQE69XyWr8AdvKvvrbaUDsmjXhoJrYVm72ST1SQ/strELO6YKbT4/hhwmLGSjbtV0h
         z5350KSf4DefY7opJCaYx8311yKX6CpBBnj04OrQi3NsJwogx1BgQV5tSuMcRdij9JMf
         ZJtCoJCySKMvxyXRDpFVlYpvRugpi8/l2F2Wx756wEk7/+2ApG0Lwipsszw7JySmvQIT
         rTR0cLc7wiyjUQtCmDw/TP4Zkf74lguswm2GV4LL4HYvQfry0bMaiWz61dDEUBF00Cbc
         iPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mHZWjaWpov+eOnVxPGUutgiqxlKsZD0elRhNY9G0A58=;
        b=JQhObOkfaVvge+cSv8kYQXXSogT/IhtGjGap2lXvWHpeHpj5l00HXDYxuwE+g/jY0M
         lE561LvgZHWMBZKopok7muNpnwE0fERUYbLWYcs9ZTgE7XMpSB/S6zoehHECgFvMp61A
         qOQhJXVjLSKabDpmA8D3HceHH/u97ILrBPWsKCIF31kdqrqajcWvsrAEKaq/sl+Xehnz
         u3NMeu5DGu2P/JAQqof9T6/3OHlkZ802P4zS6EkAmsXJ8n0mQaaS3CWfzCzaSlj/D65G
         y1dvF0QIyyhEPGMu0Fyf4jBeCvzWp/RyBUqZhNVwtzSZ1bqSZ3In9T16eFzuG5MkLqfr
         UjYA==
X-Gm-Message-State: AHQUAua2aL90T4L1JykcG9dDhOc3eE2hQnF9J955fXrrItGQnvME3DRZ
        MooJQlEM9ZCsFkSWjyCUCWezRZtM
X-Google-Smtp-Source: AHgI3IbLAtG7xTmwns5qJPHU3H6DFnsdK6GjAfBTzqza2l8EB6lA0K6EdFe1PQ5tZYDpAQDFnafaZw==
X-Received: by 2002:a2e:87c3:: with SMTP id v3-v6mr3515919ljj.13.1550006119982;
        Tue, 12 Feb 2019 13:15:19 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id g12-v6sm2947623lja.74.2019.02.12.13.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:15:19 -0800 (PST)
Subject: Re: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
To:     Peter Rosin <peda@axentia.se>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mkarthik@nvidia.com" <mkarthik@nvidia.com>,
        "smohammed@nvidia.com" <smohammed@nvidia.com>,
        "talho@nvidia.com" <talho@nvidia.com>
Cc:     "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
 <de27b8f8-ba8e-fca7-6bdc-cdd580d959e6@axentia.se>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cdb66da2-4886-e3ba-e78e-264bd4b5b73c@gmail.com>
Date:   Wed, 13 Feb 2019 00:15:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <de27b8f8-ba8e-fca7-6bdc-cdd580d959e6@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.02.2019 0:00, Peter Rosin пишет:
> On 2019-02-12 20:06, Sowjanya Komatineni wrote:
>> This patch sorts all the include headers alphabetically for the
>> I2C Tegra driver.
>>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  [V9/V10/V11/V12/V13/V14/V15/V16/V17/V18/V19] : Rebased to 5.0-rc4
>>  [V3/V4/V5/V7/V8] : Removed unsued headers in tegra I2C
> 
> "^ Header removal should be mentioned in the commit message, I think."
> - Wolfram Sang [0]
> 
> Cheers,
> Peter
> 
> [0] https://lkml.org/lkml/2019/2/11/375
> 

It could make sense to adjust the comment only if there will be anything else worthwhile a new revision, otherwise it is not-so-important. 
