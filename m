Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D028FC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974D820672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="t0iB1wTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974D820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeLKVxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:53:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38770 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeLKVxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:53:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so3879155wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=+XXBVIbYzHtNovbWCJmwmdTnooWczpT3iBx0kdMdnT4=;
        b=t0iB1wTZEAgXLrbwn49X8XzvFNFPeiLT60fCb6rMdkoDIKBhfCkMIxJNshMqV140yR
         InuG7ndXOGy7Wo6k5/o90fprjEN0PVoHDHU92VxFQDX4BeT+6kJn2rIOh3+33siG6Tiu
         GEgRlzX0YcskBRCFGIvllrE485ScWDYECs1ImC8OcdtuKmjm99nk//K89NEaETbFPWZ1
         RXFY0rfm6lDhfsbfhfWX3HFJLpTJW07Xk+wHeUV54iE91fHuGEuYV/pvClDp63f3Js8h
         xN97gwKxk/Ukkk1C+wwcLsmBcL9N92VcXShWiW8RQKLrHnNeH9fO1mqvvBHaOsXUTD84
         1/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=+XXBVIbYzHtNovbWCJmwmdTnooWczpT3iBx0kdMdnT4=;
        b=hK4Gb6jnXIFV7WZphhukmFRMKBf6rinZndtgzteAYOiuU+gF6Sld+8QqkQbQkLWQke
         UNn0Ss2SnNuyl7wyvQa0K8n4udtkleD4/raGYwva3gTXQqIMkxHvRFCb39ayR6S2HyiX
         sVVUcvVb1GayfEHAMcegMZlUoPUNbdiq+WXwvBYxbNT6zQF7/rDatDwwg1FQFoOo8Ocx
         n+IV1z/EBxCvUjD2+Lgwz2CUEr+VMMTNDiHQIAXZG3ezrCa5SDVFE5pZMz1LTGAWlcoZ
         YHPLYQiTrito7EJs23zydsCT//r3xf4R/Jdn5NjX9yZaxGyyMlHe4TYAI3Gc6isUMFw8
         /zgw==
X-Gm-Message-State: AA+aEWbmBMqTWlo5ovUNUYTbNUhJf41ozKNHI/uZzN1P/CDmUpRHeNm+
        71fmoeIzPCZ1s7oIhBTzkuNI8g==
X-Google-Smtp-Source: AFSGD/V1Btln+9aq9/fUTYO4NzFEknu3t8iCHQOnr3fJZ2m43EfEr5WN3TDsyC99HNem8KcvU03Prw==
X-Received: by 2002:a1c:1593:: with SMTP id 141mr3914236wmv.85.1544565184482;
        Tue, 11 Dec 2018 13:53:04 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id k135sm1597405wmd.42.2018.12.11.13.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:53:03 -0800 (PST)
Message-ID: <5c1031bf.1c69fb81.4653a.b36a@mx.google.com>
Date:   Tue, 11 Dec 2018 13:53:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.166-92-g216a0be637b7
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/91] 4.4.167-stable review
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

stable-rc/linux-4.4.y boot: 85 boots: 1 failed, 83 passed with 1 offline (v=
4.4.166-92-g216a0be637b7)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.166-92-g216a0be637b7/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.166-92-g216a0be637b7/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.166-92-g216a0be637b7
Git Commit: 216a0be637b7dbf8db4aaad9810aba4ab15bb09c
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 42 unique boards, 20 SoC families, 11 builds out of 187

Boot Failure Detected:

arm64:

    defconfig
        qcom-qdf2400: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
