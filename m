Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeBFQRQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:17:16 -0500
Received: from mout.web.de ([212.227.15.14]:55237 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbeBFQRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:17:08 -0500
Subject: [PATCH 1/3] HID: lenovo: Delete an error message for a failed memory
 allocation in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Message-ID: <6534fccc-ce07-4802-409a-ac0234b712f8@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:16:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:zVuoCtcUtdn4uRU/yByCM/ljHu9t6eZRSe16tMsdr4E4aAq1CCv
 TQ4m4XmIlUFxO+Z2WpO8g3Sa5siA0Tdpg8p5Bei0deXQ3lMZcpe2QuET9pBoUQT5Q5BruI7
 ZvDMEFzhozVojgEg1QVoF3IBgNb16qo5ly1Y6o+KJ4w9vnfxmQmneDxuFFdinyKCQ0LSCKV
 h7MAtNVJbeQ5B1vdH+kWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UJzLkuM+reE=:J/8eue1Elg5XPQ8AFshB+e
 /p00JOgUikcgBBXDb63uQgM1nnKmRWIZvSFXDkLcRB8a8MHAME1RZj/YR+ZoyIaeGHxNvVfPz
 WjiOjZMVEc4DF6qcaXDKKvZ+UqhOLMHFWzRWhtS6peIfvu3zdu9LeRzFGTnRPKq6NGjy1MUIA
 mYf0NC0fSsS06XWmO9IM7hxQD32jymZflYLT+9e+KbfD+aPr3Yf1c9Jes6NicpkuRp7wmd5yF
 qP92EV/ZIB5w7Muzr/FHN1Jk14qLGD9LRan5C8/T58Mi/mkxgPFkWd/aKq3+wN6gsQJjkuUqh
 /zkPMhffm2/e6gh3ZwXZwbrDs6CvgY7ejd6zljBlXsRKRpzZr70XsbLXvMuGSJRD6VBDwlC7c
 p3GHRS0Njj3kGenOli8Z22rMpUn94WN9jgLxjE1f16p9XDPwYStywFldYjdfx0ECw5z/JycDj
 FJDPYSdKKKAmIuymvlxUT60PKh+RnTe3uptCrApacLqJjmFmY5SzBVyOTAlkP3Qr/B4Ujls9i
 dBeFX1cD10vbywCIahmi4jbaxGzz4KJVobLAJrI3ff8C+WNn6iqB4TbnRe0yGHafInLE8ph+J
 6zfgNTYI3RW0vjS6L7Uy/qlEo63gcFubPNDRMtoHIsWtnVFEmQrJfcW3gWatnxb6JsNKd+l2a
 8ZJ3huw/gNb//aD77wI2IEaxlb/rcOwEnKwpRPs5wQu4BMJM+SvuitzKauaJpPapbtR8dU9jP
 b/5EsED6r+0i4jt4PonhgfFzPq5Da9HmK/Km1So6v9M/jiXyuSQqHHK6y7OUM/1EpAEnWn+cs
 wpqrB726HtEUhawHkQwlrGTwtsexQVAmwErPbaYj8TTenHTNC8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 16:48:52 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-lenovo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 1ac4ff4d57a6..549b84d01b46 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -688,7 +688,6 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 				    sizeof(struct lenovo_drvdata_tpkbd),
 				    GFP_KERNEL);
 	if (data_pointer == NULL) {
-		hid_err(hdev, "Could not allocate memory for driver data\n");
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -746,10 +745,9 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
 	cptkbd_data = devm_kzalloc(&hdev->dev,
 					sizeof(*cptkbd_data),
 					GFP_KERNEL);
-	if (cptkbd_data == NULL) {
-		hid_err(hdev, "can't alloc keyboard descriptor\n");
+	if (!cptkbd_data)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, cptkbd_data);
 
 	/*
-- 
2.16.1
