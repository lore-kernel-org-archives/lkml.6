Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCLNdN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:33:13 -0400
Received: from mout.web.de ([212.227.15.3]:58085 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbeCLNdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:33:11 -0400
Subject: [PATCH 2/2] crypto: talitos: Delete an error message for a failed
 memory allocation in talitos_edesc_alloc()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <ad256dc9-a064-37f9-fb8e-aea22ba40a2b@users.sourceforge.net>
Message-ID: <13bfdc03-1dee-2f1c-da8d-1e452f10c850@users.sourceforge.net>
Date: Mon, 12 Mar 2018 14:32:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ad256dc9-a064-37f9-fb8e-aea22ba40a2b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:yTX6GjMwDCqBcfVqXEbVb8OHo09bJKBHeSSFSRpIUVA6KEGkt0S
 5TlAxecvx+1mSOtsxHazq11XR9HNNM4fS8C+A8wxmDXVVxagTU2qEFZqwNqYpPgjJ4fT1Z7
 7WuYQg6E3RmNQkyJIjqCpIRF+DbC/Ys7TCHG8ncOcvdUlQPVkt4ksd0AQllMgk6tVc+1z19
 pAkmcd8rNqetmKp0FlO2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0XbXKteoV0o=:2lxslNx7yYOQ7NR7M5u+or
 U5KkZXSlbgqxBHnEN1ZQzXg3mmgc0ibdDqNTLUw5yN5N0+mvE96JQ0OChsNifc3aKQOJvr9Ru
 llhPPuq/4lkzu3FCDtKeN8WCK1b/0z1gXEFC2tluOROOKHSEPbZDDPZ88vj4CQ1Il3+12Ybds
 BPjM8AsaSMbMppVSm6sp5eJHcww/vHs+9VpbQ+UIXPMO/fGVeLs3z8sMcBXhj3vex9uvAELw9
 vzxTVKV5ucZx9Z7hjLpCJNrb5fG7jbx3vPM3O3U7aWSrLYArPHw2ZoAuB11evNsg/h69XtOta
 lxyPvmqZ0X/h5RIyw4+IQazPEC9qw0ISu/+Td6BeLJ9/geGsGp32huFwRhTUFY3QjPturl+8u
 Fq6RCdFTDm6gUVLPsKREh/slWE8Xv5SiOQ2KdUwbGVIpc5W+FYWuAL3OUzLjfTxMszVojnSlR
 A0KmWi/OWWPAgsA4IjIvLzJpw7mjvYxE7i04Qx7n8DOwlG5KY8gpKUGZNc4uVqVK7T1tCFCcF
 TPzsKhpegGzHiONDaff52n1Cpr8n3meWey8voh5IyXBdAi93CGZSxccT1JktSHAQpO27+1F+n
 NRYjoYhnIfjO6dCh7kL1slGC/XVoWac9lyKI7m07AohIQr1jpO/iBmLdyghMNFje40Ts7ihJB
 i0xR0yHsoz+a7kPwheHg7PG6XbyKxHc84sh3XBXG6rqFB7GXm79heRnXmZWZAXHR2zB6TWpbj
 VBe9vnJxAq4Xjikd7hoy+Z9JRmeAZ/LmRXBum+BQgjHKWGTLz/V4hsj8MjyrALs3CwAS90euJ
 faYcxDH6hjemdJRHw7BOhX2JfSjgmeq+uaVsI0DlV2R2KaJUQI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 14:18:23 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/talitos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index a2271322db34..4c7318981d28 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1399,7 +1399,6 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 
 	edesc = kmalloc(alloc_len, GFP_DMA | flags);
 	if (!edesc) {
-		dev_err(dev, "could not allocate edescriptor\n");
 		err = ERR_PTR(-ENOMEM);
 		goto error_sg;
 	}
-- 
2.16.2
