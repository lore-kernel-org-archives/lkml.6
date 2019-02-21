Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6087C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860992083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="r2cbNYGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfBUSUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:20:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54634 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfBUST7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:19:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so10545282wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=DELOPRMR14SZBBN1bg9HA95X74/PW0GpveHHQ2FcDq4=;
        b=r2cbNYGYukivZ0NakrW7oAgMmjNQfpBQzifCgz9wM8CfuZiokI+SkxmKWd2JtxZUXT
         nR2H3RvzydgFAt+u7YubVUJ5GCKb/D/EFCMY89zKzXn/zO38Tw4s3mU8Tt9rFzOaTrf8
         MA43AetTtvJjLkZs1ZJR9a4C3fgjisxoClIVvBwoA6RPI4WLvsuq8yfRTYWunKIAflWg
         2seeQ9nzBZu7+ogmaMeyMCpDOJBep4LKTqXa+RcRriVwvCczr+/aPTQUgfPYzydUQYXr
         a5FRk4tHgyl3/v58JyXa+6ldyOwFySuU+RcF8Mb0s9C6YWGFbfQUgqinshsCgwGmgQzy
         mybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=DELOPRMR14SZBBN1bg9HA95X74/PW0GpveHHQ2FcDq4=;
        b=O+zwvFswtBq0TPy8k4icl7x0RH4MKuYkGlq2IQivh2rIChqDr5/4X9QvtfhoKLWkNM
         TQgLz8NKL/DqSN4qA9575HXtLA4Qqb8QZYS1P5hDFmOdlXw5+VPFp2UHe20bh7vusBAo
         E1Bd2bEvliCqnIx1Ae3i7IR5bbHWyeNw8bmvr4YqwcsI1km9SLczqp6or0hVs7A0PJa4
         fCYOmJKm89WJLbpQZBIAdEeUT5SmQG8UU6TPn0oVNTjV6ojm1BnXoxv+GgmKsXzTJRgM
         ReRM6Q/PyZ7685PNaIwXx7QjFIlS//dG4HvJSwzkqSoBOSP2X3rjBiaJ1NT39k1yIGTs
         pIRA==
X-Gm-Message-State: AHQUAubSphN2I2bYLiK7xjPlDVD5YnC5QTXHw/9pRVQpVVS+imbgiGQ1
        P0fs3v/samwBZZGlkAf0Gmpk0A==
X-Google-Smtp-Source: AHgI3IaX3ohzkYxlC9SkspHYufnX/qRRPHxwIJMnDqwax8czIi0mpTtJtLIY++ZLweSnr/sT8jrc0w==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr11493864wmi.28.1550773197797;
        Thu, 21 Feb 2019 10:19:57 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h184sm15516901wmf.0.2019.02.21.10.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 10:19:55 -0800 (PST)
Message-ID: <5c6eebcb.1c69fb81.14fd2.0627@mx.google.com>
Date:   Thu, 21 Feb 2019 10:19:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v3.18.135-14-ge5aba7843b9c
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
In-Reply-To: <20190221125240.091472334@linuxfoundation.org>
References: <20190221125240.091472334@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/13] 3.18.136-stable review
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

stable-rc/linux-3.18.y boot: 46 boots: 0 failed, 44 passed with 2 offline (=
v3.18.135-14-ge5aba7843b9c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.135-14-ge5aba7843b9c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.135-14-ge5aba7843b9c/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.135-14-ge5aba7843b9c
Git Commit: e5aba7843b9cba24e3e4477fedc010b6801ebbc0
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 18 unique boards, 11 SoC families, 11 builds out of 185

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

---
For more info write to <info@kernelci.org>
