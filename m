Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB745C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A217F2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ga+a1+iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfBFAL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42098 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbfBFALY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id r15so3020345eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03zM+rsG3etqoUUtwSyaoBhp2feBDhfBWZLsIpE5Slw=;
        b=Ga+a1+iqN03qpOufPf3RnsBJdAAkfKoDCtLVGJsznvVN5vV2xSUmpsDdUmxKOK11Ux
         1RG0uENOFT36UoJy1hzPu8ESSWB8kLPmUOoBTiIEfkIdLhkwMZnJNCxC/dgkrSFL6Hh9
         CiQEsJ/AyHwPwSJ40URAmnaYlBLAEN4xQaNVFCMD92xltmHfUo6K/4HGCV5RxZsSaTf7
         Y9BnqmjQQbMLx0RLITyrbNdA/vIS7ltpRryxZZix18KuqqDWZEeXxAEeJSAULopCVB1z
         rqn30t9jeUBxCnySsGvDu3g7f94rer7gKN4eTSrYlnJDZZhnLVzMS093Jk2Ym5qO15MV
         P4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03zM+rsG3etqoUUtwSyaoBhp2feBDhfBWZLsIpE5Slw=;
        b=CME3yA72YG/l9TYErXK1675XD9KGdVf1VezN2+Y9QI5+xJEdQ9tti6qsIPHBd02aXN
         Fxwm4iz5/44Lnzap8+pJJ32NYvgOaSDJpDvFTpJhk5jm0bdrTzAFsetveblS22kPFP/P
         9AESK3+L1hVYFjSn8+4On6OvQiSBiaQhxznej8LgYvGV1Sp76S8Rlj9UK0t035CtmEp5
         5SppO1+TpAUJAMl/Zqpm40c5RO2xiiQLumkp32c99eJ2gF2x9lDRRfGA8nuY7MAeUWV5
         l8KeVg0kFfPWWT79It5LgL0y9QgTDQD9w1BQScuAsKLFUrKlLQdz5fwtabkBr1dWvTC3
         AtCQ==
X-Gm-Message-State: AHQUAuYUX6asubKNEHTeDHKS7q5d7Isd4vL0sZYC05/IyYRaoy/rNFRo
        HFQZ/KJR371OJLwftpYH8oJJSPexr7Y=
X-Google-Smtp-Source: AHgI3IasnVqwFk64ATvco0LubYIcu2YNGAXKB7SlZovOiOibAkG+bsgRLuhGU4vFRSgCUuYo3Lwqvw==
X-Received: by 2002:a17:906:2893:: with SMTP id o19mr5452714ejd.146.1549411882850;
        Tue, 05 Feb 2019 16:11:22 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:22 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 10/32] x86/vdso2c: Convert iterator to unsigned
Date:   Wed,  6 Feb 2019 00:10:44 +0000
Message-Id: <20190206001107.16488-11-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i and j are used everywhere with unsigned types.
Cleanup and prettify the code a bit.

Introduce syms_nr for readability and as a preparation for allocating an
array of vDSO entries that will be needed for creating two vdso .so's:
one for host tasks and another for processes inside time namespace.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index fa847a620f40..61c8bb2e5af8 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -13,7 +13,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long load_size = -1;  /* Work around bogus warning */
 	unsigned long mapping_size;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
-	int i;
+	unsigned int i, syms_nr;
 	unsigned long j;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
 		*alt_sec = NULL;
@@ -86,11 +86,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	strtab_hdr = raw_addr + GET_LE(&hdr->e_shoff) +
 		GET_LE(&hdr->e_shentsize) * GET_LE(&symtab_hdr->sh_link);
 
+	syms_nr = GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
 	/* Walk the symbol table */
-	for (i = 0;
-	     i < GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
-	     i++) {
-		int k;
+	for (i = 0; i < syms_nr; i++) {
+		unsigned int k;
 		ELF(Sym) *sym = raw_addr + GET_LE(&symtab_hdr->sh_offset) +
 			GET_LE(&symtab_hdr->sh_entsize) * i;
 		const char *name = raw_addr + GET_LE(&strtab_hdr->sh_offset) +
-- 
2.20.1

