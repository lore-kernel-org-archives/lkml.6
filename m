Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB5CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FE421104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="XeQwGCNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FE421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeK3G63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:58:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37258 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeK3G62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:58:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so3473531wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=wDu0sHLI0lN+zV4akauy0m6DXCtD5MNm9PFRZcmF0sA=;
        b=XeQwGCNNZT4NZ7LiZEvAKBuOv+xADjtenxd1etfgqd5/d4qAL4D0Uh2aQf+kOszJN5
         R/5xDiCFbsovnxBcWrudz1Tx0rskWwXZBYaqF4uuQ+0U568I9XRhCcPeZFv4B1OY/e9a
         5sNYlSq72UQtYSimGRaRMLBgoLEalg6i+zRpxSarDzIzeJNruhQxA7S+7hB/hXAl+8xl
         GVj0ju2Z97BeL2AEl1qmCW3wrOPUYba2wrd2sO60uixZ2Jy3voaELNRcmo+Oy6twC5tb
         Hnk/TDDDvkH9Jkv4qUVLz7lTFEwzfETFfkElclPuTPtCpCKeYsDZTgwV+yEFw7nj74R6
         kwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=wDu0sHLI0lN+zV4akauy0m6DXCtD5MNm9PFRZcmF0sA=;
        b=K0z47FzbC0Ont2/IMtVTY3+I3jJIIlBdxrc/31XVA5liMIlWltGBDo3O0TlJBIWREq
         Zu7VN48KukfCzYNcuvGk5y0TpPlDlDOCwkqitnWaGB8zGfydCBG0/63LfOEm/LoXNB8D
         Szlvd+x69ZSEiKhMvqEYmesvOz7pSQOZ20DQ8xv6n0X2QnDdlliCHnSWijkF83YYOMct
         vGML8cKNLWVYjv8Fh7RH0Grx4X7doOm9Jz4owTIrd1+73e90jvMyJzu1NXxMk3ZOJeuZ
         rE70D0nShL70BY5MW7E9TyIctyazS71YdP4bB89CCve5W4lTMVCszFfNPEG7vv5N51Iu
         Hjmw==
X-Gm-Message-State: AA+aEWbCJ1OAphwzMUDjtlNvM4s6y+BqbueyZEgUr2foU4ekod03LKRn
        LdcIg71beCk6L8uUP6uDbC28Lg==
X-Google-Smtp-Source: AFSGD/Xw6LQ84GR7RqQmC+i1gMfho9DzoL3k0YLpvsdS1gpT8d/yiDWzqMg5BRzQA3PxTod+Jgs/bQ==
X-Received: by 2002:a1c:eed2:: with SMTP id j79mr2864743wmi.98.1543521114419;
        Thu, 29 Nov 2018 11:51:54 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b18sm3390691wrw.83.2018.11.29.11.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:51:53 -0800 (PST)
Message-ID: <5c004359.1c69fb81.a2679.3c47@mx.google.com>
Date:   Thu, 29 Nov 2018 11:51:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v3.18.127-84-gd2846da19bca
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/83] 3.18.128-stable review
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

stable-rc/linux-3.18.y boot: 64 boots: 5 failed, 59 passed (v3.18.127-84-gd=
2846da19bca)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.127-84-gd2846da19bca/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.127-84-gd2846da19bca/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.127-84-gd2846da19bca
Git Commit: d2846da19bca0785a50c366d388d0da53c1b4042
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 26 unique boards, 12 SoC families, 14 builds out of 185

Boot Failures Detected:

arm:

    exynos_defconfig
        exynos4412-odroidx2: 1 failed lab

x86:

    x86_64_defconfig
        qemu: 3 failed labs
        x86-atom330: 1 failed lab

---
For more info write to <info@kernelci.org>
