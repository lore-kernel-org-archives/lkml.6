Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525326985; cv=none;
        d=google.com; s=arc-20160816;
        b=GcVeKnDAHOAbdcm02IL/eR1DNx3+YD4S4xC7PKpf7Ob/7UhW27SPcxFLa0F6w0QnO2
         EEm4HbbTjI+HjOPcWGUa4TcVir4Rx+riB1LPC4JXFyq96WdBRfNg+PTVIbTfThKIlDIm
         eovzqcKFThszqXi0E+FzAkW90TVKAZ7q4VGo87nog2Ur2TiVjwgFL7UyPzo7/U1cZKgU
         ecc/UhiOj9to+g5B3rVoj3qZ5/1Zwg6bw60ebYbPfJQ+TxBnR/QcoELN1Vn9xcHp4ZDn
         6JLF3/PKl8smoU0tnX2zjO3xyfsCkjm+1ZjNxj0AaP9LPAgjqPbo/eAlqtYkALTpXdwC
         DhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4FhPgOtFbhiexgn4BT+gCIUjkqiM1Ja0BNHe0H45OXY=;
        b=pu2Gypw4C1j7MBjjIKb0n+e3a2SNRF6roTrHLRAeYkobbhspgU9gpRZzi/EsEzeB4S
         8NFaYzBR7Z7mO7vJ22+Z90gJZ8uHmLekuzbZB6SmVaz5zLM7iF500T0aO12hRSzkoGBV
         icUVCPKZsjncr13iLJU6q98CM6bxXJpm1TyPRdlIgYANcGGzi0UcXUdRUvuDLGb+6Xm3
         3Xx6QHWkKJTFCH6sMGJK4C8eHrrDzZn3GWPNHH0ZzGjsCWp0EaZ9EuFEqbOuaElV48yx
         ukdmpLeTdPwnXuYeRY2Jw+lL68X+7v4FPR92FR5YFH+qgbgf/9vWJjFm+3AcxEfuquYv
         Efgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=UoUZngCZ;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=UoUZngCZ;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrnAllM83JgPGRzwPe8n02DSOc21yu7lgNecSLkT5KdFg4bznxLcAkh0vcuzcOHVkzLPYDqYA==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>
Subject: [PATCH v2] NFC: fdp: Remove __func__ from dev_dbg()
Date: Thu,  3 May 2018 11:26:19 +0530
Message-Id: <1525326979-16897-1-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599421268320906778?=
X-GMAIL-MSGID: =?utf-8?q?1599421268320906778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove redundant __func__ parameter from dev_dgb() calls.

v2:
Deleted empty dev_dbg() trace calls, which are redundant if
function tracer is enabled.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/nfc/fdp/fdp.c | 18 +++---------------
 drivers/nfc/fdp/i2c.c | 17 ++++-------------
 2 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index d5784a4..f64a6fd 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -249,8 +249,6 @@ static int fdp_nci_open(struct nci_dev *ndev)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	r = info->phy_ops->enable(info->phy);
 
 	return r;
@@ -261,7 +259,6 @@ static int fdp_nci_close(struct nci_dev *ndev)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
 	return 0;
 }
 
@@ -270,8 +267,6 @@ static int fdp_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	if (atomic_dec_and_test(&info->data_pkt_counter))
 		info->data_pkt_counter_cb(ndev);
 
@@ -283,7 +278,6 @@ int fdp_nci_recv_frame(struct nci_dev *ndev, struct sk_buff *skb)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
 	return nci_recv_frame(ndev, skb);
 }
 EXPORT_SYMBOL(fdp_nci_recv_frame);
@@ -498,8 +492,6 @@ static int fdp_nci_setup(struct nci_dev *ndev)
 	int r;
 	u8 patched = 0;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	r = nci_core_init(ndev);
 	if (r)
 		goto error;
@@ -609,7 +601,6 @@ static int fdp_nci_core_reset_ntf_packet(struct nci_dev *ndev,
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
 	info->setup_reset_ntf = 1;
 	wake_up(&info->setup_wq);
 
@@ -622,7 +613,6 @@ static int fdp_nci_prop_patch_ntf_packet(struct nci_dev *ndev,
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
 	info->setup_patch_ntf = 1;
 	info->setup_patch_status = skb->data[0];
 	wake_up(&info->setup_wq);
@@ -637,7 +627,7 @@ static int fdp_nci_prop_patch_rsp_packet(struct nci_dev *ndev,
 	struct device *dev = &info->phy->i2c_dev->dev;
 	u8 status = skb->data[0];
 
-	dev_dbg(dev, "%s: status 0x%x\n", __func__, status);
+	dev_dbg(dev, "status 0x%x\n", status);
 	nci_req_complete(ndev, status);
 
 	return 0;
@@ -650,7 +640,7 @@ static int fdp_nci_prop_set_production_data_rsp_packet(struct nci_dev *ndev,
 	struct device *dev = &info->phy->i2c_dev->dev;
 	u8 status = skb->data[0];
 
-	dev_dbg(dev, "%s: status 0x%x\n", __func__, status);
+	dev_dbg(dev, "status 0x%x\n", status);
 	nci_req_complete(ndev, status);
 
 	return 0;
@@ -695,7 +685,7 @@ static int fdp_nci_core_get_config_rsp_packet(struct nci_dev *ndev,
 	dev_dbg(dev, "OTP version %d\n", info->otp_version);
 	dev_dbg(dev, "RAM version %d\n", info->ram_version);
 	dev_dbg(dev, "key index %d\n", info->key_index);
-	dev_dbg(dev, "%s: status 0x%x\n", __func__, rsp->status);
+	dev_dbg(dev, "status 0x%x\n", rsp->status);
 
 	nci_req_complete(ndev, rsp->status);
 
@@ -798,8 +788,6 @@ void fdp_nci_remove(struct nci_dev *ndev)
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	nci_unregister_device(ndev);
 	nci_free_device(ndev);
 }
diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c4da50e..f355ab2 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -57,7 +57,6 @@ static int fdp_nci_i2c_enable(void *phy_id)
 {
 	struct fdp_i2c_phy *phy = phy_id;
 
-	dev_dbg(&phy->i2c_dev->dev, "%s\n", __func__);
 	fdp_nci_i2c_reset(phy);
 
 	return 0;
@@ -67,7 +66,6 @@ static void fdp_nci_i2c_disable(void *phy_id)
 {
 	struct fdp_i2c_phy *phy = phy_id;
 
-	dev_dbg(&phy->i2c_dev->dev, "%s\n", __func__);
 	fdp_nci_i2c_reset(phy);
 }
 
@@ -113,8 +111,8 @@ static int fdp_nci_i2c_write(void *phy_id, struct sk_buff *skb)
 	}
 
 	if (r < 0 || r != skb->len)
-		dev_dbg(&client->dev, "%s: error err=%d len=%d\n",
-			__func__, r, skb->len);
+		dev_dbg(&client->dev, "error err=%d len=%d\n",
+			r, skb->len);
 
 	if (r >= 0) {
 		if (r != skb->len) {
@@ -152,8 +150,7 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 
 		r = i2c_master_recv(client, tmp, len);
 		if (r != len) {
-			dev_dbg(&client->dev, "%s: i2c recv err: %d\n",
-				__func__, r);
+			dev_dbg(&client->dev, "i2c recv err: %d\n", r);
 			goto flush;
 		}
 
@@ -167,8 +164,7 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		 * and force resynchronization
 		 */
 		if (lrc) {
-			dev_dbg(&client->dev, "%s: corrupted packet\n",
-				__func__);
+			dev_dbg(&client->dev, "corrupted packet\n");
 			phy->next_read_size = 5;
 			goto flush;
 		}
@@ -215,7 +211,6 @@ static irqreturn_t fdp_nci_i2c_irq_thread_fn(int irq, void *phy_id)
 	}
 
 	client = phy->i2c_dev;
-	dev_dbg(&client->dev, "%s\n", __func__);
 
 	r = fdp_nci_i2c_read(phy, &skb);
 
@@ -296,8 +291,6 @@ static int fdp_nci_i2c_probe(struct i2c_client *client)
 	u32 clock_freq;
 	int r = 0;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		nfc_err(dev, "No I2C_FUNC_I2C support\n");
 		return -ENODEV;
@@ -359,8 +352,6 @@ static int fdp_nci_i2c_remove(struct i2c_client *client)
 {
 	struct fdp_i2c_phy *phy = i2c_get_clientdata(client);
 
-	dev_dbg(&client->dev, "%s\n", __func__);
-
 	fdp_nci_remove(phy->ndev);
 	fdp_nci_i2c_disable(phy);
 
-- 
2.7.4
