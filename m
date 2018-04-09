Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-609334-1523265205-2-15360411159206492038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES rosk.us-asciica, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523265204; b=wajKXqX+cyceceUeGh607VoPEQT/j0Xr8iLhLKtNdThMnYGXFN
    p6olD3XsvpHcmWMITZBEiPk2HuQT3TxamGm36/4mZHCMGV64n7mRB5zw4sy1wevr
    yASunBjkNbZpR9soGKteelL6cSP2QHqFllOKt5Ngki7aej6yEk8LyJWyAPmv/IB+
    6AH7ghTSYcYK6gHpRfXAMBPbEPD8OZE5UnhPHwqIe5jfLpFcfoXiiv+JwxeJurGY
    W+2f7KmvZP6+4i/wM731CCjq0aVwBCH0eVoMojHv02E4agQXi2cPYPo8D/1qCyfg
    lOGT6JWFpohIhpXdpOIPrVLEAr7VflwMrcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523265204; bh=
    BJb697H5iEFem3Fy7J+6MvIIwPXNM3MndqSdEodOHmQ=; b=ZscpVqnQJV8WAP9c
    Dwanvn+nWBZcw+vfz9fXT99PiRcZ3N6XVkTSLrv7X7zBDOP7uOMsF4aZWI1z613y
    e5VzmWcKy/WEHksdo6SlY6Cx4kebhCzy465WMM10Y5NWqmCtbT2uKE1/gJsbwpEp
    E1ls3f3LzdMagKKdNKb5KTVlP5jPuK10vtRKk3vhrLn31GCmC0HHUtEGOzROH4wa
    Ii7SsufKkAZJDNYBhTj5ksMateXZrBBJZ7J9nh44bHwVkwBt+ArN1qUaEojAh8cn
    +hnvet1dANZT2UwyaxwTJ64wchypsVD6yMoWcnTKyknTAjo8BZYNZ89UxggBNoSS
    GIm9qw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE3Up9qync244IW8zE3ibuffcsUvIe0hTu8go5n2E7n+ShOyOT5abKGXY7bBbNhCURn7XJ/wdIO6LyfEVCTzfhCE8HgVu7TNAGobOIBG+F2mCI3K1w56
    BufENpX6nVqdgtmLyUZlGf38VnNBo9ceqdU3D8kekP6xycGBuNm++FcEqPXt7j3gJsEduhf7ptOJBCGn/ZlwBIFG9Qplgoe9RwROopGpNf/r1aGYZjRAWuIG
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=20KFwNOVAAAA:8 a=25QsMRCy4AX-80T5tRYA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeDIJNG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 05:13:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750863AbeDIJLG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 05:11:06 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/9] input: elan_i2c_smbus - fix corrupted stack
Date: Mon,  9 Apr 2018 11:10:44 +0200
Message-Id: <20180409091051.2944-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

New ICs (like the one on the Lenovo T480s) answer to
ETP_SMBUS_IAP_VERSION_CMD 4 bytes instead of 3. This corrupts the stack
as i2c_smbus_read_block_data() uses the values returned by the i2c
device to know how many data it need to return.

i2c_smbus_read_block_data() can read up to 32 bytes (I2C_SMBUS_BLOCK_MAX)
and there is no safeguard on how many bytes are provided in the return
value. Ensure we always have enough space for any future firmware.
Also 0-initialize the values to prevent any access to uninitialized memory.

Cc: <stable@vger.kernel.org> # v4.4.x, v4.9.x, v4.14.x, v4.15.x, v4.16.x
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
no changes in v2

 drivers/input/mouse/elan_i2c_smbus.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
index 29f99529b187..cfcb32559925 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -130,7 +130,7 @@ static int elan_smbus_get_baseline_data(struct i2c_client *client,
 					bool max_baseline, u8 *value)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  max_baseline ?
@@ -149,7 +149,7 @@ static int elan_smbus_get_version(struct i2c_client *client,
 				  bool iap, u8 *version)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  iap ? ETP_SMBUS_IAP_VERSION_CMD :
@@ -170,7 +170,7 @@ static int elan_smbus_get_sm_version(struct i2c_client *client,
 				     u8 *clickpad)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_SM_VERSION_CMD, val);
@@ -188,7 +188,7 @@ static int elan_smbus_get_sm_version(struct i2c_client *client,
 static int elan_smbus_get_product_id(struct i2c_client *client, u16 *id)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_UNIQUEID_CMD, val);
@@ -205,7 +205,7 @@ static int elan_smbus_get_checksum(struct i2c_client *client,
 				   bool iap, u16 *csum)
 {
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client,
 					  iap ? ETP_SMBUS_FW_CHECKSUM_CMD :
@@ -226,7 +226,7 @@ static int elan_smbus_get_max(struct i2c_client *client,
 {
 	int ret;
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RANGE_CMD, val);
 	if (ret != 3) {
@@ -246,7 +246,7 @@ static int elan_smbus_get_resolution(struct i2c_client *client,
 {
 	int ret;
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_RESOLUTION_CMD, val);
 	if (ret != 3) {
@@ -267,7 +267,7 @@ static int elan_smbus_get_num_traces(struct i2c_client *client,
 {
 	int ret;
 	int error;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	ret = i2c_smbus_read_block_data(client, ETP_SMBUS_XY_TRACENUM_CMD, val);
 	if (ret != 3) {
@@ -294,7 +294,7 @@ static int elan_smbus_iap_get_mode(struct i2c_client *client,
 {
 	int error;
 	u16 constant;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	error = i2c_smbus_read_block_data(client, ETP_SMBUS_IAP_CTRL_CMD, val);
 	if (error < 0) {
@@ -345,7 +345,7 @@ static int elan_smbus_prepare_fw_update(struct i2c_client *client)
 	int len;
 	int error;
 	enum tp_mode mode;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 	u8 cmd[4] = {0x0F, 0x78, 0x00, 0x06};
 	u16 password;
 
@@ -419,7 +419,7 @@ static int elan_smbus_write_fw_block(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	int error;
 	u16 result;
-	u8 val[3];
+	u8 val[I2C_SMBUS_BLOCK_MAX] = {0};
 
 	/*
 	 * Due to the limitation of smbus protocol limiting
-- 
2.14.3
