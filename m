Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC63C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3240F2147E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQwfadr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3240F2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJQICM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:02:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38598 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:02:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id 204-v6so15368888qkd.5;
        Tue, 16 Oct 2018 17:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Du6wml9VVnou4jAkLBGM3hlzod6FF9zbSLCzf+JCveM=;
        b=fQwfadr91a5AmyHL08cXCsMHfp0fqJCUcmYZiXoprz3VziZ5qrrfnU5tEQJYzMh+HK
         /X06MimgPOluZywapGGBft4kszDXVnOfsgbQNNTxLhZ2dQgzoJGcWTJbnwNuCC/x/Vwc
         eKsIkHXneVtPRYGuQrtcBbaqSXnNDiVoMvsvpDjvukqUEAK0FLmBpFjyPioRX857h4jP
         2Lzqf+3SUYN/drc2FJWI86kFFXA3fl/fXOy24COSX5fACIUOVxHXsk0NMTGIdx1rlbn/
         fSqWqh8r5xY7ASkR3udc4qN4APAvX2qVF8vSrgojwOFUItzKGJIywZGFAyBSEQgFdmDv
         6M2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Du6wml9VVnou4jAkLBGM3hlzod6FF9zbSLCzf+JCveM=;
        b=D4GB1H6KszFK92T/8nCdD0L18AUhTo1bidV8RlF4xH5q6QjlX7HJN2DhwQuPZETcno
         KlmX6DRP8m7zMKWjQNwvNb43PRqu+jDRBr0Ar1KPtS+I4LLt2YQE7YkvSa9yi5fTN7NF
         vYTGMYzFVnFN8p6OqtDMRWj5nJ+m69CUiJX4GAdwgZBG9omUeV+lpLeFLc4OV/9Uo/Ch
         EP10+sNUc7TV0nQMcRga2gjyuBUYyF3B4fgX8DT805oCgFEbcQovSOV3yug5VAXktgNy
         3JGoPGLT5RUOjdRYe4/d0dZRFmHAZ5V5cO7Yx33RRNiEcWnEXQdYkv56hoY0VAIZmYYr
         0G9A==
X-Gm-Message-State: ABuFfojADJwStt81tNPCl15XjMwgWwgFKJRUPaWeOTa0lLlvCOsH1UR1
        SOrLmxxo00+Ir8gXkPHJOiVYCaRQ
X-Google-Smtp-Source: ACcGV60Kx2VZtZjsmf8vexcO8pwt5URdSQ4/2O0lQOTObvxA2XSWV63/+U2AFS2ZLWJCJUJZYdC9lA==
X-Received: by 2002:a37:2d46:: with SMTP id t67-v6mr22525808qkh.351.1539734957923;
        Tue, 16 Oct 2018 17:09:17 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id a72-v6sm8297662qkc.19.2018.10.16.17.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:09:17 -0700 (PDT)
Date:   Tue, 16 Oct 2018 21:09:12 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 3/4] kbuild: Removes unnecessary shadowed local variable and
 optimize testing.
Message-ID: <20181017000912.GA21339@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Removes an unnecessary shadowed local variable (start).
    Optimize test of isdigit:
    - If isalpha returns true, isdigit will return false, so no need to test.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 scripts/asn1_compiler.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index c146020fc783..08bb6e5fd6ad 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
 
 			/* Handle string tokens */
 			if (isalpha(*p)) {
-				const char **dir, *start = p;
+				const char **dir;
 
 				/* Can be a directive, type name or element
 				 * name.  Find the end of the name.
@@ -454,10 +454,9 @@ static void tokenise(char *buffer, char *end)
 
 				tokens[tix++].token_type = TOKEN_TYPE_NAME;
 				continue;
-			}
+			} else if (isdigit(*p)) {
+				/* Handle numbers */
 
-			/* Handle numbers */
-			if (isdigit(*p)) {
 				/* Find the end of the number */
 				q = p + 1;
 				while (q < nl && (isdigit(*q)))
-- 
2.19.1

