Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464236-2-5423670108365720718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464235; b=vX8VKbIIrE4XvxgBZC+v3sccwnsyLziOFnWRESD7gZGN5pCwZ0
    RN9BwyyimxzAy+CpbKvJKAw6CCeP7e/xZfpKzydLpL8r2pVQ+CepgYtEXbpcdK+F
    S9lVgPs3dyAhO51eGcO81ZskCvsSWqNnRTP3jgZMxb1/kOWQB26RI1wHlGchJ3GE
    9cjq0qJ0mh0QpVs+ANDKcgmG0QVsJ+zOCkXZKO8Kth5yXeD+W5BbOP4Kb/yrtWqh
    jhIM2FyyT+IDnmwej0AcJEZCe/e6ZKKA2rPzdO5Ndd6JURcTMak00ChfeLVyMjux
    5d6WoVvAJTT3Rebs4MXDdm1lZJctBYc8aiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464235;
    bh=s/TPBgrtoGXqcQj4urVsT7lcWBHXIMiPsdvaSqX3eq8=; b=eopMirejC67x
    oa7MIM6U3QFKBnuejHYNhJLJFgiddGvjY/sVbO1ZvUZ96YHLm7kiFozfePrUAINr
    bheKEby8s2w2imoE5L8ZXuJMoqqonCYdunTlIeZLtJXk6ep10pFwPlK4MTN5S18L
    dRPLJWyBQe9bn2ePqhBxNbJUnkK3curIl3lVwgsSRUZ9UD/vHCE6TDZTBh0Gpen4
    cdFUHDsua6DhajOQuWtPRgsz1q7o/xH28xP4Q1LDoJVxmg5ZJwwgcoA5FFS6Spbm
    C5OaI4htjax25ysA8fdf3MAkTY+Wb1c6wbaEVHAvLrawQUPiN0hOuTKM1f6Y30aT
    HwVVWeKiLg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfB+zmWC7lK+WpDK5HCocrWGSHrvkvLKcCMBbx6ZzLghh1wyx2JYL1KGRBH5LrwtpIX7RUfa+ZnQDNJVwn4z2MAfrj0QHeAtcqAXLkx7OFGSGP7yO1m1J
    pfhmJXyahWXXANBVCSLc0qIW3Sfg9Bl1GpsiOIDfDJD47vMJR56ro2Jfd+k7fwnbjgfJZ0Kq2LEpW000E3ymcsa4+p/EbUSZpFqNgLY8tO+jDAsUiGCbYjFr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=7aeUeagkxlEMnkZxZQ4A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbeDKQZF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:25:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753755AbeDKQZB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:25:01 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/24] ima: require secure_boot rules in lockdown mode
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:24:58 +0100
Message-ID: <152346389895.4030.16084163640865771766.stgit@warthog.procyon.org.uk>
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

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

Require the "secure_boot" rules, whether or not it is specified
on the boot command line, for both the builtin and custom policies
in secure boot lockdown mode.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/integrity/ima/ima_policy.c |   39 ++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d89bebf85421..da6f55c96a61 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -443,14 +443,21 @@ void ima_update_policy_flag(void)
  */
 void __init ima_init_policy(void)
 {
-	int i, measure_entries, appraise_entries, secure_boot_entries;
+	int i;
+	int measure_entries = 0;
+	int appraise_entries = 0;
+	int secure_boot_entries = 0;
+	bool kernel_locked_down = __kernel_is_locked_down(NULL, false);
 
 	/* if !ima_policy set entries = 0 so we load NO default rules */
-	measure_entries = ima_policy ? ARRAY_SIZE(dont_measure_rules) : 0;
-	appraise_entries = ima_use_appraise_tcb ?
-			 ARRAY_SIZE(default_appraise_rules) : 0;
-	secure_boot_entries = ima_use_secure_boot ?
-			ARRAY_SIZE(secure_boot_rules) : 0;
+	if (ima_policy)
+		measure_entries = ARRAY_SIZE(dont_measure_rules);
+
+	if (ima_use_appraise_tcb)
+		appraise_entries = ARRAY_SIZE(default_appraise_rules);
+
+	if (ima_use_secure_boot || kernel_locked_down)
+		secure_boot_entries = ARRAY_SIZE(secure_boot_rules);
 
 	for (i = 0; i < measure_entries; i++)
 		list_add_tail(&dont_measure_rules[i].list, &ima_default_rules);
@@ -471,11 +478,23 @@ void __init ima_init_policy(void)
 
 	/*
 	 * Insert the appraise rules requiring file signatures, prior to
-	 * any other appraise rules.
+	 * any other appraise rules.  In secure boot lock-down mode, also
+	 * require these appraise rules for custom policies.
 	 */
-	for (i = 0; i < secure_boot_entries; i++)
-		list_add_tail(&secure_boot_rules[i].list,
-			      &ima_default_rules);
+	for (i = 0; i < secure_boot_entries; i++) {
+		struct ima_rule_entry *entry;
+
+		/* Include for builtin policies */
+		list_add_tail(&secure_boot_rules[i].list, &ima_default_rules);
+
+		/* Include for custom policies */
+		if (kernel_locked_down) {
+			entry = kmemdup(&secure_boot_rules[i], sizeof(*entry),
+					GFP_KERNEL);
+			if (entry)
+				list_add_tail(&entry->list, &ima_policy_rules);
+		}
+	}
 
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,

