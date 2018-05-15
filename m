Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3322034-1526421902-2-15970433837676529539
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526421902; b=XVEcE2HHubb4Ap8oapfCTloXmeejcNcfS2k7owIF+l7IDdJ9gQ
    WKdgIJ8Zcq+7vf8QuwFtdW75irdIrEEM7y9R7lUrkR9Y6O8WKLE1EIdddAs8KdHH
    K3J/XyJwZIUkoMqjyVhPhZ29UJE3wxpWUyIK2EElS0smWoeEzjbuJY+WPdc3rGLy
    wTJd6oSHb4ZoA5hYKEfTWaD3Mwa8mNYyBMSnSrw0EBJpdV4zPeM7WrO3Ehkz5QQq
    UCkSaSqd8Txx4r9uWoTTNd77cIyP/aJtmT9Xs7j9qoLporSMGi2cDcxLBl6v+UHi
    EeMYVWiugYZZ9HRm0G1HvyzQacJGAtMyflwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526421902;
    bh=nyRYPb5ZtIFKPDOIGKcN/65XYxqC3xLo/paCX3aRYmk=; b=ESrt/+ttw/06
    kmURPVq5u9Qj2YpO9Uq+vHmS2Cpg2iogYJbFnMiGlT3I/LlJtMcIFD4SDHTlaOPt
    U5w1mWkgp6aiTG7DdYakkOX89H3CQzUDeD55D1yvk1sayYUeKS2xh7MtTvsO6cCN
    ZtxCm1QJBp3J7vaD0ipd8ll59cErDgXJof0v+Csuc4r1lZ73+Pd6XGMF9wgEAhTm
    PVMOF6Mg8C+u8RXCyolMVQnAVCaAylHpEfJPEUXbqU1REtuR0UCKBIqjlEz02y1M
    AYg0ru+2qimP5Nwt45qoB8Fc4DQs8g8ed0esMmEgg1eW2rRkjjL/rSHx/OFkOA9r
    tMS6qbWwag==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOwZsw2WTMu+K0CoJEMryRHK2Ra8f65NFM/bfcI74sVq0FAKlJwwuUsGUL20pwD0dgLq5q1TMk73tJSEqzISD5eANPVcR/+Zp+hYydS/s/MDA3w6+/ZT
    5BTNBt3V0V9VirkY1oSZpSJxhG0z3rsvyx0e8roGp7wCYXXZiHnaIhEFWsq2Lw9sQWkSSQGa3Fq8pb3e3J6xtfsbskrMTKxiJMcMmowLDXs78k3+nJPN6yFO
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=iAo7guES1noA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=BW3to6cFacDB0dXLSkcA:9
    a=8qWED2wUQotloAhO:21 a=ZqDvd9VaOC_8ABNq:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeEOWE7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 18:04:59 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:49873 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeEOWE7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 18:04:59 -0400
Date: Tue, 15 May 2018 23:04:44 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE
 requests
Message-ID: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526421892-531715-3345-22758-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193019
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Having PR_FP_MODE_FRE (i.e. Config5.FRE) set without PR_FP_MODE_FR (i.e. 
Status.FR) is not supported as the lone purpose of Config5.FRE is to 
emulate Status.FR=0 handling on FPU hardware that has Status.FR=1 
hardwired[1][2].  Also we do not handle this case elsewhere, and assume 
throughout our code that TIF_HYBRID_FPREGS and TIF_32BIT_FPREGS cannot 
be set both at once for a task, leading to inconsistent behaviour if 
this does happen.

Return unsuccessfully then from prctl(2) PR_SET_FP_MODE calls requesting 
PR_FP_MODE_FRE to be set with PR_FP_MODE_FR clear.  This corresponds to 
modes allowed by `mips_set_personality_fp'.

References:

[1] "MIPS Architecture For Programmers, Vol. III: MIPS32 / microMIPS32
    Privileged Resource Architecture", Imagination Technologies,
    Document Number: MD00090, Revision 6.02, July 10, 2015, Table 9.69 
    "Config5 Register Field Descriptions", p. 262

[2] "MIPS Architecture For Programmers, Volume III: MIPS64 / microMIPS64 
    Privileged Resource Architecture", Imagination Technologies, 
    Document Number: MD00091, Revision 6.03, December 22, 2015, Table 
    9.72 "Config5 Register Field Descriptions", p. 288

Cc: stable@vger.kernel.org # 4.0+
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
 arch/mips/kernel/process.c |    4 ++++
 1 file changed, 4 insertions(+)

linux-mips-set-process-fp-mode-fr-fre.diff
Index: linux/arch/mips/kernel/process.c
===================================================================
--- linux.orig/arch/mips/kernel/process.c	2018-05-12 22:52:11.000000000 +0100
+++ linux/arch/mips/kernel/process.c	2018-05-12 23:07:15.147112000 +0100
@@ -721,6 +721,10 @@ int mips_set_process_fp_mode(struct task
 	if (value & ~known_bits)
 		return -EOPNOTSUPP;
 
+	/* Setting FRE without FR is not supported.  */
+	if ((value & (PR_FP_MODE_FR | PR_FP_MODE_FRE)) == PR_FP_MODE_FRE)
+		return -EOPNOTSUPP;
+
 	/* Avoid inadvertently triggering emulation */
 	if ((value & PR_FP_MODE_FR) && raw_cpu_has_fpu &&
 	    !(raw_current_cpu_data.fpu_id & MIPS_FPIR_F64))
