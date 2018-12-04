Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C581C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229D02081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Cfn83Re8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229D02081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeLDPww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:52:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34112 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeLDPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:52:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so16508360wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=q8zv72M7QqUrtqp518RTnIhe8JFWIHyFeu+Ruwgu86M=;
        b=Cfn83Re83CQK/8uWKa8Kgt8PmXbJYgC/UcrtLDNiBHepm6EJQxUSYqkasN9Q3Ahwmq
         BRd4msBq2Jy9B59QbwAxd+BggdkKCEzniEVOHyb4UbC9VRKvX7cnqa6Yuy/AsPTV+qkh
         xl+pg/XSnzIB6XniwD2mKz58p2kq4ZYAzbzkmtz5abBP9aGst2iqgpEwq0tkIqqC/xkk
         UDwEnE2ylmkbQfTJDpy4jF5s6v6I0AZ3dq2Fz3KB0Ik7mqLuoolr0R/YkatLYNrPuCCZ
         2LBHlO0r8YypA4jNLMJ/N9eBAw65jhVO9AZ71C7D49mXzT8vhlkOpa2zCtwalslj63xK
         cttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=q8zv72M7QqUrtqp518RTnIhe8JFWIHyFeu+Ruwgu86M=;
        b=CZSECpCLQm4XAuvD2/4MDM2ZE9qJ1DJ73VE6bLON9nM6S7Y27DewCdHKjCtttku4Iz
         H3ag7KFalqnK+Afx1LosiyTiIkAJisAkKM2l7QLa3u01MLN6CRThUz0toHw751CdCLEk
         3sVPkrn7iJtdWOp+IAmsXLRHzIs7xMVw70TXHVQXXQnr1/Abn4ZyLLahJzXe8b2G7pxN
         uYubTX67VAL/Qnoz6G9eaOHOGsrrRtuOHnKEBxZNSlFjW923KzqStz9KA1rYQFEPe9Nn
         aM6/hphIK8CPiDpI8iFvHRT4KFiTOT1vDOc1HLcP+qkWtQeLagrju/JIuuHIitI0RNbA
         xxpA==
X-Gm-Message-State: AA+aEWa+hT/M98gfILMOLNqck0D9jBAuuOhqb2pjsrBWhhpd372enR2U
        Jhkq9VUccspasxSn2KpjyhIQzA==
X-Google-Smtp-Source: AFSGD/XoKYY/Gyrpj6OSPU310eoagPey2eGV+vy8rSy1qEI1zOCmaUGBKfTurudUCa5j/xQUHneBXA==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr19395778wrx.298.1543938769355;
        Tue, 04 Dec 2018 07:52:49 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x14sm12404408wrm.65.2018.12.04.07.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:52:48 -0800 (PST)
Message-ID: <5c06a2d0.1c69fb81.34878.47d8@mx.google.com>
Date:   Tue, 04 Dec 2018 07:52:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.142-51-gd453b6576ba5
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/50] 4.9.143-stable review
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

stable-rc/linux-4.9.y boot: 108 boots: 0 failed, 107 passed with 1 offline =
(v4.9.142-51-gd453b6576ba5)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.142-51-gd453b6576ba5/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.142-51-gd453b6576ba5/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.142-51-gd453b6576ba5
Git Commit: d453b6576ba5d750a0085cb26252c2a077fd60cc
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 49 unique boards, 21 SoC families, 16 builds out of 193

Offline Platforms:

arm:

    multi_v7_defconfig:
        stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
