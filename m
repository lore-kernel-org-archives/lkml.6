Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FFAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D052175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="UFP/rs2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBGSSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:18:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34201 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfBGSSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:18:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so4992910wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=44Fk095PtS9akgxQOO8LykiFBGBeJpz2/2IlA/5YY8U=;
        b=UFP/rs2PjeBbDtS2zrxr/khA3TZDK36H/gvwCZJViZIqIybiIaI+gZW1D5CyhRT+oC
         PE4YgLdLWNZ4QF9LrDWuvfS1S/aO9uP7xVO7oMsyrwHhzAmc7DP6B+GqiKI1D3lZybKN
         8ET73LwOXjwYu6UXOFkoRsfIN+feHC42nZlpQrX1mANTa4ltQlLR2LX6QJ6jhhUhCG1s
         rGSz+xIVD0r2k6vpUUmDYpBWOW7zu6N1isvvXK6SvxDwdc7AneY9++nHivVMKQ/S/U6L
         P2FLUtWW52TuoRGeEzChkKpZ6UVsK9q1Mh4lHAFkgy0pPVFNoGHpfhSGBVE6SWWaQPKm
         z3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=44Fk095PtS9akgxQOO8LykiFBGBeJpz2/2IlA/5YY8U=;
        b=VWbvgROTQlBiRsRR3ViV8vMqrXp7Isx/YmLP/k+ZF/WY9FZxJ3S8mhjIfBm5HzYFwO
         BqT/adwS+TTGzJGvzaZr/a9lPm+W6t0DQQZBpthNQBXX9dvBfrkvoTR9dEVPJDVmv+eq
         Zm+2LyLIyFA0Fip3HWD9WPYTC4FFNoiWf2Wb+jCsEtRe13UzBBEWPVVjYQuq4/X8iWGg
         v1WuJ77FbB4BTpvKG0KTLx2UqdUZ/XvvX41XHzdiQ431KNZec036rCTS+nwhBVBQSY8s
         G6qVHp0J55ohhnhyLTw2EKU3FZbMDt9lq1jOdBR679NrrIiEtuavEBZjg0Slr89sLPZu
         S3vA==
X-Gm-Message-State: AHQUAuatjJEqV/iAnf/ZwQ9yNtLgV7HL9jggRMqm1PZ3kr2bBMRcrUCc
        tPgB0Xvkwtu//NJM5EE0+dufow==
X-Google-Smtp-Source: AHgI3IZ28FNuBayNDH1NKCrA/Qv1GBT/BUeRBdIZUp+379aVeOOfM6LyIlM+8XkmDpCW9JUA07gnJA==
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr3656800wmi.15.1549563513303;
        Thu, 07 Feb 2019 10:18:33 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v6sm45248935wrd.88.2019.02.07.10.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:18:32 -0800 (PST)
Message-ID: <5c5c7678.1c69fb81.a9bca.70e1@mx.google.com>
Date:   Thu, 07 Feb 2019 10:18:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.173-35-g968fa3bc9339
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
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

stable-rc/linux-4.4.y boot: 31 boots: 0 failed, 31 passed (v4.4.173-35-g968=
fa3bc9339)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.173-35-g968fa3bc9339/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.173-35-g968fa3bc9339/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.173-35-g968fa3bc9339
Git Commit: 968fa3bc933965940f7fb2a56789dac2bd12e4da
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 12 unique boards, 8 SoC families, 5 builds out of 187

---
For more info write to <info@kernelci.org>
