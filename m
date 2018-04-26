Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209064-1524730190-2-18412409555010402767
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
    1524730189; b=IoX0BWPSRhA8eEYkufMlgpYsfrMlRf2MPoq3Hyyrat3IayUX3j
    +PPZMAq7AFr0IsEIqPgRY2GfkIIjR+7pZRUkA+nuFcapR9lHZ/jIhOpqe4X1FHUW
    SA/Hcsv3KYm9WXpvKFihzZbKDWuGRBAHMj4decInGK5frsvCAns5MU4LPkYEpxCj
    Jdv6MoFy1kxWKhCCAcpsTmXVNlm5zlL99QuaRBMaBSbDDqaeGUnWWsMb4s869N+J
    pAcWdgCZfnFW3JMqDjLacA3b39dj/f+MKIaKjv7Ex/r0TVCA6AjsNJweQ8EE+jv/
    wc/ummEDY0W/zl3DH3dp0YZF2/g7/YnkZaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524730189;
    bh=/1crSH/HVNOBu6cfhao0PUZ7KPZWPA03FBTIwr4EfVI=; b=Vu0gE+Ix7LAW
    TVDfH1ZV8zGEv8C7oq2NYg1DR9NgvLD30fCWtkfSzthMiM+LI71obKCMzeLvIwW5
    m0e3zLR+u1CH3iDVzgiXishtXgpUnEfauHsOTXbh6XrQ19YVcYBjfy/QUnqVIPZh
    iJNPYBVZuzPjBLNwzNehc345jHPNC2sq2y42PBWfRDmsxyq9L4lpWtfm0JVsV1OB
    ZasVzg0yZU3KCsfuDRKYPNX1xJskI9rxHNbfPyncipVcYLLgYBkrll5HcZ2jKG9f
    43H7Go0nprGUCFHae0cq0f65GxJEeMNm0YHZApLgzhwC/ncG5Zp5ALlQR1tTWsPv
    sQyvBdi6RA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfL4gvNnFZEMmjLIrhqPLrvySoYeeW9UfBZm8IhTFI8lNQIaEkH3WQA68AgaJ29cT6qIuWIFaFqqkQlvCsnNqqRcrUKwdAKZIVblBqdFcNI38AFTCUS3/
    kehGXyg/VwswUIhoA5gsRL7bmh2sBbxadRy71koRmmZwYYv5PoBuFQzltW1+eAr2Wi0FYg3fsqDGYF+KCSWwBaNkXe/ONch4Piw8ah+iLF8PGPSJuI3aAatN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=dPl-qn7FL8iXipNt2_cA:9 a=bRX6X2rAxnCGALWu:21
    a=jbwgSx33hnBi8uSr:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeDZIJa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753440AbeDZIJ2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:09:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD08217B9
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
Subject: [PATCH -tip v2 2/7] kprobes: Show blacklist addresses as same as kallsyms does
Date: Thu, 26 Apr 2018 17:09:02 +0900
Message-Id: <152473014240.8819.3919458094230811205.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152473007907.8819.10449983839199591406.stgit@devbox>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
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
 kernel/kprobes.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 314cec85a8b2..e7d7e3e8598a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2427,9 +2427,17 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 {
 	struct kprobe_blacklist_entry *ent =
 		list_entry(v, struct kprobe_blacklist_entry, list);
+	void *start = (void *)ent->start_addr, *end = (void *)ent->end_addr;
 
-	seq_printf(m, "0x%p-0x%p\t%ps\n", (void *)ent->start_addr,
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
 
