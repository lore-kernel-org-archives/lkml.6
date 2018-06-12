Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 61F88C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F1E208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEmXBK11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F1E208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeFLEsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:48:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42756 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbeFLEsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:48:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id w7-v6so11411681pfn.9;
        Mon, 11 Jun 2018 21:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bPcI2ECHz9/PT+hfWz4BwaLtsfX6pdaBxyMJA3e7VAE=;
        b=mEmXBK111UxPnXw0XO1qddWM/OgjLpPY3MhMCXDHG/JkIXa+Wd32Db3J+55AKtC8kI
         Y5Now5DRZn62dIT9l0b3Z2KsbVEb8aexfqYZPoeldkghRx+q/mxGmOOOPpnp7IZ8CW4S
         zUFsDWKNrPYwv6NaAXPv3ZSce7peULiez/SZf/CqPl8bJ08vedd8I8Ym5NXAYdQI3QcE
         KXwmOJ9YvG/kRUTaK4Do1fIthuUzCqXXgwrFzvKmuPF9IEMp1ekIZvXfPUzACXrzAxMP
         ufvDluF3w9T8d5oWxO+wZ+47U5VNM87c7r/i3jg/A4pVYpe/43yWit1PsXrLy0zOSwNe
         XfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bPcI2ECHz9/PT+hfWz4BwaLtsfX6pdaBxyMJA3e7VAE=;
        b=qcmvD1WhpJMHmCV9SfobpsMeDYYF2jHNy54Ng1wgNjECUv36bt3p6V1IAiTeD6e5xt
         NFQWOOhISf4ENMKAYCRxPxboGQ4uZDigRSDFo1E3Vb9v0goQON80ASpFczlHvGhKl0N7
         LLDCA31F/YSX5cKQDNJyhxJ5Qmv11t0d5ILjmixZ2DRw9osUYFNL62UKywppW8fZWni1
         Ewd392uFnsDNOef8Kioz4F4wUPSGzh9knxrWJVYO+Kiq4cvqtzDSQ+iNwgt7TCDQ/NLG
         uOoxZSC4hYAjbhYk632fPayOpVFOVTLF9hHjqQNHCGy2/vgoaYyC07oUDokVZE5FZZ3g
         CrzA==
X-Gm-Message-State: APt69E34ihpL21PE1HL8bPbhx4fGPwWl4Pakh0b8EW4fbd/7hN5ybvwm
        b7niHXhci2OOkJmzGoNkRoA=
X-Google-Smtp-Source: ADUXVKKBvprcfJA+JfO+AxXxR/Q/0sxb4jG8SegFVfKlxLNIGz8ErLRRJ7WLHPELVXbB/b8gZ3VXjA==
X-Received: by 2002:a63:6f8d:: with SMTP id k135-v6mr1858560pgc.48.1528778915085;
        Mon, 11 Jun 2018 21:48:35 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id j19-v6sm26279997pfi.84.2018.06.11.21.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:48:34 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla4xxx: add error handling for try_module_get
Date:   Tue, 12 Jun 2018 12:48:29 +0800
Message-Id: <1528778910-42113-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When try_module_get fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling try_module_get.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 0e13349..6b677ab 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -7687,7 +7687,10 @@ static int qla4xxx_sysfs_ddb_logout_sid(struct iscsi_cls_session *cls_sess)
 	 * to be seamless without actually destroying the
 	 * session
 	 **/
-	try_module_get(qla4xxx_iscsi_transport.owner);
+	if (!try_module_get(qla4xxx_iscsi_transport.owner))
+		ql4_printk(KERN_WARNING, ha,
+			"%s: cannot get module.\n", __func__);
+
 	iscsi_destroy_endpoint(ddb_entry->conn->ep);
 
 	spin_lock_irqsave(&ha->hardware_lock, flags);
@@ -8970,7 +8973,9 @@ static void qla4xxx_destroy_fw_ddb_session(struct scsi_qla_host *ha)
 			 * to be seamless without actually destroying the
 			 * session
 			 **/
-			try_module_get(qla4xxx_iscsi_transport.owner);
+			if (!try_module_get(qla4xxx_iscsi_transport.owner))
+				ql4_printk(KERN_WARNING, ha,
+					"%s: cannot get module.\n", __func__);
 			iscsi_destroy_endpoint(ddb_entry->conn->ep);
 			qla4xxx_free_ddb(ha, ddb_entry);
 			iscsi_session_teardown(ddb_entry->sess);
-- 
2.7.4

