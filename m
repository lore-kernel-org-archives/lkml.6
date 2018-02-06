Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeBFOq0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:46:26 -0500
Received: from mout.web.de ([212.227.15.4]:55976 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752010AbeBFOqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:46:19 -0500
Subject: [PATCH 2/3] hid-lg: Improve a size determination in lg_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5c76a767-b1cb-2486-f24d-0d5a220b8985@users.sourceforge.net>
Message-ID: <be5dc0ab-32e4-53a2-15a9-b8cee6e61939@users.sourceforge.net>
Date: Tue, 6 Feb 2018 15:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5c76a767-b1cb-2486-f24d-0d5a220b8985@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+Zkm88LPgkPvVH/sHoQsK1VNQfYd00gM/7t/KEftP3iMUbaktwA
 v7ZSd1Lioug1TGvmKJrGu3HfZ/x0YqZquF7wSyH6T95uP96k8T0gKTT8Xo6h5xqRwUfCtCF
 7VLW413AI1Rsy0aZ7dKXUPKQCrK15XvgdP2jLTZvcPafTAuZKf+GU8acVqczRYvoxdWqf1A
 DzrJuCPrsbAgIg/3VbJPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0OQUbtG2Pyk=:whGKlIbZW4fHfBlxfj3uKi
 PTvD6z+ZFTAD9GHt2+so4qYwtYsnoYj5oayg1kqsguM95sxw3BDIo4HH5M6+Kxkmovalfp8FC
 KeWIgiA0kjV0hd1AuKwPyrej+n9r9fpWb6JpDBB4rz3lp04YDm+ANbVv/9l6p7HOEk4b/Q8Ip
 Trgi/TonjVmt4fISsPRMh8SRc3xEJ6KvRl0clF8X3RhSdV930/Ib/bMBYHAnr1Rh9bjN3d9Gv
 NYlvRpKULJUYfn8kVxmx6xTSZeVcSCPLQWa2ASQnnTHydPQmoI3G/zqoP5H73oAhCtAv3DoIk
 gVbPW8BVkIsTH+ZqQ4SePu5lKcVxgcCET4PW8N1vGd+WXc2S+3nd36NLUx5qwkSbIfrtGT8FW
 AAKcSrWEgOsYAGJIZDiaga8YBA9h+6GeAJRHny2q7bs0qjRUtdyMNjt6csQUzxcrOftbOlAxg
 fZUmj5G1xUAyY6gMXrVdtAbSX49M9ISJW1my4Z8V1fUo40XLLfkUgF9H9l3IRR2MzyIP8WZMQ
 VilGje+tjlpyJM1ipRKZXUQNjNVGj67vgPzEZEVLxwA59MT1OvZY3/fVEaMpg0gLkHxmcp8ON
 X5L6TafQe04js9KLzzPQe1asROMjQCdKrrpmXWyyLaGZlaulNqkH1efHV4zYLldGfPZV9VvvV
 1rMfsbbCuscvLRauaLbsuoLLNEOAgLz3zsX9djexm+8hwk3sWQPumiwafAAU5XQrm+iQOzuaZ
 fSPhIO8yogzuTyHm69KF5V6GzPuIz8bBAWG92+1zot/KUISRHwqtnwNuqpw2w6SCwwyRO+MH6
 demPzCKF2alXFpEYK1nJ1UGrUH2xAwZdOQK5d4Pce+ROCKcCu8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 14:54:14 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-lg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index f4439dc64497..358b4c6f856d 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -727,7 +727,7 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -ENODEV;
 	}
 
-	drv_data = kzalloc(sizeof(struct lg_drv_data), GFP_KERNEL);
+	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data)
 		return -ENOMEM;
 
-- 
2.16.1
