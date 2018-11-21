Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128DE214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lapfKbde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128DE214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeKVG0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:26:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38164 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeKVGZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so3481045wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5b5cJt8kFByPhje8qiyxv3fYV2y87Fapa1WFYbe4xsk=;
        b=lapfKbde6DENps30AoWr8H5ovrCz/zCEtOtOw9Q0BeZe9At30zqfGWU5mTXWO5N/ZN
         CUoZj9rB6fWqlXC3qnsKRd0GlgYLBP8EKuRTF8fMykz0EW0A5zS5tzAqqlKrjn5BBMSP
         hzVXLdvk9aZuIhTmMUDCU4wL6h5wQHKObXkawzXV8nobdCWVHztMfPQ2SHbzlJWIb6EX
         +UxjBExgT2g4RodpA429ggkqv6cn+L/LlW0+fLlEmpjYw7ikfZkC2OKKUTscYheKwEwB
         wCacXFiGzB9FeBvYbeDzCP8JqbbT5SqXiJfT99zlqJgbRRzydwAIWQbiI71OTW8rYAt4
         Zsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5b5cJt8kFByPhje8qiyxv3fYV2y87Fapa1WFYbe4xsk=;
        b=ginYbhtRePa+xTElqpQFkkGWbP8YiHzPm/TjPfDVLhJu955q0G+G1X8RQE/FK+w+yj
         o7FtFz9ou+OZlD30VVt84HnEBWYq/ULfsmKf3oyd3zwClosY10kXV3lHB4i+Q8VNppsI
         ekd02UAtGH72I6O8+tOtxvwcn7IHGwh6scMQHtkXOl2RkLSYsNIoNd5lyeWQfJFfh04t
         lprMFnFSlHlPNJCtVlM1edm2eV17MXncch3a/FHKeucO1DdTZpPFrny+HH4WwKl83Edi
         6bJ5UEOvtb3I9hvhqp2EBekZiL2txv0hYSnf78hxr0rbbKglK3KgD1LgvFt2jSf0vANF
         SY7w==
X-Gm-Message-State: AA+aEWZvOkSQxgYBt4TfIRS/B1Y5op5PZZK3mt8y85DDRcTKdyPQmhWk
        VY9X/lsh5I//xekGel7apVE=
X-Google-Smtp-Source: AFSGD/WCJxlDMzLHdFMT4676Q1t76IXjSg01kfhHbjz12l8fo7/qHADI3TkBE3c5oZEEtk/WpqdOUw==
X-Received: by 2002:adf:e284:: with SMTP id v4mr3571888wri.26.1542829808222;
        Wed, 21 Nov 2018 11:50:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:07 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/10] staging: rtl8188eu: rename LedControl8188eu to avoid CamelCase
Date:   Wed, 21 Nov 2018 20:49:36 +0100
Message-Id: <20181121194937.1852-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121194937.1852-1-straube.linux@gmail.com>
References: <20181121194937.1852-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function LedControl8188eu to avoid CamelCase.
LedControl8188eu -> led_control_8188eu

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c     | 6 +++---
 drivers/staging/rtl8188eu/core/rtw_led.c     | 2 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c    | 4 ++--
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 2 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c    | 4 ++--
 drivers/staging/rtl8188eu/core/rtw_xmit.c    | 2 +-
 drivers/staging/rtl8188eu/include/rtw_led.h  | 2 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c  | 8 ++++----
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 9b2a497aa413..f6dbcf6fe39b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -294,7 +294,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 		mod_timer(&pmlmepriv->scan_to_timer,
 			  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
 
-		LedControl8188eu(padapter, LED_CTL_SITE_SURVEY);
+		led_control_8188eu(padapter, LED_CTL_SITE_SURVEY);
 
 		pmlmepriv->scan_interval = SCAN_INTERVAL;/*  30*2 sec = 60sec */
 	} else {
@@ -318,7 +318,7 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 	struct wlan_bssid_ex *pdev_network = &padapter->registrypriv.dev_network;
 	u8	res = _SUCCESS;
 
-	LedControl8188eu(padapter, LED_CTL_START_TO_LINK);
+	led_control_8188eu(padapter, LED_CTL_START_TO_LINK);
 
 	if (pmlmepriv->assoc_ssid.SsidLength == 0)
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
@@ -360,7 +360,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	LedControl8188eu(padapter, LED_CTL_START_TO_LINK);
+	led_control_8188eu(padapter, LED_CTL_START_TO_LINK);
 
 	if (pmlmepriv->assoc_ssid.SsidLength == 0)
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+Join cmd: Any SSid\n"));
diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index 99ebaf5e4548..ab68eb808c49 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -465,7 +465,7 @@ void blink_handler(struct LED_871x *pLed)
 	SwLedBlink1(pLed);
 }
 
-void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
+void led_control_8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
 	    !padapter->hw_init_completed)
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index b9bd864f323c..e5c8b02e6ab2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -785,7 +785,7 @@ void rtw_indicate_connect(struct adapter *padapter)
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
 		set_fwstate(pmlmepriv, _FW_LINKED);
 
-		LedControl8188eu(padapter, LED_CTL_LINK);
+		led_control_8188eu(padapter, LED_CTL_LINK);
 
 		rtw_os_indicate_connect(padapter);
 	}
@@ -816,7 +816,7 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 		rtw_os_indicate_disconnect(padapter);
 
 		_clr_fwstate_(pmlmepriv, _FW_LINKED);
-		LedControl8188eu(padapter, LED_CTL_NO_LINK);
+		led_control_8188eu(padapter, LED_CTL_NO_LINK);
 		rtw_clear_scan_deny(padapter);
 	}
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index 9764e85c000c..6a846d08d449 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -47,7 +47,7 @@ static int rtw_hw_suspend(struct adapter *padapter)
 		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 			_clr_fwstate_(pmlmepriv, _FW_LINKED);
 
-			LedControl8188eu(padapter, LED_CTL_NO_LINK);
+			led_control_8188eu(padapter, LED_CTL_NO_LINK);
 
 			rtw_os_indicate_disconnect(padapter);
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index dc447cc78c32..7c667a38077b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1229,7 +1229,7 @@ static int validate_recv_frame(struct adapter *adapter,
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
 	case WIFI_DATA_TYPE: /* data */
-		LedControl8188eu(adapter, LED_CTL_RX);
+		led_control_8188eu(adapter, LED_CTL_RX);
 		pattrib->qos = (subtype & BIT(7)) ? 1 : 0;
 		retval = validate_recv_data_frame(adapter, precv_frame);
 		if (retval == _FAIL) {
@@ -1912,7 +1912,7 @@ static int recv_func_posthandle(struct adapter *padapter,
 	struct __queue *pfree_recv_queue = &padapter->recvpriv.free_recv_queue;
 
 	/*  DATA FRAME */
-	LedControl8188eu(padapter, LED_CTL_RX);
+	led_control_8188eu(padapter, LED_CTL_RX);
 
 	prframe = decryptor(padapter, prframe);
 	if (!prframe) {
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index b218b9deff7b..6a2d044ec02b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -1606,7 +1606,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	}
 	pxmitframe->pkt = *ppkt;
 
-	LedControl8188eu(padapter, LED_CTL_TX);
+	led_control_8188eu(padapter, LED_CTL_TX);
 
 	pxmitframe->attrib.qsel = pxmitframe->attrib.priority;
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_led.h b/drivers/staging/rtl8188eu/include/rtw_led.h
index 80f8dcce05dc..e09ba8d2141b 100644
--- a/drivers/staging/rtl8188eu/include/rtw_led.h
+++ b/drivers/staging/rtl8188eu/include/rtw_led.h
@@ -76,7 +76,7 @@ struct LED_871x {
 	((struct LED_871x *)_LED_871x)->CurrLedState == LED_BLINK_WPS_STOP || \
 	((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress)
 
-void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE	LedAction);
+void led_control_8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction);
 
 struct led_priv {
 	/* add for led control */
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index dac9f98b4808..fb213a90ed1b 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -578,7 +578,7 @@ static int _netdev_open(struct net_device *pnetdev)
 		}
 		rtw_hal_inirp_init(padapter);
 
-		LedControl8188eu(padapter, LED_CTL_NO_LINK);
+		led_control_8188eu(padapter, LED_CTL_NO_LINK);
 
 		padapter->bup = true;
 	}
@@ -661,7 +661,7 @@ int rtw_ips_pwr_up(struct adapter *padapter)
 
 	result = ips_netdrv_open(padapter);
 
-	LedControl8188eu(padapter, LED_CTL_NO_LINK);
+	led_control_8188eu(padapter, LED_CTL_NO_LINK);
 
 	DBG_88E("<===  rtw_ips_pwr_up.............. in %dms\n",
 		jiffies_to_msecs(jiffies - start_time));
@@ -676,7 +676,7 @@ void rtw_ips_pwr_down(struct adapter *padapter)
 
 	padapter->net_closed = true;
 
-	LedControl8188eu(padapter, LED_CTL_POWER_OFF);
+	led_control_8188eu(padapter, LED_CTL_POWER_OFF);
 
 	rtw_ips_dev_unload(padapter);
 	DBG_88E("<=== rtw_ips_pwr_down..................... in %dms\n",
@@ -728,7 +728,7 @@ static int netdev_close(struct net_device *pnetdev)
 		/* s2-4. */
 		rtw_free_network_queue(padapter, true);
 		/*  Close LED */
-		LedControl8188eu(padapter, LED_CTL_POWER_OFF);
+		led_control_8188eu(padapter, LED_CTL_POWER_OFF);
 	}
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-88eu_drv - drv_close\n"));
-- 
2.19.1

