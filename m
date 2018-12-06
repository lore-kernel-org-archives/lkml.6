Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E32C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C6D214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Rp/0kVVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C6D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLFUMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:12:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38498 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLFUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:12:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so1737630wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Qmd2/VWTe4Dp+JB90tj4OUBKgS5JVJ5WwrcylTsjQiY=;
        b=Rp/0kVVj2aeWNbfcto+sG0+n8t6UvoLvnIwMpcO0jTNfhVqMRFsDmbFB/L09auIoMD
         P7ABJfB8ZqxJk3Cy9SWe4W7kBg1/OEe5t855/QfXkEg4e8L+jhsQEewh6VSQMRfRD8IE
         rn9Dd1svrrFCglFBI5HWZc+/Y/AHVbb/TtNfurA4Odpm9aAVSLVMqNurYwAmf4QSQ3wJ
         JLq2R7tinN12khUxQCS8tGBRZj1GJiF0rjrmOxtylMHGH5rMGv2KQw3K+znyEYquli8g
         gvcXcn52tf81Fa1V6DH0eVGabtJvq/Nq8YloG7Y37AG/vn4Bhkc09oaQ8drWl2MbtIAT
         j2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Qmd2/VWTe4Dp+JB90tj4OUBKgS5JVJ5WwrcylTsjQiY=;
        b=izfIhhVnLsUIj2fzXpJ57QudimYPlDBa9FKLYxGXEi1oTII49TzLVBrEUYVyvrAxSd
         np9nplCxUrqCndyLy1t2tAc3b/sCzsubo4mv5n5+rabVDCO1rer/f8CmsVSETMbWLsH7
         kYhF1EdAxLsJeVJqHpactZdkNDBS0uZ29GUJIeYjueSR6fRKkfKNz4kLtSeEuzKiaa4B
         pUzFYg0eK4YKaBmZBswVNyvZ+9/sKegRl1qsSva/Z5USbxoyVlKDlC9OH/8A9ONYA63q
         PK2rVnljT9Imswm3YJ6a9S0jImiKBTm94Mhn71HW/wiz1IsjA+vHmc2Zcl1c57xuftBU
         l7ww==
X-Gm-Message-State: AA+aEWbxC0r1pDCBuMrerZZNvjh3U5jCevMFVrap59+XZNsFrkO2qSJ0
        tu+3GxVdwsVIfeUHiZBiN/TJ+g==
X-Google-Smtp-Source: AFSGD/UwNMyACvgy3IoblOwMND9nXVCYxNLAsggzo58p3+GvLgo83h69y61A1fs5il2QOIfUUrtEAA==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr25890865wrp.242.1544127156800;
        Thu, 06 Dec 2018 12:12:36 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v1sm1474975wrw.90.2018.12.06.12.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 12:12:35 -0800 (PST)
Message-ID: <5c0982b3.1c69fb81.d0d1.9a81@mx.google.com>
Date:   Thu, 06 Dec 2018 12:12:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.86-56-g555f40d53cca
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/55] 4.14.87-stable review
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

stable-rc/linux-4.14.y boot: 117 boots: 1 failed, 114 passed with 1 offline=
, 1 untried/unknown (v4.14.86-56-g555f40d53cca)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.86-56-g555f40d53cca/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.86-56-g555f40d53cca/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.86-56-g555f40d53cca
Git Commit: 555f40d53ccac2c84734383d6d86dba512b5e033
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 57 unique boards, 22 SoC families, 14 builds out of 197

Boot Regressions Detected:

arm:

    tegra_defconfig:
        tegra124-nyan-big:
            lab-collabora: new failure (last pass: v4.14.86)

Boot Failure Detected:

arm:

    tegra_defconfig
        tegra124-nyan-big: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
