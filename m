Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653848-2-1790893974575848810
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653847; b=WkbqYF52M4Wwvv/LWCDrnUHi6Ho8E31c1YKBK0FdRej8W3UJ14
    cgvuk3EDutdlk1RZHFHMRLcmq34KXHiQd/B0JbE3u7d0BfPhPjU355KgIMTEaT3U
    bP/GSHjGwgKXMexz5kTBILZ787QRsfh3YdaXfvCoL5A0e9h3zEf78tY9/X9wDBQi
    M1tN+mRVekx9vppKngycB5ve2URV+ZJFQ7Ky9Jd24yE9yBpzQhzf1NiTXLAtvioS
    1UClB5xUDHM30uI67VlzqlZ4aJKXfgHwX0+QXn5yp4YhCeQy6ngV3C/gMidI9Ue6
    ptutBxmDOwZt3fSobQUHJgtcGjYGnypSdLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653847; bh=Y21n68hYk7lAsvbOYeXgxri4g1Asy3
    LTwMgnlU/xwzo=; b=QAz0QJXLpKIHKtUi8XRJtXVgdB5kRqIeWPm6JdED9TINXW
    wD+IpoKK6h3NlWiyt3itP/CeYCTF0X9Ca9FKhhTUaHB/QN6swwZk2CERk/+mL9h0
    l8nC625OuP+AKd1BVK4FoM7IoGuXzqbf3C2E0vk/namLxLSbtj2eLEjlz8DcPrvk
    NKftKGkDM5GP5ubXiPBUlejc/z01n2krzZKwMc67XsosD5ArBX5bqKzy8YyusNa/
    TceleucRZj5Pcx7DRa2o8TOoTurzlcOjaqZMEf4darRnUsiIfbdisuMoVHXxJtQd
    s4GCsBPr+s7/uIVsVekbNutvIMWNm/+WGt7XWZsA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLdU+ULKKNsTKI/rdC7KrJ9t81swImNLs6Lj9RqlLuoiHJEzUOQxDT4yFnoGio29PvJspDCGuk+Q/kYn0bJLGzP8xfeGbMyE8de7XCmezboVeTC8Rjz1
    7EVI4SP07cMOn4JS9d/ep6iYpoLbu697txwIgbt2fjIWClMmmrUIOrkH+SzJBXAElF/m+sbO3yevepvH6ljXrGaH7SE20+AE86KLz3a34svCzGheURLmZaNF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=KE6AYRTJDb_r4OeTZP8A:9
    a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeDYK4j (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:56:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbeDYKnL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 143/183] arm64: spinlock: Fix theoretical trylock() A-B-A with LSE atomics
Date: Wed, 25 Apr 2018 12:36:03 +0200
Message-Id: <20180425103248.294024456@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Will Deacon <will.deacon@arm.com>


[ Upstream commit 202fb4ef81e3ec765c23bd1e6746a5c25b797d0e ]

If the spinlock "next" ticket wraps around between the initial LDR
and the cmpxchg in the LSE version of spin_trylock, then we can erroneously
think that we have successfuly acquired the lock because we only check
whether the next ticket return by the cmpxchg is equal to the owner ticket
in our updated lock word.

This patch fixes the issue by performing a full 32-bit check of the lock
word when trying to determine whether or not the CASA instruction updated
memory.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/spinlock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -89,8 +89,8 @@ static inline int arch_spin_trylock(arch
 	"	cbnz	%w1, 1f\n"
 	"	add	%w1, %w0, %3\n"
 	"	casa	%w0, %w1, %2\n"
-	"	and	%w1, %w1, #0xffff\n"
-	"	eor	%w1, %w1, %w0, lsr #16\n"
+	"	sub	%w1, %w1, %3\n"
+	"	eor	%w1, %w1, %w0\n"
 	"1:")
 	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
 	: "I" (1 << TICKET_SHIFT)
