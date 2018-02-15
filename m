Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720821-2-1420226251071558526
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720820; b=DjPCwdNTWX9Nk6WhxTWEPpD09Pkx5oCmzJKApTql4bNmTeG
    xzWcJPW9+kfTKYlbPVcKeTyLaiY3E6gd7xs8yRwPNFgM/SJRRI0iep4c1aVeOF6s
    bIFb/ga6jF4b1tjmvjztnHABSTOmcQfJOaTRRoDG1cNhz3XlfP1EVYOWZNtVPr6H
    sbOy+9RSBoP8lit7m6Jk+VPpFGEXLu3oxtSCMPhZnY7xjdhLV+YNjWk4NUW2iEBL
    PJYc8XfMVH7xv4iWNCNTR5R4AtY2jMPGFUlq2w3n3qJavfnpLhMawHnvN8CAMATp
    Myo8RkgYuh02TVkOHW930FWACj7jBwVeRPJWM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720820; bh=YJCB/7umahOcSxDUIGemTgIudE
    OGydY5KvgWlWdqAk4=; b=g+ywPaowdWHr3PkCs5K6MaLO2nefgubFoBs9OXmjIN
    CY/lFgxIwVqiPjz9znfHzYSYywXXAxYBqRwTm6U+naCLYw3G0eoPf6fbVs3r6x+f
    OBTMpHrPvRxRTadq73ABJwmAtqfGq/qqzEC1rE11bgzzMTDiH+7OO5bZKAoNEjq1
    fSwXh9IGGRn7uljwZwVIgz7m/xms80JqX33AiMmR9XUwqwiFWBaXFltw2WSjPouv
    woqols2uTo4S8pG9NNObtkAmG6uCxQVOXWtWgv3JOwDciys4MG67y6F8w8kUyWyR
    WlmRSSLORe6LbXO2dA5gos9UTyWaK6nS0SD7dAdXmE+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161923AbeBOPVB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161799AbeBOPU6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:20:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 006/108] powerpc/64: Add macros for annotating the destination of rfid/hrfid
Date: Thu, 15 Feb 2018 16:16:03 +0100
Message-Id: <20180215151223.225237960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 50e51c13b3822d14ff6df4279423e4b7b2269bc3 upstream.

The rfid/hrfid ((Hypervisor) Return From Interrupt) instruction is
used for switching from the kernel to userspace, and from the
hypervisor to the guest kernel. However it can and is also used for
other transitions, eg. from real mode kernel code to virtual mode
kernel code, and it's not always clear from the code what the
destination context is.

To make it clearer when reading the code, add macros which encode the
expected destination context.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/exception-64e.h |    6 ++++++
 arch/powerpc/include/asm/exception-64s.h |   29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -209,5 +209,11 @@ exc_##label##_book3e:
 	ori	r3,r3,vector_offset@l;		\
 	mtspr	SPRN_IVOR##vector_number,r3;
 
+#define RFI_TO_KERNEL							\
+	rfi
+
+#define RFI_TO_USER							\
+	rfi
+
 #endif /* _ASM_POWERPC_EXCEPTION_64E_H */
 
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -50,6 +50,35 @@
 #define EX_PPR		88	/* SMT thread status register (priority) */
 #define EX_CTR		96
 
+/* Macros for annotating the expected destination of (h)rfid */
+
+#define RFI_TO_KERNEL							\
+	rfid
+
+#define RFI_TO_USER							\
+	rfid
+
+#define RFI_TO_USER_OR_KERNEL						\
+	rfid
+
+#define RFI_TO_GUEST							\
+	rfid
+
+#define HRFI_TO_KERNEL							\
+	hrfid
+
+#define HRFI_TO_USER							\
+	hrfid
+
+#define HRFI_TO_USER_OR_KERNEL						\
+	hrfid
+
+#define HRFI_TO_GUEST							\
+	hrfid
+
+#define HRFI_TO_UNKNOWN							\
+	hrfid
+
 #ifdef CONFIG_RELOCATABLE
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
