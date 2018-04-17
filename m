Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2126129-1523979613-2-6463223216059544025
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523979612; b=eaxqUgDLF8MrUGmwjOSLbmC+PRdPFQfzAuwTzKGlTZu/oKAC+X
    VaOBUWwTMIrLlYrnpX0e37P/Vjwlg0odWzOhAO24K6siRMcsOQwZeyzB4yAcW+o3
    UzIEdvwXvhlExNpn+rQSowxuhIEhLKS0ZlybFRvwIovYmdH4sufTlFkVN+1Jmr0s
    H7cYV/8Kn+SKkk4npdFkggXzzOq78nIZNC+dlo4QlNCbjK15JsQtXmf7vsstScLT
    27nN7b4FCMwG8lZU+9wyESCeEZtkKyVH3+ipeIs2LybujFXfScO5PVNPzenmx1lM
    ozFzcuxPA1VFlzsNuvyjCpTzfsVCPxbbtarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523979612;
    bh=cgquiRe//D89IitZiNOW/XkIQ/UIKnSjT9aZajOvfiY=; b=D7yDtDGqbnoT
    gkZ2B95JSNojnzQFAnuEke1GjnHttqTpBAQXPHA6QKdTX4wxtleUY+faK4YuG47A
    1WTLvjVeWMZrZSEN8lfi4kN4XIamWj8nY4+MzKvGgb3y5Fz48YvgZslQGnUBrMnJ
    T1DG8pH4mRTTSNzDfAg0R1PXUdcd+uf8F5XmGZCBuIDAbAUXtdoNAmwuHPkHnsJF
    idIyVM+EwxC98zLZvuoeDsJSqAbgBzoFBNZuVHaevdxGMatFdNuEhhSYJc/kEKg/
    T7TqlsSscpzX+p/P/eKRb1jRfkZpow8DpfKEtFyAFWxbuHuS6F4X5nmd3MOMgds/
    DLJu2DFO/w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH6cuJMcNWihngBkuTrfeKBnmaFP4E+W8eJl6JCNy3uEMB4G83pW26fL/cK3Yo6slnDoOTczImh75Tfjgb66v1zH4lhA0AtNWV83RvFmSIhbNWK1v+6K
    yDe2jomvDW0TcRbIAWgyluS3ymJxRawXtuNan1tjeLdJJE5y6dZILzAcj8YgsWAsU2TFpwCNKFtleHW0cakv7qP3jIeCqJBrOYNXslei02eKpDy0/3mHlH1Y
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=e7LufI87OJsagcwBs9QA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeDQPkK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 11:40:10 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:35876 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeDQPkK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 11:40:10 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] MIPS: memset.S: Fix clobber of v1 in last_fixup
Date: Tue, 17 Apr 2018 16:40:00 +0100
Message-ID: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523979597-298553-5506-31410-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192083
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

The label .Llast_fixup\@ is jumped to on page fault within the final
byte set loop of memset (on < MIPSR6 architectures). For some reason, in
this fault handler, the v1 register is randomly set to a2 & STORMASK.
This clobbers v1 for the calling function. This can be observed with the
following test code:

static int __init __attribute__((optimize("O0"))) test_clear_user(void)
{
  register int t asm("v1");
  char *test;
  int j, k;

  pr_info("\n\n\nTesting clear_user\n");
  test = vmalloc(PAGE_SIZE);

  for (j = 256; j < 512; j++) {
    t = 0xa5a5a5a5;
    if ((k = clear_user(test + PAGE_SIZE - 256, j)) != j - 256) {
        pr_err("clear_user (%px %d) returned %d\n", test + PAGE_SIZE - 256, j, k);
    }
    if (t != 0xa5a5a5a5) {
       pr_err("v1 was clobbered to 0x%x!\n", t);
    }
  }

  return 0;
}
late_initcall(test_clear_user);

Which demonstrates that v1 is indeed clobbered (MIPS64):

Testing clear_user
v1 was clobbered to 0x1!
v1 was clobbered to 0x2!
v1 was clobbered to 0x3!
v1 was clobbered to 0x4!
v1 was clobbered to 0x5!
v1 was clobbered to 0x6!
v1 was clobbered to 0x7!

Since the number of bytes that could not be set is already contained in
a2, the andi placing a value in v1 is not necessary and actively
harmful in clobbering v1.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v2: None

 arch/mips/lib/memset.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 184819c1d5c8..f7327979a8f8 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -258,7 +258,7 @@
 
 .Llast_fixup\@:
 	jr		ra
-	andi		v1, a2, STORMASK
+	 nop
 
 .Lsmall_fixup\@:
 	PTR_SUBU	a2, t1, a0
-- 
2.7.4
