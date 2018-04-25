Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652518-2-14789218658407844513
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
    1524652518; b=wFSCCj5mWsbz/PSSBWv9/5pICK8k4rHuwkVsoYZct3p0Vo9mHz
    u9GokLPbm07619k7reBsGuiVrxC4Pc+v+lFIbiN18vGOVI4kXH5uPwaZumBFmiW8
    kw3fJDwSsdU15v33B7H8GUFHuH2ZitCgFYqkB22tqWuKucGaOe71m/pEahS9dIId
    tWuhEpYEo7yxwe7PpHRsyypY6k0sxrl8sR6ysl0rSwpTR6iwda0s3fIwMrWsS2To
    BbGXEoMoYM4Gn1fSSua3CxSHyYA+AUzcZhyNe1o358xHIg+KMdDW4Q8xNJx+voq1
    FpGL45oqBeOXrCGeIqaalm0ccm6LQibJ1EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652518; bh=ASdFpj4hat6+E+FgaWFl7+k+zrIIBt
    Ks0LrzDHlJ160=; b=IlAvCFcJWWH/GSQhrvBGd5f3JtTDGLqLq3aFlT7q47Pyoq
    0h0Di1kbpwIdlnbOcc1Vs0zxsS+SK5bd1POF5wfYHRqWbdgNYxaSBo8YSLMiuYJR
    6D47NxPzAcZVB/V0tJYluinAGMjqZVI91g+HWw4YdzeS0+PhimJBf0ghwxDA/t6d
    arzrJWkEtmEwRHy9L1Lu7BymbowMe2J04MbPV36FiJDwmvI5jHmmpgoEmLpssD95
    eMlO4eRBhK1CLgGvPLyI/vGSscXk9IXAUwNOqFWan59LHyEdnkcR3bhxFQuawXu5
    xO2KRZnjfrVu5Rc9+GUFlEcg2xpHZUNPoKzke8PQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOW+qlBqIz8DcmdGAJphRylwK0cj3R5QVpTSa4tBJp/DPs5X8GT1vE3vwbip0FWZGa/Vt8CNlpXKan+9CtGiYxMOL7TrI0kS0sA9TfiFZv2l5FbGD6fg
    6qBcWA+kMqNi0biphDYiNZCkhWiuBfjoBubH8glSMz7UXYw3hsZL8aELcxBN4qEJuzpbQKPd5VSwI5pf/MOutvm90GphQ6wFADTiOKBwpN95wPfLCEnbXOdn
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=GvQkQWPkAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
    a=oGMlB6cnAAAA:8 a=ag1SF4gXAAAA:8 a=jXYp3oaWEXbJrc9mxhsA:9 a=QEXdDO2ut3YA:10
    a=IZKFYfNWVLfQsFoIDbx0:22 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=NdAtdrkLVvyUPsUoGJp4:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeDYKfC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:35:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbeDYKe5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaoming Gao <newtongao@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        hpa@zytor.com
Subject: [PATCH 4.16 08/26] x86/tsc: Prevent 32bit truncation in calc_hpet_ref()
Date: Wed, 25 Apr 2018 12:33:17 +0200
Message-Id: <20180425103315.187911246@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
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

From: Xiaoming Gao <gxm.linux.kernel@gmail.com>

commit d3878e164dcd3925a237a20e879432400e369172 upstream.

The TSC calibration code uses HPET as reference. The conversion normalizes
the delta of two HPET timestamps:

    hpetref = ((tshpet1 - tshpet2) * HPET_PERIOD) / 1e6

and then divides the normalized delta of the corresponding TSC timestamps
by the result to calulate the TSC frequency.

    tscfreq = ((tstsc1 - tstsc2 ) * 1e6) / hpetref

This uses do_div() which takes an u32 as the divisor, which worked so far
because the HPET frequency was low enough that 'hpetref' never exceeded
32bit.

On Skylake machines the HPET frequency increased so 'hpetref' can exceed
32bit. do_div() truncates the divisor, which causes the calibration to
fail.

Use div64_u64() to avoid the problem.

[ tglx: Fixes whitespace mangled patch and rewrote changelog ]

Signed-off-by: Xiaoming Gao <newtongao@tencent.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: peterz@infradead.org
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/38894564-4fc9-b8ec-353f-de702839e44e@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tsc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -317,7 +317,7 @@ static unsigned long calc_hpet_ref(u64 d
 	hpet2 -= hpet1;
 	tmp = ((u64)hpet2 * hpet_readl(HPET_PERIOD));
 	do_div(tmp, 1000000);
-	do_div(deltatsc, tmp);
+	deltatsc = div64_u64(deltatsc, tmp);
 
 	return (unsigned long) deltatsc;
 }
