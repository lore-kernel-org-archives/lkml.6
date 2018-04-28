Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1907442-1524918973-2-13562336119160911674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES ensvda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524918972; b=LoUVLzImN26F5Xl5fIFG8PKTi5wIIu390Ub2EbzAsagPzlnbaq
    g3NHrpb9XITAue3oG2IdoIm86UseX7j2wg8S2b+LFm22bSJvIL03gU3EWe97P3A0
    Z3g2srSw9VcUUsN/0c0soDKA4uzbG4g3U6Kk4BlofgvKrIjgzW6+8rVS1q/bAanZ
    U2LYRWA6rDZlxWwrM8yYVTpv5nkZMrO5XxTXgZE88g3+eHMCyzX57wlbub0SRJOY
    mSjRpEmiFM8AkhcYjZ3sOYlbZdRy/4+RUnD6FK1C3Ws9OReI+Kpe3+rV07MYT0ZT
    PPcBG46v5SamRtbi7kdLllkVrTrrNQrupQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524918972;
    bh=0f+sofCXfUfg2898TSCpUj6/YiMlFvfEuxYQO1MIxN8=; b=BfbxT3Um/xsV
    N+Zy65519zDdMjsnYxMc2QzCQQVHcZ+azuqcFdib3nOBvAn7YfksfRFmQl5GIe9T
    oNvFwVtv4KSBXKptSQlzXYTUr2TXmrjt4f6Q8B7w1CO7FfzxvOrSTwzpfYnAYTwr
    pZzVsbEb8+Ys49lODJz4R58O7lXgEr3LeNouviYqnivjZzFeMNBbT+Y27JWqfNPC
    Yuma03308Yg+HPWXesjjHQ1Ct9DBsBvF5uoLAC0g0W2FEw4IGJp8rqy4w4K0X933
    oJY9+OI/YOimHj0nKWgiXCER0q5AEbA4aO+FOMkwjMXZyW0Zm3O7YsQV1YCcr1q/
    d5ShUAGbDQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfORWcKTSCmV3fpTCh9tDATXd6BuR+acKpeJVy8C85DQFMRQ17OS46tmlRHQ3LhJtRa4DnY2CkYCkYdV0933RYPo9sSx1T6bXFDyGGCOPJ7cQRzUUXuP1
    FLPPDeW0Psrt2MutBlEV0j5Ffaur4y/lDGvg6Z9lBy2EZhfT1jlhMFUV1+wCQ3L0gU0kCs6JbzbgM+YcSXXNeAQ0ZdbNVnJYZVn7UQlW5sjkRh7LZLZhbgQF
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=dPl-qn7FL8iXipNt2_cA:9 a=-bEwiYzbEXgGZC3p:21
    a=ZxuR-HnsWkFXw3jp:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933422AbeD1Mf6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 08:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759699AbeD1Mf5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 08:35:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E09B21DEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v4 2/7] kprobes: Show blacklist addresses as same as kallsyms does
Date: Sat, 28 Apr 2018 21:35:32 +0900
Message-Id: <152491893217.9916.14760965896164273464.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152491886943.9916.18051658590418236184.stgit@devbox>
References: <152491886943.9916.18051658590418236184.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Show kprobes blacklist addresses under same condition of
showing kallsyms addresses.

Since there are several name conflict for local symbols,
kprobe blacklist needs to show each addresses so that
user can identify where is on blacklist by comparing
with kallsyms.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v4:
  - Do not use local variables and fix comment.
 Changes in v3:
  - Updated based on the latest linus tree.
---
 kernel/kprobes.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5eb42c82497c..6ec1b5e024bf 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2428,8 +2428,16 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 	struct kprobe_blacklist_entry *ent =
 		list_entry(v, struct kprobe_blacklist_entry, list);
 
-	seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
-		   (void *)ent->end_addr, (void *)ent->start_addr);
+	/*
+	 * If /proc/kallsyms is not showing kernel address, we won't
+	 * show them here either.
+	 */
+	if (!kallsyms_show_value())
+		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL,
+			   (void *)ent->start_addr);
+	else
+		seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
+			   (void *)ent->end_addr, (void *)ent->start_addr);
 	return 0;
 }
 
