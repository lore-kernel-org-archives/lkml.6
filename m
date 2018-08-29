Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF8920850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF8920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeH2Qcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:32:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33482 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Qcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:32:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id m26-v6so4160342lfb.0;
        Wed, 29 Aug 2018 05:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=vpnaqmcDGONgl/aIdNszL8SxMeXwKnFrdHVIorBeigg=;
        b=EZUgFpLfrtvZKpF9WAsJFU/psuqUFN8dv5hXUa0CFZoJQ4ayplBX7wRtJv2uI738V1
         lzTE7Nfm9EIiKx8jIuszVbCbhoztffEhmRHcvsA3jGG3VMmEAKHbip+8WohG03PxkhSi
         1c2X34IPtx1ADs1OLWCAAaQgzSdoPR6YWKDwcaNNgxYjcqjH5B5v0AfTIF8v+Te8qFav
         OJ85krhZmNxovG0TSkGuUpdO7YaPssl5rO3LLzltwbEOqX+JqiRLnznxrGT5kVnYVLbi
         2wudirBmVGFvQlUVXBcUJt8IKDk10WjKwhHltqz/tX4fuYWhRMbSnjhiomr53gdjZ32s
         Ej3w==
X-Gm-Message-State: APzg51DgKMAgWX1YszqgKzCBMoufgJYSUo6SDM+VtmKbzLIH0iaUJLnb
        POUv9EjwDUCnR3EmvpMcUb4=
X-Google-Smtp-Source: ANB0VdYsiFd5P7G/8hU2C2vTr2mIQwTt5ZrJa9g7fPar3YW91hyQhIw6Z6dZnwt5wJXZRchVyd07nA==
X-Received: by 2002:a19:a915:: with SMTP id s21-v6mr4421182lfe.92.1535546146783;
        Wed, 29 Aug 2018 05:35:46 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g16-v6sm711842lje.1.2018.08.29.05.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:35:46 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:35:38 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 0/8] regulator/mfd/dt_bindings: bd718x7: Support ROHM bd71847
Message-ID: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
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

Patch 1:
	BD71837/BD71847 voltage monitoring fix.
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

this patch series is based on linux-next tag next-20180823.

Matti Vaittinen (8):
  regulator: bd71837: Disable voltage monitoring for LDO3/4
  regulator: Support ROHM BD71847 power management IC
  regulator: dt bindings: add BD71847 device-tree binding documentation
  mfd: dt bindings: add BD71847 device-tree binding documentation
  regulator: Support regulators where voltage ranges are selectable
  regulator/mfd: bd718xx: rename bd71837/bd71847 common instances
  regulator: bd718XX use pickable ranges
  regulator: bd718xx: renme bd71837 to 718xx

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |   17 +-
 .../bindings/regulator/rohm,bd71837-regulator.txt  |   12 +-
 drivers/mfd/rohm-bd718x7.c                         |  182 ++--
 drivers/regulator/Kconfig                          |    2 +-
 drivers/regulator/Makefile                         |    2 +-
 drivers/regulator/bd71837-regulator.c              |  626 -----------
 drivers/regulator/bd718x7-regulator.c              | 1138 ++++++++++++++++++++
 drivers/regulator/core.c                           |    5 +
 drivers/regulator/helpers.c                        |  232 ++++
 include/linux/mfd/rohm-bd718x7.h                   |  375 +++----
 include/linux/regulator/driver.h                   |   20 +-
 11 files changed, 1714 insertions(+), 897 deletions(-)
 delete mode 100644 drivers/regulator/bd71837-regulator.c
 create mode 100644 drivers/regulator/bd718x7-regulator.c

-- 
2.14.3

