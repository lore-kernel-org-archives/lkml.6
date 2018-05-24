Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164178-2-15319947144402554085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164178; b=M9r670RwtlJcuPrc15KOwfQQf6PdbH0epmusqktBuL3nnPH+5C
    jHJvD9Bk9nPRxcvpvI6kwdltB53HQ3WgQzbnJmIbL0EJWPk3A4kQweQDjIHru+ao
    jGwtxI2ZnGOfrNPfUhaK4DsfKH/iyarYq0kyHY6wDtbWba+tycnOtDFsxguNWpUH
    +OtHeYqhkxoARxnfARR5Ye6SRojkB3wMlA2K6hGSennSIA+qoEhZ7Aph5nFhlxug
    eUfLPbf2zeAtBSG5/Aq2Jp/2urKZ6HXF/4OrEqSRA2A3OMRvrTvTayLNO9S0kTTn
    tB1ZPjk+R03cGCww22MQ6L4Qv/HO5SlJrgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164178; bh=1+CVbk1q5c5SilvHFhaXTYZ6RtvrMY
    lZHthwWd4ahqg=; b=XXuyZv8xxlrZBadO40K9yD+7NiDeGtY2D+j0rn0otRN98i
    AgZgvVDrJlHtHlwyY/J7TwT90Gmp6MJhyEQJv/KkWoeVbesdx8o8Dt6MnKuGYNcy
    RpSg0i+g7zePcUh1mACq1m0Af3CedqrEsHPBiLh27Gl7OcPd3TLTVLNhbwXyr43f
    bweEZYsB8r88WvLyHkPc9aG1DJNCi5kb9YFU9d5VZoAwHAgTVvdZNEEtaPHaY9Lu
    9s1Trk42SrN4NoGd18ZfbbZ7HUV1FczCjiNt4Nvut7vOhqYKgdz3HcGZsr6XfrZL
    HhrG31pp9aKxXjFlVTCcCNbLAUoDGEFN4HYMXaIA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=xEQh53J4 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=xEQh53J4 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOtJAtcwti/x+jBOzoj2Z2cLkNqF+juJ/K/s/mISjJIyTYjH5T+DH+w2LVngXmo75f3Ifp3yMR9A/fZZsKfkxAfRTgCy6MQ7wW8w7IQlhkxbpqy2rVsT
    nfymCpcBORUdGbOm/7C1PcUZREwWo2Gkge6n6qxTqjjX+qum5PrTakFCrTSJya6YVYLFWHGUC1xkXj9iQ7IsK+IRAKE9LBp9wYszUKqIURB+feHd7GP1nKbw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=ag1SF4gXAAAA:8 a=Bm5lvbky7RdN8-YtJ6kA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966302AbeEXJmM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965977AbeEXJmH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 3.18 37/45] ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions
Date: Thu, 24 May 2018 11:38:45 +0200
Message-Id: <20180524093125.494745514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 0d73c3f8e7f6ee2aab1bb350f60c180f5ae21a2c upstream.

Since do_undefinstr() uses get_user to get the undefined
instruction, it can be called before kprobes processes
recursive check. This can cause an infinit recursive
exception.
Prohibit probing on get_user functions.

Fixes: 24ba613c9d6c ("ARM kprobes: core code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/include/asm/assembler.h |   10 ++++++++++
 arch/arm/lib/getuser.S           |   10 ++++++++++
 2 files changed, 20 insertions(+)

--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -448,4 +448,14 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+#ifdef CONFIG_KPROBES
+#define _ASM_NOKPROBE(entry)				\
+	.pushsection "_kprobe_blacklist", "aw" ;	\
+	.balign 4 ;					\
+	.long entry;					\
+	.popsection
+#else
+#define _ASM_NOKPROBE(entry)
+#endif
+
 #endif /* __ASM_ASSEMBLER_H__ */
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -38,6 +38,7 @@ ENTRY(__get_user_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_1)
+_ASM_NOKPROBE(__get_user_1)
 
 ENTRY(__get_user_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad
@@ -58,6 +59,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_2)
+_ASM_NOKPROBE(__get_user_2)
 
 ENTRY(__get_user_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad
@@ -65,6 +67,7 @@ ENTRY(__get_user_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_4)
+_ASM_NOKPROBE(__get_user_4)
 
 ENTRY(__get_user_8)
 	check_uaccess r0, 8, r1, r2, __get_user_bad
@@ -78,6 +81,7 @@ ENTRY(__get_user_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_8)
+_ASM_NOKPROBE(__get_user_8)
 
 #ifdef __ARMEB__
 ENTRY(__get_user_32t_8)
@@ -91,6 +95,7 @@ ENTRY(__get_user_32t_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_32t_8)
+_ASM_NOKPROBE(__get_user_32t_8)
 
 ENTRY(__get_user_64t_1)
 	check_uaccess r0, 1, r1, r2, __get_user_bad8
@@ -98,6 +103,7 @@ ENTRY(__get_user_64t_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_1)
+_ASM_NOKPROBE(__get_user_64t_1)
 
 ENTRY(__get_user_64t_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad8
@@ -114,6 +120,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_2)
+_ASM_NOKPROBE(__get_user_64t_2)
 
 ENTRY(__get_user_64t_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad8
@@ -121,6 +128,7 @@ ENTRY(__get_user_64t_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_4)
+_ASM_NOKPROBE(__get_user_64t_4)
 #endif
 
 __get_user_bad8:
@@ -131,6 +139,8 @@ __get_user_bad:
 	ret	lr
 ENDPROC(__get_user_bad)
 ENDPROC(__get_user_bad8)
+_ASM_NOKPROBE(__get_user_bad)
+_ASM_NOKPROBE(__get_user_bad8)
 
 .pushsection __ex_table, "a"
 	.long	1b, __get_user_bad
