Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62258C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACDF2089A
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNQaVFQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACDF2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeG2AbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:31:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52754 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeG2AbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:31:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so9048771wmh.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KnwOqrYtk3Q6CdQJuA3T8ApkJrIY5ZMUs2foDYRD8Q4=;
        b=YNQaVFQKmyNPQiJBmCK37bMyg+M2ED2pDHXr1Aktx4KxS41G1IKPtS6LL6dRxajNqf
         eQrvsszYu7tis3iO6N4Bnf6FY/mIgn4CQ1GTWkffZtJriFUXVy9r5uxkiHii3JHSUzPb
         SJ+pBBqXQtrYkzoKcODxYFDL81zVJ19UjvGI02S+jEoQ0DW7+YUtIqAs1TkU+6dNP98T
         OqpIF7qWNVFvVl8xFHHgo8sqvreT1tNrf/UCN53ofRsqXEuN2DgurSJA7f8seag3eUQb
         BTN/7RsRezAlcXRq3fFvCcHUVy043jhJZHGIDoA5v4ueu90M0HQ2g/uAfksvIarohGxS
         fr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KnwOqrYtk3Q6CdQJuA3T8ApkJrIY5ZMUs2foDYRD8Q4=;
        b=n4bvu03wwybAl3boE+3tEdtHgFCmPL/91cOKT0oPETzEw3rGvLzvNVX/1mNqDTxPzg
         WXRRA3fxUnDNTJYNZyH4xazkyvKgRdSfCCrOfRFYmEYrs3oPzED3NKsgpSeoS40WJP0T
         KE0yw0ds65+fIAb6C1WgF301JFDW8H7Hwo3hVHyQQt9eut63I5aPW0fP2MbyqcQMwLaI
         JTi8yw3UxvvfFIkx3UQITEZJvCLU24BHh7ZBp9mmEHSk0ALu8NoyxCJ9X1AE3u+wZXzs
         YvFck+rCoQxf8lW2zp5mz8d+MKWoMAYNCMcIPVfRAiaVchVk4D1TdBwLtyaRx6eebMJc
         9wyw==
X-Gm-Message-State: AOUpUlHIe/0wK5U82ECyi6xVdutNVuwkDm4pWSZ9C2jNsjPmST+jc7UC
        Y8uNvlqF9UrNLfQfYy8FEobkL+BX
X-Google-Smtp-Source: AAOMgpc2dFisW08QlYQhr4uNXcxvWSRcGNOwlQTTpRJ3mPmWrt57k2r6fy/Nqk5JmwXZZCtJHkKAsg==
X-Received: by 2002:a1c:b584:: with SMTP id e126-v6mr10229323wmf.136.1532818988681;
        Sat, 28 Jul 2018 16:03:08 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m207-v6sm11490569wma.31.2018.07.28.16.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:03:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/12] staging:rtl8192u: Rename ACI_AIFSN - Style
Date:   Sun, 29 Jul 2018 00:02:54 +0100
Message-Id: <20180728230300.19732-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728230300.19732-1-johnfwhitmore@gmail.com>
References: <20180728230300.19732-1-johnfwhitmore@gmail.com>
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

