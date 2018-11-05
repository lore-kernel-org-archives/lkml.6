Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB0DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87A520854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="p/isB/ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87A520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeKEVqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:46:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35150 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbeKEVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:46:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id d6-v6so7323599edi.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aYpv+KMDP/i822XuAPfSWo4UcCeaEVbMte2++xZ1ARE=;
        b=p/isB/ZHmM9OQxSnxxS1ej9Mp6k0hjsDL/Tud1uZ9nyX8JMCUZpm/vXugixU0PMXTi
         DbHFlGQO4/MNFp6T1+OvYojsslJKZoSpBCm9y3Z0etdGlYesWL029b19ooeAyJw7WGKt
         TkSH7GXo023B4WxdaxqhO2+QLTPNqEoBlLn/MUVkUTpZxRP+qMnKETsfDLT+6WJgFTRa
         Khvou/FQFvwBG/h1CPoPkPlJW8SjAIwms0JhDZ8LwwvKA/hvJ60seth0TRjgavVLrnw+
         driQEnCo/zJlUlg7OjT5rMiMvsueJ1fs95TKSbhhenuWpu6/D8rqKM1dSOQPcc9ON71A
         ccVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aYpv+KMDP/i822XuAPfSWo4UcCeaEVbMte2++xZ1ARE=;
        b=gs6Q4AOzFiB7c3brgyDovYh3hNPynxnHT3MzkZherZzoWQ27Qs942hmAZY+N98SxiV
         HCZ3XNxi1DM9mmAiuuoHTp+nvj6nDrERfHrmyYua/o6qsajWDomlXf9Dwx9gAznOC9Oo
         f2UJi2QVKck0XmmbN8KtcjTsbl60wAWKo3pUXHvEY1lpPzdIO7+DlcpqTFPaFrs5SyCI
         ELtA394HltJZVMV7PqMeZIigTK1IGh7RKm3CY6abYjs54fnjH92tmSWDE5pxfEPpvWKX
         OK7ZOkpuCASqR0JXNM9KaiJT2Kp3KxjiW4wzxnK23a5Xm7j3bjnWS7X1solATlteAuoe
         fctA==
X-Gm-Message-State: AGRZ1gK4MYpacY8gDvin/tybJYSlOyP9Dee90ITYeA7nIFkIbIJGcUwV
        odUJUKVXtzE3O4ZGAkrdOXCdgw==
X-Google-Smtp-Source: AJdET5fKGtnX4gSVPfJFPe0zFSTaXMMEsPVuKSeqk18G5as0jvaeQ+Pc/GxW+WPwoJ3avwN1WiMuXQ==
X-Received: by 2002:a17:906:c7c9:: with SMTP id dc9-v6mr13584726ejb.232.1541420803901;
        Mon, 05 Nov 2018 04:26:43 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 9-v6sm7046056ejw.46.2018.11.05.04.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 04:26:43 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 1/7] lightnvm: pblk: fix resubmission of overwritten write err lbas
Date:   Mon,  5 Nov 2018 13:26:04 +0100
Message-Id: <20181105122610.1555-2-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Make sure we only look up valid lba addresses on the resubmission path.

If an lba is invalidated in the write buffer, that sector will be
submitted to disk(as it is already mapped to a ppa), and that write
might fail, resulting in a crash when trying to look up the lba in the
mapping table (as the lba is marked as invalid).

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index fa8726493b39..3ddd16f47106 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -148,9 +148,11 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		w_ctx = &entry->w_ctx;
 
 		/* Check if the lba has been overwritten */
-		ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
-		if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
-			w_ctx->lba = ADDR_EMPTY;
+		if (w_ctx->lba != ADDR_EMPTY) {
+			ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
+			if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
+				w_ctx->lba = ADDR_EMPTY;
+		}
 
 		/* Mark up the entry as submittable again */
 		flags = READ_ONCE(w_ctx->flags);
-- 
2.17.1

