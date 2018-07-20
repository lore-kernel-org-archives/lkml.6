Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B062ECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D606D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQIH9awq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D606D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbeGTVMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:12:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34768 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbeGTVMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:12:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so5044152wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2CyohRThTs7j+4L1yPIm+uaeTE1fNeUX4Kle2r8Cws0=;
        b=IQIH9awqzqaPub5+F10DgM3rWwlDKtnQM2om0rcyqiaHNDGx5OFtIQky74hVl8zGUY
         ziKNy0uMm8Q/4T+BLCEHmOv6BGOCigw0cf1Tc9C0tZYrsV/ZQbH+Ky8Eao5nEa/PQg25
         2EKngxCydynOywaJbBhcCPJpQHyewwuCYemW2G4VQLZses2w8Mh5rfh944nU6VWscHzG
         DZoMwrR2VyUkCBq+T+jS5YgVh9NHZWX9yfHYd80QD268zr7TgL7kwP+rQpKO+dTqTcE5
         EZ9ZQBTUNogav5r/NFNp7BP2IAUDfACi3DJQhYDH7VGJkP5d1Y0hpI4bfWdxa+ftAj0f
         yi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2CyohRThTs7j+4L1yPIm+uaeTE1fNeUX4Kle2r8Cws0=;
        b=QU3zZ0KuaQrDOYXNYRpCdLWudEMqDtGgzdgktkUiRdmx2+z+zBYPa6np3RGSioLG7O
         IqhPemaYboodRm7xQSlNZ2GKOE6no0O/oEVmXtFld8EHs1V2sji2K/pcp7ElZBkETx3b
         23fzlUPHSpfG90Q362/UA7z89xINgpQ2PvlMj38HYxnkbHCNsb4mriUlKiEJU1H3itPa
         MjB7t3ZSVs3T+BeR6C7TcfmmUfzeWNogXLkEAGtHAo8vuee4gLcQ9zJYKsi2lKRBRqQ+
         PlLf0R4lG4NL+Afj7BqfloJaQ4YBf+Es2fveYdY183WzUwyvSfeFCU7FzT3H3vTttWQY
         uAGQ==
X-Gm-Message-State: AOUpUlEDa2li0ow0nfylQ0lBcAg2H9I+t3t6JaybNr0HUikbtBExIFe4
        I+XZ9Je4D0cSgZy9gHsfhtKqEhNxNUE=
X-Google-Smtp-Source: AAOMgpfkNfUg2s2HlvSej5ZxYGb5YF/6CMItp81LkTaQRl5QLAKInFDBfyDSvotAKUSScWNyL4kXtQ==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr2205755wmf.1.1532118135780;
        Fri, 20 Jul 2018 13:22:15 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:15 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/14] staging:rtl8192u: Rename CountryIeWatchdog > country_ie_watchdog - Style
Date:   Fri, 20 Jul 2018 21:21:40 +0100
Message-Id: <20180720202142.26312-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable CountryIeWatchdog to country_ie_watchdog, this
change clears the checkpatch issue with CamelCase naming of variables.
The change is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index e5087291d64a..a7fa1a7f01bd 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -24,7 +24,7 @@ struct rt_dot11d_info {
 	u16 country_ie_len; /* > 0 if country_ie_buf[] contains valid country information element. */
 	u8  country_ie_buf[MAX_IE_LEN];
 	u8  country_ie_src_addr[6]; /* Source AP of the country IE. */
-	u8  CountryIeWatchdog;
+	u8  country_ie_watchdog;
 
 	u8  channel_map[MAX_CHANNEL_NUMBER+1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
 	u8  MaxTxPwrDbmList[MAX_CHANNEL_NUMBER+1];
@@ -53,7 +53,7 @@ struct rt_dot11d_info {
 	(!memcmp(GET_DOT11D_INFO(__pIeeeDev)->country_ie_buf, (__Ie).Octet, (__Ie).Length)))
 
 #define CIE_WATCHDOG_TH 1
-#define GET_CIE_WATCHDOG(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->CountryIeWatchdog)
+#define GET_CIE_WATCHDOG(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_watchdog)
 #define RESET_CIE_WATCHDOG(__pIeeeDev) (GET_CIE_WATCHDOG(__pIeeeDev) = 0)
 #define UPDATE_CIE_WATCHDOG(__pIeeeDev) (++GET_CIE_WATCHDOG(__pIeeeDev))
 
-- 
2.18.0

