Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCWO17 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:27:59 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:38596 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbeCWO16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:27:58 -0400
From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Organization: secunet Security Networks
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>, "Takashi Iwai" <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>, Nir Perry <nirperry@gmail.com>
CC: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Input: ALPS - add support for 73 03 28 devices (Thinkpad
 L570)
Message-ID: <7d5077ef-c185-c6b1-d602-df8d9f7dade3@secunet.com>
Date: Fri, 23 Mar 2018 15:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: F84B8090-7B76-4B12-8598-E85C79D1A61C
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Thinkpad L570 uses V8 protocol.
Add 0x73 0x03 0x28 devices to use V8 protovol which makes
trackstick and mouse buttons work with Lenovo Thinkpad L570.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
---
 drivers/input/mouse/alps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index dbe57da..5523d4e 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -136,6 +136,8 @@
 	{ { 0x73, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
 	{ { 0x73, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },			/* Ahtec Laptop */
 	{ { 0x73, 0x02, 0x50 }, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS } },		/* Dell Vostro 1400 */
+	{ { 0x73, 0x03, 0x28 }, { ALPS_PROTO_V8, 0x18, 0x18,
+		ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE | ALPS_BUTTONPAD } },		/* Lenovo L570 */
 };
 
 static const struct alps_protocol_info alps_v3_protocol_data = {
-- 
1.9.1
