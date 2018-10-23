Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C914C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43D720674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVaqH2z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43D720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJWJb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:31:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42465 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:31:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id u20-v6so12087587qkk.9;
        Mon, 22 Oct 2018 18:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=FBQw2s4pCChAO/X8Yk6XewgTMXo6hSZSprD6cHrH444=;
        b=dVaqH2z8f6Jr79Bm1JILsdyPdTPdyp/GDElric1ill4oJ0DfHXlgnJH+y5h71rwDqU
         6lpoOARFbx/VBY5f6ystB6ZazCRHH6EeJd+J+2ohn14RZylTFH30rLJ7pRTbompquGt2
         TbjUc/afAJ5OhxQ1SKcjbhfNan3KII2rFx92+7ra62D3ULcx+/XTptHXvGHm0aQcB/Yg
         IUkLo/r2/nT4qJYu9OSuJuGCKmA8t90FEklldEAsAraZl4KVRQRq46JTP7jb6OFYkpKp
         9EFsqKACWd07cXUtjx1mFGa41Au2lChWW80LqnrjGAVRnX6aaD2YC9ApN2fz0OVEJkDM
         Ugaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=FBQw2s4pCChAO/X8Yk6XewgTMXo6hSZSprD6cHrH444=;
        b=nJ8NTFLqJEPGUT9++OV9txZkEGnklzZ37hD6B/EickxnXrgF3k8wkzbOm24v35Lefe
         6XcRGDjBzxuc67HMxuBnsJ0UBKzmi6WTSdROxkKu3NepN+lZx6/EVaFKeq5Iiy+jE2r+
         E58BphD/rbBCn6aY7GyDVScSvkA7iOXTuz7dXDmUhdOrbjZ3lP1pwEcG0M35B+tzukPY
         qzYGYzFO98nVVB+TBhInyHOuPcR3tRtUfXS7eZuzUU59sAJ0D4HcbnboWAhjfZw9+xIQ
         yex37IL+UHXuP4f8m37jKtEXAEKUwdMVHNCnseANsjBeB7xDBvMcfWqOKPMh3NgdF7AJ
         /kDQ==
X-Gm-Message-State: ABuFfojVqPaBO/Z19wCSbnDazmaOYTG+quCCHmtTviAEDn1CrkEjhtxQ
        c5Q7JO2oIAC8FMm/h4HPmwI=
X-Google-Smtp-Source: ACcGV60z0x23bGU9TqTbrAgrx4O9pG0W3MZ0QIxfBzoBQzi3P++5fjvN78e94SPVgcGGbn4nfAAOlA==
X-Received: by 2002:a37:30d4:: with SMTP id w203-v6mr44203494qkw.106.1540257059028;
        Mon, 22 Oct 2018 18:10:59 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id 83sm3056255qkz.73.2018.10.22.18.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 18:10:58 -0700 (PDT)
Date:   Mon, 22 Oct 2018 22:10:52 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] modpost: Changes parameter name to avoid shadowing.
Message-ID: <20181023011052.GA6584@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the parameter name to avoid shadowing a variable.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0d998c54564d..368fe42340df 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2228,13 +2228,13 @@ static int add_versions(struct buffer *b, struct module *mod)
 }
 
 static void add_depends(struct buffer *b, struct module *mod,
-			struct module *modules)
+			struct module *module_list)
 {
 	struct symbol *s;
 	struct module *m;
 	int first = 1;
 
-	for (m = modules; m; m = m->next)
+	for (m = module_list; m; m = m->next)
 		m->seen = is_vmlinux(m->name);
 
 	buf_printf(b, "\n");
-- 
2.19.1

