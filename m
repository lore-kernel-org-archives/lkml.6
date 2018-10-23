Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E274DC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B6B20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC+hhINN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B6B20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeJWJbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:31:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36218 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:31:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34-v6so48717091qth.3;
        Mon, 22 Oct 2018 18:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=3nnNuMN0DgpLvFEqoDh+yamiGrzV6ATAjSjzW+TOOZ4=;
        b=nC+hhINNkswG+e80IHjAG8bda0ldKWXoFt5/UFsVEfA13jxY0aIkdRAjzypFDrpKmH
         ov/7mKYiA7SSbg/WmurDOb6T1OygHY6BZmAIz55pPAxl9dfK/ivuOruSwNlIDZE+eJJN
         PH/uDDAC9VaVohPsKTcewrywuMCKjAwD3hep9kNTjsYLCqOm1aGgKBEjy9+W8/a111i4
         IyBLRFrU3zRbyHdPvjeWyypvyyUa+A+kqHgDyDmcNCBDdv7HvGKP7mQq5UFVlHOU0xaG
         CAbeIz7vXCsX582aOrd7BfwnkIirhaL7SNpsS430+8QWx81C0+OifEyG6J7ma52PId3+
         K8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=3nnNuMN0DgpLvFEqoDh+yamiGrzV6ATAjSjzW+TOOZ4=;
        b=QaNhtzgSY0jD4QxcUVT8ruTRbxJSeCd0K4JXFggyd6y6c2Zjp/hrvYPvPdxc+7rNpS
         WcYd6TvVN+A64ojOfqaXOszpm+BTibqqMYiK5ao+m7XhvQW/SZqirF7Lg0Glw0QXReBg
         sF5wA7FFgs0cYdZ7InrMUyv+WFcXMzno3tEjMcZzQ5VrECbvMqvUv3eZvwHX7NvJ1qqT
         KQCP0FGeUg2itFqFwMdmkrEg1Cxwrq7dN5vzIc51tL11CdGHlliofWMGf9XsSJqjv2Pe
         0GF0gqGmlGo4LST+TjAGj60qKjCdSphTiFUaovvFRn8/Wa50LabmULWuTHmMUsub6x0O
         W/Sg==
X-Gm-Message-State: ABuFfoje1C9RCB9DMypj8ddENfqfzIzdJzmDECvB3bwFMZViBkr6Sxr2
        I/m87IxAzFL1evTcUJ/hGtU=
X-Google-Smtp-Source: ACcGV609dBDCVIqSnThpw+YX2gzunlpiWy2jq3yElfnXmqwE+2cweQjnva+XUEgq/RcSIvpbV5fssg==
X-Received: by 2002:aed:229a:: with SMTP id p26-v6mr46080540qtc.148.1540257039806;
        Mon, 22 Oct 2018 18:10:39 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id h4-v6sm19118406qkg.95.2018.10.22.18.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 18:10:39 -0700 (PDT)
Date:   Mon, 22 Oct 2018 22:10:33 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] kbuild: Removes unnecessary shadowed local variable.
Message-ID: <20181023011033.GA6580@WindFlash>
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
It was used only once, with the same value it was started before
the if block.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 scripts/asn1_compiler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index c146020fc783..1b28787028d3 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
 
 			/* Handle string tokens */
 			if (isalpha(*p)) {
-				const char **dir, *start = p;
+				const char **dir;
 
 				/* Can be a directive, type name or element
 				 * name.  Find the end of the name.
-- 
2.19.1

