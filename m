Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C77C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D5220871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="G1751Y7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D5220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeKLOBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:01:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38791 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbeKLOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:01:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so6759086wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 20:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=m7cpw0i8wUrY5Ob5tu1FfOIwXV5mQ0CEvi98GqCkEf0=;
        b=G1751Y7fcSdScGqMxp/8bYHTrokURiKCpQCfDHvBIUef6yOKwl5pwS4zrhbKGyNnmt
         ZVmPaQ+XFp1yYV3ghBbe+IesgaKJRiaPczc/k39UUfOgUeyAnxrv/It9/RtlkL6MFvjP
         BldXaUj4Bmd/mDvW1Uibg5BE1aGN6GlIKiaW2slLCkm96SC8ZU83Z+ACmDllGJLe3VZA
         Kx9dYeZnKwoz4sLxnl9Zf7aX4PgoZu0U9R96yf0aJjrTCli1a6W2Zt9ncMhFa+tZ4EmS
         KQr/Bb2umzeMX4VaJv/UHYwCM93shO0fI/2sa5vq7QdHOvesAChdlSuC1Eeg43ryMMcF
         aEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=m7cpw0i8wUrY5Ob5tu1FfOIwXV5mQ0CEvi98GqCkEf0=;
        b=a0BFO2vBX+Nei3fSvPWHdCAkRNV3a0iXkcQC8PedLkUXnM/+xB5lYfC4S8pMKDJhm0
         16SIqAIUJaAw2EJLMy/z3XlIoaW9qABiw6Y6w1CkhUlvvxI8Gt3zoa9/lpA9no9Dwlw8
         DpAa2P6NCk1SYUQ1Ho7/LpqjgJQlDyKBm4td6oMXOOuF+aTMuhFG5+rwO6VduP2c2Evx
         aEiGEpuZuCfix3JvybG/OL/XYDHpvuWWi4E8v8IQZmvyfGu9W90Iojwh/M92E0V+NnHQ
         6z4Zfb2Ps35z2ydQg9A8lz1uMCkRYAUO8URttD4EkSGsCsbV2c4xrnuuBptgH75/vGYF
         zJiQ==
X-Gm-Message-State: AGRZ1gK9KwA1/x98Ip0d/kis6jTXe/4ZJ9t09JpfXwKfxxwjV/jpPuZ7
        VBKS4GL8ZV6wtHPRWDvqcPtF8Q==
X-Google-Smtp-Source: AJdET5cHG5HVamTpIrQVfGpSa/uZ1aqkXdcQyk9EE52a7i/oZZAh7XHvF0xKOwljAPJZ4w4M/pC+fw==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr6230813wmo.138.1541995823874;
        Sun, 11 Nov 2018 20:10:23 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm4179066wmd.18.2018.11.11.20.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 20:10:23 -0800 (PST)
Message-ID: <5be8fd2f.1c69fb81.9eefe.5e0a@mx.google.com>
Date:   Sun, 11 Nov 2018 20:10:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.1-362-gc881caaeb264
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/361] 4.19.2-stable review
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

stable-rc/linux-4.19.y boot: 98 boots: 9 failed, 65 passed with 16 offline,=
 8 conflicts (v4.19.1-362-gc881caaeb264)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.1-362-gc881caaeb264/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.1-362-gc881caaeb264/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.1-362-gc881caaeb264
Git Commit: c881caaeb264eb22581247c54c007a0bd9e6cd19
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 56 unique boards, 21 SoC families, 15 builds out of 186

Boot Regressions Detected:

arm:

    bcm2835_defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: new failure (last pass: v4.19.1)

    multi_v7_defconfig:
        imx6q-sabrelite:
            lab-baylibre: new failure (last pass: v4.19.1)
        meson8b-odroidc1:
            lab-baylibre: new failure (last pass: v4.19.1)
        qemu:
            lab-baylibre: new failure (last pass: v4.19.1)
        sun8i-h2-plus-libretech-all-h3-cc:
            lab-baylibre: new failure (last pass: v4.19.1)
        sun8i-h3-libretech-all-h3-cc:
            lab-baylibre: new failure (last pass: v4.19.1)

    sunxi_defconfig:
        sun8i-h2-plus-libretech-all-h3-cc:
            lab-baylibre: new failure (last pass: v4.19.1)
        sun8i-h3-libretech-all-h3-cc:
            lab-baylibre: new failure (last pass: v4.19.1)

    vexpress_defconfig:
        qemu:
            lab-baylibre: new failure (last pass: v4.19.1)

arm64:

    defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: new failure (last pass: v4.19.1)
        meson-gxbb-p200:
            lab-baylibre: new failure (last pass: v4.19.1)
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: new failure (last pass: v4.19.1)
        meson-gxl-s905x-libretech-cc:
            lab-baylibre: new failure (last pass: v4.19.1)
        qemu:
            lab-baylibre: new failure (last pass: v4.19.1)
        sun50i-h5-libretech-all-h3-cc:
            lab-baylibre: new failure (last pass: v4.19.1)

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: new failure (last pass: v4.19.1)

Boot Failures Detected:

arm:

    bcm2835_defconfig
        bcm2837-rpi-3-b: 1 failed lab

    sunxi_defconfig
        sun8i-h2-plus-libretech-all-h3-cc: 1 failed lab
        sun8i-h3-libretech-all-h3-cc: 1 failed lab

    multi_v7_defconfig
        imx6q-sabrelite: 1 failed lab
        sun8i-h2-plus-libretech-all-h3-cc: 1 failed lab
        sun8i-h3-libretech-all-h3-cc: 1 failed lab

arm64:

    defconfig
        meson-gxbb-nanopi-k2: 1 failed lab
        meson-gxl-s905x-libretech-cc: 1 failed lab
        sun50i-h5-libretech-all-h3-cc: 1 failed lab

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
        qemu:
            lab-baylibre: FAIL
            lab-mhart: PASS
        meson8b-odroidc1:
            lab-baylibre: FAIL
            lab-baylibre-seattle: PASS

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
        bcm2837-rpi-3-b:
            lab-baylibre: FAIL
            lab-mhart: PASS
            lab-baylibre-seattle: PASS
        meson-gxbb-p200:
            lab-baylibre: FAIL
            lab-baylibre-seattle: PASS

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: FAIL
            lab-mhart: PASS

---
For more info write to <info@kernelci.org>
