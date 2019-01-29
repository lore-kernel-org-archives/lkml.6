Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB02C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E90820855
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BhUkRkb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfA2MPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:15:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36533 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfA2MPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:15:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so9582232pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GTyESbyE1Bpdox0hntYxCmNfn5GilDfGYVGS46aUYsA=;
        b=BhUkRkb2bMEgzep6A3SKSZKvEzR6H6/3n/rvcT9mofQ8LUc9dho8t/Yu7ehFO8Gy0n
         CJiCHypBp3852r/2ztKoR9l49EAKec9rzKDN4v4L4Sd88fRu4wheopoPzQir0fCXj7MC
         XmX+XyYB7eQ2Txlo/k/YOz5wDI86AKfCgoSbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GTyESbyE1Bpdox0hntYxCmNfn5GilDfGYVGS46aUYsA=;
        b=CmWqeqBl+lzRRfADY6q3/pFtX3zWiqUylH1UR/fwdQgcmtwfqMKyoH3CxHswI+z1RU
         lWlZp43qo2Dh1PJYYRbic4vNcXl11aX/6VZj/fRAw0AXzlN1/fRo7dRFeJkTOrOn4SAF
         T+DYblEYF5gvSnwrnUUnah6Wm8lTDg0qLp2gVBk1kxT+IpORwH1MGRVqu/fetw+/JAH7
         Jx1xyF7ceQpZQuaU6ifBhrJxHck0fUg5gJnA3xkqxrRucgvw5vWGIluWKefL02eRDThZ
         a9JENdZAs2VHJikhzoJTSYdqs+Ar9bVAcSYOrWgwVw9boi3DWCzVoRmkONvAaNsIndBN
         hD5Q==
X-Gm-Message-State: AJcUukdFEvbFzvdJ3gQRMnm4rvs1Pc3KbqBh6d2PyTRNMDaMoLOhT08F
        EYNlP0YaHvXgjcBYauDY/30FOdqkQg4=
X-Google-Smtp-Source: ALg8bN4FE2qffeDN1lQde5hoHGlib7HnYbcDKdqfAlYQ310ohGauCiO940dyApIYxK2coeNyP8ZMwA==
X-Received: by 2002:a62:1542:: with SMTP id 63mr26094526pfv.230.1548764103610;
        Tue, 29 Jan 2019 04:15:03 -0800 (PST)
Received: from dhcp-10-123-20-72.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g136sm48689876pfb.154.2019.01.29.04.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:15:03 -0800 (PST)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 4/4] mpt3sas: Update driver version to 27.102.00.00
Date:   Tue, 29 Jan 2019 07:14:43 -0500
Message-Id: <1548764083-5781-5-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548764083-5781-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1548764083-5781-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated driver version to 27.102.00.00 from 27.101.00.00.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index db12c1b..19158cb 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -75,9 +75,9 @@
 #define MPT3SAS_DRIVER_NAME		"mpt3sas"
 #define MPT3SAS_AUTHOR "Avago Technologies <MPT-FusionLinux.pdl@avagotech.com>"
 #define MPT3SAS_DESCRIPTION	"LSI MPT Fusion SAS 3.0 Device Driver"
-#define MPT3SAS_DRIVER_VERSION		"27.101.00.00"
+#define MPT3SAS_DRIVER_VERSION		"27.102.00.00"
 #define MPT3SAS_MAJOR_VERSION		27
-#define MPT3SAS_MINOR_VERSION		101
+#define MPT3SAS_MINOR_VERSION		102
 #define MPT3SAS_BUILD_VERSION		0
 #define MPT3SAS_RELEASE_VERSION	00
 
-- 
1.8.3.1

