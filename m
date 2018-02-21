Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218794-2-14574587218538104692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218794; b=q6vPFT/bFpTO0eK+QQ3cFbwwCItifQVAa4atuRUneCD2/xF
    VNLAK+rWMXKTw/wK9t8vNK34ZgCb9wLIv8XKuEKydJY9Wt6MYkA5v6oKFhc41Sb6
    +ddv17fzyhrSWiALVPLU3Q4UhZNDNO37IsBQAlGrzznAyVJWqxsMv8zwtkQqiy7P
    Q41qrtNywAeTJLKq4s8oano2H47sgh9pKIJHFTs377DsNrpgrPXkPcVZO0m9c/nQ
    C3LQrXhN7A5yg7Hx7ox9cpj7whXNlosUAslkGIw/WGeYg23YlbG3yIqxHlA3a4z3
    rhzr6xZbJGhK7cPAkvafP4PLzMyu7BGu5RlNuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519218794; bh=z
    C3hUGMPUat5/gQtoHwBkosujdJsmpAi9cqx/wB+ICM=; b=E7LmyfjXHmvawyWqn
    /gd3cg6IOXEOtchSKuVIvTkVmUAvYohyM2uiwH3LVF6nrG2eqz/nuRNCLzSjdst/
    5jh6CgoSiV3w+aZSmri6Fle1vTgFcxs+EjOdEa1aEyc/L/2yyqf5jXHe+JDJaso8
    +kUchs44VOpEp2Za6TC0Zwu2thKhO+GCwe8EO1HJk8LCH8ZS3J3ZjBrH8O3SZbQP
    HEEPo3DYKPgw9sPk3HDEwVhkDeLfAcGzSmXovQYGotGfR3ZPULOXFM3Yy76kGPPs
    dgXT+Y9hDg+rjQLYDGHj8mEJP5vuxNWGcEUB4MKR+CcthHaQNXdy+5pjzD6YvjQY
    GGuAA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
 dan.carpenter@oracle.com
Subject: [PATCH 1/2] Staging: gdm724x: Simplify the struct gdm_endian to a
 variable.
Date: Wed, 21 Feb 2018 05:12:36 -0800
Message-Id: <20180221131237.10960-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221104306.zq7fdbgzjmfdrqju@mwanda>
References: <20180221104306.zq7fdbgzjmfdrqju@mwanda>
X-Provags-ID: V03:K0:XAIYbuONIcfeRA66LoLm8Z+fx+YMUbqYoJddP+KiN8LklN6+Mxm
 BtUVqnPBm1HmpuiasglR6qxuAaVCieQNnR/ySgF2KFknT832TjmNZX7NaKC5dt/TEpch4qW
 QJ8nYepBtSE6UcldC0bwczkMEauhvp/ja0u7288L48RKJlpsG0EM4+ce1tbISVcALEnLDI7
 M2J0sxDxxJ6mhmfdkAjrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e7gxc2WIIsM=:RdEtJimRRipOZ93N37kb6q
 uY362agz5G56svF6tPxou1KGtK16u6Mo2lKVQgk/piRvtHYXc9SoeEPT87YKpk2/YK+fKcacG
 jUJNceZRw3rfeE/sidazr8uJ1+SnxlaG9hOSsgXNoyfhiz3vHuz+58d+F9EIWMsfO5ZZUHOjI
 445BOqJQm5GgDvZ63vrMqvgOQP6io7CFQEdkclQVH5uUrbFcC6m/ih2HwNpYVOjCQaPVJOxYD
 vM1UN2kRKCpIX6T4kZNPJ2cmXqqhJ3QLoiNRaUPWB1MnRDAqkcw27eYJ9PJ+Y29syeIGP8w2e
 k+qDIAxOcPpH04UaOg0XaxYjceeyODpGquyXTrWtpyRJ43HHTRjzyAErYRHnMDE1dKKDi/K9Q
 0R8r0WJVGnsfY3PUx/W5BGxKysVcrfIA5H+4FYHZ5kryHa9jq+hTE9U3XnR4YWQAd/eH7vXJb
 dHIVlHcCwGLzKxugzENSd/GVZI09IKjyTaSHMxx3Q272Kb25opPBPkXsvGOIMDcZfbyfX+gCF
 yVmOi/wJFDbUtvu5xBYWN5SHu/zr5HE/syvH30Ck9DtCAQ21OSJguREsZ6CxmaJVQydCpLGFW
 74GIZ/buMmHOF1CLqx9Fb4o5j50180PJjGe0wh0KTGIRJmdAoRotx5g8eeBRSNcz7Epr5KQo8
 txwVgFTV3T1YKasHuKpuTXFAPDcvOUhYhPCqBvYkD1QqTItlYEjG9iC3cRhcFVNYdY0CxlZ7h
 Gs/oeGyeiHROuNwMl5HyBPgAEaIxd21yaorqrA==
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
