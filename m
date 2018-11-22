Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C44FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6635820864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="yQIObaLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6635820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404575AbeKVPft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:35:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37640 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404557AbeKVPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:35:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so7736428wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 20:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=N7OD9ZGLTb1yTvkh48alQLeskESiZHSNfDe2RXMwI7E=;
        b=yQIObaLywRe7KVfF1h1D1JghOwvXWIYPPyyH07mZNbY1G3Z2rtQWEjjENqAO5U+SSp
         7T2GKPcgshsoqnIzodR5135it5WQz4iRAs4OaHpMb+XFXhygkCgknQmZMMeg6PRv/eJ+
         wKwHs89fNJMjloqPntEeKoh36UyJou712mzCZrPmKkZms3ttwjfn/SRXVxz8Ynv717DE
         j4yBUs5KsfjAu6vBD+0cOGYnQLSB5V6rvbQ2lTTx24TUzz9nQ7jScud2+QjPKrToLW0h
         fNlJLs6Ea3nCjRi1IItbsGIKm6OchBFTVnHmJlBqnot24zEN9pIGvAnw9U9ueKFfAMmU
         0uNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=N7OD9ZGLTb1yTvkh48alQLeskESiZHSNfDe2RXMwI7E=;
        b=lVN4SWoFt2pCzQOBCIkG0VbyzrZHQkqNNSf9wNiLdQro2PO4JTMAIq0dhAJEIpraHJ
         bK4M1mBctB7AEkD3HTqqmKblhM/UEDyPc+1/nycWcgSeRFcbdW4O1M8W0nF8HJsI+mTv
         zNqJNMWG213Snx3ZSNApOIETkMvymt5s1d81Az1Cw9oBbvdhF8jNPjedK5Pd2T2i0KXv
         YR59DjzJaAT3g8D3PKVQJG+uPXvq9+ZCzyKFYLe0UEbWdoU0DrGE/2hcYRMo+YykvPIm
         qrnpfiVHRE9jnhlI/+hRKhpWOTcpSqSBWugdo9tS5ROANMP6lecPrv1tqmiF8pryO1Yl
         kxHQ==
X-Gm-Message-State: AGRZ1gKFbk0Z1LH4KDzkl9cU6IUTRa9IV2fZrgsCIthMwhx5IP4WiqLC
        Qqy5tiwxRGhYND2KBwb+GzWoUjxdFo6RyQ==
X-Google-Smtp-Source: AFSGD/Xh4GLxWfMGNMMAYfng2nAOGbdOA8el9AZVIeVtp13h0NkY/4xfVyLj3ZZT7tisAvGFEEEy3w==
X-Received: by 2002:a1c:f313:: with SMTP id q19-v6mr7941085wmq.87.1542862689122;
        Wed, 21 Nov 2018 20:58:09 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h67-v6sm5003075wma.10.2018.11.21.20.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 20:58:08 -0800 (PST)
Message-ID: <5bf63760.1c69fb81.dc2dc.deea@mx.google.com>
Date:   Wed, 21 Nov 2018 20:58:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.138-60-g70b13958eeae
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/59] 4.9.139-stable review
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

stable-rc/linux-4.9.y boot: 79 boots: 0 failed, 78 passed with 1 offline (v=
4.9.138-60-g70b13958eeae)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.138-60-g70b13958eeae/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.138-60-g70b13958eeae/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.138-60-g70b13958eeae
Git Commit: 70b13958eeae24843ed944e4f3d4a25a0cdec0dc
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 42 unique boards, 20 SoC families, 16 builds out of 192

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
