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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFEAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F49B215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR52nlSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F49B215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeI1GSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:18:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44009 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeI1GSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:18:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id z14-v6so4403783wrs.10;
        Thu, 27 Sep 2018 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SN+JYmJRqYokRoD2ZgX9a7MU1MsQLO/fU4W70YYMQV8=;
        b=UR52nlSXceCiiZT+WWYZ8xTIemuxiT4AC6YezGcHljuPvtfkOlLemWJIblixc+BpPc
         GDoLfslUrdX/9M7jQ3VOBpxKwClRpc12IbDLXl1j8vjMKDqd7E7kY07G/FhVbKNDYirc
         5PYsxpIY/GRUMPVc8Kdm7hkSTp4ACcmbZamI1kvcFhfjd4QVHcna6LG0b4JHTxOi9Phs
         5nXVb2/KrckckpZqhf7CjO08HRWjxUzlLaSfx1NiybkgnMMKc0jdh+NbgDlPAujA8JMb
         lKzrWMOID54mcaTSl3TQcii9xVheXlOYN0ksHVTnAro95Nfn8QwcWx2BMCLi6eS9mcxf
         zYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SN+JYmJRqYokRoD2ZgX9a7MU1MsQLO/fU4W70YYMQV8=;
        b=ioDXoBwUjU03QqiJRYu238lc7/LAd3ZVloErJg697kRGiIAAkIA78CkYKWKXvcuwfG
         33+fotkwZUJHt4NAPETqVRJ/6nXVJOIjGPhqFvYghT5oCZWlConzZ0PwZoIk7phr6PO8
         nHqPKUwQBAPiO5cQW4tqVrfSfhbD+7wHk7KswZSwYZmpazWgxlLTs/OdQ4acguFnGvcv
         rtU347Ey2Ebay2qW7n9CcSNbWZ+hIZJzNYskLHUqdLHxnadYY97UFqkODTEZmuZeApte
         m6tF7kGJYJa8X+KxrXpK1ysavuiBBr3mJZqYAotxU4amvk6FzSUyxxnc5dlibhrItO1J
         gapQ==
X-Gm-Message-State: ABuFfogGzplXws/GUAiHp6wzC7ra+WcdeJjk2uBYNDnahtjwDnm0T1Tb
        7+xYwvvpuOtwtH/cX2hnuP0=
X-Google-Smtp-Source: ACcGV60kaHwyUQYovqNXNx7Y77ImqnAiFmmMMR0g0xhkTOXELZF9RDMNGnusxi4VgUHX3Kr7NqB43w==
X-Received: by 2002:adf:8567:: with SMTP id 94-v6mr10797806wrh.223.1538092667288;
        Thu, 27 Sep 2018 16:57:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v10-v6sm3332687wrp.0.2018.09.27.16.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 16:57:46 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] scsi: bfa: Avoid implicit enum conversion in bfad_im_post_vendor_event
Date:   Thu, 27 Sep 2018 16:56:52 -0700
Message-Id: <20180927235651.27151-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926045435.9213-1-natechancellor@gmail.com>
References: <20180926045435.9213-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/scsi/bfa/bfa_fcs_lport.c:379:26: warning: implicit conversion
from enumeration type 'enum bfa_lport_aen_event' to different
enumeration type 'enum bfa_ioc_aen_event' [-Wenum-conversion]
                                  BFA_AEN_CAT_LPORT, event);
                                                     ^~~~~

The root cause of these warnings is the bfad_im_post_vendor_event
function, which expects a value from enum bfa_ioc_aen_event but there
are multiple instances of values from enums bfa_port_aen_event,
bfa_audit_aen_event, and bfa_lport_aen_event being used in this
function.

Given that this doesn't appear to be a problem since cat helps with
differentiating the events, just change evt's type to int so that no
conversion needs to happen and Clang won't warn. Update aen_type's type
in bfa_aen_entry_s as members that hold enumerated types should be int.

Link: https://github.com/ClangBuiltLinux/linux/issues/147
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Update aen_type's type in bfa_aen_entry_s to match evt

 drivers/scsi/bfa/bfa_defs_svc.h | 2 +-
 drivers/scsi/bfa/bfad_im.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_defs_svc.h b/drivers/scsi/bfa/bfa_defs_svc.h
index 3d0c96a5c873..c19c26e0e405 100644
--- a/drivers/scsi/bfa/bfa_defs_svc.h
+++ b/drivers/scsi/bfa/bfa_defs_svc.h
@@ -1453,7 +1453,7 @@ union bfa_aen_data_u {
 struct bfa_aen_entry_s {
 	struct list_head	qe;
 	enum bfa_aen_category   aen_category;
-	u32                     aen_type;
+	int                     aen_type;
 	union bfa_aen_data_u    aen_data;
 	u64			aen_tv_sec;
 	u64			aen_tv_usec;
diff --git a/drivers/scsi/bfa/bfad_im.h b/drivers/scsi/bfa/bfad_im.h
index e61ed8dad0b4..bd4ac187fd8e 100644
--- a/drivers/scsi/bfa/bfad_im.h
+++ b/drivers/scsi/bfa/bfad_im.h
@@ -143,7 +143,7 @@ struct bfad_im_s {
 static inline void bfad_im_post_vendor_event(struct bfa_aen_entry_s *entry,
 					     struct bfad_s *drv, int cnt,
 					     enum bfa_aen_category cat,
-					     enum bfa_ioc_aen_event evt)
+					     int evt)
 {
 	struct timespec64 ts;
 
-- 
2.19.0

