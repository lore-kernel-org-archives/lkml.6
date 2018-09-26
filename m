Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B3CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D23B20833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQHh3K0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D23B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeIZLJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:09:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37886 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeIZLJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:09:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so25459522wrr.4;
        Tue, 25 Sep 2018 21:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/U/3xhzcXZArG3vw7amUM76vNzuqmicA2916lx0mzM=;
        b=gQHh3K0OyAeJGj/U0JMQgs6VLMjCVSAhfh3zR1vvgXAPOwuo5iOYeIXlUlsoKUVaBE
         2ED4R3pMEsTHv/giP0X8QI4iNvclaf0hH3gHdcBxgtFMQXnuU3GSZxT3f6MJ2yV6FB2T
         y3owipyJAdLvdsgET1H0+kp9exbgfMcDNrzGy+eRYxSmfhYpbEz8IKfDn3amVIrxVCnz
         MRQTtWCrqhRugLcZKbhTjbu4fRk+t6YTHhCp8m++d9m8+SIdztCXHopzCVCL8O54xnwG
         peBL33DB5XOzBeDC8dc9h+vdaDXdZpmRB+tjXgbifLmJnOZ5PHaClYx1lknYXHH0MZLy
         pORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/U/3xhzcXZArG3vw7amUM76vNzuqmicA2916lx0mzM=;
        b=sknTNQyqva3C1UeArJMBlOqO6ii98JY4bsBWhKaCw8+fyyKrazdhyruCmfHyGw0uAm
         u7OhCC1vqx48Fa6bJdUR0jrWuuohm+xERPU/NLV25UR+UAtB7L72+XgUus0ZYAJMoF+n
         P69ZP7xmpUet6Mf+qCnje7C7b1EOuvenDq/c0YRCZZixtMiBU76Q21Yeco2Je/gWcAnc
         qZ12eGddvpDEr65WBCCx09Nv/fcKQ+ka+4g8Y8xu+IfbXgYZvjbUbSGPojlRXeTiFebH
         QUspOFvBnFtbS4/D7PiRTWp2IQIk1vIO/RZYaFRThkxnOE4Sd1qrRDrKKfHnFZ9msxly
         1Dvw==
X-Gm-Message-State: ABuFfohxMbsnNi83sL8pGrvFIjCkbykmzWhfAG8kTPVl70zE/Al1Xeli
        v2mHXzS883hpHDSjWhE7zNs=
X-Google-Smtp-Source: ACcGV62xPe1exZf8YDLILgeirznggUwiTOqXepbuRfOKM0rG0usw9wPSajfT6h+D4z2HGOy17TZT6g==
X-Received: by 2002:adf:e0c4:: with SMTP id e4-v6mr3301233wri.199.1537937917500;
        Tue, 25 Sep 2018 21:58:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k34-v6sm5528710wre.18.2018.09.25.21.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:58:36 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: bfa: Avoid implicit enum conversion in bfad_im_post_vendor_event
Date:   Tue, 25 Sep 2018 21:54:37 -0700
Message-Id: <20180926045435.9213-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
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
conversion needs to happen and Clang won't warn.

Link: https://github.com/ClangBuiltLinux/linux/issues/147
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

The alternate way of fixing these warnings is to explicitly cast the
conversion when calling the function but since there are about 8-10 of
these warnings, it seems logical to just change the function definiton
which is cleaner in my opinion.

See commits 3eb95feac113 ("mm/zsmalloc.c: change stat type parameter to
int") and 04fecbf51b3c ("mm: memcontrol: use int for event/state
parameter in several functions") for similar fixes.

 drivers/scsi/bfa/bfad_im.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

