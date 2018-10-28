Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43B3ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 03:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C81D20827
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 03:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbxyGra6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C81D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeJ1Ma6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 08:30:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36306 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeJ1Ma5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 08:30:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id y11-v6so2234450plt.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 20:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BSUUSCiAf+SZUNfvSypKxLuFXw4+UcxoOy8un93LPJI=;
        b=EbxyGra6soWQj0mr3PD1FW9OM5p2A0SqOpIlaHmPFPIIopYasflIkZxvD2c/tfzYB8
         CYQMt+T7NzrHqFefrJx7CC/9DhBSawFRO0VlCRATb0/jFn+dN22LQav8Aoyc7hwW3nol
         zNR+y+pnekp9zlRojpdypcnr/4XWtYliCjvRHPg3+LnRtcOOcDxGf0ZnvV8D6Q/SJO9f
         zs4l82qQTUxoHTjnRg6jJ1wZjw8fLfUSDQN5mN5daK164htpq9Jl3So/g/k370Ymm2uk
         Ce+hcZddoW/yCL7TRbcZn27mM5681bJOdh4GCaEoGhpRdTeCjUzkM789AxG78GoBwjEX
         JByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BSUUSCiAf+SZUNfvSypKxLuFXw4+UcxoOy8un93LPJI=;
        b=ajt9NaiWchKi1HC2LVIZeB61F0NipfBcaHgJ2rmqUOucAuJE+QMvn8bK4u3NN9ai01
         M6xdy49R9atCLYnqCjJRkI9zo8rLNZC9bKblY94Mxcyro4hg+evbHxuEqzHN7tstZDZQ
         0RjfUDGBVzoUbLA4jYJeAJ+qTZQZJfFnYE8T0Sxyj3lLZdvfejR5fwnEswdj0irLlYTg
         Uk2FxeTlt1EhkX9Su+1sjG7SSkOmVIMi4m624VvuYQjOjxWTB9RV25tKhL3+vIie5bAx
         vFEE+mYWgCHHQxu0qF12hoCpHKVSjGLezSURgHzLC2FXYTTXZTovKG5ted1jQ/gJ3P8c
         fbrg==
X-Gm-Message-State: AGRZ1gLzjnCJ0gWyr45IvmsE+Vt9TRPBzdZovqbR0twf/bVEmuq7vZwU
        WzLEi20pvLXzMtmfaE/NCQzvl6GueKQ=
X-Google-Smtp-Source: AJdET5enSUtGNDgfo/YJxlYE5Rzh9t6kWGUAYWuuz185Q1gzqEmZdkfi6Jvne+wazve9CrtFlIcuJQ==
X-Received: by 2002:a17:902:2909:: with SMTP id g9-v6mr9158258plb.223.1540698460459;
        Sat, 27 Oct 2018 20:47:40 -0700 (PDT)
Received: from emca-Inspiron-3558 (96-89-123-89-static.hfc.comcastbusiness.net. [96.89.123.89])
        by smtp.gmail.com with ESMTPSA id u13-v6sm15454625pgp.18.2018.10.27.20.47.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Oct 2018 20:47:39 -0700 (PDT)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?q?Andr=C3=A9=20Lehmann?= <lenneman@web.de>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: fix CamelCase in fw_priv struct
Date:   Sat, 27 Oct 2018 20:47:00 -0700
Message-Id: <1540698425-17503-1-git-send-email-bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename fields in fw_priv struct from CamelCase to snake_case.
Reported by checkpatch.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c    | 10 +++++-----
 drivers/staging/rtl8712/rtl8712_hal.h |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 7cdd609..4c6519c 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -100,11 +100,11 @@ static void fill_fwpriv(struct _adapter *padapter, struct fw_priv *pfwpriv)
 		pfwpriv->rf_config = RTL8712_RFC_1T2R;
 	}
 	pfwpriv->mp_mode = (pregpriv->mp_mode == 1) ? 1 : 0;
-	pfwpriv->vcsType = pregpriv->vrtl_carrier_sense; /* 0:off 1:on 2:auto */
-	pfwpriv->vcsMode = pregpriv->vcs_type; /* 1:RTS/CTS 2:CTS to self */
-	/* default enable turboMode */
-	pfwpriv->turboMode = ((pregpriv->wifi_test == 1) ? 0 : 1);
-	pfwpriv->lowPowerMode = pregpriv->low_power;
+	pfwpriv->vcs_type = pregpriv->vrtl_carrier_sense; /* 0:off 1:on 2:auto */
+	pfwpriv->vcs_mode = pregpriv->vcs_type; /* 1:RTS/CTS 2:CTS to self */
+	/* default enable turbo_mode */
+	pfwpriv->turbo_mode = ((pregpriv->wifi_test == 1) ? 0 : 1);
+	pfwpriv->low_power_mode = pregpriv->low_power;
 }
 
 static void update_fwhdr(struct fw_hdr	*pfwhdr, const u8 *pmappedfw)
diff --git a/drivers/staging/rtl8712/rtl8712_hal.h b/drivers/staging/rtl8712/rtl8712_hal.h
index 42f5197..66cc464 100644
--- a/drivers/staging/rtl8712/rtl8712_hal.h
+++ b/drivers/staging/rtl8712/rtl8712_hal.h
@@ -72,13 +72,13 @@ struct fw_priv {   /*8-bytes alignment required*/
 	unsigned char regulatory_class_3; /*regulatory class bit map 3*/
 	unsigned char rfintfs;    /* 0:SWSI, 1:HWSI, 2:HWPI*/
 	unsigned char def_nettype;
-	unsigned char turboMode;
-	unsigned char lowPowerMode;/* 0: normal mode, 1: low power mode*/
+	unsigned char turbo_mode;
+	unsigned char low_power_mode;/* 0: normal mode, 1: low power mode*/
 	/*--- long word 2 ----*/
 	unsigned char lbk_mode; /*0x00: normal, 0x03: MACLBK, 0x01: PHYLBK*/
 	unsigned char mp_mode; /* 1: for MP use, 0: for normal driver */
-	unsigned char vcsType; /* 0:off 1:on 2:auto */
-	unsigned char vcsMode; /* 1:RTS/CTS 2:CTS to self */
+	unsigned char vcs_type; /* 0:off 1:on 2:auto */
+	unsigned char vcs_mode; /* 1:RTS/CTS 2:CTS to self */
 	unsigned char rsvd022;
 	unsigned char rsvd023;
 	unsigned char rsvd024;
-- 
2.7.4

