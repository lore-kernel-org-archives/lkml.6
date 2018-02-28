Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeB1P1t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:27:49 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37982 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932742AbeB1P1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:27:45 -0500
X-Google-Smtp-Source: AG47ELtVk8CRFjEut7fPMF6sq+1+exn02k4czADf92uRyPc9v2tKSYbTJFDR5JKMwE6aoOBiJqUbpw==
From: Rui Miguel Silva <rui.silva@linaro.org>
To: mchehab@kernel.org, sakari.ailus@linux.intel.com, hverkuil@xs4all.nl
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Harkin <ryan.harkin@linaro.org>,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH v2 0/2] media: Introduce Omnivision OV2680 driver
Date: Wed, 28 Feb 2018 15:27:21 +0000
Message-Id: <20180228152723.26392-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver and bindings for the OV2680 2 megapixel CMOS 1/5" sensor, which has
a single MIPI lane interface and output format of 10-bit Raw RGB.

Features supported are described in PATCH 2/2.

v1->v2:
Fabio Estevam:
    - s/OV5640/OV2680 in PATCH 1/2 changelog

Sakari Ailus:
    - add description on endpoint properties in bindings
    - add single endpoint in bindings
    - drop OF dependency
    - cleanup includes
    - fix case in Color Bars
    - remove frame rate selection
    - 8/16/24 bit register access in the same transaction
    - merge _reset and _soft_reset to _enable and rename it to power_on 
    - _gain_set use only the gain value (drop & 0x7ff)
    - _gain_get remove the (0x377)
    - single write/read at _exposure_set/get use write_reg24/read_reg24
    - move mode_set_direct to _mode_set
    - _mode_set set auto exposure/gain based on ctrl value
    - s_frame_interval equal to g_frame_interval
    - use closest match from: v4l: common: Add a function to obtain best size from a list 
    - check v4l2_ctrl_new_std return in _init

    - fix gain manual value in auto_cluster

Cheers,
    Rui

Rui Miguel Silva (2):
  media: ov2680: dt: Add bindings for OV2680
  media: ov2680: Add Omnivision OV2680 sensor driver

 .../devicetree/bindings/media/i2c/ov2680.txt       |   40 +
 drivers/media/i2c/Kconfig                          |   12 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/ov2680.c                         | 1094 ++++++++++++++++++++
 4 files changed, 1147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov2680.txt
 create mode 100644 drivers/media/i2c/ov2680.c

-- 
2.16.2
