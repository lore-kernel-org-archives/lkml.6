Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeBBVMc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:12:32 -0500
Received: from mout.web.de ([212.227.15.4]:61339 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbeBBVMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:12:25 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-sony: Delete an error message for a failed memory
 allocation in two functions
Message-ID: <75be18ab-f4b2-89b9-6283-ec80b45f6384@users.sourceforge.net>
Date: Fri, 2 Feb 2018 22:12:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:qpfseVpRKHkx0AvxRNsVH3Tp6VoPotYpv1eKhYZFWEkWKxD9Sf1
 AdJxu/TLTGgV/fP4ohE3SVWelOcxTjCDHTxEehdL5YCCL3HSSq+RMqQ6j7OtiNOJgiqfXb6
 JoNYrkg9hHzqAoBdjgKCQcXQgIgQMoXaryKa4qExHeLm25xugdHkXi7xedvtLqE0aW2qJ+w
 n5sUBTzzxtyzMDrf9135w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oe4kKE3ZWgQ=:1l9zWMo1uzu3B5VjxZztBL
 iRw836Q20P/QO9+rXIqEheHRJ7JwnPZyTyVPJ8qEq8OlH8vXG+oFcbmvSuoG1Z4MIJW+gN0YQ
 0d8/FihGB90RBqD8ZlkmZDDwjG5M4JOEjb5nNfM0thDU1hfNY4kjW/C9d++soqAddp7j1ZdfZ
 mF8JRKUu87VH2MnMB42uFlYLXAOP8RANthtyGI8dvfEm5pkH/ck2tPUfXcsprRzrvATjuPUy9
 sKrZl1tOnYBJrcAKNhCHMU4k+7PsMFrJTYasu2VU568NWF16C1byA5guBZP9v6MFrZViRoEss
 ua+dHIuT2UnBrBWwwsl7Lmd5wMmxVxIUMyENOkKRUZViu8YzFqc3ZjOkkt5EAY6q3w4CA9V3Q
 n3AOAdd9NnpFSjQvkJh0VPf/5MeP37/TgQmF+ajtNUX4cgJl6tfjTO8PnLxveEvNtO8VlCVLf
 JdG+J9zzfQtSe/E8KBQyB2tGsFp8PAWkzIsGWIlMo+CTki/eM5LeEFPmWpm4apQr8Sus3m0tT
 M0M9UqLC5z9Ns09WJRzcdQGSCTc8Wp6fvyabD/4vFBDxCOzDTBzV9rqGvPV3jJoGA8igaCtlf
 e5UJzUGysTWkHllaHxcBIqW41kdDa7hfI4tWBTrC0xK0sKTBzhBNJod08ezttHF1eb2ztaC14
 zaPQffSyDpZ/ilad04RFQj09+XxHpRuq/OBX1lSgjIu8obFOdQGPgTXCMBbYepsKxVStVvpAn
 blLCfnLP6RPwXZ5uFZov8WUQgyM6OtnABGKOVFYH8I67ar9j09u4uWWnZ9G+3yOxq2aKbWtnu
 GRWjUrEleeO8GiGuvHmy9QTZjYvgn8M+HLF1+0qMSeRyZR0ffs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 22:08:31 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-sony.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b9dc3ac4d4aa..dc22f40c2ea2 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1930,7 +1930,6 @@ static int sony_leds_init(struct sony_sc *sc)
 
 		led = kzalloc(sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
 		if (!led) {
-			hid_err(hdev, "Couldn't allocate memory for LED %d\n", n);
 			ret = -ENOMEM;
 			goto error_leds;
 		}
@@ -2722,10 +2721,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		quirks |= FUTUREMAX_DANCE_MAT;
 
 	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
-	if (sc == NULL) {
-		hid_err(hdev, "can't alloc sony descriptor\n");
+	if (!sc)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&sc->lock);
 
-- 
2.16.1
