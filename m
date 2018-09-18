Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8792133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/3St57P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8792133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeISEe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:34:56 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:41160 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeISEez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:34:55 -0400
Received: by mail-qk1-f177.google.com with SMTP id n3-v6so1521829qkn.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=PMBhSsUTwZQfsvYWSUIflvFWLLu4tkrVGV+SyhSri1Y=;
        b=d/3St57PTZc6V9kyW3cFctYZex1GnJ3N7fStalW+kIxBueE4oP58qAAomeQmQkm8JC
         yDdaJea9lTIJtWmKjUMi/9soCgtolIXmPnFlN36zdopoyLOtRgFELL63CnpjE7kkDJ4/
         Ke/5Culie2XQiA/NKJPlaY4aU7huggesD+w087iIDIga1LhvSLTWhP46Rxlp+nJvbUKT
         pUjgzUu6CDvnNu7W4FxCVCNqTrX9gBaU3OLpaZ7yr4UYj1fFY92v5TTw11rV4Vm5aveq
         ee6QGWPxpl5ZQLMuB1KJ72wt61KZx55z/sSZ9F0gBOwhqV1ToQ11XwdMol0qHZJPtxpH
         Bs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=PMBhSsUTwZQfsvYWSUIflvFWLLu4tkrVGV+SyhSri1Y=;
        b=AK6AmMlQo8FjD1BhfFarjwT2AzJxRz8nUITWpaPwebqp4ny5X7GT6u1ZuMS2PO4tHK
         TRkUM8TQaHCcdSeLLE5NYcbxDMFppvaduPci/2MF3I0HaVHaBeVAGoyxGxCRj6ogq6gc
         +n+g7kA4qUX4BJIn4QwAQw9U//bOf7D7YqXZAQnw8pxiif+neQp97PyELOjYN2gdZO7N
         Rla36zBfQfk8CHDxQrJl46ZHoVRBcxqYOyeEr8Sj2s3Jl0lAvGGszYEXxsj79PDbhuXZ
         wTlKRRnGNGiVm3/SBt8zgOrm7mYefrzoG53jDFgW7N3/oj9aMCBfMumDoJWX+WXMKr6x
         ZovQ==
X-Gm-Message-State: APzg51AlZXSNcMfZBT6rE+Mu604MSjf8iKphivbgETixRh0tAnTEHdaP
        ljou2IfVHCzBgjxDp9tEwrc=
X-Google-Smtp-Source: ANB0Vda+fX0ds6HRk24A0sQR2sgBQzlSrKsl+qhKvwBE0RsDSUOX3t2lK5bpkztMSZ8wRB3DmwTqxg==
X-Received: by 2002:a37:c15:: with SMTP id 21-v6mr21924591qkm.95.1537311606096;
        Tue, 18 Sep 2018 16:00:06 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id 127-v6sm10815633qke.94.2018.09.18.16.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 16:00:05 -0700 (PDT)
Date:   Tue, 18 Sep 2018 20:00:02 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] kbuild: Optimize tests and remove shadowed local
 variable.
Message-ID: <20180918230002.GA7572@WindFlash>
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
 scripts/asn1_compiler.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index c146020fc783..a0056df4e358 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
 
 			/* Handle string tokens */
 			if (isalpha(*p)) {
-				const char **dir, *start = p;
+				const char **dir;
 
 				/* Can be a directive, type name or element
 				 * name.  Find the end of the name.
@@ -454,10 +454,10 @@ static void tokenise(char *buffer, char *end)
 
 				tokens[tix++].token_type = TOKEN_TYPE_NAME;
 				continue;
-			}
 
-			/* Handle numbers */
-			if (isdigit(*p)) {
+			} else if (isdigit(*p)) {
+				/* Handle numbers */
+
 				/* Find the end of the number */
 				q = p + 1;
 				while (q < nl && (isdigit(*q)))
-- 
2.19.0

