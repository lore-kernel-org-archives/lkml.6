Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EDFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9F5214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ev1kNJ0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9F5214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbeKLMl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:41:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46272 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbeKLMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:41:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so7604655wrb.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 18:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=2nMjZMRQPOIuiWsyTAzVCkvlQX2NCRatOmjVlWw+5nY=;
        b=ev1kNJ0h3VExBYseO0njwvn/KCo3N7CX3h+q1o9pfysERqBvunygK6XC9hMzuP29/W
         gnp3xNhhqKiB+3c9tWnOJ6OMYVLzW1RR/4a6sl/WzHVxXpw0wGvntvmZNbpfY1YiDejr
         StfFlkHu2T+/ClBh767GXrCQGYYLXjXJtnrAk+blv+rct+OqPxFhde2t6McM9GhnUGHE
         13cNvmoK5aNFyPIdPsTHppdePwI7CtqZEKBR2PoK7zXiYGGaMVYwi7rb7eerHJRUNiUV
         xaK4DrEpmFodsR9YBA5CVleN2mIrMYiXrCv95Hp0R4feCNW1UAx/lSUNghNODLuMbwHJ
         2zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=2nMjZMRQPOIuiWsyTAzVCkvlQX2NCRatOmjVlWw+5nY=;
        b=jlqyEpmk6WyCJea3k/87lLuVOIo207K8g+Qk9yVqqyJlQg+ypb9cO5N4hoh75Fr97k
         QJRuB8dWSKbiDzbbQQnW3iyBBu98LIeo1zXf38zBfQ5LmgUylPphPhc5DhLW82cSNrOv
         mpqT6150Q3MS9osOXy5Ic+Nm96IjKYVmIbBRidafycLKTrYHs2IwPHv7478zokT99PeD
         B4MVxDdOyuhcAWihtpn5DJKM5qxvII6D80BbS/I6Ve/KwYXLK9hZF/Ax2hMzxvzrykti
         efdtL6Cp2s3TAb/vt6I87yfEHndVg4wnd//b5c24x+qqZIU5xBikVDzR3Cl9YP3Hlo+D
         JAjw==
X-Gm-Message-State: AGRZ1gKILAjpJCcAEybuln4RyarTZJFi64ik+XqG19F2dXSMYUlO/NSG
        x5ifEy9NOSKwHJ5OuxenmfrsWPplAd8=
X-Google-Smtp-Source: AJdET5eG5jDjefUxgu+c/IQhGg41iM39D6IdUwHtZhetC75DkMcN5iV9keCQMZt3QWXsGdoXcTLisw==
X-Received: by 2002:adf:9cc2:: with SMTP id h2-v6mr9796903wre.322.1541991023960;
        Sun, 11 Nov 2018 18:50:23 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x11-v6sm6142372wmg.14.2018.11.11.18.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 18:50:23 -0800 (PST)
Message-ID: <5be8ea6f.1c69fb81.eb980.05e7@mx.google.com>
Date:   Sun, 11 Nov 2018 18:50:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.136-142-gdc28287de643
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/141] 4.9.137-stable review
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

stable-rc/linux-4.9.y boot: 81 boots: 1 failed, 60 passed with 14 offline, =
6 conflicts (v4.9.136-142-gdc28287de643)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.136-142-gdc28287de643/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.136-142-gdc28287de643/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.136-142-gdc28287de643
Git Commit: dc28287de6435c38a38eb37a44e19832497d0c63
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 43 unique boards, 20 SoC families, 16 builds out of 182

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        imx6q-sabrelite:
            lab-baylibre: failing since 1 day (last pass: v4.9.135-156-gdb1=
dd7ad04c4 - first fail: v4.9.136)
        meson8b-odroidc1:
            lab-baylibre: failing since 1 day (last pass: v4.9.135-156-gdb1=
dd7ad04c4 - first fail: v4.9.136)

arm64:

    defconfig:
        meson-gxbb-p200:
            lab-baylibre: failing since 1 day (last pass: v4.9.135-172-gcc4=
6a1dedc8b - first fail: v4.9.136)
        qemu:
            lab-baylibre: failing since 1 day (last pass: v4.9.135-172-gcc4=
6a1dedc8b - first fail: v4.9.136)

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: failing since 1 day (last pass: v4.9.135-172-gcc4=
6a1dedc8b - first fail: v4.9.136)

Boot Failure Detected:

arm:

    multi_v7_defconfig
        imx6q-sabrelite: 1 failed lab

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

    socfpga_defconfig:
        socfpga_cyclone5_de0_sockit: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab

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
        qemu:
            lab-baylibre: FAIL
            lab-mhart: PASS
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
