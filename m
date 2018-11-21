Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17F7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA46214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZSciMLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA46214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbeKVGZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:25:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33458 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKVGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so1320654wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rXCZHQs7WTJCN2bn1yZ7T1u+EpHUnHW+RCOY2FbaUBs=;
        b=NZSciMLKtsvHnrM0MXRUQ3x8MB/q287ZZbXifg9+eUaeoMiBrg2bJwtfpmdh0wVtSR
         s/OhFzZaAlKblvvcQLogk2cLjg6JxcIK7xPx25VQVKTalJVg+cQCEVJXSUmPzo6Y+Pvk
         U4zl9Iv7VvDgq3KoAi5CJiuSaTZPgxKTgVIwOp4TUR5aUXgjfmtNIJ+mQNgYYqGcv6bE
         +gIxRO4G2v6cdazgg17uUXaV4vxv/F2fpSCCsBxzN0UltH1q3l2U+LkWBv3p+2IqQLtq
         akpzh7lO0aQDE75sJVRp672WERzehEjT4DEWJnpf1x1YmcfvtfwSBaD6JPO+b64fj0IO
         +QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXCZHQs7WTJCN2bn1yZ7T1u+EpHUnHW+RCOY2FbaUBs=;
        b=M5Ww52ttN9qrqLdo2MMzD3caBWnWmrlJDFhdOToB/9GafrHWqQUd6mX23TGH2T9pB2
         Aa/J9e4KdRNavJMj5gytfkLyx487SleTb9MY0frcjxJ6RpEnjAeZjEIc4Eq9aeO5ZaNq
         3IzLKGdGOxXtNlgPzoqYyladN9OVp9l3AVhUq+3iUBmEmdw08VfQ7MLadKY9auz0WaKi
         9GqnUaRKjN4SIq9lmpxl6kdSRPxXMfQzosnTwErN0siq8Wk3cpTkhFAu3QgW03I4m7+U
         yA+Efg90bbRl14WR8npHOVmpS0UAdcsZdRRlKFG6yAkZQg4Fz/MVT3JbrXG9nIXWUURg
         4KJA==
X-Gm-Message-State: AA+aEWaMDLMbEUh8YykoUPKGvxOg+pGTc8Xd7lPnx9vYEeASkoVXFxOP
        YjalbnOzZzM4W/J/lnVk/ew=
X-Google-Smtp-Source: AFSGD/VQSqbhNNdkZtJEUW7yRJDvJI8FRbkRn7jelvQ7ChlrHiSA17xffpUgL4q/k++z9lKfKDkNiQ==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr7113474wrx.85.1542829802831;
        Wed, 21 Nov 2018 11:50:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:02 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/10] staging: rtl8188eu: add spaces around '&' in rtl8188eu_led.c
Date:   Wed, 21 Nov 2018 20:49:30 +0100
Message-Id: <20181121194937.1852-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121194937.1852-1-straube.linux@gmail.com>
References: <20181121194937.1852-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '&' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
index 535ada474164..d4495839af34 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
@@ -17,7 +17,7 @@ void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
 	LedCfg = usb_read8(padapter, REG_LEDCFG2);
-	usb_write8(padapter, REG_LEDCFG2, (LedCfg&0xf0) | BIT(5) | BIT(6));
+	usb_write8(padapter, REG_LEDCFG2, (LedCfg & 0xf0) | BIT(5) | BIT(6));
 	pLed->bLedOn = true;
 }
 
-- 
2.19.1

