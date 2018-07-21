Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BA820864
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRxAkSNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BA820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeGUUUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39466 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeGUUUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so14136300wre.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QItLSUHV4P38EyAAosvCBQ/MaDBjETX25O4cLVdyXyI=;
        b=kRxAkSNeNZm/uApK/eWPplzXUcnibcg1revOGWe/wDfI459VNpqRWhU1r0BQctiZhy
         c4cSJ3cnYCt10b8TJ49DSy6sjjQq4NNE1qB3p8dLe6VTUrOvzTIuII/M4W/IQOw1EFoE
         +eOC3QBL5j/elcplkDqv/He21JKdVErKJK5sJIGoYGdaiKy16qUGRzFzEgjbnPxIiIu2
         MWan9268wKkTV8/TVPNG5veaOG/cMhXfyimUJqHWmzDTHwtOXEmfsdzxlIhQIRg1f5ax
         AFRwn9w+QoLyvtHODeAnRmLApi8hUBDNwgKqmU1SMr/5FGUtZx4kIe4wK/lcvTMraodF
         RLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QItLSUHV4P38EyAAosvCBQ/MaDBjETX25O4cLVdyXyI=;
        b=InJhjYdI04j3LPdsiDVVbl8Yu3Wo5R1idx3sU8ck3FF9lic/3nrposhYV7Ytqp8+dR
         FRplW0DjZ666JTpMji1XLatuykbespcX2+AlxbyU/F80EgdMd3nez23bV3KIjSJedc7u
         eCZySVioBDSFFziOWMY4miG214kEun0v0+2WLYXyuw63rAi5+h1R6bEPwrlU2j+ltl1r
         r03O+ie6fKNBk4bmACOjF8dfD1JNqfyBiqGj6ZqOGZSmX3fgB/yfNd0P6C5QegYRqvL+
         vhSK8m4AiS7qZhEZiDmuIaAf++UFkCskjKOjPelMSxn71ZC9A6KElvbzsKYkMjfcZDmS
         sP1A==
X-Gm-Message-State: AOUpUlHHq1itNQT42q/NIV9/erU889j0fSWzaqNzadUwxcOFzH4Sg++o
        g1uN6A5RX858e85/2AFvC9iiKHPp
X-Google-Smtp-Source: AAOMgpcv2nVTjtR03Zp/JEEetCEB0Gxh7KrdRpt4w4AuOPYTDtlkCp/OdqMHb4/BwTBqjREUKqsk+g==
X-Received: by 2002:adf:9546:: with SMTP id 64-v6mr4359032wrs.257.1532201189614;
        Sat, 21 Jul 2018 12:26:29 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:28 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 07/10] staging:rtl8192u: Rename variable CountryIeSrcAddr - Style
Date:   Sat, 21 Jul 2018 20:25:49 +0100
Message-Id: <20180721192552.5378-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721192552.5378-1-johnfwhitmore@gmail.com>
References: <20180721192552.5378-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable CountryIeSrcAddr to country_ie_src_addr, this
clears the checkpatch issue with CamelCase naming. The change is purely a
coding style change and should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 109b82e69b5e..e5087291d64a 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -23,7 +23,7 @@ struct rt_dot11d_info {
 
 	u16 country_ie_len; /* > 0 if country_ie_buf[] contains valid country information element. */
 	u8  country_ie_buf[MAX_IE_LEN];
-	u8  CountryIeSrcAddr[6]; /* Source AP of the country IE. */
+	u8  country_ie_src_addr[6]; /* Source AP of the country IE. */
 	u8  CountryIeWatchdog;
 
 	u8  channel_map[MAX_CHANNEL_NUMBER+1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
@@ -44,8 +44,8 @@ struct rt_dot11d_info {
 #define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->enabled)
 #define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_len > 0)
 
-#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eqMacAddr(GET_DOT11D_INFO(__pIeeeDev)->CountryIeSrcAddr, __pTa)
-#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->CountryIeSrcAddr, __pTa)
+#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eqMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
+#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 
 #define IS_COUNTRY_IE_CHANGED(__pIeeeDev, __Ie) \
 	(((__Ie).Length == 0 || (__Ie).Length != GET_DOT11D_INFO(__pIeeeDev)->country_ie_len) ? \
-- 
2.18.0

