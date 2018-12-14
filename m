Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2CFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C77206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ee41EiGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbeLNRdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:33:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50846 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730173AbeLNRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:33:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so6471644wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=LtUEGN2KTid2H67NJYqA1kdw1NltoUyuDSk5ZP1VJgM=;
        b=ee41EiGL8x5Blt45FM9bOZ5cpcyMmd4qdYgsYrYtPfLTmmFM1qUNO8I0xCjTnScina
         r8KyJbye/WxJmtgMKRDrrg3bVgH6BPV+95RP/Wm/F+IZt9mVx8v8XS6kiqiKqyA6tq48
         rvNRSPtySJxVQpjy6H8UutsPNl8TONgc8eHY4rGTZzbW1YYgU+OJeoVNZbZtlmUSJodK
         w0WlL26ZLY/ymkdItC/9GQ6aofmdI0TyrwS7xDoBsKopI+Jp+zVYWIZnGVmDpEpLLPtL
         NG8gs0uTieesciubInlTP0qwA927IRJMDAc/Sb7vYYi+6F7aiuWO0pUP7BKeHoj0axvt
         4LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=LtUEGN2KTid2H67NJYqA1kdw1NltoUyuDSk5ZP1VJgM=;
        b=UWuYSPqXFHAos1R54QFRCAebP0650DQbetFKKzrZmIO0wB2qz/zPZkhK5Qu5/Rg1J1
         SVpzcBu/ZCtA1/oGxYLhnxq/Q41o7A4IfSEBwy7p232ktO7IIbrTzHcX1QVnCdClwGSj
         6UugVedBDzbQ8AWiM7QSOje4DJDUplH+roHqPpQbBR0PsqJk+FoFZ6m8MoBnQVEM9feT
         /MHYU/M8iS2boCLDr3+SJ/Ux0ZLofy4hXFvZdOXwAeIspuqY1/YItGPYIxDn9h04SzLS
         05MlpgwHSTUUQ+s5c7yYnjzoZ8AY6imCYEVyIvjbXY0PBmfnr5Q0JtaWyiYjxr8/uYhS
         nj4A==
X-Gm-Message-State: AA+aEWaE0bljn4r0vcpraYC5qtc+t5Tcw+GlVQyeisqNr5Ma0K5Sia6m
        coyQH6bED9HDbiAdp5q/aciUBQ==
X-Google-Smtp-Source: AFSGD/UINq0Yy6jSUC4sDAmiSZQDY47bNWfSjVnN0IHyzOfdGEc3mbHoSLOgPUkjqed9nWIAOqENew==
X-Received: by 2002:a1c:c343:: with SMTP id t64mr4179255wmf.88.1544808800204;
        Fri, 14 Dec 2018 09:33:20 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id j8sm8928792wmd.0.2018.12.14.09.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:33:17 -0800 (PST)
Message-ID: <5c13e95d.1c69fb81.bf7ca.5039@mx.google.com>
Date:   Fri, 14 Dec 2018 09:33:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.4.167-89-g9c558d7fe359
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
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

stable-rc/linux-4.4.y boot: 93 boots: 1 failed, 91 passed with 1 offline (v=
4.4.167-89-g9c558d7fe359)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.167-89-g9c558d7fe359/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.167-89-g9c558d7fe359/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.167-89-g9c558d7fe359
Git Commit: 9c558d7fe359a962e214e426ffeb338e012bba39
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 42 unique boards, 20 SoC families, 12 builds out of 187

Boot Failure Detected:

arm64:

    defconfig
        qcom-qdf2400: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
