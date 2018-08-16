Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD473C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F25421480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLUgLrQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F25421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404081AbeHPSqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:46:25 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39289 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389292AbeHPSqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:46:25 -0400
Received: by mail-pl0-f67.google.com with SMTP id w14-v6so2282532plp.6;
        Thu, 16 Aug 2018 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=T/N/mAPPA1dB9mhQ2J3upaF/1sNB9f5UTZ/DeV5efsU=;
        b=kLUgLrQoBr/n0Cb6RYLVlgNANIkW2W47YS3pt9n3vuq0cmwuDxCxmt0+AmpYbkqKHB
         E3rOBZzHxm6MWvaR4+XU0d3QmaMMm3CA7mm/I9yeo0MRWv6hHB75NvX7MX5bsiRCclrN
         RBM9P7zKpt10uXyhyHs5HnkkQIaziB4sPd16MIBmgKbaOsNMw517B5wnIJOEO7scPgjh
         o7WdE9xKTt+KF+qp+P2cgRfFlu6qXITu9przZBDE1Lkk3Y5s2fe+jqs1gT3kdrWeobTy
         UifAgBlfAcHdnBZjAl1dhGyqYEf3simIKnRg92F4NcnYrRgx4NjHyYXLQ4F89NIlphTI
         7/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=T/N/mAPPA1dB9mhQ2J3upaF/1sNB9f5UTZ/DeV5efsU=;
        b=lqWR2bTyMJTO1gyqDKxaE9EdjZ4BdyVP4pqfzMS+Cif+o0+FcJkXbqctXeyJp+6+VD
         oNoFE2wgpotmuZYGZ6FXcC74fO26wHBMJqHSctnV/odYEsjlq7sRbBI8n2XDTXsHeC3r
         ym80tobO+eD2jLv/35hk/bRC2a/KKZC4e7H5OPFNCCYtIvFYBIaGpSFiAEvR4lOqnPc5
         aq5NqgD6o7rod9QJZAOV4u5QtzA8woHpoFGrQkcwqwxPc6U9/jjik5XQU5fTAsiVdxvk
         AKBLSxooWhveX4vT/KoKF0bFckP6NTIcm7ywavQxumMHyrYt7SNm1j0VsAFLN6EjCkcj
         bcEg==
X-Gm-Message-State: AOUpUlFxGutmGqPF3R+/eRTsPUHZizZdDgq1zNLciWGz/arJrBiD6pOY
        1X46t9mDcQyHO1MFpsplyJc=
X-Google-Smtp-Source: AA+uWPxfvzBb+xwi6tGCTU47jmjNyaMRimMaghJssR7vqcVeCYb66WtC4GXdZ+qbWZCg2+sdZmqWuw==
X-Received: by 2002:a17:902:2702:: with SMTP id c2-v6mr29966018plb.248.1534434427664;
        Thu, 16 Aug 2018 08:47:07 -0700 (PDT)
Received: from localhost.localdomain (ec2-34-212-148-38.us-west-2.compute.amazonaws.com. [34.212.148.38])
        by smtp.gmail.com with ESMTPSA id d9-v6sm39563744pfb.86.2018.08.16.08.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 08:47:06 -0700 (PDT)
Date:   Thu, 16 Aug 2018 08:47:03 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management updates for v4.19-rc1
Message-ID: <20180816154702.GA5033@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

to receive Thermal-SoC Management updates for v4.19-rc1 with top-most

84b64de597bcc26549a7cbfe2fa8022bbc142daa:

  thermal: armada: fix copy-paste error in armada_thermal_probe() (2018-08-01 09:56:12 -0700)

on top of commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

Specifics:
- Rework of tsens driver to add support for tsens-v2 (Amit Kucheria)
- Rework of armada thermal driver to use syscon and multichannel support (Miquel Raynal)
- Fixes on following drivers: TI SoC, IMX, Exynos, RCar, thermal hwmon

KernelCI bot testing links:
Full Boot Summary:
https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.18-rc3-34-g84b64de597bc/
Full Build Summary:
https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.18-rc3-34-g84b64de597bc/

BR,

Eduardo Valentin

----------------------------------------------------------------
Amit Kucheria (8):
      thermal: tsens: Get rid of unused fields in structure
      dt: thermal: tsens: Document the fallback DT property for v2 of TSENS IP
      thermal: tsens: Add support to split up register address space into two
      thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
      thermal: tsens: Add generic support for TSENS v2 IP
      thermal: tsens: Rename variable
      thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
      thermal: tsens: Fix negative temperature reporting

Bartlomiej Zolnierkiewicz (1):
      thermal: ti-soc-thermal: remove dead code

Jean-Christophe Dubois (1):
      thermal: i.MX: Allow thermal probe to fail gracefully in case of bad calibration.

Krzysztof Kozlowski (1):
      thermal: samsung: Remove Exynos5440 clock handling left-overs

Marc Zyngier (2):
      thermal_hwmon: Sanitize attribute name passed to hwmon
      thermal_hwmon: Pass the originating device down to hwmon_device_register_with_info

Miquel Raynal (19):
      thermal: armada: add a function that sanitizes the thermal zone name
      thermal: armada: remove useless register accesses
      thermal: armada: remove misleading comments
      thermal: armada: rename the initialization routine
      thermal: armada: dissociate a380 and cp110 ->init() hooks
      thermal: armada: average over samples to avoid glitches
      thermal: armada: convert driver to syscon register accesses
      thermal: armada: use the resource managed registration helper alternative
      thermal: armada: add multi-channel sensors support
      thermal: armada: remove sensors validity from the IP initialization
      thermal: armada: move validity check out of the read function
      thermal: armada: get rid of the ->is_valid() pointer
      dt-bindings: cp110: rename cp110 syscon file
      dt-bindings: ap806: prepare the syscon file to list other syscons nodes
      dt-bindings: cp110: prepare the syscon file to list other syscons nodes
      dt-bindings: ap806: add the thermal node in the syscon file
      dt-bindings: cp110: update documentation since DT de-duplication
      dt-bindings: cp110: add the thermal node in the syscon file
      dt-bindings: thermal: armada: add reference to new bindings

Simon Horman (1):
      thermal: rcar_thermal: avoid NULL dereference in absence of IRQ resources

Wei Yongjun (1):
      thermal: armada: fix copy-paste error in armada_thermal_probe()

 .../arm/marvell/ap806-system-controller.txt        |  48 +-
 ...controller0.txt => cp110-system-controller.txt} |  61 ++-
 .../devicetree/bindings/thermal/armada-thermal.txt |   5 +
 .../devicetree/bindings/thermal/qcom-tsens.txt     |  31 +-
 drivers/thermal/armada_thermal.c                   | 534 ++++++++++++++++-----
 drivers/thermal/imx_thermal.c                      |   5 +-
 drivers/thermal/qcom/Makefile                      |   2 +-
 drivers/thermal/qcom/tsens-8996.c                  |  84 ----
 drivers/thermal/qcom/tsens-common.c                |  29 +-
 drivers/thermal/qcom/tsens-v2.c                    |  77 +++
 drivers/thermal/qcom/tsens.c                       |   3 +
 drivers/thermal/qcom/tsens.h                       |   8 +-
 drivers/thermal/rcar_thermal.c                     |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               |   5 -
 drivers/thermal/thermal_hwmon.c                    |   3 +-
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    |  68 ---
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  65 ---
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    |   6 -
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    |  10 -
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h  |  10 -
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |  46 +-
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h  |  41 --
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 370 --------------
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  43 +-
 24 files changed, 649 insertions(+), 907 deletions(-)
 rename Documentation/devicetree/bindings/arm/marvell/{cp110-system-controller0.txt => cp110-system-controller.txt} (85%)
 delete mode 100644 drivers/thermal/qcom/tsens-8996.c
 create mode 100644 drivers/thermal/qcom/tsens-v2.c
