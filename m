Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2680C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306E821565
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdYbAId4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306E821565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeI0G11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:27:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55120 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeI0G11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:27:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id c14-v6so4018450wmb.4;
        Wed, 26 Sep 2018 17:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RcO7Xka82eBCqQUf12Pto9/X1Xq+0RNbQUAV8QuDM0=;
        b=tdYbAId4saJpBi9jMRnJwWgsWGYfudwW6VzqFqsAJlB1+VNYig1gVVrJ0YKmqIfLrx
         dltpAKoINc5F4Jk94FizZdYBKLrXVlxCc0qKIpktOz0yVLJAstOcQNKOjlMveIzbqybY
         fh5FxpsHcOAocHHxzQXDvGJRnccpAiWrMlYUZJhDmP+LCTzdKLkl/ZkN1bmHZkFTUbEC
         sNWvqZ0FTXb/RvrPrJShc0KsSBVlE4s82TYF4Vbx1Qf9ZZDsr7XhucHvvp/zCa/e1Cxx
         66ACZw85W/lRTq1aVMJW91WBPdURGadUDJDDlR0REAxAdtDJrRicxx+6J9NJQd+Ipc09
         ObqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RcO7Xka82eBCqQUf12Pto9/X1Xq+0RNbQUAV8QuDM0=;
        b=ugc0Mp5N8krDgN37JPVmSKb2OF6v3A5QlteXR8BjhLFDrXs1uwhGJBJUsMMrEzAUm0
         HMnL9/PdEFghgi/BZAlKT+1W6jVEKhevoDHSzB+FgFGhxe9I6WHH1YWy2AmdOG/RU39s
         VYFpOt+gR2fCK5WDihGBUBboVPdf5FwtKZ3kWc53yuQOFyR1Ru7j6f7fqZgL+sZImp8T
         oRngvB+yyufBV21EJL4fJyR+a4fZgMKj9CV6k5oRCiJJw85b+CreLfDIodivPHKEkevW
         cNqnc5BlrWGpY581pcgaqUo1GmnUrTnygpsGJWZdT6xpi+ryXrAfusx3SCEzgK1tsCxo
         Y9eA==
X-Gm-Message-State: ABuFfoiMRL+p7N/KAiRcsuKdZ692q0PqSNi1QQ/R8a98+CUbJgiANjos
        q7HX7sChdjJHAvRBt1JS7rk=
X-Google-Smtp-Source: ACcGV629yL4+eZfhMHsZXAAC9x8QS/cJjV7YuA0UkRlE3nzxw+wym/VSzhNx5Gi0Oz0CxlI4lL9w0Q==
X-Received: by 2002:a1c:1203:: with SMTP id 3-v6mr6268978wms.46.1538007116939;
        Wed, 26 Sep 2018 17:11:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b138-v6sm694852wmb.1.2018.09.26.17.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 17:11:56 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: isci: Use proper enumerated type in atapi_d2h_reg_frame_handler
Date:   Wed, 26 Sep 2018 17:11:50 -0700
Message-Id: <20180927001150.26212-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/scsi/isci/request.c:1629:13: warning: implicit conversion from
enumeration type 'enum sci_io_status' to different enumeration type
'enum sci_status' [-Wenum-conversion]
                        status = SCI_IO_FAILURE_RESPONSE_VALID;
                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/isci/request.c:1631:12: warning: implicit conversion from
enumeration type 'enum sci_io_status' to different enumeration type
'enum sci_status' [-Wenum-conversion]
                status = SCI_IO_FAILURE_RESPONSE_VALID;
                       ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

status is of type sci_status but SCI_IO_FAILURE_RESPONSE_VALID is of
type sci_io_status. Use SCI_FAILURE_IO_RESPONSE_VALID, which is from
sci_status and has SCI_IO_FAILURE_RESPONSE_VALID's exact value since
that is what SCI_IO_FAILURE_RESPONSE_VALID is mapped to in the isci.h
file.

Link: https://github.com/ClangBuiltLinux/linux/issues/153
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/isci/request.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index ed197bc8e801..2f151708b59a 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -1626,9 +1626,9 @@ static enum sci_status atapi_d2h_reg_frame_handler(struct isci_request *ireq,
 
 	if (status == SCI_SUCCESS) {
 		if (ireq->stp.rsp.status & ATA_ERR)
-			status = SCI_IO_FAILURE_RESPONSE_VALID;
+			status = SCI_FAILURE_IO_RESPONSE_VALID;
 	} else {
-		status = SCI_IO_FAILURE_RESPONSE_VALID;
+		status = SCI_FAILURE_IO_RESPONSE_VALID;
 	}
 
 	if (status != SCI_SUCCESS) {
-- 
2.19.0

