Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD8DECDE47
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3211020848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="c98StoaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3211020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeJ0Civ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:38:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33593 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ0Ciu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:38:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id a15-v6so933523pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqABpBpIahc6OG3vTXFx/efs5bgxNl0HcieUfpbSnfY=;
        b=c98StoaSO54uGYVdXzXR8PIiWEzkY54kAVnB9UqcPsBS6R8cRiGMs6qO/H/L4CM7ai
         vTaT2YKiFTpun5/LTtQfUz0I3Y9BugoYcxjBYbhq3Qr+5HJ1RVefkhSGZkBQrDG3iyz/
         xgX6k7I4yKu7lPtcDp9vYBcG+Gi3ivzKUWZVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqABpBpIahc6OG3vTXFx/efs5bgxNl0HcieUfpbSnfY=;
        b=bBeRMemolawBdp468542KLsNctbE9jFel17JJF2YOQjKtl2wPaLplUvXLiOQ5vYkqQ
         JlKMTRc/TfNw4vI7M+6cJkhRaIy42Bxr8ZpP73qSDBdfy4se4A5ZeIcVWbbe/DMaNYez
         PdDW+FIivyHlq4ulQDDonD9E8te1mRIifcY74XDTFOfd3TM3Qq1KZ3eAS/4onL/HxZc9
         EGyt8hlpQVjxv7XV8VAiKGoyXyHFnSp5EXvzev+WbvQM0lldZeCCqly/EkcCBbF4tVQe
         Ik9+lwRybg60Z68B6hjD4jdBEkfBy+HZyqoj+tyFolVuyYCDi2lfXHtHrafc+Bz/Engj
         vbKA==
X-Gm-Message-State: AGRZ1gJfb7uE5fzBCne9wH17cSl0Jfzg+TTUGcQaHSfr6ofmVYJmGJb8
        lis9YkNjw68EpAT3oQ4JYAnW1HgiTdU=
X-Google-Smtp-Source: AJdET5c08NBVrkqH9cgPjGfpQqqgxwdRyetpuss23IdKgvXODPUb8s+jkAhCBrAmMuyAOHqYAqWYVg==
X-Received: by 2002:a63:40c2:: with SMTP id n185-v6mr4496695pga.116.1540576851370;
        Fri, 26 Oct 2018 11:00:51 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id v5-v6sm17521243pfd.64.2018.10.26.11.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 11:00:50 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC 2/6] pstore: remove type argument from ramoops_get_next_prz
Date:   Fri, 26 Oct 2018 11:00:38 -0700
Message-Id: <20181026180042.52199-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181026180042.52199-1-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we store the type of the prz when we initialize it, we no longer
need to pass it again in ramoops_get_next_prz since we can just use that
to setup the pstore record. So lets remove it from the argument list.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/ram.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index c7cd858adce7..cbfdf4b8e89d 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -125,9 +125,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
 
 static struct persistent_ram_zone *
 ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
-		     u64 *id,
-		     enum pstore_type_id *typep, enum pstore_type_id type,
-		     bool update)
+		     u64 *id, enum pstore_type_id *typep, bool update)
 {
 	struct persistent_ram_zone *prz;
 	int i = (*c)++;
@@ -147,7 +145,7 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
 	if (!persistent_ram_old_size(prz))
 		return NULL;
 
-	*typep = type;
+	*typep = prz->type;
 	*id = i;
 
 	return prz;
@@ -257,8 +255,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 	while (cxt->dump_read_cnt < cxt->max_dump_cnt && !prz) {
 		prz = ramoops_get_next_prz(cxt->dprzs, &cxt->dump_read_cnt,
 					   cxt->max_dump_cnt, &record->id,
-					   &record->type,
-					   PSTORE_TYPE_DMESG, 1);
+					   &record->type, 1);
 		if (!prz_ok(prz))
 			continue;
 		header_length = ramoops_read_kmsg_hdr(persistent_ram_old(prz),
@@ -274,20 +271,18 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 
 	if (!prz_ok(prz))
 		prz = ramoops_get_next_prz(&cxt->cprz, &cxt->console_read_cnt,
-					   1, &record->id, &record->type,
-					   PSTORE_TYPE_CONSOLE, 0);
+					   1, &record->id, &record->type, 0);
 
 	if (!prz_ok(prz))
 		prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
-					   1, &record->id, &record->type,
-					   PSTORE_TYPE_PMSG, 0);
+					   1, &record->id, &record->type, 0);
 
 	/* ftrace is last since it may want to dynamically allocate memory. */
 	if (!prz_ok(prz)) {
 		if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)) {
 			prz = ramoops_get_next_prz(cxt->fprzs,
 					&cxt->ftrace_read_cnt, 1, &record->id,
-					&record->type, PSTORE_TYPE_FTRACE, 0);
+					&record->type, 0);
 		} else {
 			/*
 			 * Build a new dummy record which combines all the
@@ -306,8 +301,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 						&cxt->ftrace_read_cnt,
 						cxt->max_ftrace_cnt,
 						&record->id,
-						&record->type,
-						PSTORE_TYPE_FTRACE, 0);
+						&record->type, 0);
 
 				if (!prz_ok(prz_next))
 					continue;
-- 
2.19.1.568.g152ad8e336-goog

