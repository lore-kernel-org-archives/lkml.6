Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8D6C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2CA20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="AznjsuYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2CA20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLKUxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:53:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40555 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKUxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:53:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so3700682wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=A+azAyJhar+p1MVbzkEHo0DHZqgLAGJgNfrXURxkg3s=;
        b=AznjsuYrGrq1ltna5FocLm0bzPtswbkg8SGWPbbbxfJWShcqAshVF/AvlWuA03380i
         Eq8uudMoOeAg8sEmAIXnk1w3oa+eNN7QDoZGpArSMxh+huYksG+t9rwJHXTK7AgJEEp9
         cvFp+4xvMCP1HydIqUQFpiNPgF58s5RaFVxKp1qKAKsvSlV04l52897C7HrX2C2uzjHx
         gKOFeGKmq/gBWccT4trxD3UInxqGL957qhe5n3AWKT4UVZ76D3MLPjdqRq2DTDBHC/Fz
         EeElnP4Hv7wE+3SQtI4vL4yxg68LIh8RYEFA6YwNRfh6b9RzdPWXfNJ8xdGAPoDL3Hbk
         KmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=A+azAyJhar+p1MVbzkEHo0DHZqgLAGJgNfrXURxkg3s=;
        b=WyBqCYPZe2gYPsTfj7/SZigPq6hkknD8PRdD8j+aH1BQuFz6Ma7BY9ymDbKzidXsUW
         aYIBDisiM2kRQ5LIbTRQeW1s8Y98B/IwqM+zQb28JomlcFNVt7RhRP62MaeNhnqzer6N
         5h8PS0c2mIzbaOfSnOGSF5uDISFawh0SNU1EGOU9VoUER7x5eBu95MmjXfvsNE/KDUav
         FlmqWfaOPnJ7DTpK80o1N/8LPz3Zb48OeTsJQw4Rx6LUeV7OkTHuRVYax3yFNfYiuNQo
         G8RNpx144zX05TGcBSxBvX5iRZVgdHzcY/f1OgAEM9hgv+RZxXrgcnv+0O1qKk5gricG
         JVUw==
X-Gm-Message-State: AA+aEWaH65yQ94muR73gexQl+V0PaNKESLyqnH9AcN0HfGqLvoP78gGS
        U5cGopda1wX62iD2dq0zILHRsA==
X-Google-Smtp-Source: AFSGD/VcPdcCve+0keXy2tPA9eX7mpz+iBRDipxSjsZs4rM+G4niksTPfbo02fCV31ejmznJY/o2pQ==
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr3703436wmh.124.1544561583654;
        Tue, 11 Dec 2018 12:53:03 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d16sm3323085wru.52.2018.12.11.12.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 12:53:02 -0800 (PST)
Message-ID: <5c1023ae.1c69fb81.91d4b.3927@mx.google.com>
Date:   Tue, 11 Dec 2018 12:53:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.128-55-g93a539f50736
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/54] 3.18.129-stable review
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

stable-rc/linux-3.18.y boot: 53 boots: 2 failed, 46 passed with 5 offline (=
v3.18.128-55-g93a539f50736)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.128-55-g93a539f50736/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.128-55-g93a539f50736/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.128-55-g93a539f50736
Git Commit: 93a539f507363d7acb7eafbbd58942574b7ff4f5
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 22 unique boards, 11 SoC families, 11 builds out of 185

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        omap3-beagle-xm:
            lab-baylibre: new failure (last pass: v3.18.128-41-g5c19427b8de=
c)

Boot Failures Detected:

arm:

    exynos_defconfig
        exynos4412-odroidx2: 1 failed lab

    omap2plus_defconfig
        omap3-beagle-xm: 1 failed lab

Offline Platforms:

arm:

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

    multi_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab
        tegra30-beaver: 1 offline lab
        zynq-zc702: 1 offline lab

    tegra_defconfig:
        tegra30-beaver: 1 offline lab

---
For more info write to <info@kernelci.org>
