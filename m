Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeBCITm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 03:19:42 -0500
Received: from mout.web.de ([217.72.192.78]:63488 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbeBCITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 03:19:32 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-saitek: Delete an error message for a failed memory
 allocation in saitek_probe()
Message-ID: <e04a936f-9925-3808-9274-6cffe3c63cc3@users.sourceforge.net>
Date: Sat, 3 Feb 2018 09:19:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WmQB9nTvWyJ0Jrr11nW3k2bRnnpANP5lB3yOee8Ceni+CXH4noO
 2Sil/IyYbokBgFK56T0udxlqyrm4th6sUNx+rC6HZHQHmOX76yQMIWLXEq/+DdcHJ6vtd91
 WJFI8m/ZWfk6wAongaGOOascyd7/ff8ZchEpnoZOoQ7BDVJPU5i83w/ZQgu98fkxFlGFzNi
 PJ1H633CYndRyFvooaw5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T6YnQz+jcgQ=:2OyvTbP0NFnihn2DOgQoHg
 JJ3L1whnr2Kuo+GSOU6PSr/WfC4XU64HVwyl2uAnsj5jhLpj0u8yIUiR+fzIJ5euM3TdtMnsY
 k/Y3icjdUzE/rsY1FilJYpIqawWS+bRYb7IHmuLrxdKSkQlJfPm5MShnDYrkICYh79vC8o0Rd
 VGm+pjOVJdOzOhOV3RgGKtFdzMEv4YRGzyUGrA9BjgmZDo+OUR6z0zkSpr7zPLzsFlq4SAxsb
 eHZV4awbbw+dlWWV8IpSoonMoMtxKr/dPDq8unM+V1lMmeHcHVNUH9O8NlZ5SI+BgUuZ3Kjhx
 BaC/FSoQd9QOwWX2RzliF3qTXwvxmBcAjOs50C7sS6EIWOfBvTJgSYs7pG8KxneEp2haSrTdu
 IY+Hg3rV46Cfo91LcMUdhIMWRzcKVFeLUC3ZzuC1NPDzH6qe9Jq3Rcn0WzvjIhucC6KjMLkpJ
 xOcMn3vEC/D4cWgJ6omCqjzE9HdQH76XboweBLLaDylywW8wCwIk64gI09C0ejrOs9iZkH2aO
 npzCilEq9zHd7uhhHi8lb1QB6kopNxuTh9fKHBWuB0wMgpw/CI3y3incVOZ0dGzmX9zCL0j4V
 ZEr4Os2PmIc18yfLYFyjiQfunphX72QHGPivZow1nz+4m0a0s97jNI4oVJjOela1Yljt++N3R
 PH3BPEIsFY6bNbEB5KWTj8QzR8CpfUSA8SJma18UG8HqQh+EbfFOmcvVoB6/Vlxs9FeWaO6qC
 AUHjmtmEQg1FFjXaRwjE6OHCONqvqicKwpGpc55CDxNsS0UhV9z8ylhv7XZZMOfbmsXeGzKNP
 mebeXg8+DtNlHJu3jy25/c0Wde0NsTIew2lerT7cHxD5g/Gcu0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 09:12:24 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-saitek.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index 39e642686ff0..49355ceddd85 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -45,10 +45,8 @@ static int saitek_probe(struct hid_device *hdev,
 	int ret;
 
 	ssc = devm_kzalloc(&hdev->dev, sizeof(*ssc), GFP_KERNEL);
-	if (ssc == NULL) {
-		hid_err(hdev, "can't alloc saitek descriptor\n");
+	if (!ssc)
 		return -ENOMEM;
-	}
 
 	ssc->quirks = quirks;
 	ssc->mode = -1;
-- 
2.16.1
