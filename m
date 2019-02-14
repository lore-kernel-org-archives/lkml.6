Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D6DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15E22081B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="MhEfq0y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395347AbfBNDjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:39:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36621 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393687AbfBNDjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:39:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so4860266wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 19:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=LH8clWHOrVIz7dWZGTB3YtVEvlBahAJUgwDI/i9ex1s=;
        b=MhEfq0y8R75xypsgNGHY2ERVggXub51xt7yICp+tlSQJXEvU+Tsw76J/pDolH7Ccix
         u1jM+C6rp1PioyIzaFqqzSqwyM0jFsG8XrDBZg3KJdMKogXgUieRpy11rlU8yE/KX9YN
         UVk//2pVp9+jlLkQn1sA83M4iPMz4nk/9+MYC0kp63ev2iaN0XfSdBfX5ICCHvkGawZb
         dWrQufUg1sTOSvNXcrItbmWDDGSbP1I3ef82+XNz9yakIezfGa27QZ4hckMHbVebQcIN
         Xb8lWEQkCki2kG7fbmiM0WYr7ydv0xCcA33RUIwlhpT/XZYd0v8hrHyEQaXWOcH5ZwTT
         BsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=LH8clWHOrVIz7dWZGTB3YtVEvlBahAJUgwDI/i9ex1s=;
        b=fr5rZ65HcxgjHaWZGi0rqjN1OlToviIq0IJ+7rT7bwVMWqjXDi31z8lJL8aGZmzczJ
         xhFnqYuz0nYH38VOfVeVfAi+mLAGgZqopxczkdGrIWS0cEWNCUMc8X3mBzn/Hs9rF3sQ
         NUsS3dttyxKW5Xz2C/kI6PN03AbxJFsDvwYFkwKej+wDPMziuwP6d8KIqqi8yXi0XBb0
         kHnCcAiwltYTrGJah+kDELG59t46evAs0bqa2P455gf2cTfhE/tXqbBBSX+I9QOySXtp
         mZP6WayFoCn5JqPwbL05a+MMHaBA6jvhy2MDm8kFCrGjA2QHylWNUs3O9d0lbVUIlv0G
         BLhQ==
X-Gm-Message-State: AHQUAubrAp2a9f30bQPvbAFJ1QovRPocvI8YfG+d1I4ZT6RkoVgvFdnX
        GYswirExu0czgcRziEGLeyR/0g==
X-Google-Smtp-Source: AHgI3Ibm4g9vvGksvBzs5p9O1cpQ2UyDBcG/JPPDXwPmf2HfAHta5i6IYBq4epkyp4JMYT1GodiMIw==
X-Received: by 2002:adf:b201:: with SMTP id u1mr853193wra.165.1550115552056;
        Wed, 13 Feb 2019 19:39:12 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id l129sm521098wml.42.2019.02.13.19.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 19:39:11 -0800 (PST)
Message-ID: <5c64e2df.1c69fb81.a98e3.2822@mx.google.com>
Date:   Wed, 13 Feb 2019 19:39:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.156-25-gfaa3b6b1ed9c
In-Reply-To: <20190213183647.333441569@linuxfoundation.org>
References: <20190213183647.333441569@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/24] 4.9.157-stable review
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

stable-rc/linux-4.9.y boot: 83 boots: 0 failed, 73 passed with 10 offline (=
v4.9.156-25-gfaa3b6b1ed9c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.156-25-gfaa3b6b1ed9c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.156-25-gfaa3b6b1ed9c/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.156-25-gfaa3b6b1ed9c
Git Commit: faa3b6b1ed9c5a1671bf42cf23aff7c202b7d360
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 44 unique boards, 20 SoC families, 13 builds out of 193

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    qcom_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab
            meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
