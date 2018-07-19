Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5863ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62202205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXM99aZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62202205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbeGSQWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:22:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40185 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:22:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19-v6so8172245ljc.7;
        Thu, 19 Jul 2018 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DduDew6h1LyeGkNp5V4ERw+wDHQvf8E+B+7Oy5k1Yk4=;
        b=pXM99aZdTRJbw6+6ErhOG6VxvMUv9eIzuUlT9eEivf3CRfHleeK4Q7UY126j1q3s2m
         43nIK1hAmCasC3yhHieVhighBBE4VOxCw7OiaO3/4F0mTxSaEj1wwDdJ/xOkRXzvQ6fG
         l4wx3HQ0yVb1R33h25cQHMua+TSiQ/8+u4VacoHASKU/H+9vKZOP1JCITFFD5T4KzLGz
         o19A0w8dpr8IWIAsklS7dgWI/KcQWn5C58mEeDNGczh8HQYpX9UAlALC5dDkbSFZRkXm
         lskx39zjC908nrTL5uR9Yqy/h0JIUhDSpKAyysTC1cSPVt9VKM5zyk95y+9is1Vaca8N
         KZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DduDew6h1LyeGkNp5V4ERw+wDHQvf8E+B+7Oy5k1Yk4=;
        b=Gn75/Wu03gROdgGSgf3W789vS6iY+Yu/nimFL5J/p5t+iuAjWnnmbdjhIwpc+0pE+k
         C32+WDxHEjBLVnCUo2iHuIosC6oQq9HcP5ExvcHHRszkqjlihxGazsOT/HT0q7lHX5bB
         95k0XvQRa5tJihdaFKqoxhBW1mJ6/U2n2igGmUnivFDJseKn0hCisPtKk7azbCiDfIN/
         JY7dGFKlLC9X4MCsti5KcnhujFseu6FvpzIhcdC12DNQGlkGh7iBCmVVVZPIOogcxXW7
         AAFo0G8OdwO7hUnDxZZl+N3gyITSte3+LD5Hg8l5kCltBT6Qt42w+YkBq6oZtEehOZne
         E8ow==
X-Gm-Message-State: AOUpUlE6ovfBk4TEVsQ62VMf86zzpXERwNtMp+MKvoGyG1J+DFr5H5T3
        Di9UUme55zqM/oP4KXMXIm4=
X-Google-Smtp-Source: AAOMgpeiI1oQbvegksXipavstgrvXWKW7B5eY6vGa67LCnkAXJ3G2NUi1TsiNlYbKZGqaOvaA4g5Fg==
X-Received: by 2002:a19:4f58:: with SMTP id a24-v6mr7337521lfk.140.1532014728060;
        Thu, 19 Jul 2018 08:38:48 -0700 (PDT)
Received: from dimapc.localnet ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id 73-v6sm1003487lfx.75.2018.07.19.08.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:38:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
Date:   Thu, 19 Jul 2018 18:38:46 +0300
Message-ID: <31916977.CHrX6e343J@dimapc>
In-Reply-To: <39607791-3e71-7784-37db-4e05a316d7a8@nvidia.com>
References: <20180719132453.16860-1-digetx@gmail.com> <39607791-3e71-7784-37db-4e05a316d7a8@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 19 July 2018 18:30:48 MSK Jon Hunter wrote:
> On 19/07/18 14:24, Dmitry Osipenko wrote:
> > This fixes irrelevant "tegra-mc 7000f000.memory-controller: no memory
> > timings for RAM code 0 registered" warning message during of kernels
> > boot-up on Tegra20.
> 
> Looking at the tegra20-emc.txt bindings doc [0], the 'nvidia,ram-code'
> property is also valid for Tegra20. In fact, I see this warning on the
> Tegra30 Cardhu because this property is not populated. So I think that
> this warning is valid and harmless.
> 
> Cheers
> Jon
> 
> [0] Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt

That is the irrelevant binding, the relevant one for this driver is [0]. The 
warning is valid for T30+, but not for T20.

[0] Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt


