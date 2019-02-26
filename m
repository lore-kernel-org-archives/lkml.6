Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C49C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FAF217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="n7YA+nRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfBZOUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:20:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53880 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfBZOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:20:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id e74so2564117wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=l0giP8wlV8KX0Z8omzv8MkcdTJ7wruPl/shB4slzzvM=;
        b=n7YA+nRAIXZflm4hdfB+Kew4pBAC4ObSGc3ztm/fNolJMRIIQLesiIj2QaGcxGAMq7
         Ir9yOoz9xgAA7TlGGGMIJzNyF/wq0xTfDPzokZsQyJSbfJqqeeDtFOz0K4DXVUpUen2L
         Ukg/DHpFCTUrSiJBs/4k0tWpBCAGyrk4PrH23CXuGtdI5C+fEysD4uOUGXfqqi1oA7kg
         gh0QE2Oy6VmwYK5+kKBDKwMroIydKahp7u5SCU48p9DYolmzhYZPdgbYL28oLHpRuJ5G
         y8+0KmXjcnLCP+JTsj6zhwVjZB60NWs+ZsMvwnxvlM08ROiautmESczd7uFIVFGpGele
         pcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=l0giP8wlV8KX0Z8omzv8MkcdTJ7wruPl/shB4slzzvM=;
        b=MRqFJNFO2V/Eoj7uMVdh8zNoH8+rEWaQg2H9CCERSQdJnmyBraC1m0AM246PT6ZDRw
         M8OsnaEWw7C4J4mTrYTpxFM7wKYcPMcEkjgmJhxp0cibTzXWaCUM4TCWFHr2uAGbsEAM
         Y+0CyQYEaNpUUGDMld6hmVE1f5u2N9oX6bXZE1lPG0o34HKMT9VfbXnsX2G8MbISL4cV
         H5ijJFXKeGwW/bP48tB76Os6f/PZF6XDsAyX4Fk1PueSDZNqfYFrrmYh9s2iOhSO5lH5
         EWO50CcYRSCobgR8pRiw1TZQfNVjQAQHG8cmyu9IA+ppurYZjUgRnjJNok3tObvny1Kn
         ZWgA==
X-Gm-Message-State: AHQUAuZgqyo6Xtw9XWQWh4oET80OwQEXSkns2/k/hyZXVReBPXCmU1S+
        kkxEpDWxNjKJ966GF72ztRXlUg==
X-Google-Smtp-Source: AHgI3IZAiUU4X55ppNu1BhwGuX1rgGdjgq3QBtQOpiHjO8n3noS3qgCkvS2CKwcwZCRfR7utIioyUQ==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr2893791wme.73.1551190826441;
        Tue, 26 Feb 2019 06:20:26 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id l130sm11090499wmf.13.2019.02.26.06.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:20:25 -0800 (PST)
Message-ID: <5c754b29.1c69fb81.a87c4.8fcb@mx.google.com>
Date:   Tue, 26 Feb 2019 06:20:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.103-72-g470aad464377
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/71] 4.14.104-stable review
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

stable-rc/linux-4.14.y boot: 105 boots: 0 failed, 39 passed with 66 offline=
 (v4.14.103-72-g470aad464377)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.103-72-g470aad464377/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.103-72-g470aad464377/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.103-72-g470aad464377
Git Commit: 470aad464377e6a50dcafe2ad2fe510166d1c4c0
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 58 unique boards, 22 SoC families, 12 builds out of 197

Offline Platforms:

arm:

    bcm2835_defconfig:
        gcc-7
            bcm2835-rpi-b: 1 offline lab

    exynos_defconfig:
        gcc-7
            exynos5250-arndale: 1 offline lab
            exynos5420-arndale-octa: 1 offline lab
            exynos5800-peach-pi: 1 offline lab

    imx_v6_v7_defconfig:
        gcc-7
            imx6dl-wandboard_dual: 1 offline lab
            imx6dl-wandboard_solo: 1 offline lab
            imx6q-wandboard: 1 offline lab
            imx7s-warp: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            alpine-db: 1 offline lab
            am335x-boneblack: 1 offline lab
            armada-xp-openblocks-ax3-4: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            exynos5250-arndale: 1 offline lab
            exynos5420-arndale-octa: 1 offline lab
            exynos5800-peach-pi: 1 offline lab
            imx6dl-wandboard_dual: 1 offline lab
            imx6dl-wandboard_solo: 1 offline lab
            imx6q-wandboard: 1 offline lab
            imx7s-warp: 1 offline lab
            meson8b-odroidc1: 1 offline lab
            mt7623n-bananapi-bpi-r2: 1 offline lab
            omap3-beagle: 1 offline lab
            omap4-panda: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            stih410-b2120: 1 offline lab
            sun4i-a10-cubieboard: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab
            sun7i-a20-cubietruck: 1 offline lab
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab
            tegra30-beaver: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab
            zynq-zc702: 1 offline lab

    omap2plus_defconfig:
        gcc-7
            am335x-boneblack: 1 offline lab
            omap3-beagle: 1 offline lab
            omap4-panda: 1 offline lab

    mvebu_v7_defconfig:
        gcc-7
            armada-xp-openblocks-ax3-4: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun4i-a10-cubieboard: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab
            sun7i-a20-cubietruck: 1 offline lab

    sama5_defconfig:
        gcc-7
            at91-sama5d4_xplained: 1 offline lab

    qcom_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    davinci_all_defconfig:
        gcc-7
            da850-lcdk: 1 offline lab
            dm365evm,legacy: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab
            tegra30-beaver: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            meson-gxbb-odroidc2: 1 offline lab
            meson-gxbb-p200: 1 offline lab
            meson-gxl-s905d-p230: 1 offline lab
            meson-gxl-s905x-khadas-vim: 1 offline lab
            meson-gxl-s905x-libretech-cc: 1 offline lab
            meson-gxl-s905x-nexbox-a95x: 1 offline lab
            meson-gxl-s905x-p212: 1 offline lab
            meson-gxm-nexbox-a1: 1 offline lab
            mt7622-rfb1: 1 offline lab
            rk3399-firefly: 1 offline lab
            sun50i-a64-pine64-plus: 1 offline lab

---
For more info write to <info@kernelci.org>
