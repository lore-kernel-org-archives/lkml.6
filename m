Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeAaCga (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:36:30 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41948 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbeAaCg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:36:27 -0500
X-Google-Smtp-Source: AH8x226Y5omzbKCxPU5Qblk0IF0/jWj3wvwL5k+5WFPWw8DLR24BZRafzsQ0Th503hij5pl7VILJLQ==
From: Stephen Boyd <stephen.boyd@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        devicetree-spec@vger.kernel.org
Subject: [PATCH v5 0/4] OF phandle nexus support + GPIO nexus
Date: Tue, 30 Jan 2018 18:36:14 -0800
Message-Id: <20180131023618.14292-1-stephen.boyd@linaro.org>
X-Mailer: git-send-email 2.14.GIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continutation of my phandle remapping/nexus node series
from a while ago. I finally got around to writing the documentation
in the spec for this, but it's really rough around the edges and
could use some review/suggestions to get it into shape. Please
review!

This is one small chunk of work related to DT overlays for expansion
boards. It would be good to have a way to expose #<list>-cells types of
providers through a connector in a standard way. So we introduce a way
to make "nexus" nodes for these types of properties to remap the consumer
number space to the other side of the connector's number space. It's
basically a copy of the interrupt nexus implementation, but without
the address space matching design and interrupt-parent walking.

Changes since v4:
 * Rebased to v4.15
 * Reworded spec patch a bit
 * Dropped overlay stuff from unittest patch because that's done by dtc now

Changes since v3:
 * Added devicetree spec patch
 * Rebased to v4.13-rc1

Changes since v2:
 * Picked up Linus' ack on the gpio core patch
 * Made const stack arrays static (Rob Herring)
 * Used of_property_read_u32() instead of open coding (Rob Herring)

Changes since v1:
 * Addition of optional pass-thru parameter
 * Reduction of strings passed to 1 instead of 3 (or 4 now)
 * Updated gpio patch for the new function signature
 * Updated test-case for new funciton signature and pass-thru parameter
 * Updated kernel-doc to be correct and highlighted difference between this
   API and of_parse_phandle_with_args()

Stephen Boyd (3):
  Document nexus nodes/specifier remapping
  of: Support parsing phandle argument lists through a nexus node
  of: unittest: Add phandle remapping test
  gpio: Support gpio nexus dt bindings

Kernel:
 drivers/gpio/gpiolib-of.c                   |   4 +-
 drivers/of/base.c                           | 184 ++++++++++++++++++++++++++++
 drivers/of/unittest-data/tests-phandle.dtsi |  25 ++++
 drivers/of/unittest.c                       | 120 ++++++++++++++++++
 include/linux/of.h                          |  12 ++
 5 files changed, 343 insertions(+), 2 deletions(-)

Spec:
 source/devicetree-basics.rst | 206 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

-- 
2.7.4
