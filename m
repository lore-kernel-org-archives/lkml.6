Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464151-2-9268670187377032964
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
    1523464149; b=sAbf+E1eMwFsEhms2PkkRZM1CoMcTQOUZBRMQdtaK0Qs32o3qR
    Hkiadwg0lEJMj0meqwyzljPlw9xE7L4cWjFktOuXlPUiFBeFc6EbyrHwzH/qe9Rk
    oetddi1BCuPCSiKmnFH/GkIFEfGnHq+oDQ8VF5tjmd6f8e9DfJf8NJs9XeqSr954
    Hi8Kuwb727dfP+TZn4z+ci9SF3JYVBilTCwP5wDY5/Vuoz1pter9BqTadE+7/fQf
    24M8jf0RditsdVnF1UZeIjJ6sGeToTIZmyFi6+A0tVfgVvHEojs/iMFy7x6Z07zs
    ETPMyKvWFDZm+toniSVQO6O38DEpKz8cUHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464149;
    bh=FyLT9d1ccHnF4x/ZhGte7VMNYDIWtIVExlhQJmc4II8=; b=uU481nj057RA
    fz8/95V1p3nSZdDp3Z506o5y8FaA7odS6pyfrTgQwCmpyZScjC6UUtBmGXbYEg7d
    cyRdp0HSxq01igXG5mP2absAjthqzHcTZK19lwR6s61G07vkDBVqvn4JsP5drOio
    p2rM0AGB/1coVj9jqwpftK2IiWTKcEjwf7qbXRJdBQALebyuIuQoHkKwI3bOau/4
    b9rhLmDNVFNxDd/GkAbRSI2be8I6cUH9IZk3c1eJBtSbi7DNgZhEfZNWdR+CnMLd
    Op34sZv7j/0U4ri3oKov6yMdn2WGBlE+sQbcje2NtJb/DBUZcJVshpNrbAcKNQWe
    Hws31w6D0Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfFxSywN5/JffeKGeScVzsxPgTjffZBA51t7ArZ51PrUB6fxeA7D2lCxTDmatb4XBevU17fBGgsXSoixcUFx0XeLkipBLaTWYUVTAQ8E41UffGJy/Haqv
    PzssT9g2dzmtM6C6QFj5SDLzsDZPp2h35UfYprOG4Vi6dBZ3Ejz+pf5KyGqD61uewavfSux+u3fcrgDwBDfMtgrGueWpAj+A7j56wO0kAubrpCOxVyXW6Xno
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=9Rt4o3Z7AAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
    a=-4vmNQmCVSq4bfhZJvoA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=jE01AiZSAJ7eki2zvjzZ:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbeDKQ0B (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:26:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754146AbeDKQZ7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:25:59 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/24] ACPI: Limit access to custom_method when the kernel
 is locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:25:57 +0100
Message-ID: <152346395768.4030.17020230875159368659.stgit@warthog.procyon.org.uk>
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

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
---

 drivers/acpi/custom_method.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index e967c1173ba3..a07fbe999eb6 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -29,6 +29,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	struct acpi_table_header table;
 	acpi_status status;
 
+	if (kernel_is_locked_down("ACPI custom methods"))
+		return -EPERM;
+
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))

