Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9FDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F189A20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="MuPYaquT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F189A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLFUMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:12:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37916 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:12:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so2365826wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=T0pLC4iMCNPCig/8AcMJIz9QI262AjSzHsrEpOfECk8=;
        b=MuPYaquTjkanNAV1yWOBJ5/4uxv0pBlHAS8aEEIGJb67u1Cm6w8l+nsGqx1dSyraCT
         EmvBLwbZ8lAu+x/vYopOQje7dHuLN7OFlnWgpqDE0rtD5gtYTpHiOFi0d42NMaR+TWzd
         wi2iQo8hR4IUTMqVkY818VKpuiicYTcciw9peS8+xI1nhaS4tYK8Yb8D9nqIm61fNbhS
         GNK+XdZ6x8Vi9yZTZQ/5d0+AqiaxPPqCOIdJFCUGm8y5DKbKwPcVwlTNywKMTI5Q5Z81
         /7nzZB70eKCswWiGt3yZNH+Ccve+STrlGC7GJUTM2HmDXYq5N4ETvilBTxB9rkesdKPQ
         1U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=T0pLC4iMCNPCig/8AcMJIz9QI262AjSzHsrEpOfECk8=;
        b=Fi23f/pt/oQjOg6JM2MTSLEWH6pvOdObfbEvfQa1uCZX0HR7WMefw2ADkoi0NoeoFf
         pZFRTq1R1pKBQbKtwEBTavUyGSvSAQagekaNZz8MsCAPzeNHf91g+C/2omAWSGNcp6mi
         Rz/FqJsryrTvk8U91zSOyCnXPKsFAjefm2AygSa5lqeUHBrXRgpvy6L7g2tNxIfphyUS
         CYW6ntiNX8UP/VlFUn4MnLY548UWaVo29qtY2BZIMqtubckZTFN5ulEDzPmEM0OW49ow
         qKEO1FEWDrj+/jGtGdAI7lQTo+Cb5NoWmZFybgz29c1UAPxuxZn9eSlyC+mJAXKTYJWr
         p6+w==
X-Gm-Message-State: AA+aEWYztftcPhyqbakY6OODnBQlWBOnZr6T8PqqmH+mVkBKTWK9MVYl
        lEjlOnQnVDS08Ofcr5HPA6LBvlPi1sCYlA==
X-Google-Smtp-Source: AFSGD/VZm27RQyH1eaENkwVaXm4WO1ErQu0PH0HaAKQk4+IxV7OkDTVdd/RtmL9jCOhRvwywIDuvHg==
X-Received: by 2002:a1c:11c1:: with SMTP id 184mr16251784wmr.59.1544127156388;
        Thu, 06 Dec 2018 12:12:36 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id e16sm1893885wrn.72.2018.12.06.12.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 12:12:35 -0800 (PST)
Message-ID: <5c0982b3.1c69fb81.a088c.c15a@mx.google.com>
Date:   Thu, 06 Dec 2018 12:12:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.143-102-gcf137e4b4373
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/101] 4.9.144-stable review
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

stable-rc/linux-4.9.y boot: 105 boots: 0 failed, 104 passed with 1 offline =
(v4.9.143-102-gcf137e4b4373)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.143-102-gcf137e4b4373/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.143-102-gcf137e4b4373/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.143-102-gcf137e4b4373
Git Commit: cf137e4b43737b5c238350d3e22f031c616dd9f9
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 47 unique boards, 20 SoC families, 15 builds out of 193

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
