Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753086AbeBFTfP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:35:15 -0500
Received: from mout.web.de ([212.227.15.3]:55013 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752871AbeBFTfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:35:13 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] HID: apple: Delete an error message for a failed memory
 allocation in apple_probe()
Message-ID: <83d48f20-dd03-00fc-bfea-cd4a87b7254c@users.sourceforge.net>
Date: Tue, 6 Feb 2018 20:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:PKLF/mLMbrGIzysumkACsdbSDGQL4jivvxY9EpTyq+Ioh45w3T4
 yNtZ6qzGpDf1Cpcg4+wO+n2nkkeol1EiOPsNN7mtp6KfB9ZsJ4fDESxfgntQY8b0B9/80UC
 inXibJf4e9TTxXkG7yW9GYIllEASBD9m0MRWsxDGcYVm6QbE85k+cNrn4jjliN3WNaBv/vF
 BmvJ9HsWbfrfeYXrvJSqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T2m60o57pe4=:yQG/iwwV6HHLiAV41NZHf9
 ilBRJZrd8pZFf0naCNjs6Xhfm30Hik27xz5aG/NJ3ARH0NO8WNuOcnjRUsfdNvXBrjFNwdOO0
 k75ipFZV8WSM7y+QyXcM3koNpzFVfGqAzWC6+3+CVoIrIjMB9Vf9bCa/X4mMcxNW5/a+1Ozdt
 QQRhNxlUTXTjd+yfs0GExoqDFOSYBWcJLd0WrHJbjmEgYaL27aH0zfPGlWtYDKsjSYDY0xPUG
 bqTDsrapV5ywMhO0viztueiLwuYlhpdH6LwYz2WZYlDrSsntO9Kf6Re/Q7HCnMLrqrSFqXHuG
 QKwlRZxvRXNx2ifBY6rYlkjT5UX7WFsmEZjkDkqwM2/F32VQViJWrKOYk0cSpiMVPpZuvqB/Z
 b0LpbvRULX+aTzPOUeoVdre32EeS9Fl/YtxMMWqF4YttSL+iVPAB7cn3Hd5ngDtQFqOE8TZzj
 +vJ0dNOVCDx9bFok2bxU6BCh1oqyAQZ4AMeiD8n6ZBwfbFeaXz1LEnOxVaKmOCdMZpJgXc/xG
 GJKKrzua4ev7x6v52Eow0vUAzG/VWkNVWciDyZvygOPK0kLwGgbxpkCvasvgKore6F7wtuXRD
 PQbtnadJEgQq6oWsXXsAUEV8VVgkuq1ZNRQww1Dxq8fYgMwII+YldgePrrCRpTn0oWnd3amF9
 YHaShpQ+8LNxRsWVin/PwgmB7nfCvI8gKJNKGw1gOB9Ed9bBEXWE/e21F+bm4uIcFBvW9/XFN
 GNnwzYg/6gV9rjsmn2QxhqgrWvqh1m12L61r5DjGbgUiPGUx20ckNHIpTzqbweojomYUwl+xI
 GwbXf22b8A3STTT5Iid1uHL+JdIsuTDmJP7VJUKols/TxIvPbQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 20:06:53 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-apple.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 25b7bd56ae11..d739dd3aa622 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -374,10 +374,8 @@ static int apple_probe(struct hid_device *hdev,
 	int ret;
 
 	asc = devm_kzalloc(&hdev->dev, sizeof(*asc), GFP_KERNEL);
-	if (asc == NULL) {
-		hid_err(hdev, "can't alloc apple descriptor\n");
+	if (!asc)
 		return -ENOMEM;
-	}
 
 	asc->quirks = quirks;
 
-- 
2.16.1
