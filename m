Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7827EECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2488621534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTILfCgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2488621534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbeIUC4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:56:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40404 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUC4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:56:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207-v6so947469wme.5;
        Thu, 20 Sep 2018 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+39rZ3GSiqlAtrTzCUWxjW2PiWmY2TN5WtR0+k3DY8=;
        b=YTILfCgvTFBmNKEYgVDQM2f4X11ZLM1hZrf865kmAhw45bIBtWvm+5F2Lze/0FsrAT
         wzL5Hi272ooMZ0FHVLj/Um/5JMXDG9/HLymnGNnE+etKtUIbrrvyqWWQJXHNY2GvnACs
         vz20118GqWvNMAQOdtneLN5A+nos2mGHy8D/T0jx3Q6vDRb/wlmA/BsWAuf5H6ED/5Gq
         Z1yK6AjmhF4iu/4Z3W1zKd7AKo/hZwVH2k0zYN7zs1enoX7R6JDsDeFHbW4TglZ9lw/N
         rRqaJHPfOP9YmQ6IG9ZMPrZLusYVN02rR4h2d40HKj8v6IGM0QwuNHV9sRs089xf2r8Z
         jC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+39rZ3GSiqlAtrTzCUWxjW2PiWmY2TN5WtR0+k3DY8=;
        b=BLlfQ3ARQhCT7dUay8XWVmPF2zGjNdWVTA3sm5Qoj0VczVb5BTlUpwAtp4rkFYe7Dg
         p/vcMf5gdXb5eNexx5r/SSI+yBkP8DkFoZNMR6Hk1zyNgNDmNEcmrCSnTS3O2GGG4mT0
         g82zp6Q3I6mcCKezfZURv6XqRXiQhROjO119HAD6n0/NCQ/+WoiJXttrt+sWAdfaqM0p
         nZi8/6SqEBbL4NENX59k4wkERI1fYbaUU++X3ro2BO0oKE+nzXilgVvOLO5VBnvOy165
         CgrmO6vJL56lwWL7R4NSgVHpjQXCRyrWPfk0fU0NUuIvsLUZ2jKxKtTXswxV/H5lj+iw
         UA8w==
X-Gm-Message-State: APzg51C/m889ILi7ytYrRuv2jWCMIi8HZ8OmxZjcuPeZF1gNeK7QR4uz
        KhXfyrL9LxDr1ISk5I1iUdhyB9jIlzKT7w==
X-Google-Smtp-Source: ANB0Vdappa3Y/s80QlDNoeUNljYBJ5YEw8xjt0BPkfMMHYkzCar3G8Fs2GzH8Cr5M7yFFm1UVmsoTg==
X-Received: by 2002:a1c:dd06:: with SMTP id u6-v6mr84084wmg.12.1537477837924;
        Thu, 20 Sep 2018 14:10:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z10-v6sm26900675wrv.22.2018.09.20.14.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 14:10:37 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: FlashPoint: Remove unnecessary parentheses
Date:   Thu, 20 Sep 2018 14:10:32 -0700
Message-Id: <20180920211032.21840-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

In file included from drivers/scsi/BusLogic.c:57:
drivers/scsi/FlashPoint.c:2947:34: warning: equality comparison with extraneous parentheses [-Wparentheses-equality]
                                if ((currSCCB->Sccb_scsistat == SELECT_SN_ST)) {
                                     ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
drivers/scsi/FlashPoint.c:2947:34: note: remove extraneous parentheses around the comparison to silence this warning
                                if ((currSCCB->Sccb_scsistat == SELECT_SN_ST)) {
                                    ~                        ^              ~
drivers/scsi/FlashPoint.c:2947:34: note: use '=' to turn this equality comparison into an assignment
                                if ((currSCCB->Sccb_scsistat == SELECT_SN_ST)) {
                                                             ^~
                                                             =
drivers/scsi/FlashPoint.c:2956:39: warning: equality comparison with extraneous parentheses [-Wparentheses-equality]
                                else if ((currSCCB->Sccb_scsistat ==
                                          ~~~~~~~~~~~~~~~~~~~~~~~~^~
drivers/scsi/FlashPoint.c:2956:39: note: remove extraneous parentheses around the comparison to silence this warning
                                else if ((currSCCB->Sccb_scsistat ==
                                         ~                        ^
drivers/scsi/FlashPoint.c:2956:39: note: use '=' to turn this equality comparison into an assignment
                                else if ((currSCCB->Sccb_scsistat ==
                                                                  ^~
                                                                  =
2 warnings generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/156
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/FlashPoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
index 867b864f5047..0f17bd51088a 100644
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -2944,7 +2944,7 @@ static void FPT_sdecm(unsigned char message, u32 port, unsigned char p_card)
 			}
 
 			if (currSCCB->Lun == 0x00) {
-				if ((currSCCB->Sccb_scsistat == SELECT_SN_ST)) {
+				if (currSCCB->Sccb_scsistat == SELECT_SN_ST) {
 
 					currTar_Info->TarStatus |=
 					    (unsigned char)SYNC_SUPPORTED;
@@ -2953,8 +2953,8 @@ static void FPT_sdecm(unsigned char message, u32 port, unsigned char p_card)
 					    ~EE_SYNC_MASK;
 				}
 
-				else if ((currSCCB->Sccb_scsistat ==
-					  SELECT_WN_ST)) {
+				else if (currSCCB->Sccb_scsistat ==
+					  SELECT_WN_ST) {
 
 					currTar_Info->TarStatus =
 					    (currTar_Info->
-- 
2.19.0

