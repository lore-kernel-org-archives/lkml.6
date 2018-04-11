Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464135-2-12459864155024554660
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464135; b=l05nTADcvR6csWlWlB8zN6yRwm0zQSz2qIqe6bDAcpouTSuHja
    GGr/e3sgpYoE3OddZJNxuqVg1bnoya0R+stCDPJA7CiHY0SgcQZa5s4kO31c4v4R
    yGaBiXQrGQpSQUndWV6Nqpr9Pq88BKHn76TqrhHCOCJJlpT5wGKDMCAoBlrzcOF+
    SKiW4QpfaEJ7u3i4dGvbVnYfa6LfMljrGTlXnHFiyf7TfaVw043RUeT6EAZyzqmW
    q39Pl2PL8qPLJdDkHSw65YZd0XH9ZGYpnQwmklKaf/afn2DbSua3GrlCUHWkl6ZJ
    lw2u8m2cci70e/pbInsS1R5BDSOmWKviwaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464135;
    bh=N8Aa5MekR1R5fI3WP08J3L+aKmOUaompxxtbhechPpw=; b=d0vMvgLrLRjd
    2NOx/XzuWbXBLXDNbwZNyItGTUUOPigbgzkOyjTHudXLOVbfiGlg1OpNcOY+KWsR
    naugkH61v1xpjKrZGOXqEDje7PDJJzhJxbpyfD+30yP9XoLNMT2ZZH0ys7x7Oi06
    IdQFLO3QcMbKmRVWz4BvEFWv5aYMkjczwQGr4qVipM1SRR10rl0cbyInlvN3/1Br
    dRxmzrR1cANBYXGMuHMQLh7OUqtEEDwSMPoSDzOhQ3sc+WL6nvwFrezT6M6xtO4w
    +bLE+MulL7hIVv1O5hh/1BjsUwwvGu1zj73fKV4+G/fIlc9OPgDjLtzSf/yfvLF6
    goh3nqAYCg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOZ5xV0zMMma24nhRI9CC7GVBZUbWwKsodsTv8G/Mz17nF+a6eo62sQAkjlaL5TLT0hs/T/Up+QenFBS/2OaR9FrsNQyiXtnLMiFBBGQOjddCZImnak7
    DB3NQPsMWC59D8KTzkSdx7UuwX39aMSO9xNGlsXPF4JAlsVULUoZ92lvStbDzs6o66H4H5xmMZ1OWx4kJjfBxuCjy8J9PwcD6nU1QR2/52+WyMDXWcr2g+HR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=MvuuwTCpAAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
    a=TY0TpV-m57UpV4AJIgAA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=dVHiktpip_riXrfdqayU:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbeDKQ0P (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:26:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753424AbeDKQ0M (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:26:12 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/24] acpi: Disable ACPI table override if the kernel is
 locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:26:10 +0100
Message-ID: <152346397054.4030.6635609558509282651.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Linn Crosetto <linn@hpe.com>

>From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When securelevel is set, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
---

 drivers/acpi/tables.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 849c4fb19b03..6c5ee7e66842 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -527,6 +527,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (kernel_is_locked_down("ACPI table override")) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);

