Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A4BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E32520855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="QsbnJ9oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E32520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeKIMsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:48:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50488 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeKIMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:48:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so670422wmw.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 19:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=2bUIEZ6aye5K7oeTcESxPSTMB0OYGKhJ1UdH/QEPHnY=;
        b=QsbnJ9oWLmOxfqViMRx/UJyw6m5Kln6FyoKrBA9VEKIOyWqcQuaUL6wyDvQ/zZTknn
         gb5yCioZuUqEOROpkroMZOs5qml61ypE7iGOfuzxWqF1gZQq2550W2j1JNn4X29Bl5nI
         zfxPUyZaPBTMXmh8/Ra8P5eAN8xI+l9lhHmFcN8cUji1/GiHtb94A+v5ORSDWKcb3jyQ
         M+yw3rrFonqUBZnUQMAl1jomixNyV51DJWMo+5lkyJlWZbf54oxGkceEzds7xm3GyCmO
         +Vrnv4+JGChmDbTfjrHtS8utTPAeJJS0sCX37wvkHC1eX1hqquGj6ncykDlvjpM6rO+V
         Pd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=2bUIEZ6aye5K7oeTcESxPSTMB0OYGKhJ1UdH/QEPHnY=;
        b=FfR0Z2TJQ0solTwgIYMnFuAnZxbfiunPoyHrOxlSV7AOvw2EJzbxTeV+fFFtZ5AWm8
         CaK2OyXeb/YGWJgiry+8LBJEefGNDgFHMdROpbK9zUyJ8Po43bzUZuFwzbsRRsISP4DQ
         rTE/X3jLetIll9bWilDQZcDInahQrobulGqg08GS5BWrIFPMIKw0W4useNfaE/2IMaj0
         QRO+lLjdvB5yCN2UjiO7RfhO5dS3QQp8ywblUWiuw4G5PZlogLvPAI+TbmWsJ6KdDY2G
         7FA4L0H132yq5IyF3obIfJr+sLHB2H1dpsV3XzEgOltYoe8OaIxrwoLSG46L1Qh8oeRN
         J++Q==
X-Gm-Message-State: AGRZ1gJ8PaLftFB4tLd2VeNrr7gWUkLDQbzHdPH6JB3RuZHk+POui0Ju
        1Q3AsPLaX+ev9+vbpSfs9/SKwA==
X-Google-Smtp-Source: AJdET5fkXSWUsD0RsVzjZu5cdxk5KRlJoYYTkEecld0CWiXecUwApQW/pR1qiM+yRKR7U/jDMaOTRQ==
X-Received: by 2002:a1c:e355:: with SMTP id a82-v6mr3253141wmh.74.1541733002121;
        Thu, 08 Nov 2018 19:10:02 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id p125-v6sm435612wmp.2.2018.11.08.19.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 19:10:01 -0800 (PST)
Message-ID: <5be4fa89.1c69fb81.8f337.1df8@mx.google.com>
Date:   Thu, 08 Nov 2018 19:10:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v3.18.124-145-g70889240432b
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
Subject: Re: [PATCH 3.18 000/144] 3.18.125-stable review
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

stable-rc/linux-3.18.y boot: 62 boots: 5 failed, 51 passed with 6 offline (=
v3.18.124-145-g70889240432b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.124-145-g70889240432b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.124-145-g70889240432b/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.124-145-g70889240432b
Git Commit: 70889240432bb789ca9ef4ec1ba90206367fe696
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 26 unique boards, 12 SoC families, 14 builds out of 183

Boot Failures Detected:

arm:

    exynos_defconfig
        exynos4412-odroidx2: 1 failed lab

x86:

    x86_64_defconfig
        qemu: 3 failed labs
        x86-atom330: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

    multi_v7_defconfig:
        am335x-boneblack: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

    sama5_defconfig:
        at91-sama5d4ek: 1 offline lab

---
For more info write to <info@kernelci.org>
