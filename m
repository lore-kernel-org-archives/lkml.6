Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464131-2-4864107279447239819
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
    1523464130; b=FkWhHaYhJRC6RHfnLKANvdKDozzurvd/YufDdYC5cNb/kNqrlz
    Uio0oz6/e+mCvC9EMz39NGckon+I+rDINGDBpsMtV02cUtZVRpOxv6brgNImwPqj
    VZBFqjjZ6cEmY8/wXsuL1FYWUSnPIIqNhAb/LNrN4PwxmJ4htNZfxVeq223PC1c7
    7IfE7QsQXJtlq+UDTt5n84EAJLTIJJ+mQsNZDgXipbqpN2JTYM2X+HdEaUVNXXEE
    JhZ7xF17VZCTEigJMzobglVdlj62abckKlKGN+D3ZEEpImbYA/64DpqxjcZbZxp7
    OZ0iXEBlDE3A5AJlmuNSSFSYKod+TF0ZYm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464130;
    bh=HzO8MXPl3X229/0aHIcGFltfdt70XAisq1a8d321064=; b=T1OzXAjDZZip
    TqkROAzIPnZNp9FBh6VDcAW+ZEPNaHsWfQvRccN5vXHI5a8eONOtd7b2MVjXSTHz
    KqDj256bsZBvwR/dsa62BYRWeT4IS60e67DJKFW9+H8pH3o8pQn981i1UBezVfja
    IfHIiewxI7sMCqKrpOP6M4MBym2RqTPZggwpyGwI6r9nUY3RJSG6+tnxe7rW8n75
    OUNEz10syEHuS08rTwvLkTlHkXs4FecIFqqqV4O61imq6zxp67V1I2OXE7WehK50
    7MDikFlvFRkrp0NKpknQSLF48IgVbZhkgxVdt0anEoFaG8fAcQOX9DE/YeGhJK9a
    QzvEVpRTCA==
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
X-CM-Envelope: MS4wfPoOXcxL9dQAqNAy9MHpTCoua8Ae9yamMV3DoVtVpS8Do3b7SiL+R58ur9xLX4NKklE07MoAvYt6sUYC+kfVbXDcz6BSCa87t6FFDvRMjl7eCWp/TF8Q
    hqVoM/pB7JScG2baEGs5L/u7ZbwTFbtCFHGCWrqfMtPR3Ctt5z8SKPGIaNXSg35VqKV02nV3FsILQd839b1kP/THhZaleUS+Lxof9yVSxKuF1hGPGXTPz3ZA
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=MvuuwTCpAAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
    a=wX6tjIgA_ZxpqKf44AYA:9 a=8Ds0qXTuaD9LKBZJ:21 a=qxRUKna-qaE4gmo1:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=dVHiktpip_riXrfdqayU:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754212AbeDKQ0V (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:26:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753424AbeDKQ0S (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:26:18 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/24] acpi: Disable APEI error injection if the kernel is
 locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:26:17 +0100
Message-ID: <152346397696.4030.2692221040490871671.stgit@warthog.procyon.org.uk>
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

ACPI provides an error injection mechanism, EINJ, for debugging and testing
the ACPI Platform Error Interface (APEI) and other RAS features.  If
supported by the firmware, ACPI specification 5.0 and later provide for a
way to specify a physical memory address to which to inject the error.

Injecting errors through EINJ can produce errors which to the platform are
indistinguishable from real hardware errors.  This can have undesirable
side-effects, such as causing the platform to mark hardware as needing
replacement.

While it does not provide a method to load unauthenticated privileged code,
the effect of these errors may persist across reboots and affect trust in
the underlying hardware, so disable error injection through EINJ if
the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
---

 drivers/acpi/apei/einj.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index b38737c83a24..6d71e1e97b20 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -518,6 +518,9 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	int rc;
 	u64 base_addr, size;
 
+	if (kernel_is_locked_down("ACPI error injection"))
+		return -EPERM;
+
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
 		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))

