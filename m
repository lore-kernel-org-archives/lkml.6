Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527160752-3-4830907967274548745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160750; b=mtil9+B+vZaehOSHL4up3Od7qhqBu2hxPjHg81bGb6FzsiIgxc
    5mUXcweISAPdpzO7e70j1uxpgdYSzcK7ANA4UeJk49ZEHbhguyXWPsOv5dWaUMpr
    MrfRwEK4LoEQpbVKARt+wnUPPwpMC55jC0yVuzzLNo8cu+5U4I7ms/Aq978YfxaR
    4KF/yX7pIsgwfuc7DII2/YynivyRwKqon3HNHIni51DM7Q+pNEXGDFoHyVmychES
    6NQXfDbs4DUlx2HEhLB+Wc1eJljeBqMfBOZUd5C+o/nGUhEB9ko2XI2BcoG4jv5e
    nBZVQrVykj/M6wmNOmWH/a8jLBe4Fuotg3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160750; bh=ZEkW/XvxAICBnEFFFvTvbmWdCatMED
    VdcgVnNzbH6pU=; b=Jl+Y+C42eSe7lNvw28H4QVYFmcC11rXSh6qFblVP//ri8F
    s+xi7i+R2v//w9VLR9n7XgiBIYK/Kh/EBmIHrosoqDxNs7QzumdqFlF8uURqMOKg
    EYHer+n7vE1NK5kEaOYsjPFYdlsVMMgxIs5ncdc2gwOoalKfpoh5ajbnkvuFW6wX
    085zxr9Kr3VT9MGchewwehGvUvPwhOKWBg+tcmzy6LFF8v7BQVIehl5Fj/I8JxtE
    icQ699tHKXj5SbQhwv/yyOiVR0vusCkqsOW4rpp3e3VeRx/NkEszBJmQJHtoxLws
    YNTKTPUoE/xCpWJ3oVyxx/HVaUCaYAeu0AJzC23w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=JNmohnaj x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=JNmohnaj x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHFyaAjFzwQQEpY/gLd5WZ2ZlgR5lRbRG9VaEq5u7YzTCjNIig1yujHF22oVimcrp0/HvYEgfn1zK3TIk3iqGehvGCXsY9C6Gp2dOZqM77yIXjoEGIfw
    6gcYaFHu9GygE54ZyLrnSDYe5cq6U6/41BDL12Q74hxMKctu7Gk3+64t9zwycdso091qo5KM22G3MT05UFBx2K8h0h0V09eSP29vkwkFu/qaA6LBU1LfxJI1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=iMImQnbvsJ8DnYXdvQIA:9
    a=nY-GhDmAe0MnQO6p:21 a=_UTuHhq-9TYV9EGs:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966500AbeEXJw6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966810AbeEXJwy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.vnet.ibm.com>
Subject: [PATCH 4.14 037/165] s390: add assembler macros for CPU alternatives
Date: Thu, 24 May 2018 11:37:23 +0200
Message-Id: <20180524093623.474749698@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit fba9eb7946251d6e420df3bdf7bc45195be7be9a ]

Add a header with macros usable in assembler files to emit alternative
code sequences. It works analog to the alternatives for inline assmeblies
in C files, with the same restrictions and capabilities.
The syntax is

     ALTERNATIVE "<default instructions sequence>", \
		 "<alternative instructions sequence>", \
		 "<features-bit>"
and

     ALTERNATIVE_2 "<default instructions sequence>", \
		   "<alternative instructions sqeuence #1>", \
		   "<feature-bit #1>",
		   "<alternative instructions sqeuence #2>", \
		   "<feature-bit #2>"

Reviewed-by: Vasily Gorbik <gor@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/alternative-asm.h |  108 ++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 arch/s390/include/asm/alternative-asm.h

--- /dev/null
+++ b/arch/s390/include/asm/alternative-asm.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_ALTERNATIVE_ASM_H
+#define _ASM_S390_ALTERNATIVE_ASM_H
+
+#ifdef __ASSEMBLY__
+
+/*
+ * Check the length of an instruction sequence. The length may not be larger
+ * than 254 bytes and it has to be divisible by 2.
+ */
+.macro alt_len_check start,end
+	.if ( \end - \start ) > 254
+	.error "cpu alternatives does not support instructions blocks > 254 bytes\n"
+	.endif
+	.if ( \end - \start ) % 2
+	.error "cpu alternatives instructions length is odd\n"
+	.endif
+.endm
+
+/*
+ * Issue one struct alt_instr descriptor entry (need to put it into
+ * the section .altinstructions, see below). This entry contains
+ * enough information for the alternatives patching code to patch an
+ * instruction. See apply_alternatives().
+ */
+.macro alt_entry orig_start, orig_end, alt_start, alt_end, feature
+	.long	\orig_start - .
+	.long	\alt_start - .
+	.word	\feature
+	.byte	\orig_end - \orig_start
+	.byte	\alt_end - \alt_start
+.endm
+
+/*
+ * Fill up @bytes with nops. The macro emits 6-byte nop instructions
+ * for the bulk of the area, possibly followed by a 4-byte and/or
+ * a 2-byte nop if the size of the area is not divisible by 6.
+ */
+.macro alt_pad_fill bytes
+	.fill	( \bytes ) / 6, 6, 0xc0040000
+	.fill	( \bytes ) % 6 / 4, 4, 0x47000000
+	.fill	( \bytes ) % 6 % 4 / 2, 2, 0x0700
+.endm
+
+/*
+ * Fill up @bytes with nops. If the number of bytes is larger
+ * than 6, emit a jg instruction to branch over all nops, then
+ * fill an area of size (@bytes - 6) with nop instructions.
+ */
+.macro alt_pad bytes
+	.if ( \bytes > 0 )
+	.if ( \bytes > 6 )
+	jg	. + \bytes
+	alt_pad_fill \bytes - 6
+	.else
+	alt_pad_fill \bytes
+	.endif
+	.endif
+.endm
+
+/*
+ * Define an alternative between two instructions. If @feature is
+ * present, early code in apply_alternatives() replaces @oldinstr with
+ * @newinstr. ".skip" directive takes care of proper instruction padding
+ * in case @newinstr is longer than @oldinstr.
+ */
+.macro ALTERNATIVE oldinstr, newinstr, feature
+	.pushsection .altinstr_replacement,"ax"
+770:	\newinstr
+771:	.popsection
+772:	\oldinstr
+773:	alt_len_check 770b, 771b
+	alt_len_check 772b, 773b
+	alt_pad ( ( 771b - 770b ) - ( 773b - 772b ) )
+774:	.pushsection .altinstructions,"a"
+	alt_entry 772b, 774b, 770b, 771b, \feature
+	.popsection
+.endm
+
+/*
+ * Define an alternative between two instructions. If @feature is
+ * present, early code in apply_alternatives() replaces @oldinstr with
+ * @newinstr. ".skip" directive takes care of proper instruction padding
+ * in case @newinstr is longer than @oldinstr.
+ */
+.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
+	.pushsection .altinstr_replacement,"ax"
+770:	\newinstr1
+771:	\newinstr2
+772:	.popsection
+773:	\oldinstr
+774:	alt_len_check 770b, 771b
+	alt_len_check 771b, 772b
+	alt_len_check 773b, 774b
+	.if ( 771b - 770b > 772b - 771b )
+	alt_pad ( ( 771b - 770b ) - ( 774b - 773b ) )
+	.else
+	alt_pad ( ( 772b - 771b ) - ( 774b - 773b ) )
+	.endif
+775:	.pushsection .altinstructions,"a"
+	alt_entry 773b, 775b, 770b, 771b,\feature1
+	alt_entry 773b, 775b, 771b, 772b,\feature2
+	.popsection
+.endm
+
+#endif	/*  __ASSEMBLY__  */
+
+#endif /* _ASM_S390_ALTERNATIVE_ASM_H */
