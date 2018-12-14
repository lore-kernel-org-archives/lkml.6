Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8665C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160D3206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="DTp6HEqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeLNPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:53:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36104 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeLNPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:53:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id a18so6294894wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=YvkNmTV6SriyirEOqoFl5h3mfuoW6KRK41aAR/ktIgw=;
        b=DTp6HEqFOtaLGaXsu9b1Z8LrwHFpsgFt++7O0r8scwZ6umI/uSb3GglSzAr0t2wa6b
         eA7nNn/BFDurhKunQZ8S67pfZZ+CaGXgdaF8ByzdRqBjWoYSZqw2ww3J/GkgAA+QKUEJ
         NGQwwS/mDdQ4/0moz0oFJEuNPNmopU8GaxGaUHwCfz0HCUAtP6rTcC5BiNEfVYzkDCHZ
         f5NZ3nG6nogzzI/R4wyCLEVUmTm8dMVS5D96ELyWYilfau4SfLMsgzgmgpRYsofhJYSI
         wQ/+LdaAVOlpKiPh4w/Ng/yX5uz0z/aumoNjQaSwmjPqs9KAbMV93gnp1NnGEyo2/287
         Z2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=YvkNmTV6SriyirEOqoFl5h3mfuoW6KRK41aAR/ktIgw=;
        b=cN/Q8FrZE/jRHz312nI6FS3mZx3H9aMzQMX0LPa3bZ8ij6jEvQye0ju7Ua0i6YAuzj
         3NlD5RJdSZbpaVdTBWnZf9f0kTUn9n6Vi20BlUjIkhLz2ZrmdfHR4tYMklislLVBKFZI
         46H0pPkKJxQ+Xk+3vinvDmmEaUJXuh1Ls7H2j5/Ex88zMxYGk4xwdm+cSVXhDR7TUGtp
         x7IHIbNeb2yfUCP+osWsbXHLx+b1DjrpeaUZQx0awMUbreQZVopGYsrYpUZyZj3m3LyN
         BfAk4eSEkpyYOLo9kirEFID5Or8r+ZBUOk2v3HR625hOxHmxaK9th/Q1fKbX36i+1Gfl
         M9gw==
X-Gm-Message-State: AA+aEWbO1W//lrRrlfp9F/tA2aPZ98tiP3cwqtu0lzzseyv7jS5zCoLj
        OuX6kZd3iRs8JZ9OGFdge8j0NA==
X-Google-Smtp-Source: AFSGD/W9mEjEOAs8e94utyQc9PC6xnzUQzT6bbhnVEuD2fLbFHHcpSxZ4EnyAQqI9a/Q5ProiFtssw==
X-Received: by 2002:a1c:3ed0:: with SMTP id l199mr3634153wma.34.1544802799377;
        Fri, 14 Dec 2018 07:53:19 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id j202sm9359312wmf.15.2018.12.14.07.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 07:53:18 -0800 (PST)
Message-ID: <5c13d1ee.1c69fb81.3356f.4fab@mx.google.com>
Date:   Fri, 14 Dec 2018 07:53:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.9.145-51-gf9ce7a5debd5
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/51] 4.9.146-stable review
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

stable-rc/linux-4.9.y boot: 104 boots: 0 failed, 101 passed with 1 offline,=
 1 untried/unknown, 1 conflict (v4.9.145-51-gf9ce7a5debd5)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.145-51-gf9ce7a5debd5/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.145-51-gf9ce7a5debd5/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.145-51-gf9ce7a5debd5
Git Commit: f9ce7a5debd5bc3267eedb2f1e7a91ecee79461c
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 49 unique boards, 21 SoC families, 13 builds out of 193

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5422-odroidxu3:
            lab-baylibre: new failure (last pass: v4.9.145)

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    exynos_defconfig:
        exynos5422-odroidxu3:
            lab-baylibre: FAIL
            lab-collabora: PASS

---
For more info write to <info@kernelci.org>
