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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E220C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBC021525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuIvp7I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBC021525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbeIUEsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:48:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38254 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeIUEsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:48:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id t25-v6so1184932wmi.3;
        Thu, 20 Sep 2018 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkPypl0PFbIXh7stE5Dd5kMzzdHa3nmYxj9+3wcehLI=;
        b=OuIvp7I7eOiITV1dra1PVDVhFdAP9fu0KaXNjcwI5k2gmUod8NF8p6ua4NLLK4iL2W
         itIF98+yQmbQ1trBorlunRhZk4QWeGPqIRcDP6+I92iaTOk6B3hZ6ctwvTr71tJNadmv
         jgXsIHVnQLzV4f/NYt5r54J5SulgEL3WWfejZV6Iw4nlwQQSvda/tN7YITEtsYbaodAr
         yiNjHU5vDS3BPVKMm7YjtTWTXAh8lTTEpnj/3gzPMn3XLqjFXSP8xq8/TNY9NeOzdJhL
         7B1pPJTgIqMvLHZGpx3GiwRmGRFFNtsH286gs84G8+NeAXqyqjnBNozESDJd1c4Axl0i
         Ii2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkPypl0PFbIXh7stE5Dd5kMzzdHa3nmYxj9+3wcehLI=;
        b=oqNjkhlLJcZWU9eAjENM6+uVhFqJGIHgWh1sU1vhB7VLSAcFXsgHUVr1LdE33VhJ1X
         7tK3RwKEMpFEgyRZZUtPTbZmKYlC0IJVFuJXTonB5k6oXGm7fWUTDUZuI7XICmKl7umJ
         S1NEHfSbkYi30RHlXLBYuDScWZvFnEVIjHJsBCdbQWW9NLtXdYp2BMXgo8JQSUk+6LiW
         8p6pxovcMZ9gJCAP1JexIoe989TkEllw2z7Wad/09fH16ZoPeSOnkxPifw8raUugTgPr
         8e8R/x7ARunCfMF5QeBPSpqZzMbAlNM3y09eFOgVyhPdZEYpBYNtOWHI1Dz6apc2lKWp
         wVhg==
X-Gm-Message-State: APzg51At7GCdNMAhZIjGbFQhiBkowNZPMkIPCgJdmW6XbZUDvXjlP6TW
        bRfYL/kTGTsV5/FjQDF42HE=
X-Google-Smtp-Source: ANB0VdaRBRL4rF8/40jFnrVUXxWq0xNNVoYINasYViJsKYv7CKDsHOy+c8Lj+5Fp85cmNT96CR3T6w==
X-Received: by 2002:a1c:ee57:: with SMTP id m84-v6mr4578481wmh.9.1537484541047;
        Thu, 20 Sep 2018 16:02:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h206-v6sm4305761wmf.25.2018.09.20.16.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 16:02:20 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: bfa: Remove unused functions
Date:   Thu, 20 Sep 2018 16:02:12 -0700
Message-Id: <20180920230212.22227-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a variable is assigned to itself.

drivers/scsi/bfa/bfa_fcbuild.c:199:6: warning: explicitly assigning
value of variable of type 'int' to itself [-Wself-assign]
        len = len;
        ~~~ ^ ~~~
drivers/scsi/bfa/bfa_fcbuild.c:838:6: warning: explicitly assigning
value of variable of type 'int' to itself [-Wself-assign]
        len = len;
        ~~~ ^ ~~~
drivers/scsi/bfa/bfa_fcbuild.c:917:6: warning: explicitly assigning
value of variable of type 'int' to itself [-Wself-assign]
        len = len;
        ~~~ ^ ~~~
drivers/scsi/bfa/bfa_fcbuild.c:981:6: warning: explicitly assigning
value of variable of type 'int' to itself [-Wself-assign]
        len = len;
        ~~~ ^ ~~~
drivers/scsi/bfa/bfa_fcbuild.c:1008:6: warning: explicitly assigning
value of variable of type 'int' to itself [-Wself-assign]
        len = len;
        ~~~ ^ ~~~
5 warnings generated.

This construct is usually used to avoid unused variable warnings, which
I assume is the case here. -Wunused-parameter is hidden behind -Wextra
with GCC 4.6, which is the minimum version to compile the kernel as of
commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6").

However, upon further inspection, these functions aren't actually used
anywhere; they're just defined. Rather than just removing the self
assignments, remove all of this dead code.

Link: https://github.com/ClangBuiltLinux/linux/issues/148
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/bfa/bfa_fcbuild.c | 108 ---------------------------------
 drivers/scsi/bfa/bfa_fcbuild.h |   9 ---
 2 files changed, 117 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcbuild.c b/drivers/scsi/bfa/bfa_fcbuild.c
index d3b00a475aeb..2de5d514e99c 100644
--- a/drivers/scsi/bfa/bfa_fcbuild.c
+++ b/drivers/scsi/bfa/bfa_fcbuild.c
@@ -190,27 +190,6 @@ fc_els_rsp_build(struct fchs_s *fchs, u32 d_id, u32 s_id, __be16 ox_id)
 	fchs->ox_id = ox_id;
 }
 
-enum fc_parse_status
-fc_els_rsp_parse(struct fchs_s *fchs, int len)
-{
-	struct fc_els_cmd_s *els_cmd = (struct fc_els_cmd_s *) (fchs + 1);
-	struct fc_ls_rjt_s *ls_rjt = (struct fc_ls_rjt_s *) els_cmd;
-
-	len = len;
-
-	switch (els_cmd->els_code) {
-	case FC_ELS_LS_RJT:
-		if (ls_rjt->reason_code == FC_LS_RJT_RSN_LOGICAL_BUSY)
-			return FC_PARSE_BUSY;
-		else
-			return FC_PARSE_FAILURE;
-
-	case FC_ELS_ACC:
-		return FC_PARSE_OK;
-	}
-	return FC_PARSE_OK;
-}
-
 static void
 fc_bls_rsp_build(struct fchs_s *fchs, u32 d_id, u32 s_id, __be16 ox_id)
 {
@@ -830,18 +809,6 @@ fc_rpsc_acc_build(struct fchs_s *fchs, struct fc_rpsc_acc_s *rpsc_acc,
 	return sizeof(struct fc_rpsc_acc_s);
 }
 
-u16
-fc_logo_rsp_parse(struct fchs_s *fchs, int len)
-{
-	struct fc_els_cmd_s *els_cmd = (struct fc_els_cmd_s *) (fchs + 1);
-
-	len = len;
-	if (els_cmd->els_code != FC_ELS_ACC)
-		return FC_PARSE_FAILURE;
-
-	return FC_PARSE_OK;
-}
-
 u16
 fc_pdisc_build(struct fchs_s *fchs, u32 d_id, u32 s_id, u16 ox_id,
 	       wwn_t port_name, wwn_t node_name, u16 pdu_size)
@@ -907,40 +874,6 @@ fc_prlo_build(struct fchs_s *fchs, u32 d_id, u32 s_id, u16 ox_id,
 	return be16_to_cpu(prlo->payload_len);
 }
 
-u16
-fc_prlo_rsp_parse(struct fchs_s *fchs, int len)
-{
-	struct fc_prlo_acc_s *prlo = (struct fc_prlo_acc_s *) (fchs + 1);
-	int             num_pages = 0;
-	int             page = 0;
-
-	len = len;
-
-	if (prlo->command != FC_ELS_ACC)
-		return FC_PARSE_FAILURE;
-
-	num_pages = ((be16_to_cpu(prlo->payload_len)) - 4) / 16;
-
-	for (page = 0; page < num_pages; page++) {
-		if (prlo->prlo_acc_params[page].type != FC_TYPE_FCP)
-			return FC_PARSE_FAILURE;
-
-		if (prlo->prlo_acc_params[page].opa_valid != 0)
-			return FC_PARSE_FAILURE;
-
-		if (prlo->prlo_acc_params[page].rpa_valid != 0)
-			return FC_PARSE_FAILURE;
-
-		if (prlo->prlo_acc_params[page].orig_process_assc != 0)
-			return FC_PARSE_FAILURE;
-
-		if (prlo->prlo_acc_params[page].resp_process_assc != 0)
-			return FC_PARSE_FAILURE;
-	}
-	return FC_PARSE_OK;
-
-}
-
 u16
 fc_tprlo_build(struct fchs_s *fchs, u32 d_id, u32 s_id, u16 ox_id,
 	       int num_pages, enum fc_tprlo_type tprlo_type, u32 tpr_id)
@@ -971,47 +904,6 @@ fc_tprlo_build(struct fchs_s *fchs, u32 d_id, u32 s_id, u16 ox_id,
 	return be16_to_cpu(tprlo->payload_len);
 }
 
-u16
-fc_tprlo_rsp_parse(struct fchs_s *fchs, int len)
-{
-	struct fc_tprlo_acc_s *tprlo = (struct fc_tprlo_acc_s *) (fchs + 1);
-	int             num_pages = 0;
-	int             page = 0;
-
-	len = len;
-
-	if (tprlo->command != FC_ELS_ACC)
-		return FC_PARSE_ACC_INVAL;
-
-	num_pages = (be16_to_cpu(tprlo->payload_len) - 4) / 16;
-
-	for (page = 0; page < num_pages; page++) {
-		if (tprlo->tprlo_acc_params[page].type != FC_TYPE_FCP)
-			return FC_PARSE_NOT_FCP;
-		if (tprlo->tprlo_acc_params[page].opa_valid != 0)
-			return FC_PARSE_OPAFLAG_INVAL;
-		if (tprlo->tprlo_acc_params[page].rpa_valid != 0)
-			return FC_PARSE_RPAFLAG_INVAL;
-		if (tprlo->tprlo_acc_params[page].orig_process_assc != 0)
-			return FC_PARSE_OPA_INVAL;
-		if (tprlo->tprlo_acc_params[page].resp_process_assc != 0)
-			return FC_PARSE_RPA_INVAL;
-	}
-	return FC_PARSE_OK;
-}
-
-enum fc_parse_status
-fc_rrq_rsp_parse(struct fchs_s *fchs, int len)
-{
-	struct fc_els_cmd_s *els_cmd = (struct fc_els_cmd_s *) (fchs + 1);
-
-	len = len;
-	if (els_cmd->els_code != FC_ELS_ACC)
-		return FC_PARSE_FAILURE;
-
-	return FC_PARSE_OK;
-}
-
 u16
 fc_ba_rjt_build(struct fchs_s *fchs, u32 d_id, u32 s_id, __be16 ox_id,
 		u32 reason_code, u32 reason_expl)
diff --git a/drivers/scsi/bfa/bfa_fcbuild.h b/drivers/scsi/bfa/bfa_fcbuild.h
index b109a8813401..ac08d0b5b89a 100644
--- a/drivers/scsi/bfa/bfa_fcbuild.h
+++ b/drivers/scsi/bfa/bfa_fcbuild.h
@@ -163,7 +163,6 @@ enum fc_parse_status fc_abts_rsp_parse(struct fchs_s *buf, int len);
 
 u16        fc_rrq_build(struct fchs_s *buf, struct fc_rrq_s *rrq, u32 d_id,
 			     u32 s_id, u16 ox_id, u16 rrq_oxid);
-enum fc_parse_status fc_rrq_rsp_parse(struct fchs_s *buf, int len);
 
 u16        fc_rspnid_build(struct fchs_s *fchs, void *pld, u32 s_id,
 				u16 ox_id, u8 *name);
@@ -276,8 +275,6 @@ void		fc_get_fc4type_bitmask(u8 fc4_type, u8 *bit_mask);
 void		fc_els_req_build(struct fchs_s *fchs, u32 d_id, u32 s_id,
 					 __be16 ox_id);
 
-enum fc_parse_status	fc_els_rsp_parse(struct fchs_s *fchs, int len);
-
 enum fc_parse_status	fc_plogi_rsp_parse(struct fchs_s *fchs, int len,
 					wwn_t port_name);
 
@@ -297,8 +294,6 @@ u16 fc_tprlo_acc_build(struct fchs_s *fchs, struct fc_tprlo_acc_s *tprlo_acc,
 u16 fc_prlo_acc_build(struct fchs_s *fchs, struct fc_prlo_acc_s *prlo_acc,
 		u32 d_id, u32 s_id, __be16 ox_id, int num_pages);
 
-u16 fc_logo_rsp_parse(struct fchs_s *fchs, int len);
-
 u16 fc_pdisc_build(struct fchs_s *fchs, u32 d_id, u32 s_id,
 		u16 ox_id, wwn_t port_name, wwn_t node_name,
 		u16 pdu_size);
@@ -308,14 +303,10 @@ u16 fc_pdisc_rsp_parse(struct fchs_s *fchs, int len, wwn_t port_name);
 u16 fc_prlo_build(struct fchs_s *fchs, u32 d_id, u32 s_id,
 		u16 ox_id, int num_pages);
 
-u16 fc_prlo_rsp_parse(struct fchs_s *fchs, int len);
-
 u16 fc_tprlo_build(struct fchs_s *fchs, u32 d_id, u32 s_id,
 		u16 ox_id, int num_pages, enum fc_tprlo_type tprlo_type,
 		u32 tpr_id);
 
-u16 fc_tprlo_rsp_parse(struct fchs_s *fchs, int len);
-
 u16 fc_ba_rjt_build(struct fchs_s *fchs, u32 d_id, u32 s_id,
 		__be16 ox_id, u32 reason_code, u32 reason_expl);
 
-- 
2.19.0

