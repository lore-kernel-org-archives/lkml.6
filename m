Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB957C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D70A204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="DNm2rd/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbeLNSdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:33:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51541 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbeLNSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:33:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so6613736wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=7b/+10NrbExOOW2UWWJ1cvnnjtLmMz3m5NS8pOow5YQ=;
        b=DNm2rd/xr0LqWzf26n6IZ0gdkgmRPQSRM2505VXcDIXka+mjm/naun/AQkWhAFFyqG
         A5ifR/UDkcKvMryPJ1pr+H8RyBQdfjMqqV6NXw+OgAIjar08xU4P4i6Bwan2ULptWk45
         kuZsKE0ymWahzNQKqNvBFWTrsU6+KonnULPFYLHhesYfO0bX3fLJ0/lBpd3xn8HRqKCt
         W+jUNpeOdH4v3R7mnossdzfBggFIe7eAhU7KsMt3e+KLDPNnHEq+YkGvZZnhhkDGa8rY
         Cr5e9scmra3wy3ou9MWJw6O0bhvNAzjXE2wI7P+d9tTwbdF6f7XqHwbBIAGJGvfnImLY
         +P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=7b/+10NrbExOOW2UWWJ1cvnnjtLmMz3m5NS8pOow5YQ=;
        b=IRgBMwt3QyGR3UWFPfXHZGipA2BQlAqe6P8UECAQ0IXr4pgWM4qkvmZcrq6GoGzo5a
         erQvmiQeCXJVez8grWWZp9eryIOGqUaavMyByXtjFgeVho7eNrsxYCrxwGNvO/M6EBZf
         HQbP7C9XtirIhEb7e3gWfxHnUV+Z/h6ckzp+i9jQuJQe+PVfM8E9A9y71aqxHbRNgK8q
         WegNAADqpr9n8IDNxsSUyUipoU0ShwU58o5b+XwCKPPi2CYpsO4kfv3O/G68vt/WliVi
         hdA4qcMhtR8odnlrjv96KHRwyTq68PIGv5o97aYP6WstT48SGMkXrNmkl1gRwhxnqlSe
         fd/A==
X-Gm-Message-State: AA+aEWbZOIc1ROIvOrevsHPglgkTfLuq+2LAYnb1K6hT/98bVT5kUT5e
        zyOHIs7ajtUwb4n40POKuzfWrw==
X-Google-Smtp-Source: AFSGD/WdlLacXRaWrWQCE3qO1AY7qe/RsXY576aasCYu5aFt+y9OcdCbBlzr4BgnVdATsiEce0YgyA==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr4132874wmb.33.1544812416512;
        Fri, 14 Dec 2018 10:33:36 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id n9sm4088538wrx.80.2018.12.14.10.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 10:33:35 -0800 (PST)
Message-ID: <5c13f77f.1c69fb81.153bd.7405@mx.google.com>
Date:   Fri, 14 Dec 2018 10:33:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.9-143-g4875bf1f86d7
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
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

stable-rc/linux-4.19.y boot: 117 boots: 0 failed, 116 passed with 1 offline=
 (v4.19.9-143-g4875bf1f86d7)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.9-143-g4875bf1f86d7/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.9-143-g4875bf1f86d7/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.9-143-g4875bf1f86d7
Git Commit: 4875bf1f86d7bdc8dbf3222ab4028239446fab3f
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 62 unique boards, 23 SoC families, 12 builds out of 202

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
