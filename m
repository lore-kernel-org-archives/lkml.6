Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC0ECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150FB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="JqjaW9jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150FB20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeIKQei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:34:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46247 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeIKQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:34:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so18944434edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBTCVi2uNTgrxBSOXPkxuViymn5g5y05rXcHoNVxv/M=;
        b=JqjaW9jZsvAS8bxlFD7oXlyxc4A7dI3fwFCP/uSb97xXusDvyjfzIEGHRD9Zbu+mcg
         w4cAIi5VTiGg8sGikMWrCpKmCcO338Uo1Bx7HmoqfiRadFWwmARe+XqZyooLMx6S2HP0
         2B9LVk0EXMiDUsQbOWsgP/85qfvX87KtyEEkyI1MswIhFlM575b6iPq76Wa2HGXxouqH
         fa52GZe7GcpxmsX51zGt1q7eI5tSD2IJIYMLrIccuwceBkT+4yZOJ3OHgKILNpKFmCPv
         uw1cqCXVtHkt2KUTZflHO3SkVD4NpHzRzbOxyfDvCxpikx+pa2oz4xQATQug+P3oMad9
         vDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBTCVi2uNTgrxBSOXPkxuViymn5g5y05rXcHoNVxv/M=;
        b=n8CEkiBTS9OFiHxX9bZsCJXywmqpDPf79MVvY4vyhxu8VPTqpCSqBbB2CuPvirguYV
         wZkk7GKMjo9E4LB3IL8BC1BXKAYaD7miBQK/sMMA5w6KSCcKLhwbpJj33xRzHKepWP5P
         B6CA4MlXtQMILlsTekc5UnLlFg/NkaVPAt5cWIYfaBWeDf5hQxT58QG+mRG6BnYo3fmf
         z6/J7ERkMmJbRqD1MkY8ac87J9op0ROde3xCS+3cJtOxKerzbFR66rc6bn4mOACa3KYX
         LQEWrK7wDJRLS6g7bePFyrbRA3NjkqlDkgis2X2wNm5Jg8dQEE7vWQGuEH6Hwi5tfb+n
         fjzg==
X-Gm-Message-State: APzg51C1j+ixBgWTCB9P8NMTlzz+RGXJEsI8gA0Le/lwbLCoiHaJ7uJt
        YPSe5Etx8DTJYxHduKCJy7B20w==
X-Google-Smtp-Source: ANB0VdbHaCMOILxg/JoMbJyt9Bz3iWwh0ak7VVzUHK30Pyff95K0+KRgRfay1Wgn+Ct+pra6fvcNNg==
X-Received: by 2002:a50:c05a:: with SMTP id u26-v6mr28703678edd.107.1536665741001;
        Tue, 11 Sep 2018 04:35:41 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id n15-v6sm10934976edn.44.2018.09.11.04.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 04:35:40 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/2] lightnvm: pblk: add helper for printing chunk state
Date:   Tue, 11 Sep 2018 13:35:33 +0200
Message-Id: <1536665734-14305-2-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
References: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement pblk helper for printing chunk state.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 3d7248829013..5e4cec453a43 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1230,6 +1230,15 @@ static inline int pblk_io_aligned(struct pblk *pblk, int nr_secs)
 	return !(nr_secs % pblk->min_write_pgs);
 }
 
+static inline void print_chunk(struct pblk *pblk, struct nvm_chk_meta *chk,
+			       char *msg, int error)
+{
+	pblk_err(pblk, "chunk: (%s: %x) s:%d,t:%d,wi:%d,slba:%llu,cnlb:%llu,wp:%llu\n",
+			msg, error,
+			chk->state, chk->type, chk->wi,
+			chk->slba, chk->cnlb, chk->wp);
+}
+
 #ifdef CONFIG_NVM_PBLK_DEBUG
 static inline void print_ppa(struct pblk *pblk, struct ppa_addr *p,
 			     char *msg, int error)
-- 
2.7.4

