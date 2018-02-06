Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeBFQTX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:19:23 -0500
Received: from mout.web.de ([212.227.15.3]:33241 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752555AbeBFQTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:19:15 -0500
Subject: [PATCH 3/3] HID: lenovo: Adjust four checks for null pointers
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Message-ID: <1dc4fe03-be3b-7175-05aa-2f5397f57cb5@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:N0GOSdZGwPJIXtevB/VC64AATcXEdNHlFS5dHyp+0RD34HIZxbd
 ZR/E6qsGPKrgg1aqPAnbTlsVC4Lc2FCZLni8Mq7JFHRGyI94MnjGMtRCKTkfoUN1FCUzaOO
 /JhQCmHvALwSv/cAgW7ak9cQCxkQiAHuJIn4kr9r9F94kwzGnfMWRuf+ev3MJm1cya2ULqS
 IpFJpiylKeYO2inxymsDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZkBBWLOy/wk=:xfeaFbHD8TXLTaANTOtvo1
 FCnGF3ZaSyDM0htWGl8i2AHSc3xjsR0AdaG1Biu9RaiZYkedYDuZ2BMyxsilzivuaoQ/Xb8v9
 2gp4VHP3gbY5de436wvHkMyaKQXGcCiwFXwObQpx/DkPZQLdyvexhG8UI+LR5UdjdeRy2hC4K
 LHzTDyFmCSyftBy+7U/L2hrSYGD4b73kdHPZOZx+n6nsA6i3gLyBdzGYY38jU/B/h+F4sMJ8O
 dq6mwLLDmAUrQnfeAaZRlJFEzNiQ2x2bqG7BqEDpLMw5D6fVJpWSoewjBW3Pdnsa/gvAYS/9L
 yAvBoBLWk85+SHzGvnqYH/QCWOKtZyIUyzmKiYmUZkC1/Bs4uXVeWep4phIW0j64tWxdYxsn2
 clhs06uARQhFgq+nLGp/OFULUjjTLYQZCdrZIdruxOIRw9O2CsHxjTYwjF9rlzVNvkxbn9JEz
 p4TlOTu03vzE3+pZpDMV+G3BooIEYXlLZ1aNVMhR5psBs4mF5VrLkCjk7dMA8FA4hCPoh2avT
 hJZ2IlLjCqhYwEOCFMc4ulZhXUnQPsKPaWRqKxS+8+zhav9AjNi22cmynDmKQsQgBx8xcYwF/
 ZbVqZ0KAhaeUSXtlF+rPGqIt1QuUEm7bdjzoJHTNOHJnypiLalrGO6/3QJT9uIgAoBS7Ub36p
 5x2nyzJKFsvOPFdBz7JOsrIuR2e6pFwgOOAgxz4Ea3dtNKHerCzJruN3crXLgeClSMK+Gwpg+
 OmJZWmQKLDMsYLcO0yrCZ0IDQkHBn0AKxqmuZMmJz5oBeMSNDOnFtMhteEWbB8Af1ndeJgW0L
 CA4IEIOyRYabOkJykD3byH3HHs1X121P7Ww8mcMMs/npcPt3Ss=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:02:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-lenovo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index f863b94f3476..ba128123466b 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -687,7 +687,7 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	data_pointer = devm_kzalloc(&hdev->dev,
 				    sizeof(*data_pointer),
 				    GFP_KERNEL);
-	if (data_pointer == NULL) {
+	if (!data_pointer) {
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -698,7 +698,7 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 
 	name_mute = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
 	name_micmute = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
-	if (name_mute == NULL || name_micmute == NULL) {
+	if (!name_mute || !name_micmute) {
 		hid_err(hdev, "Could not allocate memory for led data\n");
 		ret = -ENOMEM;
 		goto err;
@@ -823,7 +823,7 @@ static void lenovo_remove_tpkbd(struct hid_device *hdev)
 	 * Only the trackpoint half of the keyboard has drvdata and stuff that
 	 * needs unregistering.
 	 */
-	if (data_pointer == NULL)
+	if (!data_pointer)
 		return;
 
 	sysfs_remove_group(&hdev->dev.kobj,
-- 
2.16.1
