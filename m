Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6131C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F39620645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQPcqkkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F39620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeLESb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51921 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeLESb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so14363033wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6Cb3IZL32U0xdIctqbMRGZiak7S108GweaHQVRRZZI=;
        b=gQPcqkkBg83VEa32ZMAT6efjo0Ank+eWYSrQopqt5fomVmmFUVr0dFp/NUXG80XKU3
         sqEoNrgLuuX+TexjroLHoDXitZjIpSS62EthnglqQWKTapnFhI7P7YahrYKirQsWFtnE
         mxE5XhbkjuBolHM/sOJ9m1Wby4q/y2Af18/qwhlo5XpSZ+srSe78MxWbzdy+oFHBRcxo
         4btvv9u4ZBOIP/x6hcVEtBh44xr8F9Yquhn0JPnv/OBVFRYLD/B2mGdO+uqa5ahnKHXs
         ZFD/wKGrAMRFUmh9k8zYJkpO9cBcFLWRcczDb84xM72P93YfIvUAFfrXx/5bqmCkcXfc
         rQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6Cb3IZL32U0xdIctqbMRGZiak7S108GweaHQVRRZZI=;
        b=snQ2Wv+7nc7/RsBszyxu+qFyxdA9Wx7D0Skb1kR2CqNqj1kFC50SuIZK8Wezc9ygJ3
         ohJWnuoP2msZ64r21PsCYUvJjg7HBGE9HJNm/1eVy6nV9cxirrGDKc/P7E/k2wFoRFbo
         q+m8los1HJ74gc4dyHRcfeVH91tobuX0puNKc5wSqWNbwV2A//6pR66P5whhPlCB1ktX
         0nEOIO+VINMegLC02tRLqvb6DM3QN73Vy77f0umX7IogRL1i59mKF5pYBxFSOie6PBek
         xYV4YOIptm+S9s/zwfkzFfTzph95eWFMMpUPN6H/T2U/H8upSt93JmYOluzyKEJmGWzN
         4tpw==
X-Gm-Message-State: AA+aEWbL4UVAHEwEdEsMOye4gWT+z59vBA1cPRwNE5jFtwg5wk7ZmDEq
        zDMf1MurGWPFBYW1NLUBVCs=
X-Google-Smtp-Source: AFSGD/Ux1osoqeQJW4kLPlu0bWjLgY22ky927T7Wqpd1yCKLirCbzZL7E2R5MRw9yLR4F5KhPe7T5Q==
X-Received: by 2002:a1c:282:: with SMTP id 124mr16655817wmc.113.1544034684382;
        Wed, 05 Dec 2018 10:31:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:23 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 11/12] staging: rtl8188eu: rename struct field Wifi_Error_Status
Date:   Wed,  5 Dec 2018 19:30:59 +0100
Message-Id: <20181205183100.16828-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205183100.16828-1-straube.linux@gmail.com>
References: <20181205183100.16828-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename struct field Wifi_Error_Status to avoid CamelCase.
Wifi_Error_Status -> wifi_error_status

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sreset.c      | 4 ++--
 drivers/staging/rtl8188eu/include/rtw_sreset.h   | 2 +-
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sreset.c b/drivers/staging/rtl8188eu/core/rtw_sreset.c
index fb5adaf4a42c..a8397b132002 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sreset.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sreset.c
@@ -12,10 +12,10 @@ void rtw_hal_sreset_init(struct adapter *padapter)
 {
 	struct sreset_priv *psrtpriv = &padapter->HalData->srestpriv;
 
-	psrtpriv->Wifi_Error_Status = WIFI_STATUS_SUCCESS;
+	psrtpriv->wifi_error_status = WIFI_STATUS_SUCCESS;
 }
 
 void sreset_set_wifi_error_status(struct adapter *padapter, u32 status)
 {
-	padapter->HalData->srestpriv.Wifi_Error_Status = status;
+	padapter->HalData->srestpriv.wifi_error_status = status;
 }
diff --git a/drivers/staging/rtl8188eu/include/rtw_sreset.h b/drivers/staging/rtl8188eu/include/rtw_sreset.h
index 3ee6a4a7847d..ea3c0d93bf0b 100644
--- a/drivers/staging/rtl8188eu/include/rtw_sreset.h
+++ b/drivers/staging/rtl8188eu/include/rtw_sreset.h
@@ -11,7 +11,7 @@
 #include <drv_types.h>
 
 struct sreset_priv {
-	u8	Wifi_Error_Status;
+	u8 wifi_error_status;
 };
 
 #include <rtl8188e_hal.h>
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 7dc7028c1cd5..e4f2af2974ed 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -263,7 +263,7 @@ static int usbctrl_vendorreq(struct adapter *adapt, u8 request, u16 value, u16 i
 				if (status == (-ESHUTDOWN) || status == -ENODEV)
 					adapt->bSurpriseRemoved = true;
 				else
-					adapt->HalData->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
+					adapt->HalData->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
 			} else { /*  status != len && status >= 0 */
 				if (status > 0) {
 					if (requesttype == 0x01) {
@@ -410,7 +410,7 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 			break;
 		case -EPROTO:
 		case -EOVERFLOW:
-			adapt->HalData->srestpriv.Wifi_Error_Status = USB_READ_PORT_FAIL;
+			adapt->HalData->srestpriv.wifi_error_status = USB_READ_PORT_FAIL;
 			precvbuf->reuse = true;
 			usb_read_port(adapt, RECV_BULK_IN_ADDR, precvbuf);
 			break;
-- 
2.19.2

