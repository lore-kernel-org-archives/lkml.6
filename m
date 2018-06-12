Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7ECA4C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EA220693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNRo7INp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EA220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeFLDiT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:38:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34703 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932650AbeFLDiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:38:17 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so13547349plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zYdq2o2hPEivRFoImDEtISLRjqAIs4y06nKopbM5QEg=;
        b=QNRo7INpqccpgrpZiT2ibtfh2FH0SpCCHMPvqRs8TSt3wRMEtDELTU1+HITGSPJDPo
         j18nzWyf76WuR6Z5eKQIpkVHZvylmZkKO2aAavl1xR0XkMBMt8CeF+DZTNa5vHutGziK
         K2wHHx/pihtgRDLyog90xF0ghEti3Z8TD5A1SUY0fOlNUdZ2dCKwzu1gfSR+MBfnwd78
         nQRwxwpl9gkFg0EFQIBb8v7j77M0Fh0xP5lJ335g/HkLZXMCgZkQrn2XlR2WNkl2OiTZ
         jnnyNY6pX3aRKib59HH1izpsRx60I71Lh6NBUAmHve8r8w9H7F/Ll7nf9c7zUQFCV5Cx
         C06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zYdq2o2hPEivRFoImDEtISLRjqAIs4y06nKopbM5QEg=;
        b=Xz2ftVMTzc+nDdI2h639U9UhYylkun5Ml2WukZ9vcMyraGsYo/Qd4RQHCicUf0w23e
         U3gCFmDccxivSsyJu5Gvp3IWhTtpHgwHPJ98Nh9W+kj78OwjlFLlj064jT+5JpOIl6KU
         XrMeMEhs934q2iOnSV17B9ZOChG8Gk8lWARNaeUbNofylIfU8lE0myIPfMq3StE57QPM
         /UoxOWK0JAm6h2Mg+GcAcUDBAM47fbAkhVGaA2ahJcMVA3HGV7MjgcNUdWx4pHuOM/18
         +HqcOQ9YTpJw8XFjhexpvEjbZF/XKldnoVq5Q60TlEtwzfhLBJ4/cpyGyD2XdO55AzoK
         cIpA==
X-Gm-Message-State: APt69E2qDYd9G4K0ZI+VM4plblCuQJeXpLyWrGkj3EaNvILaLfA5TQTT
        B41SwfifN0OvXiHIY3pTGI98s4bfCGU=
X-Google-Smtp-Source: ADUXVKK+ln9zbJAscx5ndUOEZwvQy8icx5b5nV+XguzndaNA8xfNdFD2MdtPT0axSg8l8etKw6cefg==
X-Received: by 2002:a17:902:28a6:: with SMTP id f35-v6mr2091371plb.110.1528774697579;
        Mon, 11 Jun 2018 20:38:17 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id g4-v6sm74254933pfg.38.2018.06.11.20.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:38:17 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: add error handling for kmem_cache_zalloc
Date:   Tue, 12 Jun 2018 11:38:12 +0800
Message-Id: <1528774692-38990-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmem_cache_zalloc fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kmem_cache_zalloc.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 fs/gfs2/trans.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 064c9a0..da81eb4 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -130,6 +130,9 @@ static struct gfs2_bufdata *gfs2_alloc_bufdata(struct gfs2_glock *gl,
 	struct gfs2_bufdata *bd;
 
 	bd = kmem_cache_zalloc(gfs2_bufdata_cachep, GFP_NOFS | __GFP_NOFAIL);
+	if (!bd)
+		return NULL;
+
 	bd->bd_bh = bh;
 	bd->bd_gl = gl;
 	bd->bd_ops = lops;
-- 
2.7.4

