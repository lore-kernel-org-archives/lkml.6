Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeBFRaR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:30:17 -0500
Received: from mout.web.de ([212.227.15.3]:50461 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752710AbeBFR3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:29:55 -0500
Subject: [PATCH 1/2] HID: asus: Delete an error message for a failed memory
 allocation in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5289ace9-8927-9803-4692-c7c621ab0a8d@users.sourceforge.net>
Message-ID: <668be04b-719e-31e7-05bf-7f5e6d6e0a83@users.sourceforge.net>
Date: Tue, 6 Feb 2018 18:29:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5289ace9-8927-9803-4692-c7c621ab0a8d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:gtd4YskO4zd3zfIWy1eyJF+/Q6FemO0lu5Wu+9RrzpLW5fnfFGP
 Upkuyc58V8D/zj+kgD83tSOJfk+M8o8B0l77J8R4FEZGesbQ1ryE6hGLMMpP8JthrqHoGWV
 EBtogdc1bF3YVWMZYVh8K6y/70/Vuyq8ncKFg4qLdDHQJ+Sswm/4yhpFWJdOeDYcTeBItQX
 rQ00wnGlI8vnb3bpQnybQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jQJHbCUYNXo=:F/LHeIAU+Gri+Xo7TiWs9W
 W7I0wDeyX5plqr4fcOAJS6rTH4eSaFss+6FBF0/N+YBJNOTALsEmBN6AjYFm5sY+AtkChz8Wz
 8xnaHaJlOpYwMyYP2YnoFRKjA15i/L7gq7BFrw6kAqXzr6tUy/Lya4rtM7uBW12fVjWQs/0Dc
 Q9bmLX03kQAGEKXwqVF1l0eYUD/pmyPECyDE902ynpYCUuIlj0xl7SNXmDqf43qagc37B0fMH
 GnjrfRLUmJJF8Xgq9Zl0XP/OG+5l2UjiKWA3W7zaSNyJKtTpseIe3P91NDpEpWo9PszZQjFZk
 sB+ArMukoJfQLVrWW8MYWoaJBi51TexVR10Mx6Fm4cms9AVpmSmk5yaz+RR7ZdJ84nv/OB9MF
 S9kmjqII9G8Xjv8a3JgwnpMqS+05YiDtxkWW7ulZWB1lecJ8lPH8SLtO35jZeWPP3Atkqcked
 SET8qw0QK9K39h/B4gjwaVxEqI/tma7Ch3YiRbq2H7QxGkX2P/eoa9fQWEoD6H+W8yP16S/QY
 0+GtaVlp3g1KlqDveN2sMVcCCeglhm/wY/Z70HA4u/4mJ8iVpcciTbKZlGmcGxfKhvydPUKoq
 7Kj2rXuuZErIkEaye+K7Pk7/oI36KXIlVFpxLqiNE9sy1o7lkN1Hj7biEjDRvGiZyiybOk1Tu
 geYRzGcXSIzyRfJGms08twD7SSaVqdf+yHnX01uLM9jlP1NkrYEPOctaWBpKvInKultppFCL0
 cRUsTGUHCwow/JE6uw0iN8jkqZWtCwHjipv1YXZflozENylAxbFmXw106M1ZVyso6mZFUG00N
 AL2r4OCjTDDted4jyx1rmktLQCpVWufYOC2vAttOgYqgF0/bKU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 18:03:19 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-asus.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 6d2894b7d8e7..9573e0b41922 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -566,7 +566,6 @@ static int asus_start_multitouch(struct hid_device *hdev)
 
 	if (!dmabuf) {
 		ret = -ENOMEM;
-		hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);
 		return ret;
 	}
 
@@ -599,10 +598,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct asus_drvdata *drvdata;
 
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (drvdata == NULL) {
-		hid_err(hdev, "Can't alloc Asus descriptor\n");
+	if (!drvdata)
 		return -ENOMEM;
-	}
 
 	hid_set_drvdata(hdev, drvdata);
 
-- 
2.16.1
