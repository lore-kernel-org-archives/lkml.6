Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93BAC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD7F20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD7F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJaDGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:06:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeJaDGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:06:24 -0400
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0Lodqd-1fcPyU2d8V-00goTL; Tue, 30 Oct 2018 19:11:29 +0100
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0Lodqd-1fcPyU2d8V-00goTL; Tue, 30 Oct 2018 19:11:29 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] firmware: raspberrypi: Define timeout for transactions
Date:   Tue, 30 Oct 2018 19:08:41 +0100
Message-Id: <1540922921-3653-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:lSwBe9PbnboS7iat0lA9w6drv5kU3kjgJMIIrGKwzeCgcslTRqh
 +/7u+OZ4UwTmEvz/g63mI20Wb1fVW5n2uBCpC7sU9at2AQmjjHJtp2+kAoADyQgZOiUVHyP
 rTL0VfMsLz6Ar2UNRBIvoparyzxCtfHaU7k6broKQBef72BX7/u05jL0bTKKIGN/tu5FkDE
 5rqEpidLOWU/wUvaEYw/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6/mm5e1KIiA=:/vkzelrwI6HZ+dfGeYUpA8
 ZTBrzuFzv3jNgGmjOJjLfuUy2JH6TTKqm6yUQJfeIvn1jLnri44wYPyB5W2KyXdCyaAsoUQVI
 c0OWFOKEkyVjh+LLZaDVJ4ahq61qgrD8MJW8vBfJFgLUQu+olmy5a89Qed4YjqEnNCQTu1TNC
 D+AMKEqfVte1TV1uZDxXVAnfX+mJPQMsWTQDHZSB3yOWXTZKFonfPu4kaorhNQzGFdQYmdaW8
 UeBv17UljGklCLLS1w1kRyQ8kjz1KhVGUNZZKsnEGR1O9qQTZu/wdLgmI4v9uTE1F4KeuT1gh
 3fBoCNSkvtopjXXf2QsuVpnY4y1sw5LyfI8JMiAKU0M28Un1VubwHXzNbpM1JBFOeTIh1k/cR
 E7Z9ye63BAUj+cp/+9CYWMjxDPY6aS5gNWEKYtwOeHco+ioIXy0EyFHhd9Iew6jn/Wa7LtSzf
 UckfyWvCVVewGTs+b1wcClHMYBoYbpxSfWc27NefrPUN2OF66UQ2XfZ3sS4abX+zxgPxrCMiO
 qhcJBgLnKWsECGYjvWusJESTkGxfSU6wx/yULMZ5fcOWmoCP7oiLOz/w3eQ0kmnk29Y5UW9GQ
 CaPEQE/sDeAtQ3HIqGixeG/gaTJP8TGOWF0tI3kr2jZCbIjCz7hn7Tqne3QA+0DeYubCefPzq
 maDfBSu45ZPU78w3KRe6YohmCjnCKHQRc53OQFWnh3YVn2P/Y1fAq2UN2717dcitXWD4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should never assume to get a reply from the firmware otherwise
the call could block forever and the user don't get informed. So
define a timeout of 1 sec and print a stacktrace once in the unlikely
case the timeout expired.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/firmware/raspberrypi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index a200a21..bf45ac4 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -56,8 +56,12 @@ rpi_firmware_transaction(struct rpi_firmware *fw, u32 chan, u32 data)
 	reinit_completion(&fw->c);
 	ret = mbox_send_message(fw->chan, &message);
 	if (ret >= 0) {
-		wait_for_completion(&fw->c);
-		ret = 0;
+		if (wait_for_completion_timeout(&fw->c, HZ)) {
+			ret = 0;
+		} else {
+			ret = -ETIMEDOUT;
+			WARN_ONCE(1, "Firmware transaction timeout");
+		}
 	} else {
 		dev_err(fw->cl.dev, "mbox_send_message returned %d\n", ret);
 	}
-- 
2.7.4

