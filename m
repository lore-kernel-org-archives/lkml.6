Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79545C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340F420854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340F420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dh-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeKESHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:07:14 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33045 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeKESHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:07:13 -0500
Received: from sun05.dh.corp ([188.193.90.127]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPA (Nemesis) id
 1MHX3R-1gFVxW0wPx-00DVeR; Mon, 05 Nov 2018 09:48:31 +0100
Received: from sun05.dh.corp ([188.193.90.127]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPA (Nemesis) id
 1MHX3R-1gFVxW0wPx-00DVeR; Mon, 05 Nov 2018 09:48:31 +0100
Received: from sun1049.dh.corp (unknown [10.64.9.49])
        by sun05.dh.corp (Postfix) with ESMTP id 18E5F1FC8F;
        Mon,  5 Nov 2018 09:48:30 +0100 (CET)
Received: from localhost (10.64.31.3) by sun1049.dh.corp (10.64.9.49) with
 Microsoft SMTP Server id 14.3.408.0; Mon, 5 Nov 2018 09:48:36 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.de>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <C.Emde@osadl.org>
Subject: [PATCH 2/2] Docs/EDID: Calculate CRC while building the code
Date:   Mon, 5 Nov 2018 09:48:35 +0100
Message-ID: <1541407715-5417-3-git-send-email-cniedermaier@dh-electronics.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de>
References: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.64.31.3]
X-Provags-ID: V03:K1:mFwzcpuctcdwSybWEjcPmOPRKhqqGg+HItzELNjJ9uXpW6Ep7zB
 aIuWrNEl22ijh9DIvH2Hf7pDTq1dUBCg0rLN0XirwpxbVd+dv6Wynp7tK94YRWQoL+ND08N
 1v+uqDEKxWman3It8oVoMENcc4XEliBRXLWC06RZUfskL+BLxs4QHhkxlu6zflqVD3H7KKp
 +PeC/CxQofTu313xBMnuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8aO/WK1Wgvs=:GYv9D/7l3L0HWPFOJh7CQv
 km2+H5d+nzNWXM80S5/2EwTd2DfsxQtCGVlwiFSed0hv1C6wTjr+7Nfw+xmK7nFDitsIVZlmu
 alfNBmXfFFHbY6dtS2uozxbgkN3CM8kNyST/exw8hc2AjJv6nqLUAKpoXAQYSmLq1qJzG/bKm
 Xj/0c1ydG+gKtugF7vDo/YtxaqmG3Ua2VncjjlO8MbGaqtML7RzVD5/NM2DuvsoUQ9IYRWILQ
 J4Kv2QjVApdHSqbu9CdUrUXhzCsdtI2tgy3DAdVr9CQA/94u/RguaaWH67XOtCZzzB3IJ6hXn
 EyLL2A/Ijw/OWV99ReQazg/zOltrG0KY6a/eWnSmMkux4qzDBwd0LzosylvDL3/3uf1xTFPgB
 Wy7jw6iXw5HDhD6BiNhYeMDYKtLio3bHsTTPoZ5BeusFAjACMeRWsswQl7QKwapSeBfqYhj2Y
 OEQuoYybLRM/Uv0ajKNSOwl/Gxr6UOXBSVr7LV1tp6XdWsl8VKowgEf5wCJl7pnkkUjTBJP7t
 2wE5s0QWX/EwGsbTggVRCXHOGrCHAuXnkSVQb4YZX64JdqCVBn1AeznQTE9BISm7HpCKM53D2
 5c87cJ8hf2NNGzkvyF3CsALigc+auT+Wjl1YWnz9WLyPvnuzK8Y3C64JfyEaCCq3MiaHZIJz+
 uGxbu+f/68ivjhWxp0mx051swN0VzGVIrYDd1RuU4vQ6JHkqnnXVBDlqc0lr/uHJJzji1C9+h
 DwvPHN1DhizgB5Qr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version made it necessary to first generate an
EDID data set without correct CRC and then to fix the CRC in
a second step. This patch adds the CRC calculation to the
makefile in such a way that a correct EDID data set is generated
in a single build step. Successfully tested with all existing
and a couple of new data sets.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.de>
Reviewed-by: Carsten Emde <C.Emde@osadl.org>
---
 Documentation/EDID/1024x768.S  |  1 -
 Documentation/EDID/1280x1024.S |  1 -
 Documentation/EDID/1600x1200.S |  1 -
 Documentation/EDID/1680x1050.S |  1 -
 Documentation/EDID/1920x1080.S |  1 -
 Documentation/EDID/800x600.S   |  1 -
 Documentation/EDID/HOWTO.txt   |  9 ---------
 Documentation/EDID/Makefile    | 15 +++++++++++++--
 8 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/Documentation/EDID/1024x768.S b/Documentation/EDID/1024x768.S
index ff4013e..4aed3f9 100644
--- a/Documentation/EDID/1024x768.S
+++ b/Documentation/EDID/1024x768.S
@@ -39,6 +39,5 @@
 #define ESTABLISHED_TIMING2_BITS 0x08 /* Bit 3 -> 1024x768 @60 Hz */
 #define HSYNC_POL 0
 #define VSYNC_POL 0
-#define CRC 0x55
 
 #include "edid.S"
diff --git a/Documentation/EDID/1280x1024.S b/Documentation/EDID/1280x1024.S
index ce0e85b..b26dd42 100644
--- a/Documentation/EDID/1280x1024.S
+++ b/Documentation/EDID/1280x1024.S
@@ -39,6 +39,5 @@
 /* No ESTABLISHED_TIMINGx_BITS */
 #define HSYNC_POL 1
 #define VSYNC_POL 1
-#define CRC 0xa0
 
 #include "edid.S"
diff --git a/Documentation/EDID/1600x1200.S b/Documentation/EDID/1600x1200.S
index 5eeb751..0d091b2 100644
--- a/Documentation/EDID/1600x1200.S
+++ b/Documentation/EDID/1600x1200.S
@@ -39,6 +39,5 @@
 /* No ESTABLISHED_TIMINGx_BITS */
 #define HSYNC_POL 1
 #define VSYNC_POL 1
-#define CRC 0x9d
 
 #include "edid.S"
diff --git a/Documentation/EDID/1680x1050.S b/Documentation/EDID/1680x1050.S
index ec67950..7dfed9a 100644
--- a/Documentation/EDID/1680x1050.S
+++ b/Documentation/EDID/1680x1050.S
@@ -39,6 +39,5 @@
 /* No ESTABLISHED_TIMINGx_BITS */
 #define HSYNC_POL 1
 #define VSYNC_POL 1
-#define CRC 0x26
 
 #include "edid.S"
diff --git a/Documentation/EDID/1920x1080.S b/Documentation/EDID/1920x1080.S
index e0657af..d6ffbba 100644
--- a/Documentation/EDID/1920x1080.S
+++ b/Documentation/EDID/1920x1080.S
@@ -39,6 +39,5 @@
 /* No ESTABLISHED_TIMINGx_BITS */
 #define HSYNC_POL 1
 #define VSYNC_POL 1
-#define CRC 0x05
 
 #include "edid.S"
diff --git a/Documentation/EDID/800x600.S b/Documentation/EDID/800x600.S
index b6853b2..a561658 100644
--- a/Documentation/EDID/800x600.S
+++ b/Documentation/EDID/800x600.S
@@ -36,6 +36,5 @@
 #define ESTABLISHED_TIMING1_BITS 0x01 /* Bit 0: 800x600 @ 60Hz */
 #define HSYNC_POL 1
 #define VSYNC_POL 1
-#define CRC 0xc2
 
 #include "edid.S"
diff --git a/Documentation/EDID/HOWTO.txt b/Documentation/EDID/HOWTO.txt
index 7d05a7d..539871c 100644
--- a/Documentation/EDID/HOWTO.txt
+++ b/Documentation/EDID/HOWTO.txt
@@ -47,12 +47,3 @@ EDID:
 #define YBLANK vtotal-vdisp
 #define YOFFSET vsyncstart-vdisp
 #define YPULSE vsyncend-vsyncstart
-
-The CRC value in the last line
-  #define CRC 0x55
-also is a bit tricky. After a first version of the binary data set is
-created, it must be checked with the "edid-decode" utility which will
-most probably complain about a wrong CRC. Fortunately, the utility also
-displays the correct CRC which must then be inserted into the source
-file. After the make procedure is repeated, the EDID data set is ready
-to be used.
diff --git a/Documentation/EDID/Makefile b/Documentation/EDID/Makefile
index 17763ca..85a927d 100644
--- a/Documentation/EDID/Makefile
+++ b/Documentation/EDID/Makefile
@@ -15,10 +15,21 @@ clean:
 %.o:	%.S
 	@cc -c $^
 
-%.bin:	%.o
+%.bin.nocrc:	%.o
 	@objcopy -Obinary $^ $@
 
-%.bin.ihex:	%.o
+%.crc:	%.bin.nocrc
+	@list=$$(for i in `seq 1 127`; do head -c$$i $^ | tail -c1 \
+		| hexdump -v -e '/1 "%02X+"'; done); \
+		echo "ibase=16;100-($${list%?})%100" | bc >$@
+
+%.p:	%.crc %.S
+	@cc -c -DCRC="$$(cat $*.crc)" -o $@ $*.S
+
+%.bin:	%.p
+	@objcopy -Obinary $^ $@
+
+%.bin.ihex:	%.p
 	@objcopy -Oihex $^ $@
 	@dos2unix $@ 2>/dev/null
 
-- 
2.1.4

