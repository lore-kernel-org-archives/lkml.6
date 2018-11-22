Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE836C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB4820831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="jbDwEFfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB4820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbeKVQEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 11:04:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55854 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbeKVQEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 11:04:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so7554762wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 21:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Gf1sVQinnO4nKumS8Gh84YRjj6ygCl2slob4Xiuy/8Y=;
        b=jbDwEFfzS0yMDApI2188rJDwJ8TU6s9HNeJZljpaDTDNkNfOjw0GCjmnXM2kj6cEIT
         Q/ifCzVQdy6rUhadrPFKOfU05W4aLCgocS60l5bZI5z6iqJQoT9D5UQwTTuwPPyCA+Zg
         6i1xk+W8uUVeJUuy4lCpvI4g2/kaMTZSQGqPZH/FaE6W+rRTZvMDiCB0EV8pWTRpvYdw
         hj4XkLMxedAV+KaHlqlKaBq+worHnTHxQebkCzCC6nUnTrgdfrYuwmNa/5FzyGgxuC8C
         x9KazxuDM6isaPVqGrvHseTYoZ+4lcjIZkkIG7jK9FVdLABGwkda1RXd6awYNw2Qxq5A
         y4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Gf1sVQinnO4nKumS8Gh84YRjj6ygCl2slob4Xiuy/8Y=;
        b=PDp2yqV+tFICRUzRK5ky70gB9UJhwJ3MoH6uvJAGrX5zE8kAtxm1bwEoG4MfTvLNJG
         4IB0flQyZbG2XoJUx+Me86G7wRY8XZNXum9oD4gs8dYccDWly9w7vYqO17sEd8v5g4cH
         w7Biv4LRgcPdka6D0/s/tOLOD7Hrqxf81i+lpk+oN4AGRrG0UOFn7azPS2nVFcIDh/yf
         vV3FqcjQAeG/bmO+FK1FC1qHG/3285XQ1xK3jiyBWxeDS0lX2C0RwvigLn+doCvAN3ph
         8Sflyl743co+T8Zr5ChdAM4kRzzzsoVxFq/ADiJpjRgAqXnjwg5J/pjYAS7IBW+IolLI
         DESQ==
X-Gm-Message-State: AGRZ1gJruWQGJ9NvgF5pqqaxEXHAMKdSTBlvgOMOVVrRANwBd8wWUiWd
        MNcJ9n4VtpKxoTBW3oe10uThpA==
X-Google-Smtp-Source: AFSGD/XLmRXA3f6ajyyO9JoJ5TWhamWFnMRLlsSJ7M4etgHwbcU3B79LhTeamFbadQASojLhkj17xw==
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr8143046wme.22.1542864380887;
        Wed, 21 Nov 2018 21:26:20 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x79sm7207319wmd.42.2018.11.21.21.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 21:26:20 -0800 (PST)
Message-ID: <5bf63dfc.1c69fb81.f6a67.a9b9@mx.google.com>
Date:   Wed, 21 Nov 2018 21:26:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.3-43-g2b8db8734888
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
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

stable-rc/linux-4.19.y boot: 96 boots: 0 failed, 93 passed with 3 offline (=
v4.19.3-43-g2b8db8734888)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.3-43-g2b8db8734888/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.3-43-g2b8db8734888/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.3-43-g2b8db8734888
Git Commit: 2b8db8734888b00156c6afb235eda91aa71da503
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 55 unique boards, 21 SoC families, 15 builds out of 198

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

arm64:

    defconfig:
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab

---
For more info write to <info@kernelci.org>
