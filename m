Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE8FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20C720866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20C720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeINNk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:40:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40575 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbeINNk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:40:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id x26-v6so7132315lfi.7;
        Fri, 14 Sep 2018 01:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=DKS+4f0Oh3iExl2o5ewfVatgd8aylwSwlVQHFwjW+hk=;
        b=q6NE1LIS9/4bcViGoro8uRhncfzH2wawjgnNPku32kQv3JEoErkGOoEQBVRtI261HX
         KoJrXzyV/ZxNYIquKfKvEQ8B8/zen0Vqwi/KAmdNrmiVITBf7WR6MfA9uTif12nMcC6q
         oDGm0dElyjZknKQWHgwaRCDUD8pCoqc5+g52snw+PU6ngmPkJnlCsmXKx7w0NHy85GyO
         4XTA0RO9ZxyjSfyfsjlAD5FkXq07XWtQL/W6rDmiolteXpgq8YvcYtUsyH85jrdPgTx2
         iyHwR7P9m/bPz6+STro1P0My29zoXKZMYXUvH0fKJWL7xVPZkxIzHRbBzOY3mpADYbDc
         v73w==
X-Gm-Message-State: APzg51A62Qfmrt2zyncbRPJ2FmQV0Q43VnzDvjhzVVDz5tEKihZfr9J3
        Tc2emams1aHVeKM9I3rkz/A=
X-Google-Smtp-Source: ANB0VdZtuj0YargIOBjDfWZV1BGVeULe5nSbc5BVJ5eAIOqbo7yrRyYXezhdeaKGLnujo8mCRPJ7QQ==
X-Received: by 2002:a19:f802:: with SMTP id a2-v6mr7367129lff.33.1536913653776;
        Fri, 14 Sep 2018 01:27:33 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g10-v6sm1165235lfl.11.2018.09.14.01.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 01:27:33 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:27:20 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, sboyd@kernel.org,
        mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 0/7] regulator/mfd/dt_bindings: bd718x7: Support ROHM
 bd71847
Message-ID: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
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

Changelog v3
- Fix warning caused by void * to unsigned int cast
- Fix patch dependency issue (patch 4 used define from patch 5)
- Fix indent problem.
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
  regulator/mfd: Support ROHM BD71847 power management IC
  regulator: dt bindings: add BD71847 device-tree binding documentation
  mfd: dt bindings: add BD71847 device-tree binding documentation
  regulator: Support regulators where voltage ranges are selectable
  regulator/mfd: bd718xx: rename bd71837/bd71847 common instances
  regulator: bd718XX use pickable ranges
  regulator: bd718xx: rename bd71837 to 718xx

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |   17 +-
 .../bindings/regulator/rohm,bd71837-regulator.txt  |   12 +-
 drivers/mfd/rohm-bd718x7.c                         |  162 ++-
 drivers/regulator/Kconfig                          |    2 +-
 drivers/regulator/Makefile                         |    2 +-
 drivers/regulator/bd71837-regulator.c              |  644 -----------
 drivers/regulator/bd718x7-regulator.c              | 1138 ++++++++++++++++++++
 drivers/regulator/core.c                           |    5 +
 drivers/regulator/helpers.c                        |  232 ++++
 include/linux/mfd/rohm-bd718x7.h                   |  333 +++---
 include/linux/regulator/driver.h                   |   20 +-
 11 files changed, 1646 insertions(+), 921 deletions(-)
 delete mode 100644 drivers/regulator/bd71837-regulator.c
 create mode 100644 drivers/regulator/bd718x7-regulator.c

-- 
2.14.3

