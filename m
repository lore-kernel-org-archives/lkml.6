Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B599C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D520820851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="JjGbwxRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D520820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeKTJ5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:57:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46969 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731785AbeKTJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:57:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12348wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=9Dk3vtZfTKpsOhP82stM38iMhvIiS/F1rw7I5UMw61Y=;
        b=JjGbwxRCSTxUoofE3HMqrLgbDAFHUUtcIVQRKPOWjlEyB/ekA1Iv+N7T4zS4847fOP
         AjEjA0dNp4+Vs/rBr7B4jbezt4EUAGczO9nHQXxVcBJ/N4UpsO+6aklZQvWcloEeFIZg
         xvNB98pc1DrlK/TSxNbfjsrhloNKbXVjbUtnizgORDzWe2zohF8f237qNnjKfS+3wcfS
         sNrH1XhuSBaJFZYWRaT2HF7Uc6iEPXxmJrXCaUQ2LZwKzet/7CT7m4b91kA6TCJ5FwWh
         mYsZOVHWYRa6kPnF4MEm2ST1snNfvIgXAG/6VJcsUlphJR1QElXDUon85E0ADDhgzYxa
         fySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=9Dk3vtZfTKpsOhP82stM38iMhvIiS/F1rw7I5UMw61Y=;
        b=jNW8RSPW6yXSW7/V7oQ1nu/yhJqn+OpwnZEn/z4dgyBLWSD4xwpmibeEae+FWCJLd/
         9up9LPEDFbroNPKsF2f/F8pBNafsOO8xKH0L4IjmXGZxUb7vDij/6xYsoKuHqL6BUXpw
         69/cWsp48Vspp6cK2LbCWYrnjQjMTcNZWHL1HFpgCOq6mPY+fsKaCJqCdEwU8AuB5Mnk
         MVMoYXxm5gF4P8Ih/jwKKvjN12nGR3wZpjVWa7wn8idSFiG1CSUT2NB/lMHiWE2K1lzL
         La4Ce4ZfQgZLA7Xm6D5JVbtI5+1Y73y74XjYHVcuU9I/66ugndIxvcsp1X6W7w1MgPQM
         4n7w==
X-Gm-Message-State: AA+aEWaG1YepiURA8jh7w6zLiFJSl8eAJclz20w7MKjApFtR3LkXRhzC
        dlp6ZsC8CsZt7RzN5oGAnVbLIw==
X-Google-Smtp-Source: AFSGD/WVQsw5YEv/CRcOtwDlqmzSqdu63er9FifUpUzqnmL9+R5rNZoHPJe+uSmrA1J8Qow3Jd4X5Q==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr7250812wro.262.1542670277961;
        Mon, 19 Nov 2018 15:31:17 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id p19-v6sm22693355wmc.46.2018.11.19.15.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 15:31:17 -0800 (PST)
Message-ID: <5bf347c5.1c69fb81.9c59f.c781@mx.google.com>
Date:   Mon, 19 Nov 2018 15:31:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.18.19-172-gc15e70be568b
X-Kernelci-Branch: linux-4.18.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
Subject: Re: [PATCH 4.18 000/171] 4.18.20-stable review
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

stable-rc/linux-4.18.y boot: 125 boots: 0 failed, 105 passed with 18 offlin=
e, 1 untried/unknown, 1 conflict (v4.18.19-172-gc15e70be568b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.18.y/kernel/v4.18.19-172-gc15e70be568b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.18.=
y/kernel/v4.18.19-172-gc15e70be568b/

Tree: stable-rc
Branch: linux-4.18.y
Git Describe: v4.18.19-172-gc15e70be568b
Git Commit: c15e70be568b978f9a73051089910dd60a81f2a3
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 66 unique boards, 23 SoC families, 15 builds out of 186

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        imx6q-sabrelite:
            lab-baylibre: failing since 7 days (last pass: v4.18.17 - first=
 fail: v4.18.18-351-g3c7d01cd1ddb)

Offline Platforms:

arm:

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    exynos_defconfig:
        exynos5800-peach-pi: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab
        mt7622-rfb1: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    multi_v7_defconfig:
        imx6q-sabrelite:
            lab-baylibre: FAIL
            lab-collabora: PASS

---
For more info write to <info@kernelci.org>
