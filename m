Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeBCRiF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:38:05 -0500
Received: from mout.web.de ([212.227.17.11]:51091 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbeBCRh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:37:58 -0500
Subject: [PATCH 1/6] hid-prodikeys: Delete two error messages for a failed
 memory allocation in pk_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Message-ID: <b0d723a5-73f9-e937-b93b-79174d4d0ede@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:37:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:jYPWiTxD1lLDzN09jdossElu3S/m8yLs0C7Dq2Xm7i59Ym2WGCE
 cM2/qUnsNkjwKGdUcAxowGn/32Y6PiWAQoWKzdPvGJcWaXmrFnbGwRjurpzmVRqnjCIFAUq
 1mjgLNRIPa6nf9obNW6m2I7CMbmRLEmsisgnEL9AEklEmqYmLkRxFO+NmiPQZbAOG3dHvIb
 DqfB2A/nL0ww9fkWePRuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:80yxfNSA/zE=:nGXuHHS5L3uNwJR0mowjrt
 uUxz7DVlJntdzEHQ+CAakWiIgXS9NinBzjSX32d1YqI88+BWui9aII1Z4Sh2PxxZORZqnpBAx
 1Htz6+d2fjfWfp6U3DoSitxFAA3nr8QFuUReRgl0LEComL6HCIzu5Nt872q4OS+wJPCSt4zs+
 wSgNpKbr7Fjia1rDcbZIcaBgvCwQHYKwPPk+TBB/B/kitrrATqPT3xNgBvZxu0S4ftnqpQcgI
 eW4wgB/ZXNqtRWsTBIDcM5z08BS9o07Tk13HTLBEtE42hcXUNSCDm9sUVpmTXHMM8sVIeHDtr
 4QI7LGL8nLZjzjTxpDuIQPdsHUPFfi7ChPFgvh3D0wc4BUUQzk9beNrzr9D8YIKURTemVaAtm
 9s1ni7OULSunBGHKCfNIKAgMA/QTQwPTLQRwwhvQ08hpdlKbGVpWUX/nBDuT7J1y8kMAERUt3
 dkmIKhx3QCA7iLAviYzu8L+Zr5kDOj03LKC+XWbIbMj5Tp8K7LeQ3Fe3dUuk7nbowzAMQY74X
 LrLY0UB8CqQ/mFf/zZw8K79IG/811G+RNHVjvYpSTqE2jbxQQfrl3f8KKdbi1AWs7mWiY/2XV
 pFQObEP+DpyrFRONITUJVXxAIKRJ505Pi+RyMtTgv++EZK8EnzeS/Kipv24Au66OcvwBG8gp4
 dJKMkR/o2NMIVWX2hhkMibA6mnQ/SUVIp4qf7gzz+KGtUmWWLhZGsgP3Nu1TQe2RiVforRIaF
 sYmLy/vOcPnUse6SeMYMHyRQDMW+ka1/1L+xbQFkC5JWVHyGfUvOkacSK+TQ2qy74rTQX2Mmd
 5cpIagqs1bdOUXkOXUnOvPO4epEsIBPFI+Rm6BAonfCxpOGb+w=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 14:36:20 +0100

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 87eda34ea2f8..9cad4973a67b 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -802,15 +802,12 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	pk = kzalloc(sizeof(*pk), GFP_KERNEL);
-	if (pk == NULL) {
-		hid_err(hdev, "can't alloc descriptor\n");
+	if (!pk)
 		return -ENOMEM;
-	}
 
 	pk->hdev = hdev;
 
 	pm = kzalloc(sizeof(*pm), GFP_KERNEL);
 	if (pm == NULL) {
-		hid_err(hdev, "can't alloc descriptor\n");
 		ret = -ENOMEM;
 		goto err_free_pk;
 	}
-- 
2.16.1
