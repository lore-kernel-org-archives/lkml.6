Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1550584-1519349621-2-5210597287871500280
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519349620; b=oS2NhfKlLTp0ZKBWNDd/uIQvK1XHBjr6bKUtD5rGlioSJVp
    qr96Ly3lO1pkc9k7zNt+G2Ehv+DWLaEMXHiNTnsKp1gXscXqJ+oOnzUZEoH768Ld
    cCN6v3LpJnMNsV2Cj673Q8Zq688dWoIu64Pe2uMLUen27nxDjE7AnGrw3SBe1gK6
    qcLsYD2AWdbqwWaQMZ2lj3ze2h3132qaluFy4DbN5uMGak77t3DshoZFZrk/ZA/b
    gNandiRjqimf6aGFyHoHUukV5n2Iki6IJeeRRGpWbfiuAWo74C+knRrergfuq40Z
    xHhJtflUIZmpuD8HRLEQSgLxIJbA362ATB+UdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519349620; bh=z
    C3hUGMPUat5/gQtoHwBkosujdJsmpAi9cqx/wB+ICM=; b=ZsJkfAWvrtUxw0ipt
    aZQ+xeGOZisLrKOprKy4Q6XdGghxBOQS2XKNMptZYiupqu2mj1e8VFf27eEU30xB
    ZzWRI9bvpnVkzJR06Qh2Eda/bsVES0JYbK1twrbjZ0vvbhD93lVprfqwtJAqyqEa
    FuHjwIOdcAeLIjEUbtz3nsc4jJEtIkuWCE+7Xm0Bi8FwgeyhyHqgEf/MmgMQs+ID
    QNFysg+pk+JKmtye59/j1mB/ry940v0rOXzfIhRV5lh3DZWpRzTkrwABSSxXxCMk
    4jUrpRychN7DQQgyVOI58nCbicYt0nZ+5fTeXsBBoVwFQFrG/sjOdtY7qX+aYm5c
    SctIA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
 dan.carpenter@oracle.com
Subject: [PATCH 3/4] Staging: gdm724x: Simplify the struct gdm_endian to a
 variable.
Date: Thu, 22 Feb 2018 17:33:00 -0800
Message-Id: <20180223013301.17646-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223013301.17646-1-quytelda@tamalin.org>
References: <CAFLvi22mENRoFd3Z6=a5tAcbiOGw3CCnvJy_7N4u783_k3jH5g@mail.gmail.com>
 <20180223013301.17646-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:7+fAuLLrexQz0bAH/s4NDvUENRkPJ32cbk7TtF9l6X0wtooI5wO
 MW0R87SKzgjItNpfLXSN4m9BGu3sxlZJrcMdVZiC33RtUvODGoIcxdFtxxpzF2nEBPt9afb
 zty3PMkZ/BvLm+/qcIBa364uE9DMTVcBXSSlTCGVv8H46yFYDBIQrSmiIiwDVMyiLT8WK+f
 WOdKQZwnINPQmRxf3/4kg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iynRwlAqFyk=:cTlDoNUowyotvCNeGgeD7g
 v3rL35pi9Lg92SrTnYajmpxstoSX2hxYxcetNuHvjUQ/w7t7t219qPv2c14eumtT7H/R6CJ+K
 D/uLwFywPbi+eFEaPj4DzFu7AM/TouqNlntOgIMmIXgABGlXxlKU80ONeNtt2s4/2n3Nw8jBb
 mmgqKXNQzYswOkGGZ/LGA56SdmonBe4pc3fkeYjkmDdt44SwthODYR7h4S0Sp/vooi0acfswU
 0HAQFZvNtpkSqEVtkTnhzBEzKWSc/Mcfhw7PF1+/0jy1PHLQ0+ddCRcc1FXQwf9d8+eO5HBTn
 cjv4HYQdRRRJ7Dqtnd+JFnY9SQu/N81Zdr+/Or1j9ct+yBg7sUH8Kye6L0ITwb6vQIbiHbky6
 XDVIEL/0DFpnwysj9bKmCByaCl5OREXq8DL+GwXUGNcuRQ5zIhZfgTEXYDQbTOAZlR3+POO5M
 0ftGNXnImN0d/SaFEnz5F+B7clpqrNIBK5lfKUANEXeb0se0B9knoXCcCACLcR8LkJbvMUV5z
 N74co7bOQnb5/5lJfLTxBgyklz6zMmUFNeKNs2Rsd2v7qd6Xw5RuhDl9vESDk3dE0oL0pJy8b
 6VoBF08JJhChW5L0kr9+slZjzLip9FVaidfQNZdxU2pHay/fbxUIWCtGse2gf4dP4kDbU0lM/
 eaEPqluUM0Boj/XrGvY3MPCcNXbPV6cBBUzXbcf0YVOqiVWpym+I9vJsMli3lg56depVnCl7I
 NdHIQlOptOzQnDfoRVCrBdaadXSP8BqZVTmfTA==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Quytelda Kahja <quytelda@tamalin.org>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since the testing for host endianness and in-driver conversion were
removed in 77e8a50149a2, the gdm_endian struct contains only one member,
and can therefore be simplified to a single u8 variable.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_endian.c | 24 ++++++++----------------
 drivers/staging/gdm724x/gdm_endian.h | 13 ++++---------
 drivers/staging/gdm724x/gdm_lte.c    |  7 +++----
 drivers/staging/gdm724x/gdm_lte.h    |  2 +-
 drivers/staging/gdm724x/gdm_usb.c    | 30 +++++++++++++++---------------
 drivers/staging/gdm724x/gdm_usb.h    |  2 +-
 6 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_endian.c b/drivers/staging/gdm724x/gdm_endian.c
index d0b43e20ec06..4200391b1a97 100644
--- a/drivers/staging/gdm724x/gdm_endian.c
+++ b/drivers/staging/gdm724x/gdm_endian.c
@@ -14,41 +14,33 @@
 #include <linux/kernel.h>
 #include "gdm_endian.h"
 
-void gdm_set_endian(struct gdm_endian *ed, u8 dev_endian)
+__dev16 gdm_cpu_to_dev16(u8 dev_ed, u16 x)
 {
-	if (dev_endian == ENDIANNESS_BIG)
-		ed->dev_ed = ENDIANNESS_BIG;
-	else
-		ed->dev_ed = ENDIANNESS_LITTLE;
-}
-
-__dev16 gdm_cpu_to_dev16(struct gdm_endian *ed, u16 x)
-{
-	if (ed->dev_ed == ENDIANNESS_LITTLE)
+	if (dev_ed == ENDIANNESS_LITTLE)
 		return (__force __dev16)cpu_to_le16(x);
 	else
 		return (__force __dev16)cpu_to_be16(x);
 }
 
-u16 gdm_dev16_to_cpu(struct gdm_endian *ed, __dev16 x)
+u16 gdm_dev16_to_cpu(u8 dev_ed, __dev16 x)
 {
-	if (ed->dev_ed == ENDIANNESS_LITTLE)
+	if (dev_ed == ENDIANNESS_LITTLE)
 		return le16_to_cpu((__force __le16)x);
 	else
 		return be16_to_cpu((__force __be16)x);
 }
 
-__dev32 gdm_cpu_to_dev32(struct gdm_endian *ed, u32 x)
+__dev32 gdm_cpu_to_dev32(u8 dev_ed, u32 x)
 {
-	if (ed->dev_ed == ENDIANNESS_LITTLE)
+	if (dev_ed == ENDIANNESS_LITTLE)
 		return (__force __dev32)cpu_to_le32(x);
 	else
 		return (__force __dev32)cpu_to_be32(x);
 }
 
-u32 gdm_dev32_to_cpu(struct gdm_endian *ed, __dev32 x)
+u32 gdm_dev32_to_cpu(u8 dev_ed, __dev32 x)
 {
-	if (ed->dev_ed == ENDIANNESS_LITTLE)
+	if (dev_ed == ENDIANNESS_LITTLE)
 		return le32_to_cpu((__force __le32)x);
 	else
 		return be32_to_cpu((__force __be32)x);
diff --git a/drivers/staging/gdm724x/gdm_endian.h b/drivers/staging/gdm724x/gdm_endian.h
index a785f30bb369..e58d29f868ba 100644
--- a/drivers/staging/gdm724x/gdm_endian.h
+++ b/drivers/staging/gdm724x/gdm_endian.h
@@ -32,14 +32,9 @@ enum {
 	ENDIANNESS_MAX
 };
 
-struct gdm_endian {
-	u8 dev_ed;
-};
-
-void gdm_set_endian(struct gdm_endian *ed, u8 dev_endian);
-__dev16 gdm_cpu_to_dev16(struct gdm_endian *ed, u16 x);
-u16 gdm_dev16_to_cpu(struct gdm_endian *ed, __dev16 x);
-__dev32 gdm_cpu_to_dev32(struct gdm_endian *ed, u32 x);
-u32 gdm_dev32_to_cpu(struct gdm_endian *ed, __dev32 x);
+__dev16 gdm_cpu_to_dev16(u8 dev_ed, u16 x);
+u16 gdm_dev16_to_cpu(u8 dev_ed, __dev16 x);
+__dev32 gdm_cpu_to_dev32(u8 dev_ed, u32 x);
+u32 gdm_dev32_to_cpu(u8 dev_ed, __dev32 x);
 
 #endif /*__GDM_ENDIAN_H__*/
diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 8d492d6d6a12..92cb9d115fe3 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -685,7 +685,7 @@ static void gdm_lte_multi_sdu_pkt(struct phy_dev *phy_dev, char *buf, int len)
 	struct net_device *dev;
 	struct multi_sdu *multi_sdu = (struct multi_sdu *)buf;
 	struct sdu *sdu = NULL;
-	struct gdm_endian *endian = phy_dev->get_endian(phy_dev->priv_dev);
+	u8 endian = phy_dev->get_endian(phy_dev->priv_dev);
 	u8 *data = (u8 *)multi_sdu->data;
 	u16 i = 0;
 	u16 num_packet;
@@ -730,10 +730,9 @@ static void gdm_lte_pdn_table(struct net_device *dev, char *buf, int len)
 {
 	struct nic *nic = netdev_priv(dev);
 	struct hci_pdn_table_ind *pdn_table = (struct hci_pdn_table_ind *)buf;
+	u8 ed;
 
 	if (pdn_table->activate) {
-		struct gdm_endian *ed;
-
 		nic->pdn_table.activate = pdn_table->activate;
 
 		ed = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
@@ -752,9 +751,9 @@ static int gdm_lte_receive_pkt(struct phy_dev *phy_dev, char *buf, int len)
 {
 	struct hci_packet *hci = (struct hci_packet *)buf;
 	struct hci_pdn_table_ind *pdn_table = (struct hci_pdn_table_ind *)buf;
-	struct gdm_endian *endian = phy_dev->get_endian(phy_dev->priv_dev);
 	struct sdu *sdu;
 	struct net_device *dev;
+	u8 endian = phy_dev->get_endian(phy_dev->priv_dev);
 	int ret = 0;
 	u16 cmd_evt;
 	u32 nic_type;
diff --git a/drivers/staging/gdm724x/gdm_lte.h b/drivers/staging/gdm724x/gdm_lte.h
index 3ecaff1a40cb..bad0855e4721 100644
--- a/drivers/staging/gdm724x/gdm_lte.h
+++ b/drivers/staging/gdm724x/gdm_lte.h
@@ -56,7 +56,7 @@ struct phy_dev {
 			    int (*cb)(void *cb_data, void *data, int len,
 				      int context),
 			    void *cb_data, int context);
-	struct gdm_endian * (*get_endian)(void *priv_dev);
+	u8 (*get_endian)(void *priv_dev);
 };
 
 struct nic {
diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index 87cd1f827455..c95bad4a8615 100644
--- a/drivers/staging/gdm724x/gdm_usb.c
+++ b/drivers/staging/gdm724x/gdm_usb.c
@@ -72,8 +72,8 @@ static int request_mac_address(struct lte_udev *udev)
 	int actual;
 	int ret = -1;
 
-	hci->cmd_evt = gdm_cpu_to_dev16(&udev->gdm_ed, LTE_GET_INFORMATION);
-	hci->len = gdm_cpu_to_dev16(&udev->gdm_ed, 1);
+	hci->cmd_evt = gdm_cpu_to_dev16(udev->gdm_ed, LTE_GET_INFORMATION);
+	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
 	hci->data[0] = MAC_ADDRESS;
 
 	ret = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, 2), buf, 5,
@@ -410,7 +410,7 @@ static void do_rx(struct work_struct *work)
 		phy_dev = r->cb_data;
 		udev = phy_dev->priv_dev;
 		hci = (struct hci_packet *)r->buf;
-		cmd_evt = gdm_dev16_to_cpu(&udev->gdm_ed, hci->cmd_evt);
+		cmd_evt = gdm_dev16_to_cpu(udev->gdm_ed, hci->cmd_evt);
 
 		switch (cmd_evt) {
 		case LTE_GET_INFORMATION_RESULT:
@@ -604,7 +604,7 @@ static u32 packet_aggregation(struct lte_udev *udev, u8 *send_buf)
 	u16 num_packet = 0;
 	unsigned long flags;
 
-	multi_sdu->cmd_evt = gdm_cpu_to_dev16(&udev->gdm_ed, LTE_TX_MULTI_SDU);
+	multi_sdu->cmd_evt = gdm_cpu_to_dev16(udev->gdm_ed, LTE_TX_MULTI_SDU);
 
 	while (num_packet < MAX_PACKET_IN_MULTI_SDU) {
 		spin_lock_irqsave(&tx->lock, flags);
@@ -635,8 +635,8 @@ static u32 packet_aggregation(struct lte_udev *udev, u8 *send_buf)
 		spin_unlock_irqrestore(&tx->lock, flags);
 	}
 
-	multi_sdu->len = gdm_cpu_to_dev16(&udev->gdm_ed, send_len);
-	multi_sdu->num_packet = gdm_cpu_to_dev16(&udev->gdm_ed, num_packet);
+	multi_sdu->len = gdm_cpu_to_dev16(udev->gdm_ed, send_len);
+	multi_sdu->num_packet = gdm_cpu_to_dev16(udev->gdm_ed, num_packet);
 
 	return send_len + offsetof(struct multi_sdu, data);
 }
@@ -735,7 +735,7 @@ static int gdm_usb_sdu_send(void *priv_dev, void *data, int len,
 	}
 
 	sdu = (struct sdu *)t_sdu->buf;
-	sdu->cmd_evt = gdm_cpu_to_dev16(&udev->gdm_ed, LTE_TX_SDU);
+	sdu->cmd_evt = gdm_cpu_to_dev16(udev->gdm_ed, LTE_TX_SDU);
 	if (nic_type == NIC_TYPE_ARP) {
 		send_len = len + SDU_PARAM_LEN;
 		memcpy(sdu->data, data, len);
@@ -745,10 +745,10 @@ static int gdm_usb_sdu_send(void *priv_dev, void *data, int len,
 		memcpy(sdu->data, data + ETH_HLEN, len - ETH_HLEN);
 	}
 
-	sdu->len = gdm_cpu_to_dev16(&udev->gdm_ed, send_len);
-	sdu->dft_eps_ID = gdm_cpu_to_dev32(&udev->gdm_ed, dft_eps_ID);
-	sdu->bearer_ID = gdm_cpu_to_dev32(&udev->gdm_ed, eps_ID);
-	sdu->nic_type = gdm_cpu_to_dev32(&udev->gdm_ed, nic_type);
+	sdu->len = gdm_cpu_to_dev16(udev->gdm_ed, send_len);
+	sdu->dft_eps_ID = gdm_cpu_to_dev32(udev->gdm_ed, dft_eps_ID);
+	sdu->bearer_ID = gdm_cpu_to_dev32(udev->gdm_ed, eps_ID);
+	sdu->nic_type = gdm_cpu_to_dev32(udev->gdm_ed, nic_type);
 
 	t_sdu->len = send_len + HCI_HEADER_SIZE;
 	t_sdu->callback = cb;
@@ -799,11 +799,11 @@ static int gdm_usb_hci_send(void *priv_dev, void *data, int len,
 	return 0;
 }
 
-static struct gdm_endian *gdm_usb_get_endian(void *priv_dev)
+static u8 gdm_usb_get_endian(void *priv_dev)
 {
 	struct lte_udev *udev = priv_dev;
 
-	return &udev->gdm_ed;
+	return udev->gdm_ed;
 }
 
 static int gdm_usb_probe(struct usb_interface *intf,
@@ -859,9 +859,9 @@ static int gdm_usb_probe(struct usb_interface *intf,
 	 * defaults to little endian
 	 */
 	if (idProduct == PID_GDM7243)
-		gdm_set_endian(&udev->gdm_ed, ENDIANNESS_BIG);
+		udev->gdm_ed = ENDIANNESS_BIG;
 	else
-		gdm_set_endian(&udev->gdm_ed, ENDIANNESS_LITTLE);
+		udev->gdm_ed = ENDIANNESS_LITTLE;
 
 	ret = request_mac_address(udev);
 	if (ret < 0) {
diff --git a/drivers/staging/gdm724x/gdm_usb.h b/drivers/staging/gdm724x/gdm_usb.h
index ffb3d995097d..701038685e23 100644
--- a/drivers/staging/gdm724x/gdm_usb.h
+++ b/drivers/staging/gdm724x/gdm_usb.h
@@ -93,11 +93,11 @@ struct rx_cxt {
 
 struct lte_udev {
 	struct usb_device *usbdev;
-	struct gdm_endian gdm_ed;
 	struct tx_cxt tx;
 	struct rx_cxt rx;
 	struct delayed_work work_tx;
 	struct delayed_work work_rx;
+	u8 gdm_ed;
 	u8 send_complete;
 	u8 tx_stop;
 	struct usb_interface *intf;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
