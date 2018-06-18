Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50492C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BA620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BA620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966933AbeFRIaU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:30:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966522AbeFRIaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:30:15 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87664C83;
        Mon, 18 Jun 2018 08:30:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vinson Lee <vlee@freedesktop.org>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 031/189] scsi: megaraid_sas: Do not log an error if FW successfully initializes.
Date:   Mon, 18 Jun 2018 10:12:07 +0200
Message-Id: <20180618081210.533793018@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinson Lee <vlee@freedesktop.org>

[ Upstream commit fb1633d56b0025233ed3dc49b44544748d509d9d ]

Fixes: 2d2c2331673c ("scsi: megaraid_sas: modified few prints in OCR and IOC INIT path")
Signed-off-by: Vinson Lee <vlee@freedesktop.org>
Acked-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -903,7 +903,7 @@ megasas_ioc_init_fusion(struct megasas_i
 		goto fail_fw_init;
 	}
 
-	ret = 0;
+	return 0;
 
 fail_fw_init:
 	megasas_return_cmd(instance, cmd);
@@ -913,8 +913,8 @@ fail_fw_init:
 				  IOCInitMessage, ioc_init_handle);
 fail_get_cmd:
 	dev_err(&instance->pdev->dev,
-		"Init cmd return status %s for SCSI host %d\n",
-		ret ? "FAILED" : "SUCCESS", instance->host->host_no);
+		"Init cmd return status FAILED for SCSI host %d\n",
+		instance->host->host_no);
 
 	return ret;
 }


