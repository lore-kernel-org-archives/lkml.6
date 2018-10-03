Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C344C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400DE2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0s3m/T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400DE2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeJCVGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:06:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53469 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:06:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so5900458wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k0oBurpKcb+jcktnaY+LE321qEG6Huo/xO6YoeDBOTU=;
        b=V0s3m/T3Lw3NOSSdeBimM/FMkEYV8oZhaberKYv2oGH9Do3VKBbvV7q8oAv7A3wJsl
         DBD6XqA3r7tKp+6SHMEksz8Hlg1T/Xq4H7Pyiy+HRJyUbcutgRHSLNEF4PbLpqCUNi/R
         NCQ7EbI0ZCXRIoIaT0ZAB6CXFY5LDIQttOQ0qeQ2IM2WMJpSJciG3NsbsftLjV0liuYT
         YNYTqV6Ueio07k3hH/LBtWgD43QFNTbw8OvmRTaY137CtaENLTC6wcU52oTIMo/Xb/9e
         EZmh0auzV0BqznQh0ZlwMgZpPiCuTUUlQf1/oS5EGB8N0ejZqc7P0tfDBAPAZ2ZVdrJb
         mFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k0oBurpKcb+jcktnaY+LE321qEG6Huo/xO6YoeDBOTU=;
        b=XehTMRCyUllfucW0JfRoQRbFRYZFHIU0Q2cQSQ22DvVk5WRyyB/4Q2pbeiIFpeLa5v
         hVyZ2w8ZWOJMrWuDE396lLq6hqITKeDWSM2tOyWSWl8kSF86Ozt4gr/KF23xj1CICmmL
         YiYk6vt/A4cM2bghrVk8jXazL72CaoM296DnpyXlHyMRRA5MDk63d+7qPfhyrRWZjFny
         Es6dYDCQAoWN5gDquXTNGH+nxtprUW7GnNFSq4t3tL3yHXWeft7TYwqn2m6elFDSt6JU
         7FN3n7d/bKrWiDbCkwbwYp1O4Bbul9QCSexPNny4AYiNUs+qFNik3pwWChY3q1qU4RkL
         /jmQ==
X-Gm-Message-State: ABuFfoiNDLLFitvWbom+mnw0hBIljZ0jEbZp4fysbmMDL2BC/IWVq62f
        Bk8Z5p3X19uNyMM8y0IaI1vTAbxL
X-Google-Smtp-Source: ACcGV61AnuHvrU3cTYbfDK6wCcg4hnypmn6BGSeaLCYOixrSLNJGkDKOLLzd3SSgPGqdT46Xs8ocuQ==
X-Received: by 2002:a1c:1649:: with SMTP id 70-v6mr1513523wmw.2.1538576254969;
        Wed, 03 Oct 2018 07:17:34 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd55.dynamic.kabel-deutschland.de. [31.18.253.85])
        by smtp.gmail.com with ESMTPSA id k25-v6sm2961380wre.18.2018.10.03.07.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:17:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: add SPDX identifiers
Date:   Wed,  3 Oct 2018 16:17:16 +0200
Message-Id: <20181003141716.1518-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This satisfies a checkpatch warning and is the preferred
method for notating the license.

The SPDX identifier is a legally binding shorthand, which
can be used instead of the full boiler plate text.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8712/basic_types.h             | 10 +---------
 drivers/staging/rtl8712/drv_types.h               | 10 +---------
 drivers/staging/rtl8712/ethernet.h                | 10 +---------
 drivers/staging/rtl8712/ieee80211.c               | 10 +---------
 drivers/staging/rtl8712/ieee80211.h               | 13 +------------
 drivers/staging/rtl8712/mlme_linux.c              | 14 +-------------
 drivers/staging/rtl8712/mlme_osdep.h              | 14 +-------------
 drivers/staging/rtl8712/mp_custom_oid.h           | 14 +-------------
 drivers/staging/rtl8712/os_intfs.c                | 10 +---------
 drivers/staging/rtl8712/osdep_intf.h              | 14 +-------------
 drivers/staging/rtl8712/osdep_service.h           | 14 +-------------
 drivers/staging/rtl8712/recv_linux.c              | 14 +-------------
 drivers/staging/rtl8712/recv_osdep.h              | 14 +-------------
 drivers/staging/rtl8712/rtl8712_bitdef.h          | 15 +--------------
 drivers/staging/rtl8712/rtl8712_cmd.c             | 14 +-------------
 drivers/staging/rtl8712/rtl8712_cmd.h             | 14 +-------------
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h  | 15 +--------------
 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h  | 15 +--------------
 .../staging/rtl8712/rtl8712_debugctrl_bitdef.h    | 15 +--------------
 .../staging/rtl8712/rtl8712_debugctrl_regdef.h    | 15 +--------------
 .../staging/rtl8712/rtl8712_edcasetting_bitdef.h  | 14 +-------------
 .../staging/rtl8712/rtl8712_edcasetting_regdef.h  | 15 +--------------
 drivers/staging/rtl8712/rtl8712_efuse.c           | 14 +-------------
 drivers/staging/rtl8712/rtl8712_event.h           | 14 +-------------
 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h | 15 +--------------
 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h | 15 +--------------
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h       | 14 +-------------
 drivers/staging/rtl8712/rtl8712_gp_regdef.h       | 14 +-------------
 drivers/staging/rtl8712/rtl8712_hal.h             | 14 +-------------
 .../staging/rtl8712/rtl8712_interrupt_bitdef.h    | 15 +--------------
 drivers/staging/rtl8712/rtl8712_io.c              | 14 +-------------
 drivers/staging/rtl8712/rtl8712_led.c             | 14 +-------------
 .../staging/rtl8712/rtl8712_macsetting_bitdef.h   | 15 +--------------
 .../staging/rtl8712/rtl8712_macsetting_regdef.h   | 15 +--------------
 .../staging/rtl8712/rtl8712_powersave_bitdef.h    | 15 +--------------
 .../staging/rtl8712/rtl8712_powersave_regdef.h    | 15 +--------------
 drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h | 15 +--------------
 drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h | 14 +-------------
 drivers/staging/rtl8712/rtl8712_recv.c            | 14 +-------------
 drivers/staging/rtl8712/rtl8712_recv.h            | 14 +-------------
 drivers/staging/rtl8712/rtl8712_regdef.h          | 14 +-------------
 drivers/staging/rtl8712/rtl8712_security_bitdef.h | 15 +--------------
 drivers/staging/rtl8712/rtl8712_spec.h            | 14 +-------------
 drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h   | 14 +-------------
 drivers/staging/rtl8712/rtl8712_syscfg_regdef.h   | 14 +-------------
 drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h | 15 +--------------
 drivers/staging/rtl8712/rtl8712_timectrl_regdef.h | 15 +--------------
 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h     | 14 +-------------
 drivers/staging/rtl8712/rtl8712_wmac_regdef.h     | 14 +-------------
 drivers/staging/rtl8712/rtl8712_xmit.c            | 14 +-------------
 drivers/staging/rtl8712/rtl8712_xmit.h            | 14 +-------------
 drivers/staging/rtl8712/rtl871x_cmd.c             | 14 +-------------
 drivers/staging/rtl8712/rtl871x_cmd.h             | 14 +-------------
 drivers/staging/rtl8712/rtl871x_debug.h           | 14 +-------------
 drivers/staging/rtl8712/rtl871x_eeprom.c          | 14 +-------------
 drivers/staging/rtl8712/rtl871x_eeprom.h          | 15 +--------------
 drivers/staging/rtl8712/rtl871x_event.h           | 14 +-------------
 drivers/staging/rtl8712/rtl871x_ht.h              | 14 +-------------
 drivers/staging/rtl8712/rtl871x_io.c              | 14 +-------------
 drivers/staging/rtl8712/rtl871x_io.h              | 14 +-------------
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c     | 14 +-------------
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c       | 14 +-------------
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.h       | 14 +-------------
 drivers/staging/rtl8712/rtl871x_ioctl_set.c       | 14 +-------------
 drivers/staging/rtl8712/rtl871x_ioctl_set.h       | 14 +-------------
 drivers/staging/rtl8712/rtl871x_led.h             | 14 +-------------
 drivers/staging/rtl8712/rtl871x_mlme.c            | 14 +-------------
 drivers/staging/rtl8712/rtl871x_mlme.h            | 14 +-------------
 drivers/staging/rtl8712/rtl871x_mp.c              | 14 +-------------
 drivers/staging/rtl8712/rtl871x_mp.h              | 14 +-------------
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c        | 14 +-------------
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h        | 14 +-------------
 drivers/staging/rtl8712/rtl871x_pwrctrl.c         | 14 +-------------
 drivers/staging/rtl8712/rtl871x_pwrctrl.h         | 14 +-------------
 drivers/staging/rtl8712/rtl871x_recv.c            | 14 +-------------
 drivers/staging/rtl8712/rtl871x_rf.h              | 14 +-------------
 drivers/staging/rtl8712/rtl871x_security.c        | 14 +-------------
 drivers/staging/rtl8712/rtl871x_security.h        | 14 +-------------
 drivers/staging/rtl8712/rtl871x_sta_mgt.c         | 14 +-------------
 drivers/staging/rtl8712/rtl871x_wlan_sme.h        | 14 +-------------
 drivers/staging/rtl8712/rtl871x_xmit.c            | 14 +-------------
 drivers/staging/rtl8712/rtl871x_xmit.h            | 14 +-------------
 drivers/staging/rtl8712/sta_info.h                | 14 +-------------
 drivers/staging/rtl8712/usb_halinit.c             | 14 +-------------
 drivers/staging/rtl8712/usb_intf.c                | 14 +-------------
 drivers/staging/rtl8712/usb_ops.c                 | 14 +-------------
 drivers/staging/rtl8712/usb_ops.h                 | 14 +-------------
 drivers/staging/rtl8712/usb_ops_linux.c           | 14 +-------------
 drivers/staging/rtl8712/usb_osintf.h              | 14 +-------------
 drivers/staging/rtl8712/wifi.h                    | 14 +-------------
 drivers/staging/rtl8712/wlan_bssdef.h             | 14 +-------------
 drivers/staging/rtl8712/xmit_linux.c              | 14 +-------------
 drivers/staging/rtl8712/xmit_osdep.h              | 14 +-------------
 93 files changed, 93 insertions(+), 1206 deletions(-)

diff --git a/drivers/staging/rtl8712/basic_types.h b/drivers/staging/rtl8712/basic_types.h
index f5c0231891b1..4ad7f35b1644 100644
--- a/drivers/staging/rtl8712/basic_types.h
+++ b/drivers/staging/rtl8712/basic_types.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index ede99e96984f..48d62fe6c8d4 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/ethernet.h b/drivers/staging/rtl8712/ethernet.h
index 039da36fad3d..4b9b8a97a0bc 100644
--- a/drivers/staging/rtl8712/ethernet.h
+++ b/drivers/staging/rtl8712/ethernet.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 7a4c00e49a88..bb4f56a5fb01 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * ieee80211.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/ieee80211.h b/drivers/staging/rtl8712/ieee80211.h
index d605dfd02200..1470771daa62 100644
--- a/drivers/staging/rtl8712/ieee80211.h
+++ b/drivers/staging/rtl8712/ieee80211.h
@@ -1,19 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index baaa52f04560..9d156efbc9ed 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * mlme_linux.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/mlme_osdep.h b/drivers/staging/rtl8712/mlme_osdep.h
index a20fe81f921f..9eaf94f072ff 100644
--- a/drivers/staging/rtl8712/mlme_osdep.h
+++ b/drivers/staging/rtl8712/mlme_osdep.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/mp_custom_oid.h b/drivers/staging/rtl8712/mp_custom_oid.h
index 40510089b781..a9fac87fcabc 100644
--- a/drivers/staging/rtl8712/mp_custom_oid.h
+++ b/drivers/staging/rtl8712/mp_custom_oid.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index ff4e451c10f9..2d3f38007299 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * os_intfs.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl8712/osdep_intf.h
index 5d37e1f951cf..2cc25db1a91d 100644
--- a/drivers/staging/rtl8712/osdep_intf.h
+++ b/drivers/staging/rtl8712/osdep_intf.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/osdep_service.h b/drivers/staging/rtl8712/osdep_service.h
index 5d33020554cd..e939c4a954b3 100644
--- a/drivers/staging/rtl8712/osdep_service.h
+++ b/drivers/staging/rtl8712/osdep_service.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
index 8cf4286f6318..4e20cbafa9fb 100644
--- a/drivers/staging/rtl8712/recv_linux.c
+++ b/drivers/staging/rtl8712/recv_linux.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * recv_linux.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/recv_osdep.h b/drivers/staging/rtl8712/recv_osdep.h
index 1f4986e940a3..dcd3b484c793 100644
--- a/drivers/staging/rtl8712/recv_osdep.h
+++ b/drivers/staging/rtl8712/recv_osdep.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_bitdef.h b/drivers/staging/rtl8712/rtl8712_bitdef.h
index dee35fe2587a..a4a687dcc2e7 100644
--- a/drivers/staging/rtl8712/rtl8712_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 
 #ifndef __RTL8712_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index b1dfe9f46619..1920d02f7c9f 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl8712_cmd.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_cmd.h b/drivers/staging/rtl8712/rtl8712_cmd.h
index 9181bb6b04c3..92fb77666d44 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.h
+++ b/drivers/staging/rtl8712/rtl8712_cmd.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
index 4b8985d50098..e125c7222ab5 100644
--- a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_CMDCTRL_BITDEF_H__
 #define __RTL8712_CMDCTRL_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h b/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
index 8df42a70399f..fc67771c89b7 100644
--- a/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_CMDCTRL_REGDEF_H__
 #define __RTL8712_CMDCTRL_REGDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
index 4b3436795cb1..bb3863467f0d 100644
--- a/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_DEBUGCTRL_BITDEF_H__
 #define __RTL8712_DEBUGCTRL_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h b/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
index d7c964d436a1..319220e9d53d 100644
--- a/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_DEBUGCTRL_REGDEF_H__
 #define __RTL8712_DEBUGCTRL_REGDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h b/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h
index 32dab81f1767..9048d6a65296 100644
--- a/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h b/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h
index d992cb8b1c73..02ec9f3bba66 100644
--- a/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_EDCASETTING_REGDEF_H__
 #define __RTL8712_EDCASETTING_REGDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
index d90213eb5e20..8bc45ffd3029 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.c
+++ b/drivers/staging/rtl8712/rtl8712_efuse.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * rtl8712_efuse.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_event.h b/drivers/staging/rtl8712/rtl8712_event.h
index cad7085c3f8a..0d3e5feadcc0 100644
--- a/drivers/staging/rtl8712/rtl8712_event.h
+++ b/drivers/staging/rtl8712/rtl8712_event.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
index bd8240476d71..f09645fa1886 100644
--- a/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_FIFOCTRL_BITDEF_H__
 #define __RTL8712_FIFOCTRL_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h b/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
index 6d527380fd29..189fdeb16d7d 100644
--- a/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_FIFOCTRL_REGDEF_H__
 #define __RTL8712_FIFOCTRL_REGDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_gp_bitdef.h b/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
index 66c35c990983..ee651fb3fde3 100644
--- a/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_gp_regdef.h b/drivers/staging/rtl8712/rtl8712_gp_regdef.h
index a0379360d0a3..892a7fb13923 100644
--- a/drivers/staging/rtl8712/rtl8712_gp_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_gp_regdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_hal.h b/drivers/staging/rtl8712/rtl8712_hal.h
index 84456bb560ef..42f519739128 100644
--- a/drivers/staging/rtl8712/rtl8712_hal.h
+++ b/drivers/staging/rtl8712/rtl8712_hal.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h b/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
index 2a561d2862e0..e9732a1bcd7e 100644
--- a/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_INTERRUPT_BITDEF_H__
 #define __RTL8712_INTERRUPT_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_io.c b/drivers/staging/rtl8712/rtl8712_io.c
index 391eff37f573..8eb79f73c014 100644
--- a/drivers/staging/rtl8712/rtl8712_io.c
+++ b/drivers/staging/rtl8712/rtl8712_io.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl8712_io.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_led.c b/drivers/staging/rtl8712/rtl8712_led.c
index 0aa97c9dcced..5b1004b2df47 100644
--- a/drivers/staging/rtl8712/rtl8712_led.c
+++ b/drivers/staging/rtl8712/rtl8712_led.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl8712_led.c
  *
  * Copyright(c) 2007 - 2010  Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h b/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
index 28e0a7ebcad7..3d9f40fa8469 100644
--- a/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_MACSETTING_BITDEF_H__
 #define __RTL8712_MACSETTING_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h b/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
index ced0da9332d5..e8cb2eee9294 100644
--- a/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_MACSETTING_REGDEF_H__
 #define __RTL8712_MACSETTING_REGDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h b/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h
index 8fc689416519..53e0d6b440f3 100644
--- a/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_POWERSAVE_BITDEF_H__
 #define __RTL8712_POWERSAVE_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_powersave_regdef.h b/drivers/staging/rtl8712/rtl8712_powersave_regdef.h
index 4632ddd5d1f7..1bcfde4b1c11 100644
--- a/drivers/staging/rtl8712/rtl8712_powersave_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_powersave_regdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_POWERSAVE_REGDEF_H__
 #define __RTL8712_POWERSAVE_REGDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h
index 6d3d6e8522fb..1de51c48f9c1 100644
--- a/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_RATECTRL_BITDEF_H__
 #define __RTL8712_RATECTRL_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h b/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
index 73dfc3610154..a3eaee0e1b69 100644
--- a/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 4264cd341f03..5bf9070b7a28 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl8712_recv.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_recv.h b/drivers/staging/rtl8712/rtl8712_recv.h
index 0352e6fafd90..6954c5bfbcaf 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.h
+++ b/drivers/staging/rtl8712/rtl8712_recv.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_regdef.h b/drivers/staging/rtl8712/rtl8712_regdef.h
index e7bca55b59d0..28aec9aa539f 100644
--- a/drivers/staging/rtl8712/rtl8712_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_regdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_security_bitdef.h b/drivers/staging/rtl8712/rtl8712_security_bitdef.h
index 05dafa0c3333..1c26a7eca64a 100644
--- a/drivers/staging/rtl8712/rtl8712_security_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_security_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_SECURITY_BITDEF_H__
 #define __RTL8712_SECURITY_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_spec.h b/drivers/staging/rtl8712/rtl8712_spec.h
index 51e042815cc9..c0bab4c49ae9 100644
--- a/drivers/staging/rtl8712/rtl8712_spec.h
+++ b/drivers/staging/rtl8712/rtl8712_spec.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h b/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
index 2e66d28d6918..a328ca9b340c 100644
--- a/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h b/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
index 767dfdf8d83f..e95eb5832ec4 100644
--- a/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
index 724421582421..1af5f1dd3c20 100644
--- a/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_TIMECTRL_BITDEF_H__
 #define __RTL8712_TIMECTRL_BITDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h b/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h
index 106916c7e310..b51603f1b880 100644
--- a/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL8712_TIMECTRL_REGDEF_H__
 #define __RTL8712_TIMECTRL_REGDEF_H__
diff --git a/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h b/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
index 61a3603aa587..d3b45c6cd855 100644
--- a/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_wmac_regdef.h b/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
index d9f8347ab461..662383fe7a8d 100644
--- a/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index fb64c2891e22..aa6fb516f398 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl8712_xmit.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl8712_xmit.h b/drivers/staging/rtl8712/rtl8712_xmit.h
index 02b1593ada01..9be8fb70c92e 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.h
+++ b/drivers/staging/rtl8712/rtl8712_xmit.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 620cee8b8514..05a78ac24987 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_cmd.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 24da2ccea04f..75a126d8e26c 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_debug.h b/drivers/staging/rtl8712/rtl871x_debug.h
index 74468b058258..a427547c02ba 100644
--- a/drivers/staging/rtl8712/rtl871x_debug.h
+++ b/drivers/staging/rtl8712/rtl871x_debug.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_eeprom.c b/drivers/staging/rtl8712/rtl871x_eeprom.c
index 4e713610ad8b..948bd0c757b5 100644
--- a/drivers/staging/rtl8712/rtl871x_eeprom.c
+++ b/drivers/staging/rtl8712/rtl871x_eeprom.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_eeprom.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_eeprom.h b/drivers/staging/rtl8712/rtl871x_eeprom.h
index 497276e53bbe..7bdeb2aaa025 100644
--- a/drivers/staging/rtl8712/rtl871x_eeprom.h
+++ b/drivers/staging/rtl8712/rtl871x_eeprom.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
  ******************************************************************************/
 #ifndef __RTL871X_EEPROM_H__
 #define __RTL871X_EEPROM_H__
diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
index 517137906e6c..d9a5476d2426 100644
--- a/drivers/staging/rtl8712/rtl871x_event.h
+++ b/drivers/staging/rtl8712/rtl871x_event.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_ht.h b/drivers/staging/rtl8712/rtl871x_ht.h
index 513f458ea07c..ebd78665775d 100644
--- a/drivers/staging/rtl8712/rtl871x_ht.h
+++ b/drivers/staging/rtl8712/rtl871x_ht.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 3a10940db9b7..931e5000e85f 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_io.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
index dd054d7367b3..28941423b7ed 100644
--- a/drivers/staging/rtl8712/rtl871x_io.h
+++ b/drivers/staging/rtl8712/rtl871x_io.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 08f7d1cc8ec1..e723357ac8c0 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_ioctl_linux.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
index ca769f781e96..2dc20da21679 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_ioctl_rtl.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
index 3bcceae3cbeb..7c0b880ac686 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
index f4a53df7f2c1..2622d5e3bff9 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_ioctl_set.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.h b/drivers/staging/rtl8712/rtl871x_ioctl_set.h
index 2c94cd151c96..8b1085aea962 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.h
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_led.h b/drivers/staging/rtl8712/rtl871x_led.h
index adfbc400a18d..ee19c873cf01 100644
--- a/drivers/staging/rtl8712/rtl871x_led.h
+++ b/drivers/staging/rtl8712/rtl871x_led.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index ac547ddd72d1..a7374006a9fb 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_mlme.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.h b/drivers/staging/rtl8712/rtl871x_mlme.h
index 918947f38151..8a54181f4816 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.h
+++ b/drivers/staging/rtl8712/rtl871x_mlme.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_mp.c b/drivers/staging/rtl8712/rtl871x_mp.c
index ba208a2e1e4e..1d5364f5a518 100644
--- a/drivers/staging/rtl8712/rtl871x_mp.c
+++ b/drivers/staging/rtl8712/rtl871x_mp.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_mp.h b/drivers/staging/rtl8712/rtl871x_mp.h
index 8df452e3e3ce..e79a67676469 100644
--- a/drivers/staging/rtl8712/rtl871x_mp.h
+++ b/drivers/staging/rtl8712/rtl871x_mp.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
index 6e264a8d0087..588346da1412 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_mp_ioctl.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h b/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
index 741006f1e45a..44cd911f2aa1 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.c b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
index ae4c9567bb55..351984fe254e 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.c
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_pwrctrl.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
index bd2c3a2df48b..11b5034f203d 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 2ef31a4e9a6b..f10896df094b 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_recv.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_rf.h b/drivers/staging/rtl8712/rtl871x_rf.h
index 133ed6462928..cc54453cd424 100644
--- a/drivers/staging/rtl8712/rtl871x_rf.h
+++ b/drivers/staging/rtl8712/rtl871x_rf.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index 1075eacdb441..f82645011d02 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_security.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/rtl8712/rtl871x_security.h
index 46b88a41d236..25b4d379766d 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_sta_mgt.c b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
index e2d75e4c473f..9648ee15b40e 100644
--- a/drivers/staging/rtl8712/rtl871x_sta_mgt.c
+++ b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_sta_mgt.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_wlan_sme.h b/drivers/staging/rtl8712/rtl871x_wlan_sme.h
index 44924d5de217..97ea1451426c 100644
--- a/drivers/staging/rtl8712/rtl871x_wlan_sme.h
+++ b/drivers/staging/rtl8712/rtl871x_wlan_sme.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index e780d84dbb72..5c7dc9c6f76b 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * rtl871x_xmit.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index 40927277f498..3bea2e374f13 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/sta_info.h b/drivers/staging/rtl8712/sta_info.h
index 742dfa0ca817..45dbed10295f 100644
--- a/drivers/staging/rtl8712/sta_info.h
+++ b/drivers/staging/rtl8712/sta_info.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/usb_halinit.c b/drivers/staging/rtl8712/usb_halinit.c
index 0b159850f5a2..02e73c2412d4 100644
--- a/drivers/staging/rtl8712/usb_halinit.c
+++ b/drivers/staging/rtl8712/usb_halinit.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * usb_halinit.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 85eadddfaf06..92d75d7c51ae 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * usb_intf.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/usb_ops.c b/drivers/staging/rtl8712/usb_ops.c
index 332e2e51d778..eef52d5c730a 100644
--- a/drivers/staging/rtl8712/usb_ops.c
+++ b/drivers/staging/rtl8712/usb_ops.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * usb_ops.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/usb_ops.h b/drivers/staging/rtl8712/usb_ops.h
index 78e775a46364..d62975447d29 100644
--- a/drivers/staging/rtl8712/usb_ops.h
+++ b/drivers/staging/rtl8712/usb_ops.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index 6d12a96fa65f..ee5968808332 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * usb_ops_linux.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/usb_osintf.h b/drivers/staging/rtl8712/usb_osintf.h
index 609f9210cc46..ddfa405d0c9b 100644
--- a/drivers/staging/rtl8712/usb_osintf.h
+++ b/drivers/staging/rtl8712/usb_osintf.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 00a4302e9983..77346debea03 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/wlan_bssdef.h b/drivers/staging/rtl8712/wlan_bssdef.h
index 9dc9ce5a2ccc..b54ccaacc527 100644
--- a/drivers/staging/rtl8712/wlan_bssdef.h
+++ b/drivers/staging/rtl8712/wlan_bssdef.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 4ee4136b5c28..8bcb0775411f 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * xmit_linux.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
diff --git a/drivers/staging/rtl8712/xmit_osdep.h b/drivers/staging/rtl8712/xmit_osdep.h
index 8eba7ca0ddef..21f6b31e0f50 100644
--- a/drivers/staging/rtl8712/xmit_osdep.h
+++ b/drivers/staging/rtl8712/xmit_osdep.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
  * Modifications for inclusion into the Linux staging tree are
  * Copyright(c) 2010 Larry Finger. All rights reserved.
  *
-- 
2.17.1

