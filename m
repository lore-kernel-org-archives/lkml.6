Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B7BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B17213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="qTTg81mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B17213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeK3FSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:18:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40732 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeK3FSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:18:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so3191272wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=ZSTS+pHqr5L0rheRo9k75i2H9wstbQyvyI9Nl0JaPpY=;
        b=qTTg81mXsF7WLh5VcXSowEf6olSqVpYaNzkYfTCUN7hvqzxCk4iVoSd1/QFlg6V33F
         rGAetWYf5AnOl+DrTYD+OLmvHI3GnXd27fSwdAqLDK4ON76oD2Rj32CU5rGN5fmkHVX9
         5IF964iftO4Yk53Z/bVpqAPQ6jahg+vQ+cdQaL9cpn65yc2s+vNrh8LoXjflnaxZ7/yB
         E6EKchFjKpU9YzcNuRvQ9b66AMt+PjficOhi3FWaLa/6yIixvpeTJO6wwx6F3pLpDk0j
         yZVTsSqXT92de/+GwbUlmPBGJNC32JAqRil4H0LNfi4mXnf2pngrC/cVYXtupyqgm19A
         AvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=ZSTS+pHqr5L0rheRo9k75i2H9wstbQyvyI9Nl0JaPpY=;
        b=PhIaG66rDEI/wO4c9sRO6yg6Owl1RherHlcUr4FL0wWmFbhdUi11Mw4q34P3afE42X
         0wdjI2LjVsuJdyypWG0+NwdanH06s04PJPk+d6PJnSKx5k4Tau8/ZTPEfOtbwAGz6JHu
         jYrMBzf3ZVAOiP4b4pIaI3YPJ9eM6ds0vCSdXSa6vSKh5wR4h3PMqzQhZcQ+4unE993d
         EhezZ0R1yYn2ojEtIbF0G0UqZr5TI4NYwwVhIVFg2t0QWzlaDAE14W1SAqRFl80hlG9o
         oq79fQfs/kZ+yjPpK/AqnQQ4pTfBwc2LZ2vw6N8dzz3opvtaa2Pe3uejnC1hnUdL/396
         xjPA==
X-Gm-Message-State: AA+aEWYywj/gjGptfMAK3O76V54g/wsLOVFu00OHsaziDoTxmpO8VMv0
        updemqjjXyr4rjL6D0A8Tqiz2g==
X-Google-Smtp-Source: AFSGD/UPDL4mIMSB4vFbsq6acj7bTyPDpb+nKvTEoenx0Yf52c0kVhxT6mN3pPrYvq7/ZRdy0x/wiw==
X-Received: by 2002:a1c:1b8d:: with SMTP id b135mr1998383wmb.115.1543515115214;
        Thu, 29 Nov 2018 10:11:55 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id k7sm2062654wrl.51.2018.11.29.10.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 10:11:54 -0800 (PST)
Message-ID: <5c002bea.1c69fb81.4b6c4.c169@mx.google.com>
Date:   Thu, 29 Nov 2018 10:11:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.5-111-gac4af649901b
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/110] 4.19.6-stable review
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

stable-rc/linux-4.19.y boot: 119 boots: 0 failed, 116 passed with 3 offline=
 (v4.19.5-111-gac4af649901b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.5-111-gac4af649901b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.5-111-gac4af649901b/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.5-111-gac4af649901b
Git Commit: ac4af649901b05aa42f4ed3e153ce0150d67aa03
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 67 unique boards, 24 SoC families, 14 builds out of 202

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

arm64:

    defconfig:
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab

---
For more info write to <info@kernelci.org>
