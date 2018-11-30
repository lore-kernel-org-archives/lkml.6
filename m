Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEDEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6AB2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1EOftzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6AB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeK3R1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:27:09 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:33359 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeK3R1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:27:09 -0500
Received: by mail-wm1-f43.google.com with SMTP id r24so916720wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D5YaG5x67CPZNZ7De3f1MGD+D9eRgDA2e53WZXUIGiY=;
        b=G1EOftzodz4tUtWWiGM3spjtKXTRxBMLDEgIsF3FLWcgDmpAHdo7lYZyosuOAYnAFE
         hAT407zIhZP/gfqAphwD1CrOmWhK1Cc48MDY2Y28g2Ahk4GCAa7LYTduvWx1w5wF7DUL
         A30BbPkswctYB/omRorv/kUZl7C1uWf3vjOnt1HzEUX7VwO7amGQmezYoTF5GQwPOiu8
         kawKZkynMtj8OC2kywxwbHu/9HwziVzERMTGEvVz6WPz7Ra0/Jlp8YJVFgMMUBn9Ncag
         hlkeS88U7Vn+1OHgIN5WcFwRNtcdUn+EmPRLrqomwTUn9wB5rCeS+cJPgQY8XoTRQ1bG
         CJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=D5YaG5x67CPZNZ7De3f1MGD+D9eRgDA2e53WZXUIGiY=;
        b=aED+XXDZgXLv8obE7630JdkhZg8RZ8IchZY87yus/mKb6hHQO6T6PVpPKryYLG5Qdm
         LlPOHFaDmIrYkmj8cG95kYf6jH3HE+SRgTD/Zx1iryfxaiwCfAhwHXUjeicNU4DVDiJ6
         lY9p8g7TbhLdoFs7xDRmT6AXShPKxvEiZ8duEFgf7LeEFr/KhaGddaGdrW2qZBSJ9+yD
         EdE/Hy+RjHI8osDT+Yl8jGJG06Qe0zt+oykurYRkvgGG3BQITY0ijfKLXvs0Hx8W2nnC
         X8yvDl5SPy1ryuY1E49P+X5FOSNFONA11CYwE8olEffoYCKQZjLkwzJSh7emMkYHrlDr
         4ihg==
X-Gm-Message-State: AA+aEWYkZ5TUE2z7fElZofjnvLyWfdGTbCk7Hh4hyIlaa6S0dHOASpkS
        8tklYyULIag2CYXHV5jZCF0/zZ5G
X-Google-Smtp-Source: AFSGD/Uci6DAnRWcl23dVG79AiSHSHRGRaUwW61Cssea5Xyy/vGUIbp1KFrDxK1uxc5WE+VcSCYdvQ==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr3991701wme.21.1543558736398;
        Thu, 29 Nov 2018 22:18:56 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s1sm4815425wro.9.2018.11.29.22.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 22:18:55 -0800 (PST)
Date:   Fri, 30 Nov 2018 07:18:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool fixes
Message-ID: <20181130061853.GA19395@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 22566c1603030f0a036ad564634b064ad1a55db2 objtool: Fix segfault in .cold detection with -ffunction-sections

Two fixes for boundary conditions.

 Thanks,

	Ingo

------------------>
Artem Savkov (2):
      objtool: Fix double-free in .cold detection error path
      objtool: Fix segfault in .cold detection with -ffunction-sections


 tools/objtool/elf.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6dbb9fae0f9d..b8f3cca8e58b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -31,6 +31,8 @@
 #include "elf.h"
 #include "warn.h"
 
+#define MAX_NAME_LEN 128
+
 struct section *find_section_by_name(struct elf *elf, const char *name)
 {
 	struct section *sec;
@@ -298,6 +300,8 @@ static int read_symbols(struct elf *elf)
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
 		list_for_each_entry(sym, &sec->symbol_list, list) {
+			char pname[MAX_NAME_LEN + 1];
+			size_t pnamelen;
 			if (sym->type != STT_FUNC)
 				continue;
 			sym->pfunc = sym->cfunc = sym;
@@ -305,14 +309,21 @@ static int read_symbols(struct elf *elf)
 			if (!coldstr)
 				continue;
 
-			coldstr[0] = '\0';
-			pfunc = find_symbol_by_name(elf, sym->name);
-			coldstr[0] = '.';
+			pnamelen = coldstr - sym->name;
+			if (pnamelen > MAX_NAME_LEN) {
+				WARN("%s(): parent function name exceeds maximum length of %d characters",
+				     sym->name, MAX_NAME_LEN);
+				return -1;
+			}
+
+			strncpy(pname, sym->name, pnamelen);
+			pname[pnamelen] = '\0';
+			pfunc = find_symbol_by_name(elf, pname);
 
 			if (!pfunc) {
 				WARN("%s(): can't find parent function",
 				     sym->name);
-				goto err;
+				return -1;
 			}
 
 			sym->pfunc = pfunc;
