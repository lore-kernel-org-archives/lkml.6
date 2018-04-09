Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDIJLD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:11:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeDIJLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:11:02 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/9] Input: support for latest Lenovo thinkpads (series 80)
Date: Mon,  9 Apr 2018 11:10:42 +0200
Message-Id: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Here is the v2 of the Lenovo 80 series.
Changes from v1:
- included patch to convert a function to static from build bot
- use of device property instead of platform data (thus the new device tree
  binding)

BTW, KT, if you want to add your Signed-off-by on the patches, feel free to
do so. You were of tremendous help :)

Cheers,
Benjamin

Benjamin Tissoires (9):
  Input: synaptics - add Lenovo 80 series ids to SMBus
  input: elan_i2c_smbus - fix corrupted stack
  Input: elan_i2c - add trackstick report
  Input: elantech - split device info into a separate structure
  Input: elantech_query_info() can be static
  Input: elantech - query the resolution in query_info
  Input: elantech - add support for SMBus devices
  Input: elantech - detect new ICs and setup Host Notify for them
  input: psmouse-smbus: allow to control psmouse_deactivate

 .../devicetree/bindings/input/elan_i2c.txt         |   1 +
 drivers/input/mouse/Kconfig                        |  12 +
 drivers/input/mouse/elan_i2c_core.c                |  90 +++-
 drivers/input/mouse/elan_i2c_smbus.c               |  22 +-
 drivers/input/mouse/elantech.c                     | 479 +++++++++++++++------
 drivers/input/mouse/elantech.h                     |  69 ++-
 drivers/input/mouse/psmouse-base.c                 |  21 +-
 drivers/input/mouse/psmouse-smbus.c                |  24 +-
 drivers/input/mouse/psmouse.h                      |   2 +
 drivers/input/mouse/synaptics.c                    |   5 +-
 10 files changed, 565 insertions(+), 160 deletions(-)

-- 
2.14.3
