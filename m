Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449371-1520055255-2-12268212090337282389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520055254; b=Tb/gZfBpYvRoSmJ/MnwXU3yS754xUUCpvQIZmQBcw3uZtnl
    5YE21HevL3clRLdRCbsyks820dN++csVNUVufdviXM1PWzg/RqC67ezXRDFJYWBA
    kHrY8w5VERcEbfs1h9MaN6Wxv3lpa3Tj4AQhEWn0e2ESdVXXMjmg314U91V5dAHu
    u4eKMfFzG51ayaugwhT4q5+pwCDePCwPOhudgB9i6YTOU42BA5bSwy7aRToMiU7w
    hBGMa0bVUwFOGj9+BlswSOwacGvF+nyrqHDDiyli8NmPixUcpVtK2u7UvhnWWDJf
    LPl98+OiyNeM6LAJW50LuO2lfqkAJFY+FUYA9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520055254; bh=a
    POZXK1aQaiaF89pK2l3NdO4geNO8oahzyqlcmxM1rw=; b=iDM3Q8CIiHiY6XXzO
    ELhtconvFfSZOXI4IKGtqAKqYItekVPkaG6u13LILcGykSmMwledrjyxN8Uw+s+X
    gOlZnIThei/GkHfNVoJpqzfOBrvaZOGA5PExLfU4UUNkYoSHZlIIQa+OIxjCnHeH
    LPUWwNxgwZu0JCQ2KmJc71XUHPJJFXf+9ssvpHk9NPedBMRvNQMPWgR0bhkLhOe/
    dlCLLJ4x+/FOv/Yi7wxcDlVWXQaHs1zyD9rBJb2nP5vqrE3b5z/CUlz4iTfe4fZs
    ndwAp/yhCRlEFHThcq4MpK/yhOWegd1JTjcM3Le9D65S8ml5MiUUBelGu1LTSrd7
    lhyIA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FNiIYDer x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S59amNEx;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FNiIYDer x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S59amNEx;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt92ZwUka8RTjlH/jGUTTw7QYgP73RVnKWsauX7IeEOPT+MAb85Zt+MdLZRXQB6ywYtxQQL3A==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: outreachy-kernel@googlegroups.com
Subject: [PATCH v2 6/6] staging: rtl8712: remove unnecessary parentheses
Date: Sat,  3 Mar 2018 11:02:36 +0530
Message-Id: <1520055156-8388-7-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove unnecessary parentheses around variables to conform to the Linux
kernel coding style. Issue found using checkpatch.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/staging/rtl8712/recv_linux.c  |  4 +-
 drivers/staging/rtl8712/rtl8712_cmd.c |  8 ++--
 drivers/staging/rtl8712/rtl8712_led.c | 70 +++++++++++++++++------------------
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
index 986a55b..8cf4286 100644
--- a/drivers/staging/rtl8712/recv_linux.c
+++ b/drivers/staging/rtl8712/recv_linux.c
@@ -111,8 +111,8 @@ void r8712_recv_indicatepkt(struct _adapter *padapter,
 	_pkt *skb;
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
 
-	precvpriv = &(padapter->recvpriv);
-	pfree_recv_queue = &(precvpriv->free_recv_queue);
+	precvpriv = &padapter->recvpriv;
+	pfree_recv_queue = &precvpriv->free_recv_queue;
 	skb = precv_frame->u.hdr.pkt;
 	if (!skb)
 		goto _recv_indicatepkt_drop;
diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index 9c8e0c5..b1dfe9f 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -320,7 +320,7 @@ int r8712_cmd_thread(void *context)
 	struct tx_desc *pdesc;
 	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
 	struct _adapter *padapter = context;
-	struct	cmd_priv	*pcmdpriv = &(padapter->cmdpriv);
+	struct	cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	struct completion *cmd_queue_comp =
 		&pcmdpriv->cmd_queue_comp;
 	struct mutex *pwctrl_lock = &padapter->pwrctrlpriv.mutex_lock;
@@ -334,7 +334,7 @@ int r8712_cmd_thread(void *context)
 		if (r8712_register_cmd_alive(padapter) != _SUCCESS)
 			continue;
 _next:
-		pcmd = r8712_dequeue_cmd(&(pcmdpriv->cmd_queue));
+		pcmd = r8712_dequeue_cmd(&pcmdpriv->cmd_queue);
 		if (!(pcmd)) {
 			r8712_unregister_cmd_alive(padapter);
 			continue;
@@ -419,7 +419,7 @@ int r8712_cmd_thread(void *context)
 	}
 	/* free all cmd_obj resources */
 	do {
-		pcmd = r8712_dequeue_cmd(&(pcmdpriv->cmd_queue));
+		pcmd = r8712_dequeue_cmd(&pcmdpriv->cmd_queue);
 		if (!pcmd)
 			break;
 		r8712_free_cmd_obj(pcmd);
@@ -433,7 +433,7 @@ void r8712_event_handle(struct _adapter *padapter, __le32 *peventbuf)
 	u8 evt_code, evt_seq;
 	u16 evt_sz;
 	void (*event_callback)(struct _adapter *dev, u8 *pbuf);
-	struct	evt_priv *pevt_priv = &(padapter->evtpriv);
+	struct	evt_priv *pevt_priv = &padapter->evtpriv;
 
 	if (!peventbuf)
 		goto _abort_event_;
diff --git a/drivers/staging/rtl8712/rtl8712_led.c b/drivers/staging/rtl8712/rtl8712_led.c
index 455fba7..e907734 100644
--- a/drivers/staging/rtl8712/rtl8712_led.c
+++ b/drivers/staging/rtl8712/rtl8712_led.c
@@ -181,11 +181,11 @@ static void SwLedOff(struct _adapter *padapter, struct LED_871x *pLed)
  */
 void r8712_InitSwLeds(struct _adapter *padapter)
 {
-	struct led_priv	*pledpriv = &(padapter->ledpriv);
+	struct led_priv	*pledpriv = &padapter->ledpriv;
 
 	pledpriv->LedControlHandler = LedControl871x;
-	InitLed871x(padapter, &(pledpriv->SwLed0), LED_PIN_LED0);
-	InitLed871x(padapter, &(pledpriv->SwLed1), LED_PIN_LED1);
+	InitLed871x(padapter, &pledpriv->SwLed0, LED_PIN_LED0);
+	InitLed871x(padapter, &pledpriv->SwLed1, LED_PIN_LED1);
 }
 
 /*	Description:
@@ -193,10 +193,10 @@ void r8712_InitSwLeds(struct _adapter *padapter)
  */
 void r8712_DeInitSwLeds(struct _adapter *padapter)
 {
-	struct led_priv	*ledpriv = &(padapter->ledpriv);
+	struct led_priv	*ledpriv = &padapter->ledpriv;
 
-	DeInitLed871x(&(ledpriv->SwLed0));
-	DeInitLed871x(&(ledpriv->SwLed1));
+	DeInitLed871x(&ledpriv->SwLed0);
+	DeInitLed871x(&ledpriv->SwLed1);
 }
 
 /*	Description:
@@ -206,7 +206,7 @@ void r8712_DeInitSwLeds(struct _adapter *padapter)
 static void SwLedBlink(struct LED_871x *pLed)
 {
 	struct _adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 bStopBlinking = false;
 
 	/* Change LED according to BlinkingLedState specified. */
@@ -281,14 +281,14 @@ static void SwLedBlink(struct LED_871x *pLed)
 static void SwLedBlink1(struct LED_871x *pLed)
 {
 	struct _adapter *padapter = pLed->padapter;
-	struct led_priv *ledpriv = &(padapter->ledpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct eeprom_priv *peeprompriv = &(padapter->eeprompriv);
-	struct LED_871x *pLed1 = &(ledpriv->SwLed1);
+	struct led_priv *ledpriv = &padapter->ledpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct eeprom_priv *peeprompriv = &padapter->eeprompriv;
+	struct LED_871x *pLed1 = &ledpriv->SwLed1;
 	u8 bStopBlinking = false;
 
 	if (peeprompriv->CustomerID == RT_CID_819x_CAMEO)
-		pLed = &(ledpriv->SwLed1);
+		pLed = &ledpriv->SwLed1;
 	/* Change LED according to BlinkingLedState specified. */
 	if (pLed->BlinkingLedState == LED_STATE_ON)
 		SwLedOn(padapter, pLed);
@@ -499,7 +499,7 @@ static void SwLedBlink2(struct LED_871x *pLed)
 static void SwLedBlink3(struct LED_871x *pLed)
 {
 	struct _adapter *padapter = pLed->padapter;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 bStopBlinking = false;
 
 	/* Change LED according to BlinkingLedState specified. */
@@ -593,8 +593,8 @@ static void SwLedBlink3(struct LED_871x *pLed)
 static void SwLedBlink4(struct LED_871x *pLed)
 {
 	struct _adapter *padapter = pLed->padapter;
-	struct led_priv	*ledpriv = &(padapter->ledpriv);
-	struct LED_871x *pLed1 = &(ledpriv->SwLed1);
+	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct LED_871x *pLed1 = &ledpriv->SwLed1;
 	u8 bStopBlinking = false;
 
 	/* Change LED according to BlinkingLedState specified. */
@@ -844,7 +844,7 @@ static void BlinkWorkItemCallback(struct work_struct *work)
 {
 	struct LED_871x *pLed = container_of(work, struct LED_871x,
 				BlinkWorkItem);
-	struct led_priv	*ledpriv = &(pLed->padapter->ledpriv);
+	struct led_priv	*ledpriv = &pLed->padapter->ledpriv;
 
 	switch (ledpriv->LedStrategy) {
 	case SW_LED_MODE0:
@@ -886,13 +886,13 @@ static void BlinkWorkItemCallback(struct work_struct *work)
 static void SwLedControlMode1(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv *ledpriv = &(padapter->ledpriv);
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct sitesurvey_ctrl *psitesurveyctrl = &(pmlmepriv->sitesurveyctrl);
+	struct led_priv *ledpriv = &padapter->ledpriv;
+	struct LED_871x *pLed = &ledpriv->SwLed0;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct sitesurvey_ctrl *psitesurveyctrl = &pmlmepriv->sitesurveyctrl;
 
 	if (padapter->eeprompriv.CustomerID == RT_CID_819x_CAMEO)
-		pLed = &(ledpriv->SwLed1);
+		pLed = &ledpriv->SwLed1;
 	switch (LedAction) {
 	case LED_CTL_START_TO_LINK:
 	case LED_CTL_NO_LINK:
@@ -1106,9 +1106,9 @@ static void SwLedControlMode1(struct _adapter *padapter,
 static void SwLedControlMode2(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	 *ledpriv = &(padapter->ledpriv);
+	struct led_priv	 *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
+	struct LED_871x *pLed = &ledpriv->SwLed0;
 
 	switch (LedAction) {
 	case LED_CTL_SITE_SURVEY:
@@ -1239,9 +1239,9 @@ static void SwLedControlMode2(struct _adapter *padapter,
 static void SwLedControlMode3(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &(padapter->ledpriv);
+	struct led_priv	*ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
+	struct LED_871x *pLed = &ledpriv->SwLed0;
 
 	switch (LedAction) {
 	case LED_CTL_SITE_SURVEY:
@@ -1383,10 +1383,10 @@ static void SwLedControlMode3(struct _adapter *padapter,
 static void SwLedControlMode4(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &(padapter->ledpriv);
+	struct led_priv	*ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
-	struct LED_871x *pLed1 = &(ledpriv->SwLed1);
+	struct LED_871x *pLed = &ledpriv->SwLed0;
+	struct LED_871x *pLed1 = &ledpriv->SwLed1;
 
 	switch (LedAction) {
 	case LED_CTL_START_TO_LINK:
@@ -1650,12 +1650,12 @@ static void SwLedControlMode4(struct _adapter *padapter,
 static void SwLedControlMode5(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &(padapter->ledpriv);
+	struct led_priv	*ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
+	struct LED_871x *pLed = &ledpriv->SwLed0;
 
 	if (padapter->eeprompriv.CustomerID == RT_CID_819x_CAMEO)
-		pLed = &(ledpriv->SwLed1);
+		pLed = &ledpriv->SwLed1;
 
 	switch (LedAction) {
 	case LED_CTL_POWER_ON:
@@ -1723,9 +1723,9 @@ static void SwLedControlMode5(struct _adapter *padapter,
 static void SwLedControlMode6(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &(padapter->ledpriv);
+	struct led_priv	*ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct LED_871x *pLed = &(ledpriv->SwLed0);
+	struct LED_871x *pLed = &ledpriv->SwLed0;
 
 	switch (LedAction) {
 	case LED_CTL_POWER_ON:
@@ -1737,7 +1737,7 @@ static void SwLedControlMode6(struct _adapter *padapter,
 		pLed->CurrLedState = LED_STATE_ON;
 		pLed->BlinkingLedState = LED_STATE_ON;
 		pLed->bLedBlinkInProgress = false;
-		mod_timer(&(pLed->BlinkTimer), jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 	case LED_CTL_TX:
 	case LED_CTL_RX:
@@ -1807,7 +1807,7 @@ static void SwLedControlMode6(struct _adapter *padapter,
  */
 void LedControl871x(struct _adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &(padapter->ledpriv);
+	struct led_priv	*ledpriv = &padapter->ledpriv;
 
 	if (!ledpriv->bRegUseLed)
 		return;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
