Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC55C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705042087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="YYNifdpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705042087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLKVdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:33:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37544 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeLKVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:33:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so3815838wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=cKlvjm7fBC+meqsyrz3rDtgbKIOCXkz9KOmZrmYCVcw=;
        b=YYNifdpDNJXanSgpLqER9euCxWv+gE4AItPVXpere8I8u3x+7B8KznF6CwHfx+vhqu
         iYmFgdA+5z0WEfKQQcIc0XuAXwp75gNCUfzo22H+Fo2PMUqJUUIaZYFTyN5+R8Nyw1Fm
         ZSO2irXQBR+6MTjNSOZOwU2frr63BqaqbP0IF/NoXKLuLbb+D607nQ21PMU0gag7vEGJ
         HtPvHuEPJoCasW3YVNsa1+aiBnl+Tdheyot1xO3FdJrGczvRbEM7O7O+nEhX+5N3TLwF
         1lg3RJEKBlchvOOoS4dgTBPYfrsH6Gnfu5ccrXlF2RDJPJR67S0Gb0Ot3nJAMiw6/c2W
         qmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=cKlvjm7fBC+meqsyrz3rDtgbKIOCXkz9KOmZrmYCVcw=;
        b=bePgoDx5s+2a99lHKi6G5mpxQBt/Ueyto9oU52iWyW7HZiZyc3Z1kd+gOfeu7t1yPz
         5K1QBvvA2y7naItWPr+WWTdaquSQubf8U+LRHE09GRaMNkTmbU0fW3UTqVVyWBOSVJr9
         Uv6O/hyTNEVRnbfU72uVj0WN4x/v7++903pYyZYVGSZd0xn4mmdaCs6n9/wZDjtuwzRP
         lfwdRLUFYnXOaLFZPwYoLr5R8I8OsVtrCOF5pvngM6KWeXP59ZpMl5Umj8B6LNn1nFTL
         S2PX/x69xIKnFb5kVo5tQotsk7LBvhDLTmgjbswOVM9ib85Z6b6gP9j8Gt880vnqTNeo
         XL5g==
X-Gm-Message-State: AA+aEWaR0ndlVlXS72qVuLTgzEApcYMm60HLLFKarvIiM6osrkRUBH7g
        P86TDvD6IARgPaP5m+b9kGZINw==
X-Google-Smtp-Source: AFSGD/UVebZXorNVFXg9oTT1WEkWLfQOc8YNx+/0jgDPVatWmwI8gJ/a6Qr/JCkZJPlp2sAR2geCGg==
X-Received: by 2002:a1c:c7cd:: with SMTP id x196mr3858597wmf.12.1544563983759;
        Tue, 11 Dec 2018 13:33:03 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id w18sm11315369wru.54.2018.12.11.13.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:33:02 -0800 (PST)
Message-ID: <5c102d0e.1c69fb81.db666.e058@mx.google.com>
Date:   Tue, 11 Dec 2018 13:33:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.87-68-g9557e80a8f28
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/67] 4.14.88-stable review
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

stable-rc/linux-4.14.y boot: 115 boots: 1 failed, 108 passed with 6 offline=
 (v4.14.87-68-g9557e80a8f28)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.87-68-g9557e80a8f28/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.87-68-g9557e80a8f28/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.87-68-g9557e80a8f28
Git Commit: 9557e80a8f28e6bae4083dcc7dc6c2d1cb38d758
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 60 unique boards, 23 SoC families, 12 builds out of 197

Boot Regressions Detected:

arm64:

    defconfig:
        rk3399-firefly:
            lab-baylibre-seattle: failing since 3 days (last pass: v4.14.86=
-56-g555f40d53cca - first fail: v4.14.87)

Boot Failure Detected:

arm64:

    defconfig
        rk3399-firefly: 1 failed lab

Offline Platforms:

arm:

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

    multi_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab
        stih410-b2120: 1 offline lab
        tegra30-beaver: 1 offline lab
        zynq-zc702: 1 offline lab

    tegra_defconfig:
        tegra30-beaver: 1 offline lab

---
For more info write to <info@kernelci.org>
