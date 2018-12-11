Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE5C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F12420851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="y/BpQFqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F12420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLKUdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:33:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36102 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKUdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:33:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so13691229edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 12:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=x7X5VX0/enjjRolAMPSTcXLa+sacGx9rCmX/XfkBe3o=;
        b=y/BpQFqAoRcCeygrSHKLQLPLJIKeMnjPhS84jZINujpUnC6M3SEsbVELje8Q5c1SPP
         bGsnwGfR/u+ihw3YVIDTZnLTivw4UmMc4r/gBtmZhIihMgolgCJYuuzsjx/ll/Jlzo7Z
         kmqjP2RuQGbhWf8yweqII+ffZf1ZEF2dH5EWtoTopE2kF/Pi7DveF/6scby31XCoB3cM
         dnkIPf+JcjVPqYhrUsiRSt/kc0ifY/d6Yf1/7+JZ+Ly8OtulMlUS8J/M9nX5sTWZTkAd
         Fdy34luK3inFbso5u/z8dQxocrvW4EavxHtnKFQaMl0VKZF3RdMM/CHigqEOTht60d7D
         Hf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=x7X5VX0/enjjRolAMPSTcXLa+sacGx9rCmX/XfkBe3o=;
        b=MAxhN5D4QpbyvMe3JlzbSkLzaVXgdOk1cqh2ZtNebL5oORCaCdelHlhUJsC2s5P0j4
         bSgagrow7/yWulJIS1jsfKl/CfURh+kymCuPbkKWOfeFgo2Wue8eQntPqUUkVsPW9eyn
         AD4RQmK4OsENV9JENBkjdco8BOn575GWCM58A8hxi67jgEbcjD9BArv1sNrkJwJP9Idj
         wATikfRRIAAwlZ+S1imG/ZVnCs5Ld5+bouK5wNyrI+dIigsebeblVJk4HBzznrpKxkEs
         taG7eCcUB12cdwjHd2jaRLGIh3xxdAqY1QhLCYFlCGDCY9/Rn0WlL8BWnSAWhEYM2sWr
         J/LQ==
X-Gm-Message-State: AA+aEWa9l3Gj6LeQOEBjiTdQZhuCEjFVGlJp0gutD6HZXJO6Bs2NvmQ3
        EP9zvl1+MNuPJNC1dklj6FwOJA==
X-Google-Smtp-Source: AFSGD/VfyMreqRQcQL+tyHQWhXPCseSA9b7mQ+vBB+ZxQTqM5TpRPC6EloUBr9AIfA8ag4dK2v0Hzw==
X-Received: by 2002:a50:f4c3:: with SMTP id v3mr16217735edm.196.1544560383213;
        Tue, 11 Dec 2018 12:33:03 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c38sm4276408edb.15.2018.12.11.12.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 12:33:02 -0800 (PST)
Message-ID: <5c101efe.1c69fb81.84622.8ff6@mx.google.com>
Date:   Tue, 11 Dec 2018 12:33:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.144-52-g8705173bd0fe
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/51] 4.9.145-stable review
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

stable-rc/linux-4.9.y boot: 102 boots: 0 failed, 95 passed with 6 offline, =
1 untried/unknown (v4.9.144-52-g8705173bd0fe)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.144-52-g8705173bd0fe/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.144-52-g8705173bd0fe/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.144-52-g8705173bd0fe
Git Commit: 8705173bd0fed9cbde3a23f8b1680e9f997d7019
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 49 unique boards, 21 SoC families, 13 builds out of 193

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
