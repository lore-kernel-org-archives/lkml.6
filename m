Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2662C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA211222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391683AbfBMOHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:07:44 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:35957 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391585AbfBMOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:07:43 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07112098|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16367;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.Dy6iQiS_1550066841;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Dy6iQiS_1550066841)
          by smtp.aliyun-inc.com(10.147.40.233);
          Wed, 13 Feb 2019 22:07:36 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC v8 2/5] dt-bindings: pstore-block: new support for blkoops
Date:   Wed, 13 Feb 2019 22:07:05 +0800
Message-Id: <1550066828-18806-3-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550066828-18806-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1550066828-18806-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create DT binding document for blkoops.

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 .../devicetree/bindings/pstore/blkoops.txt         | 29 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pstore/blkoops.txt

diff --git a/Documentation/devicetree/bindings/pstore/blkoops.txt b/Documentation/devicetree/bindings/pstore/blkoops.txt
new file mode 100644
index 0000000..8f3d85f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pstore/blkoops.txt
@@ -0,0 +1,29 @@
+Blkoops oops logger
+===================
+
+Blkoops provides a block partition for oops, excluding panics now, so they can
+be recovered after a reboot.
+
+Any space of block partition will be used for a circular buffer of oops records.
+These records have a configurable size, with a size of 0 indicating that they
+should be disabled.
+
+"partition-size" and at least one of "dmesg-size" or "pmsg-size" must be set
+non-zero, but are otherwise optional as listed below.
+
+Required properties:
+
+- compatible: must be "blkoops".
+
+- partition-size: size in kbytes, must be a multiple of 4.
+
+Optional properties:
+
+- partition-path: strings must begin with "/dev", tell blkoops which partition
+  it can used. If it is not set, blkoops will drop all data when reboot.
+
+- dmesg-size: maximum size in kbytes of each dump done on oops, which must be a
+  multiple of 4.
+
+- pmsg-size: maximum size in kbytes for userspace messages, which must be a
+  multiple of 4.
diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a4..f49dd37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12318,6 +12318,7 @@ F:	drivers/firmware/efi/efi-pstore.c
 F:	drivers/acpi/apei/erst.c
 F:	Documentation/admin-guide/ramoops.rst
 F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+F:	Documentation/devicetree/bindings/pstore-block/
 K:	\b(pstore|ramoops)
 
 PTP HARDWARE CLOCK SUPPORT
-- 
1.9.1

