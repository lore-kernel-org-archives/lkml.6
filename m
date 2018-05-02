Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525283384; cv=none;
        d=google.com; s=arc-20160816;
        b=NuJTQIqsfGTSozS5o6jH4sjAxtIvGs8TU053nUoDRkCyr3ViHuXmFXjf9lY+Y9u2fJ
         VlLj7IC9Yvm/4+UV3JgburmdYh/BGhxhU4eKy2j5wSmE5GI+ZltNeonEudwJkdk3Qe3U
         jgaPTSD+qY/xJBn/gvRc3DChiyPyhuLCK1yatIh6tahWWT69JgwuOVlyt5/ARs3oIB2O
         kpmZKqOrkJlv9hUId5suXtfn9458PQQL5m/uzD2mjNlTsF/GpzdUl5ZZZ7tqEueTZgxK
         WVMt7TW95G0c/dVO/yQTNjfXZTTalhqR8tl8cLaXvbVptawuuVlzUREb9GzFVwGO353f
         LGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=author:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=k963rsKbRvZ0iKEU2kAKepLfS69IrhXu8/g9e07LQVM=;
        b=R7jFPwh+jN2WY1EPI40fXBrTyrgVU6kxL7Yv9nisMC8GYNWZJVFmTXKnhCpHWf0/2W
         X04CdpFr+y3ehKd+QMq+kZjxTTGyEH5t1IMiK+p9cKbiAEmRok1HkyD3NMmS+6qenGw5
         t2cGPRFk76B7gx1Gay3GZZaEBRO/6TNXu65m/TVYwXlmlr7d9ruw8Wx7ixXf2mvI9R+T
         BRcqZTCEK5Z/tyVEi3nBoK+br6pDnWLdHh2AaCYrT5gcL/c0Hd2gYJnTzTWMygFhuEKY
         LcrqTw7tukI95Knju6Cq2WCjdJ5K9vn7ochP6AImpFLU19iIaddWBPJhTIOiz/O65tHt
         IiPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=AxbxUT9q;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=AxbxUT9q;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrn6m14V/TNA2gQtQ7NhFK2eIdPtVJDY+pR3VFsfyWovGpX5yvVZV6QQ1gp+l3xi1tmHP5hUg==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>
Subject: [PATCH] NFC: fdp: Remove __func__ parameter from dev_dbg() call
Date: Wed,  2 May 2018 23:19:39 +0530
Message-Id: <1525283379-7141-1-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
Author: Amit Pundir <amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599375551043714716?=
X-GMAIL-MSGID: =?utf-8?q?1599375551043714716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove redundant __func__ parameter from dev_dgb() calls.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/nfc/fdp/fdp.c | 22 +++++++++++-----------
 drivers/nfc/fdp/i2c.c | 20 +++++++++-----------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index d5784a4..3251346 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -249,7 +249,7 @@ static int fdp_nci_open(struct nci_dev *ndev)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
+	dev_dbg(dev, "\n");
 
 	r = info->phy_ops->enable(info->phy);
 
@@ -261,7 +261,7 @@ static int fdp_nci_close(struct nci_dev *ndev)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
+	dev_dbg(dev, "\n");
 	return 0;
 }
 
@@ -270,7 +270,7 @@ static int fdp_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
+	dev_dbg(dev, "\n");
 
 	if (atomic_dec_and_test(&info->data_pkt_counter))
 		info->data_pkt_counter_cb(ndev);
@@ -283,7 +283,7 @@ int fdp_nci_recv_frame(struct nci_dev *ndev, struct sk_buff *skb)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
+	dev_dbg(dev, "\n");
 	return nci_recv_frame(ndev, skb);
 }
 EXPORT_SYMBOL(fdp_nci_recv_frame);
@@ -498,7 +498,7 @@ static int fdp_nci_setup(struct nci_dev *ndev)
 	int r;
 	u8 patched = 0;
 
-	dev_dbg(dev, "%s\n", __func__);
+	dev_dbg(dev, "\n");
 
 	r = nci_core_init(ndev);
 	if (r)
@@ -609,7 +609,7 @@ static int fdp_nci_core_reset_ntf_packet(struct nci_dev *ndev,
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
+	dev_dbg(dev, "\n");
 	info->setup_reset_ntf = 1;
 	wake_up(&info->setup_wq);
 
@@ -622,7 +622,7 @@ static int fdp_nci_prop_patch_ntf_packet(struct nci_dev *ndev,
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
+	dev_dbg(dev, "\n");
 	info->setup_patch_ntf = 1;
 	info->setup_patch_status = skb->data[0];
 	wake_up(&info->setup_wq);
@@ -637,7 +637,7 @@ static int fdp_nci_prop_patch_rsp_packet(struct nci_dev *ndev,
 	struct device *dev = &info->phy->i2c_dev->dev;
 	u8 status = skb->data[0];
 
-	dev_dbg(dev, "%s: status 0x%x\n", __func__, status);
+	dev_dbg(dev, "status 0x%x\n", status);
 	nci_req_complete(ndev, status);
 
 	return 0;
@@ -650,7 +650,7 @@ static int fdp_nci_prop_set_production_data_rsp_packet(struct nci_dev *ndev,
 	struct device *dev = &info->phy->i2c_dev->dev;
 	u8 status = skb->data[0];
 
-	dev_dbg(dev, "%s: status 0x%x\n", __func__, status);
+	dev_dbg(dev, "status 0x%x\n", status);
 	nci_req_complete(ndev, status);
 
 	return 0;
@@ -695,7 +695,7 @@ static int fdp_nci_core_get_config_rsp_packet(struct nci_dev *ndev,
 	dev_dbg(dev, "OTP version %d\n", info->otp_version);
 	dev_dbg(dev, "RAM version %d\n", info->ram_version);
 	dev_dbg(dev, "key index %d\n", info->key_index);
-	dev_dbg(dev, "%s: status 0x%x\n", __func__, rsp->status);
+	dev_dbg(dev, "status 0x%x\n", rsp->status);
 
 	nci_req_complete(ndev, rsp->status);
 
@@ -798,7 +798,7 @@ void fdp_nci_remove(struct nci_dev *ndev)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
+	dev_dbg(dev, "\n");
 
 	nci_unregister_device(ndev);
 	nci_free_device(ndev);
diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index b80d1ad..3138730 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -57,7 +57,7 @@ static int fdp_nci_i2c_enable(void *phy_id)
 {
 	struct fdp_i2c_phy *phy = phy_id;
 
-	dev_dbg(&phy->i2c_dev->dev, "%s\n", __func__);
+	dev_dbg(&phy->i2c_dev->dev, "\n");
 	fdp_nci_i2c_reset(phy);
 
 	return 0;
@@ -67,7 +67,7 @@ static void fdp_nci_i2c_disable(void *phy_id)
 {
 	struct fdp_i2c_phy *phy = phy_id;
 
-	dev_dbg(&phy->i2c_dev->dev, "%s\n", __func__);
+	dev_dbg(&phy->i2c_dev->dev, "\n");
 	fdp_nci_i2c_reset(phy);
 }
 
@@ -113,8 +113,8 @@ static int fdp_nci_i2c_write(void *phy_id, struct sk_buff *skb)
 	}
 
 	if (r < 0 || r != skb->len)
-		dev_dbg(&client->dev, "%s: error err=%d len=%d\n",
-			__func__, r, skb->len);
+		dev_dbg(&client->dev, "error err=%d len=%d\n",
+			r, skb->len);
 
 	if (r >= 0) {
 		if (r != skb->len) {
@@ -152,8 +152,7 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 
 		r = i2c_master_recv(client, tmp, len);
 		if (r != len) {
-			dev_dbg(&client->dev, "%s: i2c recv err: %d\n",
-				__func__, r);
+			dev_dbg(&client->dev, "i2c recv err: %d\n", r);
 			goto flush;
 		}
 
@@ -167,8 +166,7 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		 * and force resynchronization
 		 */
 		if (lrc) {
-			dev_dbg(&client->dev, "%s: corrupted packet\n",
-				__func__);
+			dev_dbg(&client->dev, "corrupted packet\n");
 			phy->next_read_size = 5;
 			goto flush;
 		}
@@ -224,7 +222,7 @@ static irqreturn_t fdp_nci_i2c_irq_thread_fn(int irq, void *phy_id)
 	}
 
 	client = phy->i2c_dev;
-	dev_dbg(&client->dev, "%s\n", __func__);
+	dev_dbg(&client->dev, "\n");
 
 	r = fdp_nci_i2c_read(phy, &skb);
 
@@ -305,7 +303,7 @@ static int fdp_nci_i2c_probe(struct i2c_client *client)
 	u32 clock_freq;
 	int r = 0;
 
-	dev_dbg(dev, "%s\n", __func__);
+	dev_dbg(dev, "\n");
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		nfc_err(dev, "No I2C_FUNC_I2C support\n");
@@ -368,7 +366,7 @@ static int fdp_nci_i2c_remove(struct i2c_client *client)
 {
 	struct fdp_i2c_phy *phy = i2c_get_clientdata(client);
 
-	dev_dbg(&client->dev, "%s\n", __func__);
+	dev_dbg(&client->dev, "\n");
 
 	fdp_nci_remove(phy->ndev);
 	fdp_nci_i2c_disable(phy);
-- 
2.7.4
