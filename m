Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729DDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB0F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="f0VBRJWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB0F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeKIN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:28:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38562 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeKIN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:28:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id e3-v6so404653wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 19:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Gxmw/gqJlgtam7noZEs0DyiNOxbwzcN2IQua+SK0QT4=;
        b=f0VBRJWWr+Z0jFkpCX3qFCKzQRajvIUX5olTYZNfWS3w806ll6ylhoGpBWLRSQwkFq
         lzULWDOo5S6jbor08xn9c7YnGlGq3p1RXVrBiwqx5geR02Gw6WpV8HAj/or1L8oWLBsh
         Egk4W6EY4tMW+m3cw/OkGeW7sh893Dw2n/1UoI9bGi+ND3kgR3XdA9oe6gpC04qCLRLm
         QXPmTVSIPU04vESsGbdgf2pEAAsi8gUQ/GxLPLxXPm9Pj5t7d9/lG5PmdINyz9mV3llZ
         0yr390KVTjoloWxsW5BuectJcalpz0+91SNjq2KLiBKi2oWYz3GSC6fyLmzfVkl3hwZN
         RdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Gxmw/gqJlgtam7noZEs0DyiNOxbwzcN2IQua+SK0QT4=;
        b=Rtv4q1we8eOuQWbM1IMASGMDlmBSNJczJAt9KlH/A0KQl3m8Mb536rSC17BmQ1SUGR
         vOgkjdkK30fJikMUUN9oiY8nFxJstm1KdJY+4vIw8L2NAvwMKP0ZZm0L+cmOH3hJ/9n8
         AwOwAXWw92/kY/uCts0+zcx7/xf2j+TMo/YR/3P8WRDhaO+z5R2mSVkkL6Sil37dJpdY
         LOdPRV5zBgaKeWyNhu+tj4zzyJNXaLWvvDOao9KknTtzNTOjm8bo9f8G7YKx5ikKkCpu
         zeY/8F5ohRJEYoh8Dbm2T5QhlNGRFCA9sfcK0ECCMxDgTErFVk/O4+vd1sObuFIo7rFy
         P+IQ==
X-Gm-Message-State: AGRZ1gKpFEXgZ3QyOCsjF+a/vo9SEVHP5G0HjrR3udz8Oe0a7VDB2/NA
        2koNNvzvcjWI7toTsLsQh5f+KDkS+is=
X-Google-Smtp-Source: AJdET5d1JtzEn4ku6CokKAaCrp/FzaF570VfW6lTdBXJ20BJ2yhkEv6f15EMenFM2vGjJo6OHGJDLQ==
X-Received: by 2002:a5d:4fc7:: with SMTP id h7-v6mr6725372wrw.48.1541735402067;
        Thu, 08 Nov 2018 19:50:02 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 65-v6sm832801wmj.1.2018.11.08.19.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 19:50:01 -0800 (PST)
Message-ID: <5be503e9.1c69fb81.de6ec.3dae@mx.google.com>
Date:   Thu, 08 Nov 2018 19:50:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.135-172-gcc46a1dedc8b
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/171] 4.9.136-stable review
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

stable-rc/linux-4.9.y boot: 84 boots: 0 failed, 70 passed with 14 offline (=
v4.9.135-172-gcc46a1dedc8b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.135-172-gcc46a1dedc8b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.135-172-gcc46a1dedc8b/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.135-172-gcc46a1dedc8b
Git Commit: cc46a1dedc8bc44d1f238a21ee2848ff2ca6f6d4
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 44 unique boards, 19 SoC families, 16 builds out of 181

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

---
For more info write to <info@kernelci.org>
