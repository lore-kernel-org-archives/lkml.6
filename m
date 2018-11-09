Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58127C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 04:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FCC20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 04:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="IU47kEj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FCC20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeKINuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:50:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40357 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeKINuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:50:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id i17-v6so425870wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 20:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=CykYK84YsVaK2XIiwSp5R+bwBnLEsAum14yEZ6tar3A=;
        b=IU47kEj0oWuuLypwfb7CGvUilVa9ls2TCsHYN2gCNuaAzLM4ia4eaKu+XO2clRY6wZ
         f+MoqtchEptgKQK05p//wa2PEMwqPoWEStyvYr5rMPuUiu/V16EV0MEQ6o9u0j6jYNV1
         wKKeBmQGZKG9oCxBgays9GmgLcHu5ZhD6K5QALgajriLj1Ra3j83EB4Frh/dpY5sUrSc
         ZmxpjURO39gNK+Tn1E6c3jfzUIa72in0R+Q/4Y9tqiQZWmqM5XLZSQYJ0cdV1oLq+rIf
         cqWZ2T8k03myVhUqHahY6rFvq3MEyoRwBYoe+kcJuupqMSAVgQqWttH89LOJ2OsSK9qN
         yrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=CykYK84YsVaK2XIiwSp5R+bwBnLEsAum14yEZ6tar3A=;
        b=hHujP1uXxvPhi+/v1d20vuzjxW/VhVmAcb8GF24J7UaePA0J1uRcQIOX32ni3hebm4
         +Wrvvx6Lli2BjmIr7aUSkSXoPP5WiUW9cd19UfisPEObwO4ccttOtXFaviiiRBVvxg3e
         fSzwYdRTlGlIUiqLOtOMtwLW/J0V1hS4LeBvC4zVSZOV8xnUof528gDItaY+76odIn+i
         +VZOOqzHgIR0H9a+KZMG9lNFUDvY+/SkaG+jtwYtCgN9UQzyh1nMcBAZG4+OB3A5WMyp
         hpvzsRsz9ikrVM6WJdPMPSWbbjAbYD4B+0y9kXAqqS3ycNFfahtVToNQXyjaJHfxmi9Q
         Y6NQ==
X-Gm-Message-State: AGRZ1gIBGGGkiThnMtStf4iMXUgfoQIlIRh1vhb490GvKoqDHaL4hpJs
        XCFPpx3nRhimdJoApvAp/v6W2g==
X-Google-Smtp-Source: AJdET5cOPpsNWG93IlWz8lY5wDxRVwVe2y0qaDLdy37LJEFUXBWxDHCuXmAvN6Hoh9TrhBYDVgGeTQ==
X-Received: by 2002:a5d:6943:: with SMTP id r3-v6mr6274634wrw.323.1541736700003;
        Thu, 08 Nov 2018 20:11:40 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id l140-v6sm626494wmb.24.2018.11.08.20.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 20:11:39 -0800 (PST)
Message-ID: <5be508fb.1c69fb81.63f85.2b35@mx.google.com>
Date:   Thu, 08 Nov 2018 20:11:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.79-32-g24f453c41e18
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/31] 4.14.80-stable review
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

stable-rc/linux-4.14.y boot: 74 boots: 0 failed, 59 passed with 15 offline =
(v4.14.79-32-g24f453c41e18)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.79-32-g24f453c41e18/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.79-32-g24f453c41e18/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.79-32-g24f453c41e18
Git Commit: 24f453c41e18a0eeb83d7c5d65f210b4f3f2018b
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 49 unique boards, 20 SoC families, 14 builds out of 185

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
