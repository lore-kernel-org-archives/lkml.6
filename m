Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B6EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE73213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ7U0FsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfB0PPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:15:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44770 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfB0PPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:15:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id j3so8086386pgm.11;
        Wed, 27 Feb 2019 07:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=09UsXtmMlPqyjs0g1mEFYSqyEsjC6rGycLBx4GCevCE=;
        b=VJ7U0FsFsSEPEd2grg9ESaQkoL0+IY5dZVuq8tBLF7sAXIoApBq8oFmHVP75F2QtqY
         eb+dHyNbSYQe/J8qsRva9FrQCFSRQWk2Oa8fx70g2XfgaZB+8sKpbXCnoTklcfkkuvSL
         d2hzKuY9ww/mxwt6poF9M4WzO8GnUUYvmSRN3xycntIqDRP7BoPM4ZJGoJu9LdIqwhix
         BArZs/v3sE/b+5x+0JghTdM6HixZ3E5Za1KdCwG58glcIxK4IUmZFdvAx5i6ugz6Nqvl
         elidIxRboxiXBE2wcmvyp2qkrdnQ7jCA8riP51HUPHNEQuXCTIJ2EGObFbWLJrb6Iz9k
         IzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=09UsXtmMlPqyjs0g1mEFYSqyEsjC6rGycLBx4GCevCE=;
        b=tPqrX/nXXfN4/gZdlzy9P6Gl59f0b08LJDiqy7ISD7lXs0gcUXQ0BaOcB2xNPKX/c+
         hJIHRw4JFwzgwrKS8boExQpk53O458pZnoUHKHGNBn9a58Pxgow7bEDLKFe3ld0bc5iB
         HHYc2+cwXX5zObUz5FO4LU0DOpWfVI520CDG9uE2cu11qDfTLlg8/zNYq/K94ckrlQA+
         OB7mOHtNrt3QJjQhvMoOX2G0PSC6fmyBaRCYKlITrvu7Fd723UBpNWVWLew/tWZyUMho
         EX6rHzFvahSRzn1E0lTf9CZnq08TIe1iUeHjQr+eCB5/I8qwwwkl/DXh7dV8xzILtaKF
         vhyg==
X-Gm-Message-State: AHQUAubpxIJ9ZXEunv/4sHBqh16IPC3p1HkXCcvqk5G68IoUsjhbDxJ+
        LcWoTG2dN0qq41FmAm3ooR60VG66
X-Google-Smtp-Source: AHgI3Ibmq0tjbP8V9P6nRAsmEvxPq0WVuYHsZqFuE35WAOTt48hI8QjGU0no7W2dPdOhrzksN0BYwA==
X-Received: by 2002:aa7:8390:: with SMTP id u16mr2104460pfm.63.1551280514170;
        Wed, 27 Feb 2019 07:15:14 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id e63sm31521709pfa.116.2019.02.27.07.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 07:15:13 -0800 (PST)
Subject: Re: [PATCH RE-SEND] clk: tegra: Don't enable already enabled PLLs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190224153222.8142-1-digetx@gmail.com>
Message-ID: <b64760b5-0d37-ae05-9c8e-9e6d47293c92@gmail.com>
Date:   Wed, 27 Feb 2019 18:15:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190224153222.8142-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.02.2019 18:32, Dmitry Osipenko пишет:
> Initially Common Clock Framework isn't aware of the clock-enable status,
> this results in enabling of clocks that were enabled by bootloader. This
> is not a big deal for a regular clock-gates, but for PLL's it may have
> some unpleasant consequences. Thus re-enabling PLLX (the main CPU parent
> clock) may result in extra long period of PLL re-locking.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Peter (and everyone else), yours r-b and ACK will be appreciated since you kinda already took a look at this patch in the past and were okay with it (IIRC, we had some brief discussion on the #tegra IRC a few months ago), thanks. 

