Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3800C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9E82154B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="1G3xAoB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9E82154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbeKLOBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:01:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40812 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbeKLOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:01:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id w14-v6so2268499wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 20:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Ymv+DfedSWse1fGcGucdcVtGurVXymjViLDtbKDWnp8=;
        b=1G3xAoB+TJXg7HcUlZatTAQDaXf7+FSg9lNQ4KzW6MO6nlhLXDvlJlPnw619RKwr8M
         IcNjj1g1ezYD5NPMUYVfVN4P7TGDFwppAJpmznE6iZbauTuwzHiUrz7jMHgeduNWl+/m
         8xJ4d0D5qQKdzbkXtEIWYsFqET1B1G9OXmA7kADYnarJDvgZVtzxv3OEDwmVBaVVMWSs
         ZKdZ6jmXu5c8/Wk3mT8Eb4WfFb3t34rWJq02FOc2l7++66BBu8H4MBWefJisGUThDJFp
         INFMaFMURVOR6ikJxnI+2ig0H4MP8Zmrv/V8ztSCGKLXOjTsz/cggsiQ9bRDiROTNKW/
         j2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Ymv+DfedSWse1fGcGucdcVtGurVXymjViLDtbKDWnp8=;
        b=rdiYXcTar/SfRd+u6uxbYDTfD5s8j+R7/16FakMYtmTmVFBs3sqcJMsl3eIXzYDkOA
         B++xxQYnp+FzZEnNBV0Hp31UcLSI2zR60bjLETSKE4SJeXZBL67mhHOltIE6rZwVVfZB
         +WTmFig919NxwDzduOFy9H4EnpGDK7Pt9oocO+DV5m4/goFslKzNJutVNaPsBqdpgt9u
         1lET+QwcRtqUMu1MJRRJf8/is6nlRvhVUw4dhw/ytHw2Je0IuFQGBk1doS5qON40vScm
         jtf9eTiFJX3SGgFK/R9uqCA8J39uCArre1XzBbY9xdq+sadZK37TefNnHFF8n1g5JOHU
         xeeQ==
X-Gm-Message-State: AGRZ1gKkoRsLG5CJBlaJQ3Jl5UxqaZLXXNmZzTUNdOsqlCVdNYQ4hZRc
        nAZMG2QDlOLaeoUt0S+on32O3g==
X-Google-Smtp-Source: AJdET5dovg85GrbnCHE2CfumJCJaEVuJNvu+W3raFjQ4YGaOaHCrFA6cIdXLz/GmuOPsJoXx/S6ElQ==
X-Received: by 2002:adf:9170:: with SMTP id j103-v6mr16280726wrj.217.1541995824845;
        Sun, 11 Nov 2018 20:10:24 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 6-v6sm2425432wmd.45.2018.11.11.20.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 20:10:24 -0800 (PST)
Message-ID: <5be8fd30.1c69fb81.ad760.c822@mx.google.com>
Date:   Sun, 11 Nov 2018 20:10:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.80-223-gaa871c61a152
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/222] 4.14.81-stable review
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

stable-rc/linux-4.14.y boot: 94 boots: 4 failed, 66 passed with 16 offline,=
 8 conflicts (v4.14.80-223-gaa871c61a152)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.80-223-gaa871c61a152/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.80-223-gaa871c61a152/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.80-223-gaa871c61a152
Git Commit: aa871c61a15249c475462be9156df7a359395ecf
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 54 unique boards, 21 SoC families, 15 builds out of 185

Boot Regressions Detected:

arm:

    bcm2835_defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: failing since 1 day (last pass: v4.14.79-32-g24f4=
53c41e18 - first fail: v4.14.80)

    multi_v7_defconfig:
        imx6q-sabrelite:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)
        meson8b-odroidc1:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)
        qemu:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)

    vexpress_defconfig:
        qemu:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)

arm64:

    defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)
        meson-gxbb-nanopi-k2:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)
        meson-gxbb-p200:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)
        meson-gxl-s905x-libretech-cc:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)
        qemu:
            lab-baylibre: failing since 1 day (last pass: v4.14.79 - first =
fail: v4.14.80)

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: failing since 1 day (last pass: v4.14.79-32-g24f4=
53c41e18 - first fail: v4.14.80)

Boot Failures Detected:

arm:

    bcm2835_defconfig
        bcm2837-rpi-3-b: 1 failed lab

    multi_v7_defconfig
        imx6q-sabrelite: 1 failed lab

arm64:

    defconfig
        meson-gxbb-nanopi-k2: 1 failed lab
        meson-gxl-s905x-libretech-cc: 1 failed lab

Offline Platforms:

arm:

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab
        mt7622-rfb1: 1 offline lab

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

arm:

    multi_v7_defconfig:
        meson8b-odroidc1:
            lab-baylibre: FAIL
            lab-baylibre-seattle: PASS
        qemu:
            lab-baylibre: FAIL
            lab-mhart: PASS

    vexpress_defconfig:
        qemu:
            lab-baylibre: FAIL
            lab-mhart: PASS

arm64:

    defconfig:
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: FAIL
            lab-baylibre-seattle: PASS
        qemu:
            lab-baylibre: FAIL
            lab-mhart: PASS
        meson-gxbb-p200:
            lab-baylibre: FAIL
            lab-baylibre-seattle: PASS
        bcm2837-rpi-3-b:
            lab-baylibre: FAIL
            lab-mhart: PASS

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: FAIL
            lab-mhart: PASS

---
For more info write to <info@kernelci.org>
