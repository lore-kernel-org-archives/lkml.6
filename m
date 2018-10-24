Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B9C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6758A20651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYTCiEwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6758A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeJXMaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:30:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43904 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJXMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:30:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id m17-v6so2314908qkk.10;
        Tue, 23 Oct 2018 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYupy0TAMQX9ANbtIAFOJdw7USjhcvPmg1UT0VrOxEg=;
        b=AYTCiEwoqf5reGphmyiZjHue7Mo3cS1HWrbsiqlvANJ6YEzXirUF37jAwfkeQ6vDTz
         gX6WEy4RFPXT/ChWzfBWT/aiOrz2hx0GLD4dMgaY6IMhmnq0o2oeMYXqmVL885mUk2+x
         izrudr7mUrvvI4gKmP4RHZPp/Wwvu6K0VLn0oulDKfpPukzvqBS6sZoAPQpEFp1hPY12
         X3J/Ocs0IG7u38z1xo1YqsRRRQMEHMlUXDjzv6FjJ/DkBP1SSu2R0MD1OVsuVvhDDyGP
         oXjl+k5ul0njkZm5TW+Z6CGlUV8e6GzJskbwiaVWt+KLrN/pQ63Y/ADyVLMCpv81GP/Y
         EA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYupy0TAMQX9ANbtIAFOJdw7USjhcvPmg1UT0VrOxEg=;
        b=GSKaSgK+jED6pgHYMRZHTB/vjIpWegUnbsrpNfw3Gd4Q7/nTbWwMqiMmcKuEw6m2a7
         0OdSxRA/LD+Md0LvVIhM5iderH9R8fx0vNH+S+NVnN23Vbd6XN84ta/D0hctw40Vouiw
         wQW9VbxtCN5R9N22gEm7xx1QKRfc8afqigfiosZD7Z7sbiUDnYTliOvtTgTG+3nAC15y
         apNrPvT2+7Y6vFEpdqyC/rX4XEpfZDb3wOhcycWnbLSalBPu3QhQopOtci6fW6ZCYIJt
         SVt41S1C899+xfG/7lhkM7cpGtc+0SdazBJTXyITJ+3kK3/V1mmyr7Eo5RkS49dQNYaD
         pB4Q==
X-Gm-Message-State: AGRZ1gKxxLcY8FkTBstB7cXka+xieIxSzBTGx2rcHDc/dWLK074yQoWk
        rTyrHvFNs4qKG+azKIBtOGI=
X-Google-Smtp-Source: AJdET5ebG0OzTl8HIWMA1kPBCXrSD6IEAE7bjSMExKUEbDNOwu7t1CFbhQY09bjEOo8D9UmD2JLaew==
X-Received: by 2002:a37:2455:: with SMTP id w82-v6mr870170qkg.247.1540353851547;
        Tue, 23 Oct 2018 21:04:11 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id e195-v6sm3229126qka.2.2018.10.23.21.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 21:04:11 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] kbuild: Removes unnecessary shadowed local variable.
Date:   Wed, 24 Oct 2018 01:03:51 -0300
Message-Id: <20181024040354.24879-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024040354.24879-1-leobras.c@gmail.com>
References: <20181024040354.24879-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes an unnecessary shadowed local variable (start).
It was used only once, with the same value it was started before
the if block.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
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

