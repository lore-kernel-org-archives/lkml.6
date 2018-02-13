Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965578AbeBMSfC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:35:02 -0500
Received: from mout.web.de ([212.227.17.11]:58809 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965399AbeBMSfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:35:00 -0500
Subject: [PATCH 2/2] firewire: nosy: Adjust eight checks for null pointers
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c4e817a2-1554-2480-9469-9d06543b1eee@users.sourceforge.net>
Message-ID: <d6591d1e-c568-dfcd-d162-03b60ae528cb@users.sourceforge.net>
Date: Tue, 13 Feb 2018 19:34:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c4e817a2-1554-2480-9469-9d06543b1eee@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:8a1ohThRSdqHjPrnrtYTyWobNxENel9PYV32d6/aDJsFxJJcTzq
 5ZCCSMGyrg1JCLHwr/FZs814ecai0xNusFIrU9hKaYrb/ilT1coA2t9VsFZpCKEyDWU3SU/
 Ux0BYe5NmWsl4y1Oa2hsDCCyk5yACMWj+12gtWiGBwR745wEUKOvtqKMbLeS1U/8yTyZXnA
 37WYx93hYu10hXWNDbO5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JbeOOBUJc+Q=:1AAHmviIfUy4lKfwXporu1
 f6bpEGmCpeoouNtbG9jDZ2YejH27YHm4zpbkbZecq2+RhsWMrkkIE8aWtiJNxoLhb1QeAeLMU
 t4JVyCg1hSNQy7E6VVUI/ZhyTdMHiAN0QqUX77qX+lnaUMuP5ny/VwvTd2OoMlKZMRiAy+7VX
 LkQUuZX2N0DwCkPYa7pphu4pPg2oMiRF9t3PycLmr6jK+oQ05cExRt7+QaORFI4onv2fBQeM/
 DuNneoIGxNXD6/YYU53MSetv3SaLc+7l1cCULRojYJWJiaYWFeTX4BTYnTtAQEloD9xLiAujG
 CGK45EIyad9ciprH9dbNPvuTAsevuZVe5JMftiAR2cdl+iNR9KDH3px5QCMWk6et5Gm9q4hLs
 SGVHDwxSJE5YXUwtQpEjTBMp9gSpouQS4ILkHV3O/u4rr5ARXxw8Vyky+RnmQstnVpZKgZ9tn
 BL+X05aSctZdlANi6JkiOkTNa/I+z/U1cmM18pQ/5ekWOHb4QT/IM2jGTo16/lwgaLFLYdy84
 wf4kabCFTCr73w/MxecWVZN8MiZky/9RSPmb9RghnYDiAkpqfuQdWhR7HC9GVevMLDhavOidL
 dVk8eOE/+cbpeELEc9HKN9Kem7igH2dDwAsk6hkN0sb+8UdB3wed+csAGmctqt7kU55sjee/7
 drtiIVfMrhTMkGBmOnos9SgfaZv9cyYPIo7/giaiLsYhx7PxdjYPAaiOPscnciD+4Xa5Qs756
 XfNATzAoAsYf6szPANChjGx4/HYOcA40a6uHTSCcGCo9NCTTv/gQPp+Ar5VD5ggIarcN2R4OO
 nOCYlMBSBiE5N6jZnPgGRJ3TQSDr+Fdv1GnHxUwoo6hNA45pHw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 19:20:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/firewire/nosy.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index 6192f0718bf2..0eaf79c625c6 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -128,7 +128,7 @@ static int
 packet_buffer_init(struct packet_buffer *buffer, size_t capacity)
 {
 	buffer->data = kmalloc(capacity, GFP_KERNEL);
-	if (buffer->data == NULL)
+	if (!buffer->data)
 		return -ENOMEM;
 	buffer->head = (struct packet *) buffer->data;
 	buffer->tail = (struct packet *) buffer->data;
@@ -287,11 +287,11 @@ nosy_open(struct inode *inode, struct file *file)
 			break;
 		}
 	mutex_unlock(&card_mutex);
-	if (lynx == NULL)
+	if (!lynx)
 		return -ENODEV;
 
 	client = kmalloc(sizeof *client, GFP_KERNEL);
-	if (client == NULL)
+	if (!client)
 		goto fail;
 
 	client->tcode_mask = ~0;
@@ -552,7 +552,7 @@ add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 	pci_set_master(dev);
 
 	lynx = kzalloc(sizeof *lynx, GFP_KERNEL);
-	if (lynx == NULL) {
+	if (!lynx) {
 		ret = -ENOMEM;
 		goto fail_disable;
 	}
@@ -565,7 +565,7 @@ add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 
 	lynx->registers = ioremap_nocache(pci_resource_start(dev, 0),
 					  PCILYNX_MAX_REGISTER);
-	if (lynx->registers == NULL) {
+	if (!lynx->registers) {
 		dev_err(&dev->dev, "Failed to map registers\n");
 		ret = -ENOMEM;
 		goto fail_deallocate_lynx;
@@ -577,9 +577,7 @@ add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 				sizeof(struct pcl), &lynx->rcv_pcl_bus);
 	lynx->rcv_buffer = pci_alloc_consistent(lynx->pci_device,
 				RCV_BUFFER_SIZE, &lynx->rcv_buffer_bus);
-	if (lynx->rcv_start_pcl == NULL ||
-	    lynx->rcv_pcl == NULL ||
-	    lynx->rcv_buffer == NULL) {
+	if (!lynx->rcv_start_pcl || !lynx->rcv_pcl || !lynx->rcv_buffer) {
 		dev_err(&dev->dev, "Failed to allocate receive buffer\n");
 		ret = -ENOMEM;
 		goto fail_deallocate_buffers;
-- 
2.16.1
