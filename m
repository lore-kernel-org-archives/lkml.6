Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6383C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F3E2147E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX1hVOn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F3E2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJQIBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:01:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37533 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:01:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so28025369qto.4;
        Tue, 16 Oct 2018 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=5Q7vGbq961nf2LzoNGlaXLvNyGpktZKrKB9yXgUHndA=;
        b=EX1hVOn4JuhoKatY4YuCpVLGjN10GHqFZfUCvMSMiGNIuTAA00xiU+efKD7cxPices
         zFM/hSypQZYAfKES6M2qX+Ss4vwa3K5AyDeSMZWXxcTqV3Z77ChVW783hjcG7i82Ly5O
         SrlpF7ShP5sjz8BRG4Ry/cGXLWwBcN+KhUAOnPaEqlcyvje20Cu9dDs8ljsaK5SUOt9B
         8q195Gn8ZjL/YVw6GAgm0IJMsZAmfazbrstT0DdsmFrFSH+m8kfs5VOhgnpf6UAua25z
         AKquM1ZT/1tF50i6caYMNbTxGoWiwR+9f70HesWNyaFupGGTX2ggW/84UiJTTTgW99OZ
         0VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=5Q7vGbq961nf2LzoNGlaXLvNyGpktZKrKB9yXgUHndA=;
        b=hD/1rVPsD07UMbbnH5eMFusMCIF4CTQ+i4qeR2Fs1D3qB5BZbuOiNXq5SAva+2py8D
         B6hlInB67WSIa2dphKGa2JUDRGcyiH0Lin+mOBwZUdKw9REO4da0YBJOkrCOwNGozv+w
         x1qcn7lPv/l6mMMMatoXIPLi5yNMknWGVbQSlWfiwcJbmhe/YGN3OolMKyuOb+L/fk+5
         K+kNcYtMP952wp43CsosdPr6cIteDUa0xRxLwVlgjvrXZ6pIEm5S5m6DKg/7PUpv5J2W
         UoizqJIje99SbGeINi90NsBnGE1bErShJ7kr70lmItMW4DAWTxBC52P260bEwLsDG32z
         LrZw==
X-Gm-Message-State: ABuFfoigRA4Fkpz+5qW7Bn3WuauHjLaD9b7+d+AhCz9jrcnXXqQGmCET
        4Qe0dk4SdYLDU2ig8DSkxps=
X-Google-Smtp-Source: ACcGV61M+Rf/4oky/z9ua/Cvh8YByBKAByZjKqo3Lztq3/NeyNaUN6I8+J/SdiauRyE8kS8ryRw5Ng==
X-Received: by 2002:ac8:4790:: with SMTP id k16-v6mr23183700qtq.253.1539734920249;
        Tue, 16 Oct 2018 17:08:40 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id o50-v6sm11689672qtj.41.2018.10.16.17.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:08:39 -0700 (PDT)
Date:   Tue, 16 Oct 2018 21:08:34 -0300
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
Subject: [PATCH 2/4] Renames variable to fix shadow warning.
Message-ID: <20181017000834.GA21330@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renames the char variable to avoid shadowing a variable previously
declared on this function.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 arch/x86/entry/vdso/vdso2c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index fa847a620f40..9466998d0f28 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -93,11 +93,11 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		int k;
 		ELF(Sym) *sym = raw_addr + GET_LE(&symtab_hdr->sh_offset) +
 			GET_LE(&symtab_hdr->sh_entsize) * i;
-		const char *name = raw_addr + GET_LE(&strtab_hdr->sh_offset) +
+		const char *name2 = raw_addr + GET_LE(&strtab_hdr->sh_offset) +
 			GET_LE(&sym->st_name);
 
 		for (k = 0; k < NSYMS; k++) {
-			if (!strcmp(name, required_syms[k].name)) {
+			if (!strcmp(name2, required_syms[k].name)) {
 				if (syms[k]) {
 					fail("duplicate symbol %s\n",
 					     required_syms[k].name);
-- 
2.19.1

