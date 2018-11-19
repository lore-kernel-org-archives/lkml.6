Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19747C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFC22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="VCOXzGIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFC22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbeKTJ5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:57:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45545 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeKTJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:57:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so15082wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=/x029yPmWv5HAI9X0TEEOzxwBnRkzjCL2IaD3JTf7vE=;
        b=VCOXzGIROM6yDti/GoS7PEBz6O0loJgZBxTdMunie8UuYrXLXG2QKckB46J9bQ9bIS
         xOsTXyV/rbqxaOotpinwX21DTBvw+VXSsfsoru81UtWRBxl3E55dYKio5TEOZocpHRfv
         F16mjTX4G265j4fVEYgMyUoKUZyU0Dxm78pDs++Zicv54lszvyp0JaoI8d8c599F/+87
         8JLL7wu1abeQvbVgZkfHLUKPI0eygvKIgfNft2T4QbzxeykYyTAFq2LVhOpNaGK4w5vP
         kLhJpJDN8LgSw5e+2ix85bfB+nFJ8ZJv8iT42krzFPebtbEtN43F6zzTHe/Zg/pvoVup
         jEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=/x029yPmWv5HAI9X0TEEOzxwBnRkzjCL2IaD3JTf7vE=;
        b=qstFinbNYFbVmF0n041OMF3T47hUtQeK5YJIB53wYvcy7v8O2M1ylTlblUw5oSJJtc
         NWYAvabkU9hccGYO9Fxf6Elyu2Tbux9O15IWUID9hyE4nDseM/9nUpJcQIbFD25WL1J+
         4tw/F5XFEzUn4YycgdgHWLVZgas7DgXWnLlph+37Dvqg0i6sWyj9xm57kzbUjVMHCBFl
         ylF7U2wuxwJV9DFsgku7cSbgNSsb6GTLLGMHlZpuP/uK1drm0vvK4hU9dfji79sZyVlh
         LsdLF3DpH6i5PuU9gHBJZjhA5Z62TbTf/DkLXBs7WJU1WFQsana3BsACNB9i8INUDVST
         H8Yg==
X-Gm-Message-State: AA+aEWZuUXAVKclFOwGRfLms+86eu8zsSCLAANKo4ngPVKVt4y0VlfvR
        6NRgRT8h0CVc74AmlcEpY8BC5Q==
X-Google-Smtp-Source: AFSGD/UDA9LWOX53R+RUNS0Xn5glOWIlJmIrAUfCtMWn4tKfbrFzy+0fZzLm+pyrj9nG6mv1Z1Vwaw==
X-Received: by 2002:adf:8544:: with SMTP id 62mr9921495wrh.1.1542670277581;
        Mon, 19 Nov 2018 15:31:17 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a204sm8351514wmh.23.2018.11.19.15.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 15:31:17 -0800 (PST)
Message-ID: <5bf347c5.1c69fb81.83080.265c@mx.google.com>
Date:   Mon, 19 Nov 2018 15:31:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.137-83-g4ca3f6d71162
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/83] 4.9.138-stable review
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

stable-rc/linux-4.9.y boot: 59 boots: 0 failed, 43 passed with 16 offline (=
v4.9.137-83-g4ca3f6d71162)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.137-83-g4ca3f6d71162/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.137-83-g4ca3f6d71162/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.137-83-g4ca3f6d71162
Git Commit: 4ca3f6d71162e660e35f62700d1dd2486feb5e4c
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 36 unique boards, 17 SoC families, 13 builds out of 182

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

    socfpga_defconfig:
        socfpga_cyclone5_de0_sockit: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab

---
For more info write to <info@kernelci.org>
