Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F091C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABB620878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0vjTlK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABB620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeG2Anu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:43:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37182 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbeG2AnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:43:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so8710451wrd.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KnwOqrYtk3Q6CdQJuA3T8ApkJrIY5ZMUs2foDYRD8Q4=;
        b=X0vjTlK/+w0dQNlcznZP4lq3O3v2mnJPMcFjQwhNN1bHrEFSMCQhaSLtPbT5WQcXs0
         rtm9WbOXnt27G8FvpysHzTK8HTzAzKAct6sFo8L4XjMBpGkcbgYGnSJqosRk3MZCvWkd
         b3U9EGmaB2pMAnGOv7086ILnpve51f+q+YtPaostR6LBiEPVHjCuwFLe/4snvT9nlqok
         vTUKyxvHWtP/METZm5M592fPj82rg4jhGDxGtD3M9Hrp0K3PgbFEMNZB7QXW46z3GXk7
         jz5FHcRAYsBTFg08TXl9AcEQ4Yv5LRJ3K5PyjdEw/k6haiQ62fNZvcRvvvkwn9d7rOfb
         NOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KnwOqrYtk3Q6CdQJuA3T8ApkJrIY5ZMUs2foDYRD8Q4=;
        b=M78KCa3NFK2dXGsGmBDMe0NrJ4BgurRiCeVXcbZdXwwzwZEOjk5UFfOALnD/mvncy+
         y/eShGzyooj8RuFyoYzXaP2EmEpja5lHMvY5eg3G+aiXzTnrQsMU+pG+Lya6PNm5TbJc
         tqWkjQm6hdFRidR67f4RRMFGmplUNUHuf7VNnpqmfjohKWEySaxcEW5WbArBICXgRY1z
         JY6myjJe8q6b5XR+ng1OJgCUMp8f0pO97w06DfZL4qnXmVHtxM9x45KBqwaBXvBj0YTp
         QC0Z0zk1x/zuyZVyK8od4jbPyGIT3mVrnO/WhegpyyH1f+ZNnXzhaIDeVoeBCNFjYFbR
         CJYw==
X-Gm-Message-State: AOUpUlEPkSxDQ1weQFTD5VPLgewu4Lvw5toFlXFOK0mugVitpxlgoe2q
        gCOnmDM2k4ms00LgZQAN7XEB2K8W
X-Google-Smtp-Source: AAOMgpfUlPptYiQY6ZRYboszH4Hjn5SKBJh5YNk47dmmXhYxmM7hkyP+YV8JuNXFLoUQHTkEA0FCxQ==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr654737wre.29.1532819702148;
        Sat, 28 Jul 2018 16:15:02 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8909745wmb.25.2018.07.28.16.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:15:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 02/08] staging:rtl8192u: Rename ACI_AIFSN - Style
Date:   Sun, 29 Jul 2018 00:14:46 +0100
Message-Id: <20180728231452.20107-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728231452.20107-1-johnfwhitmore@gmail.com>
References: <20180728231452.20107-1-johnfwhitmore@gmail.com>
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

