Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF36C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B212081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="1mI44K5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B212081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeLDRc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:32:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39382 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:32:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so16854103wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=w3Fr+Sfcr2l1OFCevvEmc/S9MtRhE79N3XUuP6w6MFg=;
        b=1mI44K5IRZdOygpNdb/Eat9HjIMo6HMLMAqK4G08NiHjwaRmkqi765GliffAIyL5Dx
         trDqGeO1DUg3krvziXPD3X0Q3wYsxSGqGBbjx1F0n4pSILa1HXK65zMGXrAdV5eJ1P/N
         oquF/MMZ6fknpX5G7CFcQ8RqHGFwQ+s0NmhbIXJ2frs3at2nd+d9D7CValpmIKcVI8dO
         cKlzgX/zVG6YCEWi4c5esKvH3ZkaERYB7wGfb0Pq24esyFZ4Lm4O2Q4DqRFORqy007zO
         XTK3logddOVrcYEx5xorvnAsa2b19jG1cnzxmcI9ivINOk8JuLwzmDdG0emPQr99+66L
         2x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=w3Fr+Sfcr2l1OFCevvEmc/S9MtRhE79N3XUuP6w6MFg=;
        b=YGigYUfD/i7/yVv5l8T9M2OXOEurb25qGJd++Ora2024r/gSBppjkzWg7adNZQJavG
         JGQGjv4JEOgpc1ESgb1O+p3lep9X610fWnboarpp7fON/j/PtXSLJfuxVBNf/jjqH7Dp
         vTPWgm30LKcHStbGvXJ1D7jQ7KejtJ0Xip6iTOQpTXITNMtB8Fxj1F6F2i8K1DksyaiT
         Qqjk43PBAK5YgMk15pK0iDj8UXqKU/NuUXTCvz+s3DDxZeFWgLiwenQjmPWO5xv3U142
         g0B+f+LI5S1ssEMaQhR9conaycnhTvcpwjH6vhso1XiNHpRBzGM6AQTsn17QDFNaS2L7
         zqYg==
X-Gm-Message-State: AA+aEWbpvrtB+a0zl959+XY3g9kp6jU/L6MpOyFAqO0zJLrG9KJBfADp
        qy/Q1fIBNvLmGLI3z4508E3nmw==
X-Google-Smtp-Source: AFSGD/W1j8d+gptWYN5PJTVaDwQrmO82K1WR2wGQH0erMRhW9IDdMtsVXcgzYFDwAz1PX+DzM7EARw==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr19769176wro.262.1543944744343;
        Tue, 04 Dec 2018 09:32:24 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t5sm11512327wmd.15.2018.12.04.09.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:32:23 -0800 (PST)
Message-ID: <5c06ba27.1c69fb81.f1cf.f930@mx.google.com>
Date:   Tue, 04 Dec 2018 09:32:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.85-147-g2bfd08691add
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/146] 4.14.86-stable review
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

stable-rc/linux-4.14.y boot: 120 boots: 0 failed, 118 passed with 2 offline=
 (v4.14.85-147-g2bfd08691add)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.85-147-g2bfd08691add/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.85-147-g2bfd08691add/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.85-147-g2bfd08691add
Git Commit: 2bfd08691add5955f6d58006360c4a78edce64d0
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 59 unique boards, 23 SoC families, 14 builds out of 197

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

arm64:

    defconfig:
        meson-gxl-s905x-p212: 1 offline lab

---
For more info write to <info@kernelci.org>
