Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40737C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BA520827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="yViJVCvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BA520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeKEVqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:46:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41349 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbeKEVqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:46:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id c25-v6so7289742edt.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SBI5wmJR3GrCOuVAoVisL6o6BQzzsk47CQDsKZGf3JU=;
        b=yViJVCvIpa/MIRdTSmN11wUdmGX6zk7Twps88VA2eK5t0/IggmgRUUQ/C1Vt/iaVPg
         cTORBnBuR3dSXdu+emG6HozYCmBxWI67+IrMOss0tuimS6DE5BUteo1NGxE4WebtpCF0
         kWE8sO6hUifRXuma8fEgBHVw+vz1pY4xcZEdNHmDnCnqoR13lqB07B+mlHvOnBMCTDp9
         zL3BkMDGVZYpm/XMzAqCtn8ZG3CBMnM38sQnNxfTNH2R5iyjpXHh4YUT2fK9VXNZs+lY
         fuwWytEZI9TkfVKaXo3u5l8EPsUR0F/1OYI882ZvpUjHyhKf/kNYdFtBV8sRamHH6fQM
         aNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SBI5wmJR3GrCOuVAoVisL6o6BQzzsk47CQDsKZGf3JU=;
        b=FDSES0qcjR8wNmQ9pMd4Zd/4Bfqn8J4ilUzPlOFV2qQyC7hGIG5FXmhmtk4b9QaVMH
         +k9dYPjLvd5hUNnBYI0S9QKlNVcseAOKSRi6tl3ncvVYgDsLR5StTp5ToYu/+TyqHPW8
         yTZEDStun5um0vjztlPNP24q1vHh2ccfLBp/xP8QB2CsCFmfGOx5CCmXuROS5pAV7rFW
         IyaN2vuc0jcVjd35cJgHwL69pKT0VuSo5/PcBMRPyYgTdmI+DXBO/WlyAV3H179cAY/X
         RPaT+S+LrNRcU9XGISAnzB4dy158kS2+1HRTL+7i8e+z9lBBryRFNBvhmSfmgJUY+XF5
         KPpg==
X-Gm-Message-State: AGRZ1gJzvgQFMacCrQBOt9MZibO50h6PawzkQ0ssAa5L5LAzIIGKYWjM
        4vD/LvZ7Wsc7OEnTpOwGjdW4HQ==
X-Google-Smtp-Source: AJdET5cuRs3qouhWGwILRbVwzlGeUX6O4tzs5q87eYFWeeWF3hLt4heEFCwd3H5EjmCKGnIFJEb86w==
X-Received: by 2002:a17:906:4e14:: with SMTP id z20-v6mr13554086eju.187.1541420809369;
        Mon, 05 Nov 2018 04:26:49 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 9-v6sm7046056ejw.46.2018.11.05.04.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 04:26:48 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 6/7] lightnvm: pblk: fix pblk_lines_init error handling path
Date:   Mon,  5 Nov 2018 13:26:09 +0100
Message-Id: <20181105122610.1555-7-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The chunk metadata is allocated with vmalloc, so we need to use
vfree to free it.

Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 33c1e83327c3..ae9686b5d521 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1053,7 +1053,7 @@ static int pblk_lines_init(struct pblk *pblk)
 		pblk_line_meta_free(l_mg, &pblk->lines[i]);
 	kfree(pblk->lines);
 fail_free_chunk_meta:
-	kfree(chunk_meta);
+	vfree(chunk_meta);
 fail_free_luns:
 	kfree(pblk->luns);
 fail_free_meta:
-- 
2.17.1

