Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD7E2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="a9V5OzC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD7E2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbeKTLlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:41:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37026 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:41:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so536917wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 17:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=6dLHQlJrz0ezkS4UvFjAaQkzEgUwa9UvG5DGvMZY4Jo=;
        b=a9V5OzC28qcuSyLRDP6Ri7yPpWTap58ZE1Uz2BuCf4UWxSWQeqKloQbHH81nymmxfl
         tVC7oYvM48U/L/faBudkkLxx1QsdHw8sI7/Qh8DHfETk9oMlvbg/ORKpHTLnToCOxtY+
         y7Rk7OlAbNJCttkl1XDuUPAKbp/L2yHjwg7u1pUxLDvSKavYYcermKBmOI/nywnbaS37
         OQovN4rYu5XkxBY3kDQbSmcdzOxEI9nhvkKnHu+GBOplWGxE8XaBQ1edlH1oSN9GdJIC
         OYK465zHtu1DZ+/N5fJSWJofxyJeyaRWx4v8TbEkjefwOGALXrKHcHdV8wg846pusUn4
         ZP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=6dLHQlJrz0ezkS4UvFjAaQkzEgUwa9UvG5DGvMZY4Jo=;
        b=K60oqpn0Uew8CHNlEbN7lsnJd0WWq6QawCIqeIC76DFmAjL+esZHxW8nQ/GESM5/48
         mjG3vTrp73y11AA81y6mAlrcmUn2dodFAn35/2tUAOgW11FESF2aqP4uEVa+dhz5WoTt
         Yd8NLhZGcC5Ylx6Liz+v+HaHkIONqNbNEox2y4HPoQsq/drKfdi7lPYwX4MtNAkUZXuB
         jiNITHCVdXyW2mGyTySUZJvLbM5J6wh7s8aSkK58glHpV80Rpt62fT0BbHHVyoSQ5js6
         7h33xij4HKbhJtVvBbmhDrUf4dY2FgXfXSnDxMAW6O4rLi/NXHQcTqh4M1LcygSs0NTm
         zdXg==
X-Gm-Message-State: AGRZ1gKaj+bhUokol2PGAh2mbA7j9wbRD6BupWsPrYVYThKTkl9/vXZM
        v7Rp01vH6gNIQS5EYIk8kPBzJg==
X-Google-Smtp-Source: AJdET5d6SN49vFvC0+MawmpB9OE6UyCcRGqCy7xukcNW9vYyGVr/5RIRXOWbh5L/JXQ67M1SymAKZw==
X-Received: by 2002:a1c:a183:: with SMTP id k125mr284452wme.25.1542676506386;
        Mon, 19 Nov 2018 17:15:06 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id e7-v6sm31487127wra.10.2018.11.19.17.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 17:15:05 -0800 (PST)
Message-ID: <5bf36019.1c69fb81.513e1.f777@mx.google.com>
Date:   Mon, 19 Nov 2018 17:15:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.81-125-g43bb46eb6e2e
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/124] 4.14.82-stable review
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

stable-rc/linux-4.14.y boot: 77 boots: 0 failed, 59 passed with 18 offline =
(v4.14.81-125-g43bb46eb6e2e)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.81-125-g43bb46eb6e2e/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.81-125-g43bb46eb6e2e/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.81-125-g43bb46eb6e2e
Git Commit: 43bb46eb6e2eae660d29ec037de28fca0cd2e7e5
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 50 unique boards, 20 SoC families, 14 builds out of 185

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

---
For more info write to <info@kernelci.org>
