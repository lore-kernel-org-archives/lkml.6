Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0DAC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BBF21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="JBeg5VPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391795AbfBRR7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:59:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38228 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389500AbfBRR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:59:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so19353639wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=nE1PDB2ceh+GdP9w9OhQ3E/HhKSCd+98FrNJOXhIgXg=;
        b=JBeg5VPUmbTbuSaLP+uNrN7vkHrrCfJPGAavGg8pwkyVTrXQP76H8iNq1xwvwJVdLF
         s2QpOpgs+lmKku0YzdMECu3biWFmfcpHYAQ9AAlwD39yl5wijkKODyZxB9stoRkjUvbx
         3jhjKbFZw4eyonAaUiLrI7RD63m8Pwh+ed2fu+8QQBuoGx4NrhkWZCMRz0AmpYEgVjF5
         uQAXvEyUnGYLZC6SFdJhOmEh/wb2Kc06RdoeS1pH/scW6HddVmGIMjIRm93FUGmCFjB2
         o9CjZOFpZp65lV8SQOhxeB1uZytr1pmp17GeRe/jZWlWyH4+xVjKjbkBZcY4ykBY+XF6
         WUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=nE1PDB2ceh+GdP9w9OhQ3E/HhKSCd+98FrNJOXhIgXg=;
        b=ph4iurhhbshinJmy19vIfpoE8Nc7ZpeAWFaMD8WsB+LEQZ9RfwAAziXCx9KdT2+J8Q
         S1xgk3MqbDV1xyxdkNKO6gGesotcVat76e97biZYLXwBVVMHCIdydbls7HApeJTdQ7Zc
         rVPSNAFhU94LE9AkBti4Uhjty6DdQixCazmE8t8Ge86yKr6eZ5V9oeVvd4FJYNFLHsVF
         3XvlBIMnjrAZPZ7zSeTlYQSFdgtFDTdXj8U/efV4nxZs8aAQ+e847dTAFerG+sHLkLW5
         7+iPfbSPE1KsnsMes+Ghpd13LcdzqmyGd6o6B78b6uAWFLOFKW0/FjGrzkXzpOoQzw6S
         ZA+Q==
X-Gm-Message-State: AHQUAubEcSF0d4yVqGAzKIXohIhhnFxF0koJAbbWb6xfYwmEDeCUWgjU
        no/47ttruMgr3ZqgtaWG1YJpuQ==
X-Google-Smtp-Source: AHgI3IYZD7s4m0wYt53Y0EEwEquE7KWpchAu74moA9zOt0wd8+qerKeV4BVyy1PiHjjpdxEyW5q+2g==
X-Received: by 2002:adf:a749:: with SMTP id e9mr16892314wrd.210.1550512776696;
        Mon, 18 Feb 2019 09:59:36 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 90sm33352110wrk.95.2019.02.18.09.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 09:59:36 -0800 (PST)
Message-ID: <5c6af288.1c69fb81.ab1bd.4af9@mx.google.com>
Date:   Mon, 18 Feb 2019 09:59:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.174-144-gb21488342322
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/143] 4.4.175-stable review
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

stable-rc/linux-4.4.y boot: 85 boots: 2 failed, 81 passed with 2 offline (v=
4.4.174-144-gb21488342322)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.174-144-gb21488342322/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.174-144-gb21488342322/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.174-144-gb21488342322
Git Commit: b21488342322bbf876a019f6638b4d5f142acc14
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 40 unique boards, 20 SoC families, 12 builds out of 187

Boot Failures Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
            stih410-b2120: 1 failed lab

arm64:

    defconfig:
        gcc-7:
            qcom-qdf2400: 1 failed lab

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
