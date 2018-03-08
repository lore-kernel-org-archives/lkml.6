Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935925AbeCHQjI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:39:08 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:42914 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934087AbeCHQjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:39:01 -0500
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
CC: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Organization: secunet Security Networks
Subject: [PATCH] Input: i8042: add Lenovo ThinkPad L460 to i8042 reset list
Message-ID: <3063cecf-a893-6c0e-06cd-dfe325c45e2f@secunet.com>
Date: Thu, 8 Mar 2018 17:35:14 +0100
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
X-G-Data-MailSecurity-for-Exchange-Guid: 13E148E2-311F-4AF8-8B92-B41B01F68A13
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset i8042 before probing because of insufficient
BIOS initialisation of the i8042 serial controller.
This makes synaptics touchpad detection possible.
Without resetting the synaptics touchpad is not detected
because there are always NACK messages from AUX port.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 6cbbdc6..7755134 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -627,6 +627,13 @@ static inline void i8042_write_command(int val)
 			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
 		},
 	},
+	{
+		/* Lenovo ThinkPad L460 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
+		},
+	},
 	{ }
 };
 
-- 
1.9.1
