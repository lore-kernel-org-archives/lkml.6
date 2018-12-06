Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D01C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75DC20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="pyxXeCT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75DC20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLFUci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:32:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32843 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLFUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:32:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so1819339wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=hkcRWuUPYeAASQ/6P/Nhj0bkRKp3JyTj/Pw4jOX7Yqw=;
        b=pyxXeCT9ar0ZgskmG6WpLJD5NQG80XKPBjqGfzCfehutOWjm4KjjDc1qwRRUJOCaPO
         c7VIXxk9b7HpbQ4iuJBkNIXzibb1eCYjbQ/dRlfgH5SFBSqBOIm+61ewtGlZmaaW44Se
         srl31fN6i5oCU5ibcGIKO/oavG2y7qZpbeuomYZS8WcpXtDyyvo/1oeSyjx0AFiI8iGS
         xd3fLy7MvRQEsnCLYg2DoNcfZ8jDDfRK+Ofp2kZBnAHrsINUYBgPMRlZszfInOLWKhnT
         BGvMVdMvjMlGLClsRLYlg8tOKzeOdbAOFqyKD5Ckf04C4Qo4KXvblvHNAczJAIcH8PKy
         /bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=hkcRWuUPYeAASQ/6P/Nhj0bkRKp3JyTj/Pw4jOX7Yqw=;
        b=DTq0C88PfHXW6L6P6PYeGi3Z6hXq3DzBLwFXzSZPi12vYYw7utYq+DnXSYFZsRtzwe
         BPGCvnA0nRREK9zHPEcyg0JldOi/zr+ft6L1tz/nW6T90R2OmXjzsJ9iWswfpBeuwybo
         RPTJiQAUeLvZoeLiApMF9QsSpn+/sKg6baNwxtTe9gPWArII9F/85V+LktBAbN05JBnk
         LBSDSlaX/qmbp8ric7lVZW4UKkWBYIARLc5xtvdA0lZv2eaulEy8BjtLVFR2qh7HQDJH
         sO+p0HEsW1V0aBdgsM/YNJ1A+BMyigEH/N0zkR/vvTV6klV6y07BqESO1s0IWPfNFq2w
         29bQ==
X-Gm-Message-State: AA+aEWZnnNZj8s06c/m2dDEX/r2GOdTMNMsv2l53Gi24GfVSF9ZN6RQC
        uSnPQaIWRlQzFMERcWGPqG12jg==
X-Google-Smtp-Source: AFSGD/U6Ha773J41alvgGwZ4yP8kfL+j2CJQwRcK+UUujRFDfQz/BGZFajssEo/L/dF8nG+FWUTrHA==
X-Received: by 2002:adf:f649:: with SMTP id x9mr26210236wrp.247.1544128356899;
        Thu, 06 Dec 2018 12:32:36 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id j202sm3156370wmf.15.2018.12.06.12.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 12:32:36 -0800 (PST)
Message-ID: <5c098764.1c69fb81.ca983.341b@mx.google.com>
Date:   Thu, 06 Dec 2018 12:32:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.7-42-g62b84b3cf313
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/41] 4.19.8-stable review
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

stable-rc/linux-4.19.y boot: 120 boots: 0 failed, 119 passed with 1 offline=
 (v4.19.7-42-g62b84b3cf313)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.7-42-g62b84b3cf313/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.7-42-g62b84b3cf313/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.7-42-g62b84b3cf313
Git Commit: 62b84b3cf313e064c6ad249e95a5fb8feb22c77e
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 60 unique boards, 23 SoC families, 14 builds out of 202

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
