Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28422C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13BE2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="1MtewAwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13BE2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeKCIa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:30:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40439 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeKCIa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:30:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id i17-v6so3510579wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=3O1qaATcHIkuuPgSXnv/8XGANB3AKCCJ/lgCD4fLLVw=;
        b=1MtewAwPuYFduFY0GQVeHBcGjkYJV9ov/cmMOALGxDWn07gqBImDYDr+noddsLbTwB
         39tkoh/yXmykjRu97naRiacEAf+L8kXBo9neQ1Mpc8sv4ymj4X3neBb3yR9tlASdtFr5
         mUkHODukxBYrciI2cHnxXRNzwZDfsMzVwh7D6+kkAtAVibG6cJPWEjhW9V/vQZ4y2UYU
         Jxjzl3qN5bl4qVg4HRPi6/XHqN+kHaE9YLHxXEzGAHcLR/MxgspuEXUZO5mv3NtuJoGc
         g9su8l3IWPPHI9ZGtEWjWgpRNHCo0wJiugWE88vBTO8B+E3ExgAxLkbmogfhuKhAw84z
         8hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=3O1qaATcHIkuuPgSXnv/8XGANB3AKCCJ/lgCD4fLLVw=;
        b=cVyy7KffPWVVPe23IYXjqHgVV68xS2OW1QZJCuRZOSfBeTmHy1iqcSR3iT1weoESYv
         0TQSSSL/ARbXSD/DPUf1XVlmLTVuCBS29PUjW+8RNsAgflXpc26QKwwDO/pfI7IfvC6p
         mAjTyte4TSdL5NbW3ysbUfx7/IWWdDOzCtOYgZdQgFQuiT6ztZwBKfHh2EWIQVwkPNot
         s/fVKWC1yHc6iN0+GzMYkE0e8QZASZ2LI8AglL++8mLiPATMDcLfTL+pPjuci4JaLKuC
         9Y88vAPjobup7rh+8ijZeXVowLIVUdKeCUZe9ggQ3koC0V6jKxNbUpV8nuEIWt7Cqp+C
         xDpw==
X-Gm-Message-State: AGRZ1gKFdX1dZxP613MgG/jFRJzwhjK7GrzVMZquEJwB3SBqDEPnrxAa
        CiFxItfP8c+n//8DnyIrwwMvFQ==
X-Google-Smtp-Source: AJdET5fAQx5WUAiG+WbmMU9OWGQ3kwUo9M9+VXq+G9gEIjm4rIKYnyztBCQJU6Um9DjYkMTIM6FWoQ==
X-Received: by 2002:adf:fa92:: with SMTP id h18-v6mr11647861wrr.74.1541200908805;
        Fri, 02 Nov 2018 16:21:48 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id e8-v6sm9602738wrw.75.2018.11.02.16.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 16:21:47 -0700 (PDT)
Message-ID: <5bdcdc0b.1c69fb81.27f78.0e10@mx.google.com>
Date:   Fri, 02 Nov 2018 16:21:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.78-144-ge862e4c85291
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/143] 4.14.79-stable review
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

stable-rc/linux-4.14.y boot: 125 boots: 0 failed, 110 passed with 13 offlin=
e, 2 untried/unknown (v4.14.78-144-ge862e4c85291)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.78-144-ge862e4c85291/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.78-144-ge862e4c85291/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.78-144-ge862e4c85291
Git Commit: e862e4c85291ce6758f1aa05b05c54b1afce6844
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 63 unique boards, 24 SoC families, 15 builds out of 185

Offline Platforms:

arm:

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
