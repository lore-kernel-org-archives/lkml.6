Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938776AbeBURAE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:00:04 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38394 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933341AbeBURAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:00:00 -0500
X-Google-Smtp-Source: AH8x225a/8J9HVTgsdSHVvaPCLy4tRRaK/pl9TQWMnBznzqp2oVLnHElFDmJW3+njtm9mxbVGUHdgQ==
Date: Wed, 21 Feb 2018 17:59:57 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] Topstar U931/RVP7 ACPI LED Workaround
Message-ID: <cover.1519231939.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for your review. Changes since the previous submission are
highlighted below.

On Topstar U931/RVP7 Notebooks, an issue prevents the WLAN toggle key
from being properly managed by the Embedded Controller and successfully
disconnect the adapter. A specific ACPI method allows to toggle the WLAN
LED state regardless.

Based on a DMI check, the LED is registered within the corresponding
subsystem, making possible to use a software-based trigger (rfkill for
instance, to synchronize the LED with the network interface state).

Thank you for your time,

--
Guillaume Douézan-Grard


Changes since v4:

* move module description comment change from patch 5 to 4,
* fix SDPX identifiers mismatch.


Changes since v3:

* fix revert commit message format and wrapping,
* update module description while actually doing the changes,
* switch to SDPX identifiers.


Changes since v2:

* revert an older conversion from a generic module to an acpi driver
module instead of undoing it manually,
* separate commits for the renaming and the spliting phases,
* DMI-based check instead of a module parameter,
* copyright and minor fixes put at the end.


Changes since v1:

* leave devices names unchanged for ABI compatibility,
* fix label names,
* separate module authors definition,
* add commit description to Patch 3.


Guillaume Douézan-Grard (7):
  platform/x86: topstar-laptop: revert "convert to module_acpi_driver()"
  platform/x86: topstar-laptop: use consistent naming scheme
  platform/x86: topstar-laptop: split ACPI events and input handling
  platform/x86: topstar-laptop: add platform device
  platform/x86: topstar-laptop: add Topstar U931/RVP7 WLAN LED
    workaround
  platform/x86: topstar-laptop: update copyright and fix some comments
  platform/x86: topstar-laptop: replace licence text with SPDX tag

 drivers/platform/x86/Kconfig          |   2 +
 drivers/platform/x86/topstar-laptop.c | 363 +++++++++++++++++++++++++++-------
 2 files changed, 291 insertions(+), 74 deletions(-)

-- 
2.16.1
