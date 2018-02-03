Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeBCVUc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 16:20:32 -0500
Received: from mout.web.de ([212.227.17.12]:53391 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbeBCVUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 16:20:24 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] HID: magicmouse: Delete an error message for a failed memory
 allocation in magicmouse_probe()
Message-ID: <79c01fa9-647c-5c34-41cc-3bc9c09f38ee@users.sourceforge.net>
Date: Sat, 3 Feb 2018 22:20:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:s7yU8BNNUdGmgrsluPiOw/y5NXmEr5IKfh1BJlSIte16WAManMx
 sC0LFeiEyhRpAZI4xMnGPFeAO0zH7JyjX4aT/jiC7/h0uFt64n+HokOI/sYbK1IPL2CKnOz
 TYEMWhbodoDlhZ/dQMQwlQi4L//pRJkqHHwCVjL9cJPV9e6runkpfvU1KxueLI6NwooFoee
 vwc4yk5bxQZ60SULCo3Kg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ldjAtSBVzs0=:wsYHt9zav2dfFzZD1j59bn
 AxxA6XoRlEB7N+EOrb6cTW/YCcWzC4biFlyA/2dupsa0h0FBPEo3E1NR/Y4KY2Nxl6VwY96ZG
 ZKhnUmCP85pA1WdtCJ2SB56ks8AA2bzITp1G63900iDwcM1azA+wlsnYoQMKwvM8AemkM0cQE
 4AqJL5azJsDkOvnvkw6SmnEn2Xoy5avMuDxiRirFkKzFU1icatAgKkKgszZBLEICz+cTbrgu8
 FFn9+Z+NzCtWbvb6x4m7zcbjkAoGS4ASMpzoPTIdl91YwwgtqUJgp+6I0wXmIk6p3GOmyZx8C
 FQ11CIS6G/AnpWdpPW9PpUaxZSD9YM3C4A9HOHR3ltNWnv/eNcX7iBhNHCA4e5reNoewsH6OL
 RvjtetbF7P1UV2r6bg48tU+tazG6u6xxJSTyffL/NlKTWPzymFNVFf41dFYU3zv1FTOmjoH0P
 YVGAF2mbS44FVFDbMfg5b3VkO8kweJt/oR9htdAF8XJL90TUyIvMmgl1/C3Q9Q1MDKYXo+mTC
 LGOi93kSq6l1ebTPzF+eoAwik0zsoetPPeI+ALTHFBhOfDH/86sDSxJKG/82V1U8kI0oP9bZA
 86h360iPJgjAJ/wkzSc9mnC9aUnzLH4SWoRM5esqLVcKCthdxCsEP5GczPDLZkBlKLEzpmn0W
 YeyFgK7KwGoP+h5iPhjDwosykB2ohgQcqkgQnku1fpnwZw6ebx800B8mbIJVaUSoo1O06QKXz
 CX9hlyWSdKysgGHtS9FaSC7yIQzzC+THL5hzZTJbX/do/x2/x+1C7bQERZYfyguqc/RTOAIV3
 yf4YQY78QQYJmNftVav552cPFCKDEwuFxwcbfe8BtmdVccNxRY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 22:15:05 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-magicmouse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 42ed887ba0be..8d17a812c5ba 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -501,10 +501,8 @@ static int magicmouse_probe(struct hid_device *hdev,
 	int ret;
 
 	msc = devm_kzalloc(&hdev->dev, sizeof(*msc), GFP_KERNEL);
-	if (msc == NULL) {
-		hid_err(hdev, "can't alloc magicmouse descriptor\n");
+	if (!msc)
 		return -ENOMEM;
-	}
 
 	msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
 
-- 
2.16.1
