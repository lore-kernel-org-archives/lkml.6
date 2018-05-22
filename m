Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeEVH1m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:27:42 -0400
Received: from mout.perfora.net ([74.208.4.197]:41527 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEVH1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:27:11 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 5/9] staging: rtl8723bs: Fix camel-case in IS_FW_HEADER_EXIST_8723B().
Date: Tue, 22 May 2018 00:26:33 -0700
Message-Id: <20180522072637.9782-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522072637.9782-1-quytelda@tamalin.org>
References: <20180522072637.9782-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:LlYDSaXVxMxsJg8h4uo0YOvt3Wc8eSok4ezFUSI4jgzfJaiHQr9
 U/JeqUIJU6QL9jaFDXANl2SowkmAwm4JMdtE/OIzlz9JtHvQ6aawqEPjM4wUGKgj8bkRuLy
 scy0rw5ydPk307ETvUUg2GvSwVa4jLvWA/OB8A6OMoexXIeLqWHF0CZQsquqV2byK3w4qyv
 PNCngGoUoKWb0Cr7kZLUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mnl1HVjOW6g=:+0Q3jPxh7pGA20xAIWh9+T
 1qQ6VG20ZX3FjTKr629z4J8etrF5l2ca8eVLnBQMTNwW9Pr+1pHEKZLcKW12P3kkAj3g++p9k
 Ut+2FOyQ8k+NAAcszJ1/uA2dHWfMpM6mfwBjh/1NDCtP8CwXH2TDK/e6/5LQIQPChfAX+tGIB
 tm5llaFOOlKVXIJppNR+8/QLjqUgDePN0TlT4+pgOjUIjavIAEYDt+LohsPI3pSXBuHS5Aowt
 FXja5nPZIJ1RvNg3r+4wIoEvr0QUmMZ5j9gctpuWn/0k889o/2X1OrJH8Jd22CxL6+JxCtUA2
 s21sL07ubbmeaAxpxd7AFVFlH6iftt4/wclGcWOxlPsKmQwyIdxlxKiXYvhxVHmxlBvcJlJMT
 of1G5iJvULGun4DvXo8bjPLyf+YPDJVKrk6q+AIbR+iVXjOMP20tNrpBxqBpaf9XIZcvuCF4b
 VsnA4sCBHmflV1PMvQeeaVrHR2jXMztYnJBUZiP+Vq5cGhC9EKgACg5nh7zWgkm+dbiSCtEct
 jQUhUmD5cZEcQSD5+XViCsxvDQI22wwOBhUlYQEL7xotIMnf0N8tl4foe8aL7TWmN6NEwFuS+
 JUwHUkxP3wpI4TNChqrY9Y3c105OI6fHrfjlBCFJ1bZXDFk1F2FmsOXUi5wiXVXyCfDDhxgRt
 Kl/DE4FGtoucmqmsBpEOQn9B2dZTInl+zqwGeIMA7M1hxEdOxcbGoPSbiZN8Psj6yOvE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the parameter of the macro to the snake case 'fw_hdr' instead
of '_pFwHdr'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index 8ce4f7a9edc3..b4b54e3e6a43 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -43,8 +43,8 @@
 #define FW_8723B_START_ADDRESS 0x1000
 #define FW_8723B_END_ADDRESS   0x1FFF /* 0x5FFF */
 
-#define IS_FW_HEADER_EXIST_8723B(_pFwHdr) \
-	((le16_to_cpu(_pFwHdr->Signature) & 0xFFF0) == 0x5300)
+#define IS_FW_HEADER_EXIST_8723B(fw_hdr) \
+	((le16_to_cpu(fw_hdr->Signature) & 0xFFF0) == 0x5300)
 
 struct rt_firmware {
 	u32 ulFwLength;
-- 
2.17.0
