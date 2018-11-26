Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EEDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CC92086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="mm8SRryG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CC92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeK0EGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:06:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36781 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeK0EGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:06:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id s11so19388255wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=bsCUzTV03oR+yjYCClLv+PWHhBbGrRd1NQDA66y6fTA=;
        b=mm8SRryGb91sW6Ft5ec9ust4SZ0jik7RL9DQMPONhqTYR5e24qGeEDu8qoEnLcOLWM
         Sxm04L51FvJXBg5fscJO9eLOr4F/WUTxhObju1PjkX1xJDLo7rq83cgqhMH7ITWskgBT
         zVH7de1uI5UjfN5qZeOgsXZjBqEuT8thZwSONfTj3dezOyTAj66S1zCQDIsLSODwQr8b
         vfJMy3M5GkAMXfBoqnX1T0YukegiF72vZkX4GbUusvFoCGWtLQ1MUX5p4YJflEMpi7Gg
         yng0xqlT+DOB/S6uh8ZlrN9j1X6FUKP4wIx/MeatpZUxiwTNaci0VQLAnNwU3Ft1akdA
         oE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=bsCUzTV03oR+yjYCClLv+PWHhBbGrRd1NQDA66y6fTA=;
        b=Za8fAriVuamWg4jA0q5nQLj5kLPxmOlKEqZ+WbXlIhU+JT6UlzDgOPHabjMVeOF2fr
         96y+TBMS3NnsTrgVcNuri/gD3riwIuc0iPlvk+Ftugv8tSs8cfUqrUpO+KDlsKqnLtaB
         CHn5btO1Yd3FEvYy3Wah7QI7s9E4CTb4tkJFvz2vaKiGySejLZvCvvMwtB+9aMwNdpoB
         5b+LTx/sBAFEmGaEjEbQJpzkm0yfG9AfP1w3MSLFQZjB+GqL8obGC7M9nzdFhhy0UReT
         7NtIoIC1rz3lw08ftNc5kLcbs5T/hGcpmysbS/5q7vOdhYD8fQ90de1v8KQgtRtV2ebY
         4UlQ==
X-Gm-Message-State: AA+aEWbv3MgdFVpZ1WRxSgZVuNXY1UI6xCiZfdeXc1ZkpvKiTfgT/tqz
        ZHxB12ans7naYWigDUkyJbcPXw==
X-Google-Smtp-Source: AFSGD/X2k3Z5RbG3B79XMLG9lIDqirQ5A5I8HPwK2ot+rhfwSEVdKxq+juqe9O0I5+ydjzKAyLvX8Q==
X-Received: by 2002:a1c:da92:: with SMTP id r140mr17185598wmg.136.1543252298287;
        Mon, 26 Nov 2018 09:11:38 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id l3sm870436wru.36.2018.11.26.09.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:11:37 -0800 (PST)
Message-ID: <5bfc2949.1c69fb81.80f6c.5681@mx.google.com>
Date:   Mon, 26 Nov 2018 09:11:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.83-63-g0ece78cdc128
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/62] 4.14.84-stable review
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

stable-rc/linux-4.14.y boot: 60 boots: 0 failed, 57 passed with 2 offline, =
1 untried/unknown (v4.14.83-63-g0ece78cdc128)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.83-63-g0ece78cdc128/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.83-63-g0ece78cdc128/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.83-63-g0ece78cdc128
Git Commit: 0ece78cdc1285e114e5cec4c7517c90121ee32f5
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 48 unique boards, 15 SoC families, 13 builds out of 197

Offline Platforms:

arm64:

    defconfig:
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab

---
For more info write to <info@kernelci.org>
