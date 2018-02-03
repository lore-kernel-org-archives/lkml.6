Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeBCMso (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 07:48:44 -0500
Received: from mout.web.de ([217.72.192.78]:65050 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbeBCMsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 07:48:37 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Andrew Duggan <aduggan@synaptics.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-rmi: Delete an error message for a failed memory
 allocation in rmi_probe()
Message-ID: <07a48fd9-de27-52d5-7a53-8eb1de4de14b@users.sourceforge.net>
Date: Sat, 3 Feb 2018 13:48:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:riojrtSRkhbfUwbYAAM0RDxtP6odME/TFWTi/fwZG6o6oeZHKkS
 7SIsWyy6LBpB2/hMV7L1KMkxdogN8JWa0yQStNfZoHT4/vlIJrALLkQJkljE4HUhl7LnilL
 etfW80vREUWobseoQFfpFDOTj8J8w2JkoodjA0QH7IHVd+96RbXWzeGpE4Gv6iA6FjLgCZh
 efhCC20wuyFWvGoGUjTQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Chpdvh2ky0=:B5sUtYYM6AFUiJQzbgxrIh
 L6izmtPG1xxrjPiyRjS5iOcTR7+l+MgdQaOE2YS4M/pQMVFoniUYJ9DULUejfpTxHAb4l0ZGM
 ndIGeUk66DWaAYC6SH5ZrzhWZ7VSKNtGeshsPayPn9dVGyaBmzWXC6GiBebhGwY3sFpGN//68
 AhmJF0gQWI62hTBpMCfV+7FGccTVxojq/BJLYqwF1RqsJFn8TjRii5aVNRs1sw3o1Ofn5kuQ4
 gSx6xkO9cvP8JogpJMkWxSAY63b4kv1u43rqIHowHS+UG02ylQioqtw97H+ZR8yzKvmTycyS3
 GbCeiDRg13SwnJKiXyfEsO7MrLabPabC8UUC+NcWtrCM9HwNlXTo9piyQx8KHNiQoZ76ZDUOd
 6FgxTuIiqTPitmkeSuKfuIIdBOMf+at+pX0mmRIX8RAcCjAyqQ0UnG+ke70tLRhI7LVpbtiAj
 FVaPez58/ZiB7e7dYOL5U+BfGVEQqX7EGbuVwhNbcvNsRyzljiREyWpY9RKcVZZV3Mk36f5w8
 sIjhupqF9Tke6gvFHvGknH7/MhdZ/iNIEPxLUz3uMjUn9k78+zgB4JLjH3KswmQPVEFuh9Wmz
 nR3/OaqvKEIQYuW/iQADxJB7mNRkSGnzEurS84ftk1/pF0Roqb+16tjHdQjFUoNqnJYnR/CnY
 qUzNXim4XriBNb5uQCqrD++vvxcndgHUaSpUPAqAZqPshKGepxUsNVJFxCZXDsH0Ih6h615mS
 VstT/EByAFyt8ENMwRSXSFlb9ZwH2Z6HQzF+7BukjauNPCYZRCJnTPJfCLkR2gPBtjkyew43P
 8byq+nyr347Fix0t/na1e80JSh8P7SE9aqCTU9F47H7Fd7xBJs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 13:42:08 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-rmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 0f43c4292685..d92a17954b67 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -678,10 +678,8 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	alloc_size = data->output_report_size + data->input_report_size;
 
 	data->writeReport = devm_kzalloc(&hdev->dev, alloc_size, GFP_KERNEL);
-	if (!data->writeReport) {
-		hid_err(hdev, "failed to allocate buffer for HID reports\n");
+	if (!data->writeReport)
 		return -ENOMEM;
-	}
 
 	data->readReport = data->writeReport + data->output_report_size;
 
-- 
2.16.1
