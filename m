Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD08C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E9220890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E9220890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeILQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:48:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40983 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:48:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so1333324ljy.8;
        Wed, 12 Sep 2018 04:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=B/2ksNmbCUJqZLwO+g44lmvij4XM3PRDiPEPV0z24is=;
        b=Sk4AbViGUv9Nyh4y/jLSRViPWpPLiwjCr8O2sRCrEi2apLjzuZgjQtnIvgo/LEZIjS
         ox7W25F+2rjj4MFYAKQQse8XSLwjIPcBnG4j/ZlAqZ2oGWHQxtdFQFFLemhTAIOMCobV
         pTw1YDadXknWx9mz47t3zsyHXyzSJ/dB3MyUhn41uGhs/1+TSslWdDzAbbK2QRQe4Zp8
         Yux/KyI5ta9SFCZiaSJNiIgLyLxyXqZe5nFK7mDmYFaPFkbpFs34P4QeA87ej3//tV6A
         k35aOYA16c9EFin3TdH1TDZBVca15n+4lnCbt2eVx7W7v5cW0EZrNIueweL8RTBu6QKe
         ZA+Q==
X-Gm-Message-State: APzg51DmiUWhRcxgD4BpScYM03YNY+a7WsfGFuSDsMZ1L4lm/LwYf9NV
        Vj6l5tOuYvo2gI/rtcNah/Y=
X-Google-Smtp-Source: ANB0VdbaGfYWUbJyps622Sil8igzhC1QkkNkcYNQWvAv3mTTFlj8loqSQlAm6JJod20+bJmYfrhB/w==
X-Received: by 2002:a2e:954e:: with SMTP id t14-v6mr1136826ljh.68.1536752652933;
        Wed, 12 Sep 2018 04:44:12 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h4-v6sm137530lfj.69.2018.09.12.04.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:44:12 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:43:59 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        sboyd@kernel.org
Subject: [PATCH v2 0/7] regulator/mfd/dt_bindings: bd718x7: Support ROHM
 bd71847
Message-ID: <cover.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adding support for ROHM BD71847 PMIC.

ROHM BD71847 is modified version of ROHM BD71837 Power Management IC.
BD71847 integrates 6 buck regulators and 6  LDO’s.

The patch series adds support for BD71847 in BD71837 driver. It also
extends BD71837 to support all BUCK/LDO output voltages.

Support for "pickable voltage ranges" is introduced in order to fully
support BD71837/BD71847 voltage selection registers. Some of the voltage
regulators provide different multiple voltage ranges and output voltage
is determined by range selection bit(s) and voltage selection bits
instead of plain voltage selection bits.

Changelog v2
- Dropped first patch (voltage monitoring fix) and "rebased" on top of
  next-20180912 because first patch was already applied.
- Fixed two commit message typos.
Fixes based on comments from Lee Jones
- removed PMIC revision check.
- stored chip type directly to data pointer
- minor readability improvement to DT binding
- unified naming for last enum members
- moved unrelated changes from pickable ranges patch
- removed C++ style comment

Patch 2:
	limited BD71847 support (without range selection)
Patch 3:
	BD71847 device-tree bindings for regulators
Patch 4:
	BD71847 device-tree bindings for mfd
Patch 5:
	Voltage range selection support to regulator helpers
Patch 6:
	Simple renaming plenty of BD71837 occurrences to BD718XX
Patch 7:
	BD71837/BD71847 Full voltage range support using helpers from
	patch 5
Patch 8:
	Renaming bd71837 regulator driver to bd718x7

this patch series is based on linux-next tag next-20180912.

Matti Vaittinen (7):
  regulator: Support ROHM BD71847 power management IC
  regulator: dt bindings: add BD71847 device-tree binding documentation
  mfd: dt bindings: add BD71847 device-tree binding documentation
  regulator: Support regulators where voltage ranges are selectable
  regulator/mfd: bd718xx: rename bd71837/bd71847 common instances
  regulator: bd718XX use pickable ranges
  regulator: bd718xx: rename bd71837 to 718xx

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |   17 +-
 .../bindings/regulator/rohm,bd71837-regulator.txt  |   12 +-
 drivers/mfd/rohm-bd718x7.c                         |  160 ++-
 drivers/regulator/Kconfig                          |    2 +-
 drivers/regulator/Makefile                         |    2 +-
 drivers/regulator/bd71837-regulator.c              |  644 -----------
 drivers/regulator/bd718x7-regulator.c              | 1138 ++++++++++++++++++++
 drivers/regulator/core.c                           |    5 +
 drivers/regulator/helpers.c                        |  232 ++++
 include/linux/mfd/rohm-bd718x7.h                   |  333 +++---
 include/linux/regulator/driver.h                   |   20 +-
 11 files changed, 1644 insertions(+), 921 deletions(-)
 delete mode 100644 drivers/regulator/bd71837-regulator.c
 create mode 100644 drivers/regulator/bd718x7-regulator.c

-- 
2.14.3

