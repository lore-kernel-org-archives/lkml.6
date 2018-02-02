Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeBBUK3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:10:29 -0500
Received: from mout.web.de ([212.227.15.4]:55536 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752545AbeBBUKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:10:20 -0500
Subject: [PATCH 1/2] HSI: ssi_protocol: Delete an error message for a failed
 memory allocation in ssi_protocol_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>, Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <14dd4865-f983-ba7d-3068-f6450a8de7ea@users.sourceforge.net>
Message-ID: <77f958da-a645-69c9-8641-d37a073c0d53@users.sourceforge.net>
Date: Fri, 2 Feb 2018 21:09:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <14dd4865-f983-ba7d-3068-f6450a8de7ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:locSoLtG/JAzAtuaTywB2kG/ThWCfzZzD2XonheDm+oqxDhSBoH
 GA6fE2TSrCdEsq/5I1/IxjTk1jP9PyN/GI461kY8xwtW3kbsvHzZksJ7Ad7YJ8v+toQ6if5
 mvg89pPkGsKXmXjOEXUYymJy/gDnNs3YsTgU7YOYciB49EQWIniDVX1/fr4JhuOaZUHkqbl
 Z2dWLjfu6/LCt14/PSDrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7b1p9E8Rapk=:AOr/Zlu1NX/dmM2rqUB5Ua
 XvjZ9kpULHmpOCsTCx0JXbb4LWXinJU7PIAWRTOeJE5nR2HipnkV1f845OpPTZAeiN+I/bi2U
 HoodPJnMAdS8o43IlM67vCTUFu+sX/v6TFl9Y4rSWzcC8BwtMDbSBoVyvFl07pcIh5HPTwYG+
 I8N5zhHsmPzZrTOg183IyIt1DKzOEThgzgs8y4653twdFnRXWnE0S9Q7240+wNbsekliZyi1J
 5eGeWUxGYVptXNqFkCzMNCWu113uIRA0OlZb31Mk5WMg5B1pifnruqak4ZE7cPitnhSzsGobr
 MaghCVRULQgs4m5ewuHSt2z4WYK6u9t6QjwAlx9vHPhlEjKA9pRrciPA3EXxFaafaN4uA+n2S
 cAZfdQD+YcGTG9oJe5rDOvl8TTmQjio888s20E8TywivtSynSZEhEk6PEkvjPPT41TkMWMOJj
 +hZ0DnvNQcRo8TWKhxHLU1ypiRqB5lkz8qfXmiwml8R89dsn7eIjO8bbDlYXqKj7Q3dLyCDJf
 xl6UsmbDouSAZ4ImHavR4klkZynk7+COaptznEbpW57Qz37SvDb/whR1Ca5ae0OnqpVCC75e0
 fhYrjvO5Z6Z56+NuHUSfSo2dWGs5r5jSgmr3FtF0IuRP96T+jsu8MWjx0okQX58gIi2jQTDpa
 KcwTuK35pjeia9LnxtLfHdxaj4Hd0GMK2uR2XYjC5juuTbob+uYO8BSoshG5v+2+E05VLSoUn
 ON7TjT8hho2a9uWapa4kYyfFnLPnQby/PM/bC2nqeRGCODsb702g7NUCIQMvs+Dtd7z/Bwvpr
 Z5V2M0v8bpnwh73K9Obb7q+2cLpFpJKWCJtDjherifwXqi9IwI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 20:02:17 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hsi/clients/ssi_protocol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 9b167bc6eee4..0bccea2fa119 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -1088,10 +1088,8 @@ static int ssi_protocol_probe(struct device *dev)
 	int err;
 
 	ssi = kzalloc(sizeof(*ssi), GFP_KERNEL);
-	if (!ssi) {
-		dev_err(dev, "No memory for ssi protocol\n");
+	if (!ssi)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&ssi->lock);
 	timer_setup(&ssi->rx_wd, ssip_rx_wd, TIMER_DEFERRABLE);
-- 
2.16.1
