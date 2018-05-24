Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527163777-2-4458082868990680829
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
    1527163777; b=Yx8b0GInZsEiT13cFVulpAygULeRxBHTXbmIlN6qj3EEgoU7l3
    ZjeUXEm60nqt5Jal4VVMYrAwn9JHFzcbTWsjtuMqM2zxVyQSXSrRYiRHeIR9h8za
    Hhx4kea3p0DZHuN8T/7CJtpFYFcbg0+dHcHYk0anbg1MBMHsSlBIfQNGGM6w/fo2
    2wsLNlq9jCVUiSq9ehb2SrgPudpfRydCpeLXPNIc14c/58zY44/CreuhwK8ZFak2
    y80R6rC0lPh4ief8u4ElmmDrl9DyEb1+7ZwaGmw/Bzn/tLc3VFeegdOObQhHnzWC
    nMPGwUnILwI5SOlHM/OTdsqlJK6zb04za6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163777; bh=DL6d4rcFNsbbE4LQNJPV2Ax3rn5YRC
    iHnMPcQsKZ6hg=; b=lcmH82QGbeSZ/kgJ2MrvVMd0dNVFsqbPL3Gys2UHN+R/30
    W8AK5t7tMRpSQrGeB9tDEHez7VXn3VWge+1CVcfUIHEYXGNOZzv7Ci1eno3WVsPe
    IlvMdmh7hKqyov2fTqx4wp9tBrIyheAcBz874OmVMFRy6P3LDsjQISHpMiXOxOL/
    JvSn8+COFqInYanqb4yscisQukHQdv6LV8cdvbavty6aLehq6IAXJP4evmbqy19n
    osJCYCQSaTAPAOcU0oQN3VSz1b/QJKRLA5fVc2Op9+1OFf6I3r2nn7e+7BUbq7O/
    wbz5MDLudFTWo497/qhswacqOqshZsImzRT4wKfw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Z6P7xKCG x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Z6P7xKCG x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfA5rwyTgS2Acay2kplL/CAv0rX9J+gymxHSINogMqnKuwGJ0yJCmXSpsY739W0SvXskk0rj9ocHuF9sHFYVcFNw3zNoJoiQFALwOQ/zB4vx06om99ccA
    by4/gKoSjhLzCkcrWIoKMK2deBGDVVAeFMY/uQ4DjPQv+IRvv9U7rG151dK8n3i0Gx7Uz3oW/X241rH+MAQ8RDdsFwxkomFA0I7nSpcnmQVWy8YIyC97BHpJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=ag1SF4gXAAAA:8 a=bhZMS0Sl6ytBHf_z0TsA:9
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966019AbeEXMJU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966486AbeEXJn2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 4.4 22/92] arm64: introduce mov_q macro to move a constant into a 64-bit register
Date: Thu, 24 May 2018 11:37:59 +0200
Message-Id: <20180524093201.122741037@linuxfoundation.org>
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 30b5ba5cf333cc650e474eaf2cc1ae91bc7cf89f upstream.

Implement a macro mov_q that can be used to move an immediate constant
into a 64-bit register, using between 2 and 4 movz/movk instructions
(depending on the operand)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/assembler.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -204,4 +204,24 @@ lr	.req	x30		// link register
 	.size	__pi_##x, . - x;	\
 	ENDPROC(x)
 
+	/*
+	 * mov_q - move an immediate constant into a 64-bit register using
+	 *         between 2 and 4 movz/movk instructions (depending on the
+	 *         magnitude and sign of the operand)
+	 */
+	.macro	mov_q, reg, val
+	.if (((\val) >> 31) == 0 || ((\val) >> 31) == 0x1ffffffff)
+	movz	\reg, :abs_g1_s:\val
+	.else
+	.if (((\val) >> 47) == 0 || ((\val) >> 47) == 0x1ffff)
+	movz	\reg, :abs_g2_s:\val
+	.else
+	movz	\reg, :abs_g3:\val
+	movk	\reg, :abs_g2_nc:\val
+	.endif
+	movk	\reg, :abs_g1_nc:\val
+	.endif
+	movk	\reg, :abs_g0_nc:\val
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
