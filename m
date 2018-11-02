Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72916C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170D22081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="T2HWUx0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170D22081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeKCH6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:58:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52941 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCH6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:58:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id q19-v6so3237542wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=HObUMrHYyaU2TJl0VzRufyRketaHun44LwvNCOS3eFM=;
        b=T2HWUx0MFJfqp+PUoOkDYc+oOEkaRcR3u9nN0xALo3bkKm/6vMs1g0ddSMDRQ/lfPI
         5bShoO2T6GlHAdEdIHDKLQBJJUjrDfcd1I/n18bropos8jif95uckGn5z4jQvvyDbqXW
         wlzUYqxKE6VFJZu3Q5tvEGmnIcP3JcLdUva4rI8UPa4ZZsjtEKzsIx3arpEZ3GbBlhqX
         TkwL9+/MNnn8Mdbge6wtvqdE6A4QZnXBZWXoHQ5NLHOxas7Z44hzc8CDAiVPSYONRAiJ
         VIrWc2eY0CEQKke7wsJLIgcrNzEbVbg6/XwqH9r3dcZju5dkxfQylDa6R0HA7bcr4Zxa
         FI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=HObUMrHYyaU2TJl0VzRufyRketaHun44LwvNCOS3eFM=;
        b=bINxDFoZDnPmGi40j1ikOZfl3giaDAvBS1lchVACn7Bv0gTMrF+KWgG9zDZlSZwxZc
         Ah8VudE5iO31r+uEqpkVH94A5q7P2fOhXNaivZTrRqwXEXxRHtXFokE0XZKKhFQVii3Y
         kMLw5KxT7Rx7P/VXfGHGfhfkT4J7193l+j6KNklIzZrgzQOATZFL2ZH+YxQaxea/pc0T
         owpt3YIM1AtPOmZbdGqrvIk6qeQDdgehWS8myTkuWUHUm9tk2O36cPUYu2LZqJ/3VXSj
         zzA27G56cYGDX3foOB1icyyPL/EiJKi9b9sCXrxn/plFYf5/jeK6FgOgP4A7H3bArY97
         N6tA==
X-Gm-Message-State: AGRZ1gJrlD8mStMBs1c8nUH90eBwd1CCB7LNxI/XSWq1BazkqIyE1DY0
        sRh61EMwZtvsNPB61ngS1Fs/5g==
X-Google-Smtp-Source: AJdET5eSC3deTfhALXVliLuRuHRLkAQCEnLAHKfI0lgrEkWMu1OUBUgL0h1YP7KJRIV2boq71aghGw==
X-Received: by 2002:a1c:1c0c:: with SMTP id c12-v6mr80386wmc.18.1541198972084;
        Fri, 02 Nov 2018 15:49:32 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c24-v6sm61095412wre.44.2018.11.02.15.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 15:49:31 -0700 (PDT)
Message-ID: <5bdcd47b.1c69fb81.c38bf.1e49@mx.google.com>
Date:   Fri, 02 Nov 2018 15:49:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.18.16-151-g8a21f68d3977
X-Kernelci-Branch: linux-4.18.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
Subject: Re: [PATCH 4.18 000/150] 4.18.17-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable-rc/linux-4.18.y boot: 130 boots: 0 failed, 116 passed with 13 offlin=
e, 1 conflict (v4.18.16-151-g8a21f68d3977)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.18.y/kernel/v4.18.16-151-g8a21f68d3977/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.18.=
y/kernel/v4.18.16-151-g8a21f68d3977/

Tree: stable-rc
Branch: linux-4.18.y
Git Describe: v4.18.16-151-g8a21f68d3977
Git Commit: 8a21f68d39776cc3ca539a12266806e0a483da57
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 66 unique boards, 24 SoC families, 15 builds out of 187

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5422-odroidxu3:
            lab-baylibre-seattle: new failure (last pass: v4.18.16)

Offline Platforms:

arm:

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        mt7622-rfb1: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    exynos_defconfig:
        exynos5422-odroidxu3:
            lab-baylibre: PASS
            lab-baylibre-seattle: FAIL
            lab-collabora: PASS

---
For more info write to <info@kernelci.org>
