Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D70C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D9E2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Izj2RAxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfBFAMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:12:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36767 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfBFALh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id d12so3445370edy.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nimaTeKw7f/fJd1Dlno7nOd96/JVuqHQeRI54wLbQ+4=;
        b=Izj2RAxE2wSvlX8RKdqGreGsv1KNNvsVAH1A8YVSBR4OWKwROlI7L4W4Q5wEJPbnLy
         12SJsfkvyW9vTo5FT460OFVoeXlDb+CFbbXP7sG6ShYQfCekMZfVr3/yCr3+m7S36zYy
         OKwmz0QuMGgLw8WANDcg3swdulSXgDnUq+W29avZbqw9DHWVUrE+lguVgjNZrvcpY9RN
         DzRQe7BGcBt8TofkKPOl2i0Kqhs54hY52pUnBeVVRYqY3HP0YpIWxdpiYG/O1QGTnmq+
         yDgMhwu8WRACrHBWgw4rhS3UBZqJUohv+4xWKMPMLvWrPTScvqFF3WY3qxupFrxUhNua
         A/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nimaTeKw7f/fJd1Dlno7nOd96/JVuqHQeRI54wLbQ+4=;
        b=KQfp768o16UxtadnkF3MVqab8OstdVVSuFRw0MBI4iM91p3UBRSXHKeIp58L8HBruc
         I7y3HBkrGOzazFgtcW9DYWUqkoFfWGww8ZAZ1rY/3hiW5PjE/4IjVbmlSGlwko1owXm7
         tOEE04Ae9vx7wxXSoHO6vnnItgnjDjVpBNq2paVxElAKRWqTIXT6vYo8yuRMQfsAaoul
         3NqAiuHOEp5VaMZBjhrS1uk2e4iY+mpYvkm/yguagom3wm1AqLFT3+LjDb6ckDvZVBV9
         y7Wdd3Z6UsomyzVDsRm3nyIWn7C8FLcYdYvd+Y8P+n6wgH3yfUa94UzFvtCLWKLMzQfJ
         1bRQ==
X-Gm-Message-State: AHQUAuZI/NJzmaluQIJc2IImlhAsmwGFyxryYT9VimWQkYgNbFbSlFDG
        V2XR8BvbQg6/EwSBuiTq9/XK7jTOiKE=
X-Google-Smtp-Source: AHgI3IYUS4o7bq42mBWP5mTfZF2fWscQByrDhjvFzM1vR9YtCXkd1x0huWtXY+D+v0NHSoyg55B2gw==
X-Received: by 2002:a17:906:6447:: with SMTP id l7mr5282738ejn.156.1549411895293;
        Tue, 05 Feb 2019 16:11:35 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:34 -0800 (PST)
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
Subject: [PATCH 19/32] x86/vdso2c: Align LOCAL symbols between vdso{-timens,}.so
Date:   Wed,  6 Feb 2019 00:10:53 +0000
Message-Id: <20190206001107.16488-20-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align not only VDSO entries as on timens VDSO, but also addresses of
local functions. Otherwise, ld will put them after everything else
into *(.text*). That will result in common VDSO size bigger than
timens VDSO size (sic!).

Unfortunately, filtering by STB_WEAK doesn't work for ia32 VDSO:
by some reason gcc transforms weak symbols into local symbols in .so,
i.e.:
    27: 00000000   219 FUNC    WEAK   DEFAULT   12 clock_gettime
    29: 00000000    95 FUNC    WEAK   DEFAULT   14 gettimeofday
    32: 00000000    40 FUNC    WEAK   DEFAULT   16 time

become:
    20: 000006e0   219 FUNC    LOCAL  DEFAULT   12 clock_gettime
    31: 000007c0    95 FUNC    LOCAL  DEFAULT   12 gettimeofday
    33: 00000820    40 FUNC    LOCAL  DEFAULT   12 time

that results in the same align for two functions in .entries file:
		. = ABSOLUTE(0x6e0);
		*(.text.__vdso_clock_gettime*)
		. = ABSOLUTE(0x6e0);
		*(.text.clock_gettime*)

As result, ld becomes a very sad animal and refuses to cooperate:
ld:arch/x86/entry/vdso/vdso32/vdso32.lds:339 cannot move location counter backwards (from 0000000000000762 to 00000000000006e0)

Align local functions on VDSO to timens VDSO and filter weak functions
from .lds script.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 50566dd94451..7096710140fe 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -15,7 +15,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long mapping_size;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
 	unsigned int i, syms_nr;
-	unsigned long j;
+	unsigned long j, last_entry_addr;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
 		*alt_sec = NULL;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
@@ -121,7 +121,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		if (!out_entries_lds)
 			continue;
 
-		if (ELF_FUNC(ST_BIND, sym->st_info) != STB_GLOBAL)
+		if (ELF_FUNC(ST_BIND, sym->st_info) == STB_WEAK)
 			continue;
 
 		if (ELF_FUNC(ST_TYPE, sym->st_info) != STT_FUNC)
@@ -134,8 +134,19 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 
 	qsort(entries, next_entry - entries, sizeof(*entries), entry_addr_cmp);
 
+	last_entry_addr = -1UL;
 	while (next_entry != entries && out_entries_lds) {
 		next_entry--;
+
+		/*
+		 * Unfortunately, WEAK symbols from objects are resoved
+		 * into LOCAL symbols on ia32. Filter them here, as
+		 * linker wouldn't like aligning the same symbol twice.
+		 */
+		if (last_entry_addr == next_entry->addr)
+			continue;
+		last_entry_addr = next_entry->addr;
+
 		fprintf(out_entries_lds, "\t\t. = ABSOLUTE(%#lx);\n\t\t*(.text.%s*)\n",
 			next_entry->addr, next_entry->name);
 	}
-- 
2.20.1

