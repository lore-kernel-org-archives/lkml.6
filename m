Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EDCC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BBB20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BBB20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeKCAWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:22:24 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKCAWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:22:24 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mgvj1-1fc7o01if7-00hKi9; Fri, 02 Nov 2018 16:14:45 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mgvj1-1fc7o01if7-00hKi9; Fri, 02 Nov 2018 16:14:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Mustafa Kuscu <mustafakuscu@gmail.com>,
        Daniel Drake <drake@endlessm.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: asus: fix build warning wiht CONFIG_ASUS_WMI disabled
Date:   Fri,  2 Nov 2018 16:14:32 +0100
Message-Id: <20181102151443.758229-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:j95rsxkGv3TlKksXbH+UOcInQSsWSTiVPTyZX23/q7gBCHouhmd
 cF7Um1sxYxynMGddz0zQly9jgCzio5VDSuYfv263SoJklFAr7sj0eiZJy08OzIkfUR0HK/u
 TjtTDvWjPf4KVcxrcocMg2wA4OSMbhdEaKaWiXn1kxiBnAsJmXkOUG7H7C7+XNYSkVsorPy
 VBRj6rfMCQYSqh9oVxubA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qjWYcfgqvn8=:1+/wXhZM8OAUBulgihJ5Ur
 8UcWpbSZGXEbXbUJ2sQTATM96Kd7XCzTkBK23Oxo/twhCK295PCoikBhtb6qbPFpeSIXL57Yl
 VxYr/nC62ne4in0SdpfgBC/FO7lyfxXl5+/NwzO1l/rX5X1BBtVGsXGxsD2oneHi/JgNxwPZ1
 NeehLYOifrnRBSYA8+0AcX/7ODxvmxB29xOS6gdQ17eJ6uc7L/BVKnjMPbFtG2Ynx32+gzhsE
 +uLKuJibOFHwB0J10vDefN6XMqJUOIlM3nSI5iuxNOuehx/yGE5OmrBrRbXaTWw5Ht8IGWmLV
 QRfHeFtuIGb6X55If9yCGkByg+umNnLfXwbJNCmdAoMi501sAfpqQvDW/DV0RPMBEHXf86j9U
 ZJ9SaQPrBklEG7Ix2KpH4tpPuqxNRpVSO7IT0v20eeiOay6sdjufBEnGMJWvLpvbV1uaxXSsL
 ZSgUuEp+eQ4mN3J+S7lp5WfN0KxtVluwhq452tB5pLfSHZruZJqc3xy+mxw/Um6tBy8Thkll5
 o59MTRAdwLHVH/T6uSKGG49hgW2/goNn+PMkeZTi2jsSYpgNqF+BgrRaS95ow//fadQZyKwG2
 HRsqVLVHeLfJPoICwHcqfvnPnytTYGHAxrUqdxs+qwidvviO7k/QpcAkaNeWzUgcY/+KxH0YQ
 tXIXn5jcxy6pKILI7c8LuqXmHi0kfSHPAq5W5n4Vx3Q9HeY+XuEcCblsV6WFGhoPlSOGqK6uQ
 N7x3Wc/JiJylfLEQ8HlcggV3gXz4huiPK6xfKdXbvs44cuI8zele/WvcFkkBDXfqwjZHIBLOp
 TECxQ/b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asus_wmi_evaluate_method() is an empty dummy function when CONFIG_ASUS_WMI
is disabled, or not reachable from a built-in device driver. This leads to
a theoretical evaluation of an uninitialized variable that the compiler
complains about, failing to check that the hardcoded return value makes
this an unreachable code path:

In file included from include/linux/printk.h:336,
                 from include/linux/kernel.h:14,
                 from include/linux/list.h:9,
                 from include/linux/dmi.h:5,
                 from drivers/hid/hid-asus.c:29:
drivers/hid/hid-asus.c: In function 'asus_input_configured':
include/linux/dynamic_debug.h:135:3: error: 'value' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   __dynamic_dev_dbg(&descriptor, dev, fmt, \
   ^~~~~~~~~~~~~~~~~
drivers/hid/hid-asus.c:359:6: note: 'value' was declared here
  u32 value;
      ^~~~~

With an extra IS_ENABLED() check, the warning goes away.

Fixes: 3b692c55e58d ("HID: asus: only support backlight when it's not driven by WMI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/hid-asus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index dc6d6477e961..a1fa2fc8c9b5 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -359,6 +359,9 @@ static bool asus_kbd_wmi_led_control_present(struct hid_device *hdev)
 	u32 value;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_ASUS_WMI))
+		return false;
+
 	ret = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS2,
 				       ASUS_WMI_DEVID_KBD_BACKLIGHT, 0, &value);
 	hid_dbg(hdev, "WMI backlight check: rc %d value %x", ret, value);
-- 
2.18.0

