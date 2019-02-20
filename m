Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67DF20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaUSPDt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfBTNac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:30:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41749 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfBTNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:30:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id y5so6672006plk.8;
        Wed, 20 Feb 2019 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qy04mKzoL16kaKUgEkcr5rBVmxccfjZptBeFKXDuxX4=;
        b=UaUSPDt+CASC9nvRx3/L8wM8jaGF3+vSR1u9JOLeXeISX4poVGcXMA4pU6hpQHIGoG
         eeVDfM0G1r06KcRHYQpz9Cq23JiXyOfGeis+/mRiKwxUmIEURCrDWGqzzBVLJy+jBAyg
         h0SzKCCkUx/1zgPV5ZWEIDiwp2ZGpqxo0Eoy1/+y0xcTV8gfhYUxvpWX2mpZGa3937bB
         0E7jA2MBqQ6blq6lxUI+uvS30Q36ze6Mn050xeqF6uMhdwvvdaYMHmKThgCu66DU/wXI
         XERLT+A/+qPq8bp4JiSHUxlDiX8cbPvYunnNJGQdJd2AhcWXxChuyqlav8plB7tLjfaj
         otXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qy04mKzoL16kaKUgEkcr5rBVmxccfjZptBeFKXDuxX4=;
        b=BKN5ssfqmFSgzOldGq4vchnAVJsvn9AYvF9b4ovOD/YYrgWYOeHJ8zN3dAkCfxDmuk
         TahqyvLwXPpHdNXkvKnE67Mo7qSGkfXGCFEaTxN+99pxWTzH3V3Bdc5p2SfMhW5/4Zi+
         kujwU9X0xPyAtkid0qAeU3FECgsODMzNONXxtRVvQZvX/AZN5M5iuAXHovMeDgd6lwEG
         F73LgjYBR1Jb9u50fd5ssM5aiFnZM1TIK/1QBWmiU9zgonfUTMC9bSgL6gmejNR3qeoY
         Qyjt9ZMMJBNMdCszpIiFiACyDNgPh1y8gfpzR3wpJoXXvQAvpQGAUiakRViRCbcYjKA5
         /kFg==
X-Gm-Message-State: AHQUAub+LUbbUq1obUts90AILrM1zuijMuFdFczZMdxjdQmoodjX0nLT
        D/TJUfCs3l1+tAc1jFJAdC9r5ok4
X-Google-Smtp-Source: AHgI3IZj3eHY4pAV2P5YuTvM/dcJBqwavtz+ELmWQVqm0o+LMl5vt/kCbCYoevuFuZLpN/veR/vTfw==
X-Received: by 2002:a17:902:e90b:: with SMTP id cs11mr14674338plb.197.1550669430801;
        Wed, 20 Feb 2019 05:30:30 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id h3sm4447539pgv.38.2019.02.20.05.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 05:30:29 -0800 (PST)
Subject: Re: [PATCH v4 0/8] Support Trusted Foundations firmware on Tegra30
From:   Dmitry Osipenko <digetx@gmail.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190218001726.16785-1-digetx@gmail.com>
Message-ID: <c6d761cf-370c-c4f7-931b-d2333e02f2dc@gmail.com>
Date:   Wed, 20 Feb 2019 16:30:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.02.2019 3:17, Dmitry Osipenko пишет:
> Hello,
> 
> This patchset adds support for the Trusted Foundations firmware on
> NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
> firmware and upstream kernel can't boot on those devices without the
> firmware support.

Hello Michał,

Will be awesome if you could test the series on yours TF300T and report back, thanks in advance!
