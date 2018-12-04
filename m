Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B720661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="BbbevpNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7B720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeLDRM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:12:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37658 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeLDRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:12:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so16772058wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=pc2qkZ/fZj18Fzy7SVhPl63s4s0jlteEt+vDPnMNtME=;
        b=BbbevpNqYxZhavjtLpmMBTjRK/fbhFdYM3oabZPFhIhvVafZqkHJDKrOT5w6TnZzYm
         owKgzNLGfvbsZ70fXZjsO3SeWmIVtu8bcYQ6RPSYzAoSFP5GYesbEFTW5db90bgEhSYD
         xj5n+jWdAJuus7RZ/luup1jNsnHpdlKWotpOU0YG+XIGPsDgx2PeCrkHmkqUXsQWkVDu
         8hzKMk7ze5nXxG2nnO6B/A+HAoEKQ4/GR8k1P3FZy71bIFly1mTB+o17dYtXGneV1VFT
         d6y4MBKBKlahf+9KdNOBzQ+FLhboCG60iVqjcvPcT/3wBVx4iX8VuwFexp2czbvfttTL
         /wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=pc2qkZ/fZj18Fzy7SVhPl63s4s0jlteEt+vDPnMNtME=;
        b=CiYKW/7wGBDSw/yv4SMi0ZOrWvbY14hWRQqZ97aG3YgLl0YS+37WW7NPdD81nnfPTa
         JvDaCpfis5wyJwJO9RopudSuezh52tYvEswWMS9YzftFVSzhPeJLboMX3P+yHjGm/HMe
         /KF5HrCOq2Ggy/lOGC0raJcfVjPMnTMJkOfGIURE8YnAzhEFD2knfX9AeFB/gHFn4Vh6
         GRZ0CsX+BRRwFQZcz6mmulIYquCcdT8atVfmpcroRxhbxvLGnb1v4kP/FEreRktocJtG
         7jOVGM4du9zU2DkMzvtBtkL7MQqzeMoGBbcCn7HCUB/wm1OFEEcXpQxm3AE89e6Cn2hS
         8r5Q==
X-Gm-Message-State: AA+aEWZM2rs5k6u43tqVcOiWAhJxnJjHzfbIkE7jK+IbH72EdXg3yL8z
        cnwJZh0tuEtXtLKGVUB/UrK7wnK+DgHOYQ==
X-Google-Smtp-Source: AFSGD/U8GFbuTLnibeXSVxW234ClUkf7G0t5M+TKg1N1HlrUli92jCEGw1SlTDSm0evUKMxWy3G9hQ==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr17841828wri.210.1543943544333;
        Tue, 04 Dec 2018 09:12:24 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h4sm15663252wrt.66.2018.12.04.09.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:12:23 -0800 (PST)
Message-ID: <5c06b577.1c69fb81.1352a.a192@mx.google.com>
Date:   Tue, 04 Dec 2018 09:12:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.6-140-g987a6da5152c
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
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

stable-rc/linux-4.19.y boot: 120 boots: 0 failed, 117 passed with 2 offline=
, 1 untried/unknown (v4.19.6-140-g987a6da5152c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.6-140-g987a6da5152c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.6-140-g987a6da5152c/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.6-140-g987a6da5152c
Git Commit: 987a6da5152c29e37cc11de9a2d10a23a48015c9
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 62 unique boards, 23 SoC families, 15 builds out of 202

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

arm64:

    defconfig:
        meson-gxl-s905x-p212: 1 offline lab

---
For more info write to <info@kernelci.org>
