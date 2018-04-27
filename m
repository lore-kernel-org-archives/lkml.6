Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524811268-2-9645933017396588398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524811268; b=Rlr7HjaN1Dj4iC09jPZMnkK9Y5sWWvYOUV1KbZbSWVsGeBVezD
    YlcUvzavSxeP36pwmjmzvwVx0+VSx4UvHKS1vyqmvUdJXrJT8gTSgImPgpqcPd1M
    LgUOF16JWhi4AoqANaVRAFiUkcbhGzoOWUfEIfo3WIVAZ3yxEemQ0JXBTebv3s3j
    Eb4VrCHO+2lExVuPkY7RMlcbOVBvxCP+v4xxPVikk2qw1ITWCWfQkM5vn6jKbzcf
    Leo/xVzYUH8geJnSHVCKABog3NI44mUSlrlIc5rXX6mX/I5pQcSOt4XAsw7K9Lig
    AfWOSgLr22ALW49Dpwq4QyD0sUxaudRu+Q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524811268;
    bh=pA1oe6ROsev5ko524HpzhwggHn679BN7WjhEtWXW0tc=; b=EhEH8aLvKT+4
    3h5wFtX33jl/By9FGcgIKJ3v+kIewL8WBbH3jzkRhL37fCS9jZ1bOgG/LF+6omw6
    FoNs5whZgRhSEkTrhFxfeRG3ocXtgdHVo23FneR22NG4NblcHv8mmWJ48KKcW1wr
    kx2awigh1rT86X1QKpF0jDjW75TvREj0SRnOhecF1E9mrj8u4CZdRV6jZSo6T9MZ
    j4EMpTHCrmNlXHq0a3tC3zvsGClbHMft+iyL4WG4dAo1+nzPBhSN14rUQ9Z+zpYc
    fjbv1WKgDNjfA3ZxHxx9A5vex6bJwaPd2b/t7NvDjmGCB/fw/S5Wqx/D3yCs0H3Z
    sntmIK8JeQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfJm/25vqmkE/iXCYmSpozVizi/6UmVtitZzUhBG74ELQZt5t53h/zYss4XAoQRIQ+4MH60bgN24WU9i8J1ybT/siu9iulxbvSRWDsOtqBfmXwF5TwuG2
    47lnAhrf2dZRxHBa2B4kIQOvPy1Gf14TpmAPRTYxK0+Lg+yM+CF0cjmmYbGaChNXwSatBX0to1fwZkYCnEY0CoQt9KJiMHpsdZoidFeJac0nlbBa9LHEqWUe
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=dPl-qn7FL8iXipNt2_cA:9 a=uiKeyTZhSqnr6NHZ:21
    a=a0j7m7JFZAyrER_I:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757471AbeD0GlF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeD0GlF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:41:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6512168C
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
Subject: [PATCH v3 2/7] kprobes: Show blacklist addresses as same as kallsyms does
Date: Fri, 27 Apr 2018 15:40:39 +0900
Message-Id: <152481123945.22588.459569704440210836.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152481117776.22588.1210388093668905564.stgit@devbox>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
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
---
 Changes in v3:
  - Updated based on the latest linus tree.
---
 kernel/kprobes.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 51096eece801..e7d7e3e8598a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2427,9 +2427,17 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 {
 	struct kprobe_blacklist_entry *ent =
 		list_entry(v, struct kprobe_blacklist_entry, list);
+	void *start = (void *)ent->start_addr, *end = (void *)ent->end_addr;
 
-	seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
-		   (void *)ent->end_addr, (void *)ent->start_addr);
+	/*
+	 * As long as kallsyms shows the address, kprobes blacklist also
+	 * show it, Or, it shows null address and symbol.
+	 */
+	if (!kallsyms_show_value())
+		start = end = NULL;
+
+	seq_printf(m, "0x%px-0x%px\t%ps\n", start, end,
+		   (void *)ent->start_addr);
 	return 0;
 }
 
