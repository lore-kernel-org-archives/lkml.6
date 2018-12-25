Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3685DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CDC2177B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="H6YtH35B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeLYUzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 15:55:42 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45524 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbeLYUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 15:55:42 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 66769943
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nTqxkmlfvTZb for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 14:55:40 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 3118B937
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 14:55:40 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id f7so3930005ioo.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FuHOuKpGz+fwN2iVXkaCpSkG9NfBhy+p6k9UTEUSGqU=;
        b=H6YtH35BlI/V3PZ55iyAmdwen5kwY3eFsnO9j5OgQHKvZ6HuED8RFNDkT0n+rNBdbp
         uRjGjl5b42nVi7ktflyWk8nKh0wBjDGCRg2HGU7zgpmXnozsEsKENs8F8g+K/2mJzcbI
         YOMeV7KceT5YIG4A+i5XCXPPOTUnobsUOt4Uigs0go1R/dsO0jxFECjXByFuvEagUePD
         JECETukDaHErs1ivXO8JZvGHEw1gy8PJH8OKapv4HUImz6POfitOXF9N6a8ZpV8s6fz0
         5c5U7uzSU86PV5TEjMlh1iKvBjM9xn+58GdHXXI093MsCmp5yp5Gn0ZalzbmwTSj9qFI
         p/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FuHOuKpGz+fwN2iVXkaCpSkG9NfBhy+p6k9UTEUSGqU=;
        b=oszE0Kt76IL31+eFoW8/vfkqYJFtko+kqhDTl1UOsnyvbr9AKZhMy2MsQ9jqYTh7PE
         iZLeN7RvlGrfxvOkzCw8zOuElihSgyn6iLj+lrlnTdznXNuW/oNkldZQ0x2e1DtllhJq
         6VIOBFNyngFvceopn6hyPmdNoLuTc1exXiIXcPqx6oCp+1sZ49fw0v1TKy/Sxq9y9cJK
         c3qVYMZ6S3nqGIKWjwaDru6sUWH9wf256cLb8EIjKEz2S3jMiaJp/xfYOo7GUi/DDslg
         Ag2M9aNz4BgSg4zR0AM6t5FOK54pjpO6scjHUt2QV/dJCd+3Hrii2eXzVKiXQ/708qxa
         zzQw==
X-Gm-Message-State: AA+aEWbi65km2RXNefQLRiobPwlJUNga4usyRZ3qDl1u22sN7cCAx4EN
        BJMIx5GxPdxPB/aY9ZD2iX7UTeoc+sTq3ku5QJAFS61+r8nebud/w1plLTyhUe3SqpnqN8Attjs
        up0LaNiFj42QjYP+xA8KOqbKF0iTR
X-Received: by 2002:a24:4606:: with SMTP id j6mr9591387itb.10.1545771339763;
        Tue, 25 Dec 2018 12:55:39 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4YpOXfPQ/gfmfoQhv5AEa9CJihpigvPuSf0UpyXCrIAuv3lC0Gpv0Xt1wFHmigQIZqdrvClg==
X-Received: by 2002:a24:4606:: with SMTP id j6mr9591379itb.10.1545771339521;
        Tue, 25 Dec 2018 12:55:39 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id m2sm14887285iol.75.2018.12.25.12.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 12:55:38 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: avoiding fetching signature from user space again after check
Date:   Tue, 25 Dec 2018 14:55:09 -0600
Message-Id: <20181225205509.69618-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signature is checked so that it must be "MEGANIT". After the check,
if we fetch the signature again from user space, it may have been
modified by malicious user programs through race conditions. The fix
avoids fetching the signature again.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/megaraid.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 8c7154143a4e..a2255fbd0ab6 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -3396,7 +3396,6 @@ static int
 mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 {
 	struct uioctl_t	uioc_mimd;
-	char	signature[8] = {0};
 	u8	opcode;
 	u8	subopcode;
 
@@ -3408,10 +3407,10 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 	 * beginning of the structure.
 	 */
 
-	if( copy_from_user(signature, arg, 7) )
+	if (copy_from_user(&uioc_mimd, arg, 7))
 		return (-EFAULT);
 
-	if( memcmp(signature, "MEGANIT", 7) == 0 ) {
+	if (memcmp(&uioc_mimd, "MEGANIT", 7) == 0) {
 
 		/*
 		 * NOTE NOTE: The nit ioctl is still under flux because of
@@ -3421,7 +3420,7 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 		 */
 		return -EINVAL;
 #if 0
-		if( copy_from_user(uioc, arg, sizeof(nitioctl_t)) )
+		if (copy_from_user(uioc, arg, sizeof(nitioctl_t)))
 			return (-EFAULT);
 		return 0;
 #endif
@@ -3432,7 +3431,10 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 	 *
 	 * Get the user ioctl structure
 	 */
-	if( copy_from_user(&uioc_mimd, arg, sizeof(struct uioctl_t)) )
+	if (copy_from_user((char *)&uioc_mimd + sizeof(uioc->signature),
+				arg + sizeof(uioc->signature),
+				sizeof(struct uioctl_t) -
+				sizeof(uioc->signature)))
 		return (-EFAULT);
 
 
-- 
2.17.2 (Apple Git-113)

