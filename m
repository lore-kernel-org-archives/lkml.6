Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C1C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD8B20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD8B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeGIPUl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:20:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:39142 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932844AbeGIPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:20:39 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lsupa-1g4cjL2cDy-012WN4; Mon, 09 Jul 2018 17:19:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jean-Christophe Trotin <jean-christophe.trotin@st.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] headers: fix linux/mod_devicetable.h inclusions
Date:   Mon,  9 Jul 2018 17:19:02 +0200
Message-Id: <20180709151947.940759-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:efgJ6uVok1qdxHrFjPB7HE8+6nRPiiIcuxHKpGOFUC969JcCc6l
 4x2gjqNrFe78eDYKMTcO6A4f7oLi9P6oC1vyJsmMP8PEf+ixlaZ/CLXv/JBnnvPf0ZAO/vS
 kykH8N2M9hZAtpUXHgMP5xpVenGnib7NNrdiRBp7d/dfjQx6pj86xmiHg8qrGtWRJxp4TjS
 oLsylRUow6I1JCNGLp1Pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fo9KCseshzY=:Qq5r4itrPVxG0RSCRwZTwS
 0Aj7FfkDgoX9nLGvtf/Gq1YzOj4UoOPfOnVILoUTzS1z9oTYj3JepKP7K+GakMQ9toLXED+Sm
 dMc09GsjqBuFz19enGXjFcF8vlY2GeLjwWnXFNWes9DyN0+s1aVIk01EnssaBNpZsTLCeSamS
 X+enXG9IfYw6NsI2F/rBZhuFN2lW5jDbs5pzxOR+FYbTR5V6EjHRG7yTT/RHImblw5K+rwEn7
 fEyZvzGLyF2Fm7SWymyl4j0UNULLL3ETiyb55gVIL9/ejL7Z6gHAvGC9J37u6BvSuchES9P6E
 IGqUjm0yiKCrYL6b9SxKXjCR5igbPBJrSPW3s88m0EdFUBMvFq+ciwNw7XG2SL7uOKbdGr8+i
 HxmT75BO5gu+DxxRad0mIGuDkFxU+rtzPEUDY16iWZUXTlmTIegWg+waZEDwtWMnhA3a+ZNhI
 Q3LUApwhVQ+FgROiDWakT2nlDqG5lIqGS1Q6IH+3h+Q6vqhKubtQV9c4grmm2VR0FMFmrl6c1
 sbXdYk+fEamakzCtTSpWHHxJ1T7J4xA3SAosGZXkwjYvRrHfM4QZJSCNCcUGASVOrcTwQnMAg
 MbhO3wN/3IMbbgNrSDiDeq2cIizyfOMKTybupFtsOjVMPmccYUTT7wnfaEMF92ewgQuSXeXlJ
 x45SbzHDp0IGS1b8Ay1ePcmex+O0L5XoH8H+8RL8USp1zaSAEnteoN7Hs/Ln8LIo+LYs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of drivers produced build errors after the mod_devicetable.h
header was split out from the platform_device one, e.g.

drivers/media/platform/davinci/vpbe_osd.c:42:40: error: array type has incomplete element type 'struct platform_device_id'
drivers/media/platform/davinci/vpbe_venc.c:42:40: error: array type has incomplete element type 'struct platform_device_id'

This adds the inclusion where needed.

Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/qemu_fw_cfg.c             | 1 +
 drivers/media/platform/davinci/vpbe_osd.c  | 1 +
 drivers/media/platform/davinci/vpbe_venc.c | 1 +
 drivers/media/platform/qcom/venus/vdec.c   | 1 +
 drivers/media/platform/qcom/venus/venc.c   | 1 +
 drivers/media/platform/sti/hva/hva-v4l2.c  | 1 +
 drivers/platform/x86/intel_punit_ipc.c     | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 14fedbeca724..039e0f91dba8 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
diff --git a/drivers/media/platform/davinci/vpbe_osd.c b/drivers/media/platform/davinci/vpbe_osd.c
index 7f610320426d..c551a25d90d9 100644
--- a/drivers/media/platform/davinci/vpbe_osd.c
+++ b/drivers/media/platform/davinci/vpbe_osd.c
@@ -18,6 +18,7 @@
  *
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
diff --git a/drivers/media/platform/davinci/vpbe_venc.c b/drivers/media/platform/davinci/vpbe_venc.c
index ba157827192c..ddcad7b3e76c 100644
--- a/drivers/media/platform/davinci/vpbe_venc.c
+++ b/drivers/media/platform/davinci/vpbe_venc.c
@@ -11,6 +11,7 @@
  * GNU General Public License for more details.
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/ctype.h>
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index f89a91d43cc9..d4e23c7df347 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -14,6 +14,7 @@
  */
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index f7a87a3dbb46..0522cf202b75 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -14,6 +14,7 @@
  */
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
diff --git a/drivers/media/platform/sti/hva/hva-v4l2.c b/drivers/media/platform/sti/hva/hva-v4l2.c
index 15080cb00fa7..5a807c7c5e79 100644
--- a/drivers/media/platform/sti/hva/hva-v4l2.c
+++ b/drivers/media/platform/sti/hva/hva-v4l2.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <media/v4l2-event.h>
diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
index b5b890127479..f1afc0ebbc68 100644
--- a/drivers/platform/x86/intel_punit_ipc.c
+++ b/drivers/platform/x86/intel_punit_ipc.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
-- 
2.9.0

