Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E316C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6F720871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="CT3fcOTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6F720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbeKLOBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:01:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39742 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730681AbeKLOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:01:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id b13so7702472wrx.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 20:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=mQtEIYyyCk+GXzdqOc04OLO19t/vZLT1R+ebldxvoRw=;
        b=CT3fcOTm/B8Kw/oie1zLYfRRIvdnGeb80+y0Yajw8b77s2sp+Aa6quxZezLVkdvF21
         iBSAZO47roRs0bW+MhriM+Pz+yAyAHJbjTLPcH1NJkRjPb0nEUwMa6+xEPsuFn9jz47O
         KXuBtK3jioPggG99KqGBHfQdlClFdafvssYoEi4aoYBCRMzvMubbebf7STFrhgruhJ90
         To/Fcjbu/enJCBjr3wTwI1mxVAXt6HkHQ9ZKVhbZmANnlWUABhGVHoFQDcckXbntwqOK
         VlBMvnhAMEr5YrSdYcPTxtS9F/oQwJHF/gVXgo4+SUN/QXgrlbRr3s9MWqopHXjdJ+Ip
         VHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=mQtEIYyyCk+GXzdqOc04OLO19t/vZLT1R+ebldxvoRw=;
        b=kDOgCzrmDORDvujQnjkBcN3DOPdUJ5tT73+5RpsE5saOM64Yjj5wvqCo0nyrYoiCjO
         DXpZYAfwb5yKEEsUEToCv/XigFnZTa7EvT+4xuorJyEg5qwZy6QSAmOKWBrsHIrd3ydF
         I6Ba4GsIzNn7LdQwaCnO2C3cYDCMT/mGc89wRG4qCE3+yutOd/XbF7w+e+ga4CfW6hmt
         NYuEZ2V+U8P4UQ6/w64tLEBD/lRbvJi8DSjdeafDWg8livsS1me4v8vs1UgUBdMH2zgR
         vGSdzwahD1vUHUAcageBsaPYO05Q/BT/gXdPbuhVouWG52E1nRJiMaG8caRgZeJVFhet
         VBwQ==
X-Gm-Message-State: AGRZ1gLyBaXRbtdTyP8M4BruomyvUCZUZH83NefoHe2hbQZMfD0V9Jhi
        i2D5mjuhFFPpu4h8kY5M/8ZvlA==
X-Google-Smtp-Source: AJdET5c7F4ZWIUvtKde8VwnVpC88TVf0lV0W6aPv0LQXAyiqcxXE7UOWtQypjvV+YCPugWAMZgGpgA==
X-Received: by 2002:adf:94e2:: with SMTP id 89-v6mr15550796wrr.25.1541995824322;
        Sun, 11 Nov 2018 20:10:24 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f18-v6sm5462727wre.57.2018.11.11.20.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 20:10:23 -0800 (PST)
Message-ID: <5be8fd2f.1c69fb81.d2041.c16d@mx.google.com>
Date:   Sun, 11 Nov 2018 20:10:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.18.18-351-g3c7d01cd1ddb
X-Kernelci-Branch: linux-4.18.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
Subject: Re: [PATCH 4.18 000/350] 4.18.19-stable review
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

stable-rc/linux-4.18.y boot: 100 boots: 9 failed, 67 passed with 16 offline=
, 8 conflicts (v4.18.18-351-g3c7d01cd1ddb)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.18.y/kernel/v4.18.18-351-g3c7d01cd1ddb/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.18.=
y/kernel/v4.18.18-351-g3c7d01cd1ddb/

Tree: stable-rc
Branch: linux-4.18.y
Git Describe: v4.18.18-351-g3c7d01cd1ddb
Git Commit: 3c7d01cd1ddbc9a886879493eb0fc25482f399d8
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 57 unique boards, 21 SoC families, 15 builds out of 187

Boot Regressions Detected:

arm:

    bcm2835_defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: failing since 1 day (last pass: v4.18.17-35-g46c8=
6a0ac4a1 - first fail: v4.18.18)

    multi_v7_defconfig:
        imx6q-sabrelite:
            lab-baylibre: new failure (last pass: v4.18.17)
        meson8b-odroidc1:
            lab-baylibre: new failure (last pass: v4.18.17)
        qemu:
            lab-baylibre: new failure (last pass: v4.18.17)
        sun8i-h2-plus-libretech-all-h3-cc:
            lab-baylibre: new failure (last pass: v4.18.17)
        sun8i-h3-libretech-all-h3-cc:
            lab-baylibre: new failure (last pass: v4.18.17)

    sunxi_defconfig:
        sun8i-h2-plus-libretech-all-h3-cc:
            lab-baylibre: failing since 1 day (last pass: v4.18.17-35-g46c8=
6a0ac4a1 - first fail: v4.18.18)
        sun8i-h3-libretech-all-h3-cc:
            lab-baylibre: failing since 1 day (last pass: v4.18.17-35-g46c8=
6a0ac4a1 - first fail: v4.18.18)

    vexpress_defconfig:
        qemu:
            lab-baylibre: failing since 1 day (last pass: v4.18.17-35-g46c8=
6a0ac4a1 - first fail: v4.18.18)

arm64:

    defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: new failure (last pass: v4.18.17-35-g46c86a0ac4a1)
        meson-gxbb-nanopi-k2:
            lab-baylibre: new failure (last pass: v4.18.17-35-g46c86a0ac4a1)
        meson-gxbb-p200:
            lab-baylibre: new failure (last pass: v4.18.17-35-g46c86a0ac4a1)
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: new failure (last pass: v4.18.17-35-g46c86a0ac4a1)
        meson-gxl-s905x-libretech-cc:
            lab-baylibre: new failure (last pass: v4.18.17-35-g46c86a0ac4a1)
        qemu:
            lab-baylibre: new failure (last pass: v4.18.17-35-g46c86a0ac4a1)
        sun50i-h5-libretech-all-h3-cc:
            lab-baylibre: new failure (last pass: v4.18.17-35-g46c86a0ac4a1)

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: failing since 1 day (last pass: v4.18.17-35-g46c8=
6a0ac4a1 - first fail: v4.18.18)

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
        bcm2837-rpi-3-b:
            lab-baylibre: FAIL
            lab-mhart: PASS
            lab-baylibre-seattle: PASS
        meson-gxbb-p200:
            lab-baylibre: FAIL
            lab-baylibre-seattle: PASS
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: FAIL
            lab-baylibre-seattle: PASS
        qemu:
            lab-baylibre: FAIL
            lab-mhart: PASS

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: FAIL
            lab-mhart: PASS

---
For more info write to <info@kernelci.org>
