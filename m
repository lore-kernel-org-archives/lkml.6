Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526938377-5-11568258950250790094
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
    1526938377; b=YRAw2EyBm0lJffiznQF6KTrCMjQoCxIkQ5I1awqSZ/87RRBkkd
    dB76JPLbpRtTuae38Mf2jNUlHOxN2QCyanMR8kXjUll5wAvf1QWFwsTt0GuqUWFE
    ubcaO2381TRnciE9n3dkZtIYHbf+KlUoiZHsd80WjV1JTcd2h8z6rESCl2ZIv9qM
    u+E6K2vK/dwMGgM1VlAoEIYQK1jWx6iPjAOfnbNE2Mticma77J47mHI1/ARiOw1G
    kZibjLGoe7SsUw/EXfA5bTKSHzmzx6DLgPTuMHyaOkZS7CSixzZcKfkV+UIzFlho
    VfJF0eJcYBTDKBupdzFjJYXNEjKw5FTkGOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938377; bh=y05wfrRwglc4jN8l9OEQ1/DFGnUqfb
    zSNdrqQnk7jhY=; b=a3uy5uRN1CjmQpeTBVZVV+OtdHwqP1acUFI47845XibjkP
    ktgoTZ2q8AOTOdVBuKMuCKZAXMxqVDfD1Z1QZfDGjQnZ5GgdBdqmxqZ+zDO3cc+j
    Q49icTiUUyxCPscaNR/FniShYVwMFa9YTDzdlwv8oz9ZeVMCtmZAH2AfQUZz9uY0
    AbBMLPugXGcqx/uCC1GCGLzGusiJ1APoJgJB6hg7e04QdL+V+rPrtCc4wmIqQTTE
    vY6T2K2H5Iv+jJq3vfRIvGIfn4m995VhoAZR5yMR4X33OWoG/yQtgSDKmoqj6vha
    cXs0SSsLQFoA8B7k21b/Ava+X0IiDRzd3ecPf4hQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=BWP6ALTh x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=BWP6ALTh x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJhLM7MGlPIXUiYOV/KHIXExM2g6dN4ucfu9l5iomMI/5imJ0Eyy5IHceRltp37a83Lal2D+X1LfeXXf5mdEhowegiB+hTGhHK/DNVGu50/2Lupk/U1k
    32gpf7H9MWV5cve4l7XXIz0CxZ8xVVR+AqBa/KcqqgpPSmRLjaD7RfaecYZvffP9vLf6irzFaSi+Trc7s7sxPWIovsxhSsdZ5RkHPe0MGSp/SDIHP/1xLKjS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8
    a=z8yJcAMKaryFdafcbzYA:9 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932531AbeEUV0R (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932510AbeEUV0P (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 093/110] x86/cpu: Make alternative_msr_write work for 32-bit code
Date: Mon, 21 May 2018 23:12:30 +0200
Message-Id: <20180521210514.103306437@linuxfoundation.org>
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

From: Jim Mattson <jmattson@google.com>

commit 5f2b745f5e1304f438f9b2cd03ebc8120b6e0d3b upstream

Cast val and (val >> 32) to (u32), so that they fit in a
general-purpose register in both 32-bit and 64-bit code.

[ tglx: Made it u32 instead of uintptr_t ]

Fixes: c65732e4f721 ("x86/cpu: Restore CPUID_8000_0008_EBX reload")
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -265,8 +265,8 @@ void alternative_msr_write(unsigned int
 {
 	asm volatile(ALTERNATIVE("", "wrmsr", %c[feature])
 		: : "c" (msr),
-		    "a" (val),
-		    "d" (val >> 32),
+		    "a" ((u32)val),
+		    "d" ((u32)(val >> 32)),
 		    [feature] "i" (feature)
 		: "memory");
 }
