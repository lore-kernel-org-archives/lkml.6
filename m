Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464147-2-14682803789036020718
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
    1523464147; b=H4EoyxQk0bgdTeHpImlMTxnagrDCq79ebPwOFTulds5fUFtW+g
    53iBrKfiQaKNERmzRuqr5ax1EscgfQXkwZljcoPVUaWYjSzvoZ9YxnHWvYM9/0hb
    YV0l4YKef6Xtll9uilpI61I8HPchcc+v/gWSj9sAc24CDbIhJft2LAwDAm1kvsMY
    Gnw9/nZahd/yEA6JNPlDLZspxLpmfmBWDhQjoTpBzPQEB+c8rIuJPFh/f+a9jfAx
    v4f0y5HQ2V9amovjt+Q47H9dzDe0vGkwdA8K9u7aMlJsKujl/tQwIuFu2Siy2wSS
    XJ597UA5FslNSB2nDV1A35HrH4SdS7vy9ITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464147;
    bh=NzZYyQyfb/EBcowrd+UROiYF2VdefX94+bjLpWCZsB0=; b=mDka1Ytt8UXf
    kUV/jcW5wVWLjWiMWf+PbOpUXyJqAanI2c+TO8ph0EbHtaPEUI217/JalvmTSbfq
    Dlb92HTyZ39gEAxiLGNfbdPaqokTfSxx82T0sU304AuRNh6vzoFqVX9h2EjZTFjR
    wj4HBaVqcwK/jTfu0k3AlbMKLfXRANRB8sUg1S/yJtgzdsIQ4R7gl7BlWJrOy7RR
    xDApgdDjN+mfn9GPpf62eemvbGMLOXiuP3cjlgSuIfBMizd95wRUGuzIIsneAAoO
    WrCPeKBl+yGbDkpGdFQEg9XWbM2ngeimK64qnV3KpreM4P1W+cb5BjMicXRajLGl
    +QetC6bd1Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfHqnw+3GtDNYdW28cYdnA3FcmbwhNPaxOF6O5gEBJ8lxxYOvo3PNKvZIkmnB2guFlIYTdUyRRfqfUYSqoeFnbDaUDk667d/OWkvhbkfANGsPEnB0oR3A
    nvm/1ZeyON04BNA35Hjo0kUjK80ClGc1YogOn3O9R+I91MiB0pn/2NH+VLpgxNo2C/tpxQ6k18HFr7EgbX2k2rMljUX6XDdjOs9GbmvoeYWdABbbEYBbKO0r
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=sa12cLUmOxuQF57ou_QA:9
    a=90RV9aGKGKdpPeXI:21 a=2G6o78pQYZCjLpek:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeDKQ0I (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:26:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753424AbeDKQ0G (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:26:06 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/24] acpi: Ignore acpi_rsdp kernel param when the kernel
 has been locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:26:04 +0100
Message-ID: <152346396411.4030.4824200967123540129.stgit@warthog.procyon.org.uk>
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

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
---

 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7ca41bf023c9..34e4ce7939f4 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -192,7 +192,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !kernel_is_locked_down("ACPI RSDP specification"))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();

