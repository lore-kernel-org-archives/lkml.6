Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD921104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="lZP8zNmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAD921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeK3G6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:58:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38262 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbeK3G6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:58:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id k198so3487924wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=qqFXZH2bviU9VvtWAjJmgTDOaU8MT5bPB+D4lIawCEs=;
        b=lZP8zNmLb/D63xau8A/2lpIt42M2+bjpdiMR2KmEP2nDRNjYtE2HaWMB9yIw7NQvtp
         w3ufKIFJ92sqKaeel9XoKgyi8RMJAmearzFWZ17W+3dCmzpi/NrPfcNGPSwkixfcVgMU
         cZ+9E3CpQceGmjIli9G16QBOXW0cw2KakPYT7+W1Kc3kKEwGhIHbUd+YYRuWPDveEd1B
         QNkpu764YcLE7i9q4q1FjkjJsI16FRsLO6roWMUY915KG+o623bUGp3G+jVSigx55/K9
         T7IJG/GZxa64a3dG2XTAUkfePTi1xNilxaF/E/gP0eisJ6B4/keu7+pkO9ZXFMwxxfQA
         rFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=qqFXZH2bviU9VvtWAjJmgTDOaU8MT5bPB+D4lIawCEs=;
        b=GzlrQXxdrxAmr1XYvQ65e2YxC1aeKSVyFrjtZ0GcdyJ7EEt7KHQhAqDoK2c9ZH3H6y
         WkDAHdC0/Q3RhZ80jF2y5nE2IGvMtYgccQxUahHkJ14TSKlhxK+dLcoIk5wcSWquKBXz
         lFxI2I+ta14A/ha2pgqHEP9XdZpdB5eJdJy7isgNXstMCwLhR+TH/HbTL58XHYctPAzi
         yt6A8IQcTHT3rf7YUB+JaSE2XseLUi3+2/z/CNsBFeM+qgP2NRqMDpeXK5XRC2oIiVvN
         GFGxrNJ8l6mY5jfMfN6ocGdAYiz69ZG1hW+J+7YoHvw+TReHVZTlr1PRP0eleJqFCcDj
         1YYQ==
X-Gm-Message-State: AA+aEWaGECysimLYqsB5blap0sCoTuKS29wObIL44Fm8A9H4R9zx0UvG
        4CEyLx6qYNVic0A8BsW7k43dAw==
X-Google-Smtp-Source: AFSGD/W7LOaKQR6OGHxSTVK3MWpBnmok08NevtGhuiYqIvN/97btl4j85ToRJBm7T0j87UqnqpQIbg==
X-Received: by 2002:a1c:f8f:: with SMTP id 137mr1015186wmp.96.1543521115971;
        Thu, 29 Nov 2018 11:51:55 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id l13sm5471626wmb.27.2018.11.29.11.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:51:55 -0800 (PST)
Message-ID: <5c00435b.1c69fb81.e17c3.12c9@mx.google.com>
Date:   Thu, 29 Nov 2018 11:51:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.84-101-gfed8ae3e80b0
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/100] 4.14.85-stable review
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

stable-rc/linux-4.14.y boot: 121 boots: 0 failed, 117 passed with 3 offline=
, 1 conflict (v4.14.84-101-gfed8ae3e80b0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.84-101-gfed8ae3e80b0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.84-101-gfed8ae3e80b0/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.84-101-gfed8ae3e80b0
Git Commit: fed8ae3e80b06a2e8f9c86798dec421d50054bab
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 66 unique boards, 24 SoC families, 14 builds out of 197

Boot Regressions Detected:

arm64:

    defconfig:
        meson-gxbb-p200:
            lab-baylibre: new failure (last pass: v4.14.83-63-g0ece78cdc128)

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

arm64:

    defconfig:
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm64:

    defconfig:
        meson-gxbb-p200:
            lab-baylibre: FAIL
            lab-baylibre-seattle: PASS

---
For more info write to <info@kernelci.org>
