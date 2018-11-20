Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83334C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494D920870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="TtFCj5Oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494D920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeKTLRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:17:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53931 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbeKTLRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:17:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id g131so485919wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=OlmRjiz/OT+DbWDPI418Is0a8JE2W8QZW3YF5vn/TFk=;
        b=TtFCj5Oyr8s/uPhJ6MyL2XDiLu7RfNoLICXt/+g0hjyIR3Fzoi0aySTRR0k6QhwOLp
         k+zHMdD8yDv7PBkme4QqXPZqCvtNoMDjPF4e9syO7MYPOJBuTMBSH5ZQyBtvXunoSgOk
         Vd1m9+imPM+NNz0prLGCEFh77lqXsdyccgmpB00BfyHV2gMLcK27u+oyE8MyMhkdtv0J
         ny1dsNHrKSvlmiBeyfVvsaTt3czRug4F/GoXhFel2Q+G+7EuHjC19aICcf/xyC8Mzrin
         2h8tbdRHZkNg2hNKGC3l/MP4fVniwLHrLUmOUGjirvroDIwb6jk9HRhgtVMcvnMRck21
         ZW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=OlmRjiz/OT+DbWDPI418Is0a8JE2W8QZW3YF5vn/TFk=;
        b=CeSIGXI5Z0QYn7K0ozK+NPXRWUG/nRB7L8VJrO1/JIy/La6lOepmfJfwUJ6SPKKaUe
         ObPV7GNSvhoCfd/2aJYmLPDUOd+3q29HMqcqqNxkUoXVQXFdaeJhzY61I30J2Ww6+Lo/
         DffAUoQPph3NFhG5YDLw/xOQB+nDasducc+gi4LgvRiXswayF2NfLGwzd3NShH8I/ZHF
         dMTZnP2DOpMPNQ8X/F3uWGuTJ7a/5F3+vezq+18OAFLfUOaAegxVgi2TKNdkSbnYBJjM
         gBH+TtK8AchtwM5av6yvzBXrW6Px3OQPx/zvbKlbQJbggr/yrjbGeumxoKcA4furgCCm
         Wi+w==
X-Gm-Message-State: AGRZ1gLjkKDxQQzdCOwl2hVOjgqu6jRqyvaBwdyT9h2AR/D5T858fp3Y
        uX/+DNJdmRhx8VjnIbzQpQeyng==
X-Google-Smtp-Source: AJdET5dFjEQ5Fi1A9lPODGA8AYM7wNrSYKzfmgQ7uYJ/akvDt+XT6SvSENfarW03SdboCiyPQYxnUg==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr245293wme.1.1542675078735;
        Mon, 19 Nov 2018 16:51:18 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t17sm10835808wme.43.2018.11.19.16.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:51:18 -0800 (PST)
Message-ID: <5bf35a86.1c69fb81.8478.e42b@mx.google.com>
Date:   Mon, 19 Nov 2018 16:51:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.2-206-g857962e4c7ee
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/205] 4.19.3-stable review
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

stable-rc/linux-4.19.y boot: 120 boots: 0 failed, 101 passed with 18 offlin=
e, 1 conflict (v4.19.2-206-g857962e4c7ee)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.2-206-g857962e4c7ee/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.2-206-g857962e4c7ee/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.2-206-g857962e4c7ee
Git Commit: 857962e4c7ee68cec7bbf720850c80d2ec7e5777
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 66 unique boards, 23 SoC families, 15 builds out of 187

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

    exynos_defconfig:
        exynos5800-peach-pi: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
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

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm64:

    defconfig:
        meson-gxbb-p200:
            lab-baylibre: FAIL
            lab-baylibre-seattle: PASS

---
For more info write to <info@kernelci.org>
