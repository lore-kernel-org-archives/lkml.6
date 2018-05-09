Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-68406-1525852312-2-4642203726299682339
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525852312; b=ByswSP4Gc3KpdfTGBg0dbs+s+jJq7X4W6O+ZcSOtdOs864M0Y0
    ZeipiEvjKpYaDVQyFyNMr13E6onqBqglRHFbgszkZo6qDDYfmCnULetqx07B5sNw
    Pm8B3CqMyxUiqqOsx6vvqc6JmSg4YvZP7CyBq9KPWlZSWbP74lhNhT24s/x7J8N0
    B7LOMxjYstF8yfuEgCwzDdkWmZ6RkR7mZf/H4CHPdmOzj7APHYf305ng0nrYTtiu
    j4PCOrGDQ5t1fz1hyFyqllSEkp4aM1IalE3hSYeTeo/QX+XAumV4W+OqEz56v0Oq
    yJ62c37Ajtw0WGI0BN+ECJ5cg63s7YsS03hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525852312; bh=dAwDArEBu5JSbsfB+Gc3yLepeme1WO
    BhvLTZddeZO5g=; b=Ywvo9EkTNgSufqVvdiIea8gWTYa40PRyEsyatAHHA+/+w1
    hbKhfOSLJTRYiDKvIX9NsCKAH3jXzUU7fFiRm57eKgCjS04x/WhS/+DeBsmLXa4o
    upFuh/KA54ChAY8sv1EvJpS3MS5xihb3Pg8Ew5jZdTsx1WcZRzrQWgkCRtmUdiyO
    dPpafQAqR7+x5BGVIj9CCjO71A+qj2wm/717bwpNmayqAURuRUEY2IkRHYBSJOhG
    PcXGU2CZHGAq2rONocILwfMdaLXBLnZMnIjxucMooDffXDNzhhP/nEVJr+CBXyGB
    Pi2/YNiHkFrnBKWMG6XFWaMAihWGjwRh4o4eFKkQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
    header.i=@nifty.com header.b=FiOGPr/F x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=socionext.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
      header.i=@nifty.com header.b=FiOGPr/F x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=socionext.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMi9un/UUyHdWCQwPOC9ozFt04cu3XAuX7jMnZdDUTXNThSMTq9s3re5ccvzPcba4t4z+og8Zp+5lAAjTkSFr1uUhM4gKS+wTiogT/uObF+XxZVDsR2d
    PDilC5KiYgRw/TSw9fYSh5COV9Me92eMgOVXyWIRvuXHRD1qqNtcTlpO7uQFVdAfputHGiyyaHCcEDgCWRFqLZoudud+aWbDEyneJFxxg9B+q6BrS6h409sT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=c-n4J4-pAAAA:8
    a=ChmWbc53oW39AlPumEIA:9 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933848AbeEIHvu (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 03:51:50 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:27164 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933715AbeEIHvt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 03:51:49 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w497phvd018758
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:51:39 +0900
Message-Id: <1525852299-29134-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for s390-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 08d12cf..f0414f5 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -82,10 +82,10 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
-		VMLINUX_SYMBOL(_sinittext) = . ;
+		_sinittext = .;
 		INIT_TEXT
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(_einittext) = . ;
+		_einittext = .;
 	}
 
 	/*
-- 
2.7.4
