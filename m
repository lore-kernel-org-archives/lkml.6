Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E33C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD4221773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="OKZP7y+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfBRTTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:19:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53999 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfBRTTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:19:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so208622wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=ZmqZX6mHnPOSaBeDwsOgX73Gdd95I1wztacm5SQKEIM=;
        b=OKZP7y+LgGdm9RQNMQ4TdXUs3DUgKihAaVW/RadvxDQQeyFykmF1P5hC6eoeVPFkUw
         kDc+gOkHsnAO+WequKlIlNWMNX8wkTauxM2aTRZfW/W8U0wWyfBU9UKEw6oKWMlvTlwV
         WKKYtoYg1nVW8TsTJJFUOfPA3rjdEJ3SnWtRm8NK+0GOa0NvQ/YyPFBbyIp8D89qd3N5
         1QpWVBPB4j+c4ch7mXHVq23dllWXSQxaDXKQx1Fn9z6bT92KNwGsbpL9n46uecSIHLw0
         nZhZCC6ZEmeRr1fuCa5Lt0V9xXXCUIfm1jK9o4X7tBSk4ht3pzbSY8UzNQoQKZi0t/Jo
         lGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=ZmqZX6mHnPOSaBeDwsOgX73Gdd95I1wztacm5SQKEIM=;
        b=DfnzK3xYMTluSroijtVx2PdLLAmA/aPUs/3H2DyrwFuugJKbq0v5f9L+2YN5dWViha
         ehN5cQusoa1zXkmraaD/2Ncvtkx2S5uxB10uECAVsCAhqlPdt9nNEnlY729mnJbEgD+1
         N7C5coa6a7YZPARMvE3KzwV9i+yX5IgfUxnemD+qlzATwclV6sVzefsdcAKzTaNkv53L
         v7KxkzNaSNErodqP04pKZCCM3rlooKoGSqNaNhqY7+ykIqXEDa3KPNYTmmQe5H2eQhbY
         krxrYS9PvenJioDLvpXg6PttPMFYpJKpJgQvf3sPZVrbgJ+nXZBDmuZMWLoQf91dU7+G
         c8Gw==
X-Gm-Message-State: AHQUAuZuN1H0j1WACL7edqgiP627CKPLgQjRjV1rDgblKU2D7SNoOvM/
        ZiSx/VFYsG5pasnQHDlnAFZBAluGAj/FGw==
X-Google-Smtp-Source: AHgI3IYlihwW/f7Jaq5NY4BdPAptILLpKJZ5F0WgENyM0tQHfNk3lwncei3PERl4OJ1GdPlYWmMBvA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr224993wmh.53.1550517576003;
        Mon, 18 Feb 2019 11:19:36 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id m4sm514015wmi.3.2019.02.18.11.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 11:19:35 -0800 (PST)
Message-ID: <5c6b0547.1c69fb81.677f9.3459@mx.google.com>
Date:   Mon, 18 Feb 2019 11:19:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v3.18.134-109-gcc973ee706b3
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
Subject: Re: [PATCH 3.18 000/108] 3.18.135-stable review
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

stable-rc/linux-3.18.y boot: 48 boots: 0 failed, 46 passed with 2 offline (=
v3.18.134-109-gcc973ee706b3)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.134-109-gcc973ee706b3/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.134-109-gcc973ee706b3/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.134-109-gcc973ee706b3
Git Commit: cc973ee706b35e690d95035f00eda7063b1f927c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 19 unique boards, 11 SoC families, 11 builds out of 185

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
