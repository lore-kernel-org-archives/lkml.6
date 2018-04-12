Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeDLKmx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 06:42:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36473 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 06:42:51 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: mjg59@srcf.ucam.org, pali.rohar@gmail.com, dvhart@infradead.org,
        andy@infradead.org, mario.limonciello@dell.com, tiwai@suse.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3 1/3] dell-led: Change dell-led.h to dell-common.h
Date: Thu, 12 Apr 2018 18:42:37 +0800
Message-Id: <20180412104239.25584-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header will be used for more than just led. Change it to a more
generic name.

Cc: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3: Simplify dell_switchable_gfx_is_enabled() by returning bool instead
    of error code.
    Use DMI_DEV_TYPE_OEM_STRING to match Dell System.

v2: Mario suggested to squash the HDA part into the same series.

 drivers/platform/x86/dell-laptop.c          | 2 +-
 include/linux/{dell-led.h => dell-common.h} | 4 ++--
 sound/pci/hda/dell_wmi_helper.c             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename include/linux/{dell-led.h => dell-common.h} (61%)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index c52c6723374b..8ba820e6c3d0 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -29,7 +29,7 @@
 #include <linux/mm.h>
 #include <linux/i8042.h>
 #include <linux/debugfs.h>
-#include <linux/dell-led.h>
+#include <linux/dell-common.h>
 #include <linux/seq_file.h>
 #include <acpi/video.h>
 #include "dell-rbtn.h"
diff --git a/include/linux/dell-led.h b/include/linux/dell-common.h
similarity index 61%
rename from include/linux/dell-led.h
rename to include/linux/dell-common.h
index 92521471517f..37e4b614dd74 100644
--- a/include/linux/dell-led.h
+++ b/include/linux/dell-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DELL_LED_H__
-#define __DELL_LED_H__
+#ifndef __DELL_COMMON_H__
+#define __DELL_COMMON_H__
 
 int dell_micmute_led_set(int on);
 
diff --git a/sound/pci/hda/dell_wmi_helper.c b/sound/pci/hda/dell_wmi_helper.c
index 1b48a8c19d28..56050cc3c0ee 100644
--- a/sound/pci/hda/dell_wmi_helper.c
+++ b/sound/pci/hda/dell_wmi_helper.c
@@ -4,7 +4,7 @@
  */
 
 #if IS_ENABLED(CONFIG_DELL_LAPTOP)
-#include <linux/dell-led.h>
+#include <linux/dell-common.h>
 
 enum {
 	MICMUTE_LED_ON,
-- 
2.17.0
