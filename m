Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeBFUmY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:42:24 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36597 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeBFUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:42:23 -0500
X-Google-Smtp-Source: AH8x227ZUmMA9qGASYVC8lphIfr3RCbaHK54loZ/FXcJHtN2jUCOb1z4SU4OIa9QBkY5PI/EuTzyyg==
From: Corentin Labbe <clabbe@baylibre.com>
To: corbet@lwn.net, jeffrey.t.kirsher@intel.com
Cc: intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] Documentation: networking: Update ixgb kconfig select documentation
Date: Tue,  6 Feb 2018 20:42:14 +0000
Message-Id: <1517949734-27314-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation on how to enable ixgb and ixgb DCB.
Simply remove NETDEV_10000 and replace it with the new used kconfig names.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/networking/ixgb.txt  | 3 ++-
 Documentation/networking/ixgbe.txt | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ixgb.txt b/Documentation/networking/ixgb.txt
index 09f71d71920a..b10f360c57d4 100644
--- a/Documentation/networking/ixgb.txt
+++ b/Documentation/networking/ixgb.txt
@@ -70,7 +70,8 @@ select m for "Intel(R) PRO/10GbE support" located at:
       Location:
         -> Device Drivers
           -> Network device support (NETDEVICES [=y])
-            -> Ethernet (10000 Mbit) (NETDEV_10000 [=y])
+            -> Ethernet driver support (ETHERNET [=y])
+              -> Intel devices (NET_VENDOR_INTEL [=y])
 1. make modules && make modules_install
 
 2. Load the module:
diff --git a/Documentation/networking/ixgbe.txt b/Documentation/networking/ixgbe.txt
index 687835415707..90a3860cca3d 100644
--- a/Documentation/networking/ixgbe.txt
+++ b/Documentation/networking/ixgbe.txt
@@ -253,9 +253,10 @@ Additional Configurations
 
         -> Device Drivers
           -> Network device support (NETDEVICES [=y])
-            -> Ethernet (10000 Mbit) (NETDEV_10000 [=y])
-              -> Intel(R) 10GbE PCI Express adapters support
-                -> Data Center Bridging (DCB) Support
+            -> Ethernet driver (ETHERNET [=y])
+              -> Intel devices (NET_VENDOR_INTEL [=y])
+                -> Intel(R) 10GbE PCI Express adapters support (IXGBE [=y])
+                  -> Data Center Bridging (DCB) Support (IXGBE_DCB [=y])
 
   After these options are selected, you must rebuild your kernel and your
   modules.
-- 
2.13.6
