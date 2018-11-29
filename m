Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C2DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3721104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="NJIC+lMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA3721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeK3G6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:58:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55855 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeK3G63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:58:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so3505771wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=OEsErebjDzRNH88hYylPJ6x9GojHG8M+pJx0soUw9DY=;
        b=NJIC+lMODAaOnTGQQJroH/WBohDw75yf4qpUPu2dZlZfNRNaDkqAdoUYqr/Rn6CTxP
         OcYGi1podHnMZtdcmEXIrojW54Aek0QeXXKFitN4uQctWN0CE00sxlpgO0o97V7DTnX4
         Mtc5GMMjspwEAXrpAZ8s1uH/VK6nDcbr+EQ48Dk0WNfgFbjOTHeeHagCaP9mzFo0Y/UA
         lIyy71KnOtaBcnlvxG7pJxYk2YJo6XZ0SILKT3EX0i4cvyxjbSryPom0XXgVKwCPZXj8
         RazTt5G1Fe69WHrjQwrL3cWPN7T8Es9iG3TscYz+NqBD4k5EabZ7EgyctPPkyN2kOHzJ
         g/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=OEsErebjDzRNH88hYylPJ6x9GojHG8M+pJx0soUw9DY=;
        b=YjtBPZfG4F4YkERdHP4e4ePdTvf3mCKfCi4pE3TR5/fCfqZBABT/x7ER6OtuO7dh1D
         QclGSF11pU0SsGIePphC0fhMOWZ4+e1FMetMBRISStf2rVqxnGE/et/KMqrJWKlCScLy
         /pCFQiMYenLjjNhoRPxysrjO9pgIAIDWloAqToTg/naOxArTYc+NC71q1jrKJAze9CYk
         mW1C96Cg/FuBpCTK7zvZP+tL0j/Z2y7XKQTjss6eDtM/e+r5RXYdptyh1K4VQ1qyZZtu
         ctGL/X9qoxbNQRrwF1+dWj4BYgjmAEZPFeDoqw6Ziyty3ETgArPXaksr7LDnAjRM7HwQ
         ORNQ==
X-Gm-Message-State: AA+aEWaJoNjaRfe1MkRIEyhW15Qo2P9+RebiWe4yGdgpmwWeRkHCfJka
        ugO6oEUXCHPJCFEqs+Va8GtPFQ==
X-Google-Smtp-Source: AFSGD/WVlX5Rt4C4qchHM9a8fF6oW1FNZv1phjBbdibuTZ9v0FmQkUHne1zTY9Kk0jlFLXTNgyGxsA==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr3002376wma.82.1543521114794;
        Thu, 29 Nov 2018 11:51:54 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c7sm4534124wre.64.2018.11.29.11.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:51:53 -0800 (PST)
Message-ID: <5c004359.1c69fb81.71fc6.b09c@mx.google.com>
Date:   Thu, 29 Nov 2018 11:51:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.165-87-g0741f52e1a53
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/86] 4.4.166-stable review
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

stable-rc/linux-4.4.y boot: 103 boots: 1 failed, 101 passed with 1 offline =
(v4.4.165-87-g0741f52e1a53)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.165-87-g0741f52e1a53/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.165-87-g0741f52e1a53/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.165-87-g0741f52e1a53
Git Commit: 0741f52e1a53c50944292102dfa048c5de080f14
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 46 unique boards, 20 SoC families, 15 builds out of 187

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
