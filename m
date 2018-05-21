Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937996-2-15636807485623823910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937995; b=matvAsNb/ahwiKLI+fFVP/b6lMB07UBZ1jTiKV4F7+x8Ikr/pX
    fcdqYww/rF3OoNf8jM2OG/5v9flWOWSTqh7u3pfUWnC5atB3KPBoXUDAaAc3OfZr
    dTQvLXc48fRAYtqJzN3hXUIB7HqnPXYUrqYmVZ6ztP/AQ/z8O2f/2+/GHviAmq9X
    wVWyl4E9+fXMns0eFxZrgOvD5FNcH2FUjqPGwq3QXHrjMWBN5r/eZ9+Hf8BjAZgh
    ZP5DWPrbymEykjLksPRjoEOf8vHBeB4hlz+um9dqw/ESLxd4vkO3CQvh0YjIc617
    lAxXfXlxtGVhJgZdkX1kJ165+Rrho8dgH8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937995; bh=xBSRX4Yolhv4uuaMQnW10KbzHTta+T
    GMri0yGGBQ4wA=; b=H/F6IsC8MKzh85PaQyrHlVkWXL6/oSuV0DzmOF0DjB4p95
    0rVY7PnjDl+kYSyfa5DBtPEi5RyWwkK5tY91gVXzyrL7EO/NbOCSO9SoyhW60gWm
    nqIcazu/1G2BaLXM4zJXsfs5HYzpRXUXdANVFguxUMS8L6T1TTL6v88HZzpwDiKF
    sR8InCai55+WHV56xXCkS6le7v0IJoq0osbxBoqulQKUhf+QAawlLY2SUQc/Ami+
    DJoER1zRkA7/PTXZ7TyOhb0AEI12De9eT1or/6PJCR5rXPs2WkFBwR1WIrFjjdA7
    AefD2apJ8ZzPgRqBMzRSMWhhW8g8IlzkPPHjaiEg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=2nvfq2tj x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=2nvfq2tj x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFrfAhCdriuH693aKk+cQwN0nZHd1B54iRbkQXROVqP5FQ+pLs/4lrnzqBKTnkOYpgORPt+BwYDZRDOIw3OpSO/CcXn5GJ+Tu9UC/Aw6mHwZPbkC/5Mf
    S5sDuVd+RIfm97ngWJyFG1thYFI20P/pzfcNVhejSB1z+InI1Ixu7Mq3wdvfA6+CvUMtSAfNcWq3Xfl0W4yCRacAif8bSHhKCg2KKtGFWInV1uvbCY15ZXRm
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=SZ0p3u-7cUBWybIdt-MA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeEUV0c (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932536AbeEUV03 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 068/110] x86/cpufeatures: Add X86_FEATURE_RDS
Date: Mon, 21 May 2018 23:12:05 +0200
Message-Id: <20180521210512.229504900@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 0cc5fa00b0a88dad140b4e5c2cead9951ad36822 upstream

Add the CPU feature bit CPUID.7.0.EDX[31] which indicates whether the CPU
supports Reduced Data Speculation.

[ tglx: Split it out from a later patch ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -333,6 +333,7 @@
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+#define X86_FEATURE_RDS			(18*32+31) /* Reduced Data Speculation */
 
 /*
  * BUG word(s)
