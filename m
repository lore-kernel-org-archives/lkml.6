Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9964FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D1B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="zBanSCc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfBUSUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:20:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35565 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfBUSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:20:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so31765325wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=j55cNS765A3bpv/ixToqZvG3ZkM7YAQMCe9Viuk/cp0=;
        b=zBanSCc8An6YL4btO3NdRSAMK/rMrgsSMi85Sumf/UW0yNZQ8NPrekb3blQaHjEWsu
         dbvcpYYxAkzU5OwuDzGRJH8jO/XLCKUUbGvn6UD+myxCNKt+Ay+BXoEV37DMVOwGLK7S
         VsOiwOmGvR5TxBmVPPX7POongIYhN2kpa8Vtj9J4die+AB2zXItRZvL0kEIVEJ/ytTZq
         7eY9wwzF9d3ceGsOVhp52WN98jW2W2EdeOM73i8rlXyvgoCuYzJoQGNFaNMPlPR0ixVp
         n1b9JM8FwlAPcwIq/PGDjjiOO0JjOT2SkfEksooK8UQZDQ2QGzbnAuPb+j3iaNN2bXae
         BRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=j55cNS765A3bpv/ixToqZvG3ZkM7YAQMCe9Viuk/cp0=;
        b=U+H1P+9syC6UQ94zB8yxcHjjFi71qg6ePb6B8qSJ42VLNiJ5QyA1nyKXTUH3hzfrcI
         lmfR3tThjFsae4JE7F+cao6j+qBHfx8odVqOFffdtbB0IrM9W2H2jLdDNd4O1g8Jdb1a
         SsmTcP2T6BoJPE1uSR3sNCRExrVwsEpVusGl6D4MzesYiPizZN/ghl8PTJkOSfhWhaRr
         nAquHp+6cMMTyxrBqH0wAkFSuMcMLO63Vy5lr0wqc1RepBDjn/KXt2C46qKqsyt66rf/
         hT83TNcwZ2c1eYTUrgwDOLfdBjDeJddHi9yy30O3RxsTuk+acE3cGnGqANhhZTxZ1sE0
         gXAg==
X-Gm-Message-State: AHQUAua4fbslAUkv8kIHFQkA0ghSpw+8arjmiXbOilVWzUoIGGCGs35a
        pKlqDC0OaPLWq9eJgGWuE0saS1NfoSvkpg==
X-Google-Smtp-Source: AHgI3IZIhM3uTK9GDACPXU1P0D+R1i4EEXC553SAqKC7cQNKg8GyAOH3EuJWstfKML8uvxLa2GJCIQ==
X-Received: by 2002:adf:eac2:: with SMTP id o2mr7759008wrn.0.1550773199472;
        Thu, 21 Feb 2019 10:19:59 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v18sm23699323wrr.90.2019.02.21.10.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 10:19:57 -0800 (PST)
Message-ID: <5c6eebcd.1c69fb81.7280f.1856@mx.google.com>
Date:   Thu, 21 Feb 2019 10:19:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.159-21-g53ba7e5fc78e
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190221125242.153179182@linuxfoundation.org>
References: <20190221125242.153179182@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/20] 4.9.160-stable review
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

stable-rc/linux-4.9.y boot: 94 boots: 0 failed, 92 passed with 2 offline (v=
4.9.159-21-g53ba7e5fc78e)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.159-21-g53ba7e5fc78e/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.159-21-g53ba7e5fc78e/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.159-21-g53ba7e5fc78e
Git Commit: 53ba7e5fc78e08a5573e9c0e64f5a960911c2fe7
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 46 unique boards, 21 SoC families, 13 builds out of 193

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
