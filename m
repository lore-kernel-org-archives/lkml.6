Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5784ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71231208CE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/W3U6SG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71231208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeGNNML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:12:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37223 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeGNNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:12:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id v22-v6so26585049edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2WGoThNQ3iEbQtjeDXe1LaVcQDkGIrfb8pdEXKp+cBc=;
        b=o/W3U6SGElfJpUk4K02hbauaXTU1j1fsbd0wC7mSTZeXXhVwnMQ1IeFErE44L3bdei
         ljhd0pp3TNLPloZ+VzUCDZHUCZl79rzmInWikGHxxT3t0m6WswcU4m6K/ZCTNAlTVLec
         ZNhVoXE99es8YpUhp6r4db67w0gZ0eSGjkHFc7kS1o9rDbjwkjEsEu+ibIyYek/yLsf4
         20NtrHB0FRxhGyq9lhQTIc7TVfZkMEgFeLUI5uz/SBwrPntSMDrI5v9NvpAQDJQAi07D
         kQdOmO/ou4Z2lTv6TIzmsJeoNWS4Fg1DdX6X+nUAcS+mT04P8eADMhK3L9rXt3/OoaPq
         gpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2WGoThNQ3iEbQtjeDXe1LaVcQDkGIrfb8pdEXKp+cBc=;
        b=C4PVfFsr+nDsVKIS+kW5d6nnkXfoDDYPUkMG9FpGE8g8uodJe6gJSSDeNHwOHSb93u
         a1jwoqo4Uk1Ijj8bWbnu1h1M5q/oSheP7mNcfvJUh0hM8pU/y0X6i56KwLu9G1CP2fWw
         dbIXBk0sVOGJKzgyyOqMJlVwFK7+SXPssuTtWZ9ramMu1EsTmuZ71VW56U1EH32aNdLQ
         NOpRkPWohBROC+yJmxmQC+bE2NA70iskapttNg/gX4Xns0Lwz5EciJqVeK/L4i/S/IV2
         qeWL8+P8W5NIbb1wFjyEB5cKVXd7OTjxnXh/KaJg4wfZzl44MWS2kqZbDiJY6elZ/HpO
         rWcQ==
X-Gm-Message-State: AOUpUlHOGjYt8yprhZisLfdeARTrB0q9goHo1nnmihBmv+o4YJzlmWKf
        pEUm6vsQSvaEbBgvyvvQs98=
X-Google-Smtp-Source: AAOMgpeWewp2bbTHptRnxrcrzmEpNP/WU/L7h0m4SZVvGqAVYLYTzjM7jAtNvOkQud5VhRcqayNe7w==
X-Received: by 2002:a50:ab13:: with SMTP id s19-v6mr10899347edc.133.1531572789513;
        Sat, 14 Jul 2018 05:53:09 -0700 (PDT)
Received: from arch.localdomain (x4db2bd54.dyn.telefonica.de. [77.178.189.84])
        by smtp.gmail.com with ESMTPSA id n10-v6sm16577396edr.59.2018.07.14.05.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 05:53:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: rtl8188eu: rename function parameters
Date:   Sat, 14 Jul 2018 14:52:38 +0200
Message-Id: <20180714125241.15509-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180714125241.15509-1-straube.linux@gmail.com>
References: <20180714125241.15509-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function parameters to avoid CamelCase.
bWrite -> write
PwrState -> pwrstate

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c    | 8 ++++----
 drivers/staging/rtl8188eu/include/rtw_efuse.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index fa145cd89613..004b786de37e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -29,12 +29,12 @@ enum{
  *				and disable LDO 2.5V.
  */
 
-void efuse_power_switch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
+void efuse_power_switch(struct adapter *pAdapter, u8 write, u8 pwrstate)
 {
 	u8 tempval;
 	u16	tmpV16;
 
-	if (PwrState) {
+	if (pwrstate) {
 		usb_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
 
 		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), default valid */
@@ -57,7 +57,7 @@ void efuse_power_switch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
 			usb_write16(pAdapter, REG_SYS_CLKR, tmpV16);
 		}
 
-		if (bWrite) {
+		if (write) {
 			/*  Enable LDO 2.5V before read/write action */
 			tempval = usb_read8(pAdapter, EFUSE_TEST+3);
 			tempval &= 0x0F;
@@ -67,7 +67,7 @@ void efuse_power_switch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
 	} else {
 		usb_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
 
-		if (bWrite) {
+		if (write) {
 			/*  Disable LDO 2.5V after read/write action */
 			tempval = usb_read8(pAdapter, EFUSE_TEST+3);
 			usb_write8(pAdapter, EFUSE_TEST+3, (tempval & 0x7F));
diff --git a/drivers/staging/rtl8188eu/include/rtw_efuse.h b/drivers/staging/rtl8188eu/include/rtw_efuse.h
index e125bab0caf1..3ec53761e9fd 100644
--- a/drivers/staging/rtl8188eu/include/rtw_efuse.h
+++ b/drivers/staging/rtl8188eu/include/rtw_efuse.h
@@ -82,7 +82,7 @@ u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data);
 
 void efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset,
 		u16 _size_byte, u8 *pbuf);
-void efuse_power_switch(struct adapter *adapt, u8 bWrite, u8  PwrState);
+void efuse_power_switch(struct adapter *adapt, u8 write, u8  pwrstate);
 int Efuse_PgPacketRead(struct adapter *adapt, u8 offset, u8 *data);
 bool Efuse_PgPacketWrite(struct adapter *adapter, u8 offset, u8 word, u8 *data);
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
-- 
2.18.0

