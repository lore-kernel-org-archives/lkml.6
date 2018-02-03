Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753689AbeBCU6U (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 15:58:20 -0500
Received: from mout.web.de ([217.72.192.78]:53920 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752802AbeBCU6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 15:58:13 -0500
Subject: [PATCH 1/2] HID: ntrig: Delete an error message for a failed memory
 allocation in ntrig_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <86d02ef2-0ac2-5462-0ff0-a0cd87c3d1f7@users.sourceforge.net>
Message-ID: <a89d945d-6bfa-ed1a-3bf5-cd9efddba6c9@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:58:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <86d02ef2-0ac2-5462-0ff0-a0cd87c3d1f7@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Pc3GYWruxN9yusHtPkfd0inWGdgtYbNVVU0p6f6z5aVnBhsnqQC
 voNdApr02YTgFcPQXWdUa2H+epmewMzf7VNLdBRsE6KzoeZ0kDj1P7xehFXPQPwM5SGZx0P
 oxumxKYgF7EW7T22IpfcklpLOJJsCxQKTwJEchN969Wf7/Bkyb+a5UUUj5MYKddFzqu2GyV
 bQbZI1ZXheHcWcq1dVMMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tiqXX9wbGlM=:vMGZWdpC9V0icdlLDFjg9t
 is703e+7zrANuwdB0+Nb4ewjWHPQxBFwHWvjVoYXaCMF+GhBthAGXrEzfQVm15idJysbIJz20
 A6NyCeIDLOSVcLQ/xJLeoPnZ8OKR1Rt63rPFbUCsYSL8yJqVs2ksuKkkFF1J6afb9YGkHI1qV
 42y0G6W0EIn62djZJmDZUZnI9r/MMftkaOoa6LTWK3jZW3tga1WtSwro/rvj/BTuDwegA7CGd
 UsgQh6RA9nkjXUIsGIOjPMnxYUPyKHN8ZL/zGpOIh9Qd157wlkWYpwu5yBpEPDwTO/kebB/78
 FFmUGjJQggMz6AzJN+gofxRzMsflbpNxF/wLjVyYUA5uRe6AdyOTh/7ePhwDdchjej7jR8J4S
 oNb5EFWy5S9qxxahebkF+UPJH5hKuz/uSlD0G8ybqd33oLV9BSXEN8R5IhwsdKzz4nCelxf5i
 0roYNNkMQDfFsAM1LJyebQ/I/AAi7p8A6fnFVBoKf80mcR1msJYtO7InLCLUUcEuHtmrfiaY8
 cVIPCeUmmXWps3K8Tgfz6RSOJZfV64zhQrU6v6f61ghXbdeuRPpAM5DJE5AJ2UkBEjCrGAmdO
 i0VD9gpZtGASYHFGSG9eFxrfTWG3RDOpFQr5+OAM7/Nhc7WDQhIfda94BPY/5nuoTqfICWzWF
 +YNYzxscJbnP4gpQ1pXL0dMO5mSJYzfoylamnXsv9u8PQmmJc8qLrDuqaM+oTP/9X/9rdllPk
 AqQYo+/YPx++DtbLstVqOEMa8NHp3CTsbxCjENrrmH2dde/6B/n339ZxLpv8TphJnqP7DtsW4
 UnfQ1LyOORPPMbeUCB8Y6TuE0AYaUetUhjHg2muvkYVODolRH0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:46:20 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-ntrig.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 3d121d8ee980..2a8dafaea2f0 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -905,10 +905,8 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				| HID_QUIRK_NO_INIT_REPORTS;
 
 	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
-	if (!nd) {
-		hid_err(hdev, "cannot allocate N-Trig data\n");
+	if (!nd)
 		return -ENOMEM;
-	}
 
 	nd->reading_mt = 0;
 	nd->min_width = 0;
-- 
2.16.1
