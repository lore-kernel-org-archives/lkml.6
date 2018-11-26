Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D2FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45C120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="b9L9KF2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45C120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeK0DYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:24:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38492 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeK0DYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:24:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so16146455wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=cW/1IctGcBURfr07rFHdHj95hoQxGRbYUUyVLvb2fj4=;
        b=b9L9KF2fbAnMU0fe1NlSVJHGDi0v4t+24QOvJzhCxoT7Kb3qFZpAfLo00BAZg18W7p
         GoL+rPs59/QAX+FYwr9e7toiCVTwnIysLzUC78kzYJQ1XYypyS8BhtynEhyEIvw/thLH
         D9VVFmbvuOWhbhXnXpcXaD8p04tTXYaC/zh0kSGZHJCXwQxLjZgcqM5F7Q1CllwW+9Dp
         8JLCR1/AtW4cIOP4gfp3q0Tf9FrifAXEh1Sa69edqcARiZW9d2kaZjFXtky9EftHCswt
         yhoqiL+AGW8NHZ4MyqFTZ1DkIkdaA2vomwUewoAgNKVbSE3+P88ZUsIfqo/POyfxsGLG
         UF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=cW/1IctGcBURfr07rFHdHj95hoQxGRbYUUyVLvb2fj4=;
        b=FYP2f94u93a+E4lEGvm65vLlE4W+6UbTqBurvjWuRnAwBKQFr9DFHSqK4J+UpjVzpF
         prCrRdwlz5ks/v8ZTnR098v+VZnKffcFI8KKqSvyGj55SXTsRdRmp8CXArz7cWFcmrwZ
         784TGSFf3LH37mZMjrrd098J5ZxcDOhds1J+mRStong9o2L3Ua+1bMlxk1HFpUYiAtLd
         PF0a3iCoVrRFK4BkXY6i1DA30N3JT9SK6I5nW7DtsfyQTOdvu5CVFHczh8/q1RJ/Sd+Y
         MR+b8vBO5u+ycV1jYCJ63In7I8rIDJTL3t/GnSbaaz8gZVvDbzfHsFpNoaPbndQgpfjJ
         cqgA==
X-Gm-Message-State: AA+aEWZB4JPqbE5XR2dYJ8zCXefqlJ9hPEKCzTpMbNyg26fkiN4fhiyN
        zyXJE5srtQJHjsBp6XBL4xqXPQ==
X-Google-Smtp-Source: AFSGD/XozVs+C82YIZTOqiAhuoRjyx5Qn5qE5qI7R2aWLLCZrzPk5sOTMJbSrhL501EiZWx9iDYPOg==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr25629188wrx.302.1543249788462;
        Mon, 26 Nov 2018 08:29:48 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z17sm1044351wrv.2.2018.11.26.08.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:29:47 -0800 (PST)
Message-ID: <5bfc1f7b.1c69fb81.0f7e.6378@mx.google.com>
Date:   Mon, 26 Nov 2018 08:29:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.126-25-g370f85bf6ea2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/24] 3.18.127-stable review
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

stable-rc/linux-3.18.y boot: 48 boots: 3 failed, 45 passed (v3.18.126-25-g3=
70f85bf6ea2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.126-25-g370f85bf6ea2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.126-25-g370f85bf6ea2/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.126-25-g370f85bf6ea2
Git Commit: 370f85bf6ea241301c2e85819c289778fada9162
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 23 unique boards, 12 SoC families, 14 builds out of 185

Boot Failures Detected:

x86:

    x86_64_defconfig
        qemu: 2 failed labs
        x86-atom330: 1 failed lab

---
For more info write to <info@kernelci.org>
