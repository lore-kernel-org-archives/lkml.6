Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-69720-1525852446-2-9889968269666030652
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525852446; b=YgiifyGE8Suc+rh1JoU78K4K9Hj8ymAfeOaQ+aZwQNzHsEJM7r
    1d/WWM1qHoT8UoGNrDRl7HhhdjxO6NLe8TBvOJAxutqX0tn3dqoHguVoebs/cftb
    W3uIQ7LSix5CTzTkWoRxRNvrAM8WIC+/sNOaP0VcZK+KBjN9XfcuxNaJWxJlLKQE
    sW3MOky5nlJjRt9BPCebBKdBN0DGA3XjH2dBy44YFbEGyUcXWSz4FWjB761WQ794
    Qycmqund7Rbhxrw57rK4ed4Me37dHLxgDzs5UnKu2rCtkW246q9r+dXamjQ2DRiH
    TGVYbHkQIoUHYTZADdyCvJKdbIOtsD0W0s0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525852446; bh=eK28HOQgde35W/56fWpdOXBRlV5RLU
    pa6SORyzZoWzE=; b=WnP9Wd9UEmqnT+jDEGd6BOJg3zIR/wo6aPKZyhOIAQEUy+
    X+nwtoXEP+2fL0J6Hhk/EpwkUEDxf41cOJg/Fqy0FpZj2EF5+M3gLV41iOd/N2ve
    0zoVT6pX8+lVs66BaQf2ve/dpWT2JnDrbhxaQ89QrlCaVSqHthU5wy5T/JX6oM8A
    C7Y01f8YdSjt8R1YKj3FSaFa5EH8MgdfRIJh+dt91LOWSXWm0eiHoMCxG/Z4u1Fw
    pjMKaa3dLDuYKsjUVm0k/9p5CmKg3T17lrhrTDUp8uXYXejfOtWmUGhSRDuOZQWg
    Q0+usq4fRfYbtBBKDSmGXhYUrmMD1kJ06LEOS7JA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
    header.i=@nifty.com header.b=ulUUXMic x-bits=2048 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
      header.i=@nifty.com header.b=ulUUXMic x-bits=2048 x-keytype=rsa
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
X-CM-Envelope: MS4wfIEVvbMqclVmUlU1qANfmmZph2o99Pa6/u6i9aOPrDa60XyeSXbPeInoEa6mDd2jFYtrQdI4g7fYc8SxN9fpwoMqIOvOylp8ztVApsIwAxohGKvhd4+C
    tiuf0RXjAiqr3mTUtQcgoOfTfAebW4vK3HuBNEAN6Jmy3S/cPPoZxulHj+6n9ztYBCm/bAC1YijRaBFqvB5kJ7s43Qs3rfP8hkhmHkGSSkMrA+kblPE1dpzQ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=c-n4J4-pAAAA:8
    a=IvD3CSTIwG9ghnhG7sMA:9 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeEIHyE (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 03:54:04 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:41699 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933930AbeEIHyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 03:54:03 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w497rQ5B001863
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:53:22 +0900
Message-Id: <1525852402-29269-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for SuperH-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/include/asm/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/vmlinux.lds.h b/arch/sh/include/asm/vmlinux.lds.h
index f312813..9929556 100644
--- a/arch/sh/include/asm/vmlinux.lds.h
+++ b/arch/sh/include/asm/vmlinux.lds.h
@@ -7,9 +7,9 @@
 #ifdef CONFIG_DWARF_UNWINDER
 #define DWARF_EH_FRAME							\
 	.eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {			\
-		  VMLINUX_SYMBOL(__start_eh_frame) = .;			\
+		  __start_eh_frame = .;					\
 		  *(.eh_frame)						\
-		  VMLINUX_SYMBOL(__stop_eh_frame) = .;			\
+		  __stop_eh_frame = .;					\
 	}
 #else
 #define DWARF_EH_FRAME
-- 
2.7.4
