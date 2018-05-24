Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527155170-2-15543599361208145555
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
    1527155169; b=miWcaYs4Ok/2G9glKHdAoSEelDawlmUyCCkT7NPi+YDy1SBVTT
    gIRwrMj0QFDRmTrGL0zBUBaTCf3jl0hJ36ZNMkrdp2ftVXJyPeOVrRZ8I5/WNuFa
    WZWmaAwLihoMOWJJnS+6TEdQOSRCy/HglRKnjVlaFX1b1OIf3tN7IBFboJ40vinl
    sqOlz22+CtqR8XfHAUhzUuI0PJceW85/QQIPdSyYuqiucWycOBEPgVJsareyr7dT
    P26OtSvfWMoP7fWT/aTwm56/Pj46PC6R0FZl7jir7aMf8q2ARE1UnrM/uEPJuXHR
    heTUmKq4z9L7GYgpAREwsViOAs59/Ek6nFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155169; bh=p3YlXPmpN2xfyOz99/2eSGv8H+1q9a
    q3L2dv5ejfOb4=; b=aeOnLS5uwl8bnB3+swIUNMyqTQFa5OLr8fOqyZfUKN2tf9
    zez3aLly2+PhOE1UoO2SA6X4OxpfR/56h1oJ6pD73p19KkUFlpr8zvvnoEzedYeZ
    PRhBrG0E3ILzpBrYm6XxvZUmwHnqnpZGWBmeVfsfdwd1UUr6fz4TIQnaYZNDihlC
    jNg1dDF5Nu4YN0VzUHrZ0ofVV9jnN2LZzFvXLFc5ssoORwxAXXuy6HBz+97L3axO
    0OU330RCguNdZyZo9gXpQUwevetK/VteK4tzAF8usdmDHcB4OAUAPqX+L9H4tRDk
    6FelLKAewVuJg+Mu4P86eNvLMjHjCqwr2LKMLKEQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ISap7IsJ x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ISap7IsJ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKCHgtZ11zfpdkav3rBtxkaGmYURSOYGotW4SVQQ8CK4eOK1eTvEMQEhSdUS53ZWJs8lRCRYH5cTOO94XaMV0jc+QCmJL87P02gbYY8q3kqE5WRv5qL+
    Agec6y1i3G74IaCsmbDaYKvRumlyuFef3ZWE0+uE4mWZFAxk6zfEzBh7SACn1xisRkADu708AcXedG23Ou5ysgggazzndbUREKSXSDWhiY0SU+xq7cq7QkfO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=iMImQnbvsJ8DnYXdvQIA:9
    a=2rckGudTEIC1C4xs:21 a=_UTuHhq-9TYV9EGs:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966873AbeEXJqF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966857AbeEXJqC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.vnet.ibm.com>
Subject: [PATCH 4.4 76/92] s390: add assembler macros for CPU alternatives
Date: Thu, 24 May 2018 11:38:53 +0200
Message-Id: <20180524093206.575196384@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
