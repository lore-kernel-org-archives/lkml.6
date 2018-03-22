Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754970AbeCVNye (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:54:34 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:49058 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755408AbeCVNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:53:57 -0400
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To: jakob.unterwurzacher@theobroma-systems.com
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] can: ucan: add driver for Theobroma Systems UCAN devices
Date: Thu, 22 Mar 2018 14:53:37 +0100
Message-Id: <20180322135338.60923-1-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 of the Theobroma Systems CAN/USB adapter driver
upstreaming effort.

Featured v2 -> v3 changes:
* count error frames as data packets
* use canid_t for all can ids
* use BIT(x) instead of (1 << x)
* use __le16 / __le32 for little-endian fields
* add spinlock around context allocation (fixes a possible race)
* fix comment style
* use WARN_ON return value
* fix state logic bug that did not allow return to ERROR_ACTIVE
* drop echo_index from context_array (not needed)
* rename "tx_contexts" -> "context_array" to prevent confusion
* add __func__ to all errors and warnings, and to info where it made sense

Jakob Unterwurzacher (1):
  can: ucan: add driver for Theobroma Systems UCAN devices

 Documentation/networking/can_ucan_protocol.rst |  315 +++++
 Documentation/networking/index.rst             |    1 +
 drivers/net/can/usb/Kconfig                    |   10 +
 drivers/net/can/usb/Makefile                   |    1 +
 drivers/net/can/usb/ucan.c                     | 1628 ++++++++++++++++++++++++
 5 files changed, 1955 insertions(+)
 create mode 100644 Documentation/networking/can_ucan_protocol.rst
 create mode 100644 drivers/net/can/usb/ucan.c

-- 
2.11.0

Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
