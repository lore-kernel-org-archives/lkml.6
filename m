Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBFEC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9CE208A2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAZ8wBeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9CE208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbeG2Whj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:37:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40366 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731466AbeG2Whj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:37:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so10585899wrs.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KnwOqrYtk3Q6CdQJuA3T8ApkJrIY5ZMUs2foDYRD8Q4=;
        b=JAZ8wBehw1x9ARok4tv7n+EgrtXSD0pK9IYGgxHyDxJnigZyfhu3C9Mo6IRX286pi7
         1SAayRttJWbErGTz+kRp21koINDn/FLlemF+unjOZpThnD/8BbTN42jXdTTDGCSPnH5q
         Yw+swCROuwCh4+6V/X9NrKHA3iHURpYoel/4Xu0AtwfeFLUh895qypG3exFTxIwq3bxv
         lhOVdnIUB99wXOIJ7qXaTkyXF7F3AHK8j5Oji/OxBvgZDcDH+obg0MOnp7pIu3cFrdCT
         1Q+HUDjCi1Avg9ufj5CW4AtprW63ynWkaLdDMNh/pounzJHM7ew+cLMhqYLa/7I/2f+Y
         Gs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KnwOqrYtk3Q6CdQJuA3T8ApkJrIY5ZMUs2foDYRD8Q4=;
        b=jFg6fl1zNLFO98GSVef+zEYRp2UW9RQSnEW8iUcQJworRgrtCfPKWFz4n3wJ0ByZsh
         VVKBps2mEORDft2FaS5YpPrqUImMy4u0six5DHE+eOkpUkXfUxPXMHRqZUkjqajQeoLY
         DofLchRcCElZ3XSvWJ7WpEF7usJOdu2MElWB0jxWWDIy/nEQfg2+zvlLsVE6RA5sh3Zk
         WLJRlOQpXTDpC9XZnV3cmkvlbkhM3tsgdPfSnlWSy10GmGmj9DMdRoXOtEdVUUQdb+7i
         FGZVX/5v7fvnTRp9nzOZQj4vlaAP3Z/259LuZyt1ac74zJia/lcXFo6H2O8tyw0QUF4I
         SWjg==
X-Gm-Message-State: AOUpUlFvAX61s0QMfQDEjQn6bxSrHLx2byIP9mbWush+oshTx34IBMXE
        geuRuE74jwB7mMziHzBDAWaQUqa80mw=
X-Google-Smtp-Source: AAOMgpf71w6IbPnCIoFCfjfr3EnBKlCUuvFl2d+Wp6VmEicwNb4/x1sakVtj0M0bHBMcj8HRw4cdEA==
X-Received: by 2002:adf:c891:: with SMTP id k17-v6mr15489462wrh.6.1532898348001;
        Sun, 29 Jul 2018 14:05:48 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id l19-v6sm10476876wmc.3.2018.07.29.14.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:05:47 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 02/08] staging:rtl8192u: Rename ACI_AIFSN - Style
Date:   Sun, 29 Jul 2018 22:05:15 +0100
Message-Id: <20180729210534.10617-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210534.10617-1-johnfwhitmore@gmail.com>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the union ACI_AIFSN to aci_aifsn and remove the typedef directive.

The removal of the typedef clears the checkpatch issue with defining
new types. The renaming is to adhere to the coding style where types
are name in lower case.

These changes are coding style changes which should have no impact on
runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 6 +++---
 drivers/staging/rtl8192u/r8192U_dm.c             | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 92afa9dc9663..5856bf87c5dc 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -13,7 +13,7 @@
 // ACI/AIFSN Field.
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
 //
-typedef	union _ACI_AIFSN {
+union aci_aifsn {
 	u8	charData;
 
 	struct {
@@ -22,7 +22,7 @@ typedef	union _ACI_AIFSN {
 		u8	ACI:2;
 		u8	Reserved:1;
 	} f;	// Field
-} ACI_AIFSN, *PACI_AIFSN;
+};
 
 //
 // ECWmin/ECWmax field.
@@ -45,7 +45,7 @@ typedef	union _AC_PARAM {
 	u8	charData[4];
 
 	struct {
-		ACI_AIFSN	AciAifsn;
+		union aci_aifsn	AciAifsn;
 		ECW		Ecw;
 		u16		TXOPLimit;
 	} f;	// Field
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index c4e4e3ba394b..04c08ca8a0bb 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2333,7 +2333,7 @@ static void dm_check_edca_turbo(
 			{
 				/*  TODO:  Modified this part and try to set acm control in only 1 IO processing!! */
 
-				PACI_AIFSN	pAciAifsn = (PACI_AIFSN)&(qos_parameters->aifs[0]);
+				union aci_aifsn *pAciAifsn = (union aci_aifsn *)&(qos_parameters->aifs[0]);
 				u8		AcmCtrl;
 
 				read_nic_byte(dev, AcmHwCtrl, &AcmCtrl);
-- 
2.18.0

