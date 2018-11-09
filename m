Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D32C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A0320855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ksxGgwqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A0320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeKIN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:28:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39231 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeKIN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:28:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so674572wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 19:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=nbU5+iHgVxHTe3RCHQSRcWeHTQddvf+JH+sn75eiAcU=;
        b=ksxGgwqZqJAD+NnbP+d6AWGqZqk3Mcz7MDsE/YDutG1e1e+1wV1LQ9AZVIvZqzpgKk
         jgjFVfRr9kqWk2ilWawWYBwcJDaJppybPVGVSgZGP22o61EwZquK4wkaxfMuuQl19wx5
         hV4vp1rFM6WJDrD8uobxLZE/O4FGC3qjVT5ZgPyQaGcUvNOl5DJsWA6mjNWqru0D/hRB
         tAubHVa7cDCPI/DDkxNDpWo6pzRe6Bp6R1kZDviQYsnNcoRhmKXScgQl6fGusWYr6f7a
         BtH9j3i7Fw77ig+HKcxSxd9s8bNn9TMUyiMduyHD0JJycaRMBIvHWhbo2PhWyAyAKaMl
         CmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=nbU5+iHgVxHTe3RCHQSRcWeHTQddvf+JH+sn75eiAcU=;
        b=KFGU7Mc0h4Lvi2km/op9vfeHTMiKLuFGNA33nEG1csLfqAQp8bdyP2dNuTL5sFCtZG
         pW/MVzfQwopd8soRKALsbD6sH9XRKBBfKLSaK59QDCrXW2aAQtBlhsPBJ8sUb/ivRKmP
         kZunenslGcyzVKpEbzJE+kmfnmpk2skLJf+K5E+1jlyKl7w9/iBdtmJ1J+R7Q3H3lwGz
         KKEFtd3GcmotAZxk0tRO4SUmUjwiDkWAaXrNaENOknoRvGFaSd7tYtVv8PAl8xhaNh4U
         I21T2rBakjw/AFGgCpJonu18pj2s40Pjj2fmiWjEMHD1FyGygmihSG3PpK6wzUaiA8bK
         Ik6A==
X-Gm-Message-State: AGRZ1gI0pvK68I2quy0sqFLk1S0Vv/nT7KJtTtetvess2ZAA52RXs0gr
        6yanXdtpvw4wASV4wtUg8yOmnTCk4Hs=
X-Google-Smtp-Source: AJdET5em//Qqa3AwiUjPs1+Q0MX1SPa/l/7i9vwEhvlPLEJ+QopUAqlESUfh6HJ6cM+f7Noy1+qj+Q==
X-Received: by 2002:a1c:4407:: with SMTP id r7-v6mr3290768wma.16.1541735402572;
        Thu, 08 Nov 2018 19:50:02 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id i7-v6sm4605896wrs.55.2018.11.08.19.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 19:50:02 -0800 (PST)
Message-ID: <5be503ea.1c69fb81.b9223.9429@mx.google.com>
Date:   Thu, 08 Nov 2018 19:50:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.18.17-35-g46c86a0ac4a1
X-Kernelci-Branch: linux-4.18.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
Subject: Re: [PATCH 4.18 00/34] 4.18.18-stable review
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

stable-rc/linux-4.18.y boot: 91 boots: 0 failed, 76 passed with 15 offline =
(v4.18.17-35-g46c86a0ac4a1)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.18.y/kernel/v4.18.17-35-g46c86a0ac4a1/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.18.=
y/kernel/v4.18.17-35-g46c86a0ac4a1/

Tree: stable-rc
Branch: linux-4.18.y
Git Describe: v4.18.17-35-g46c86a0ac4a1
Git Commit: 46c86a0ac4a119d8aaa02055e233b2ee550a016e
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 56 unique boards, 20 SoC families, 15 builds out of 187

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
        mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
