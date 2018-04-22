Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406744-2-5766542965044887710
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
    1524406743; b=VYJCcJ2jYC2sOJJo8Uw1VreP+2Xgu/r4/YssPgtjruRdyWX+2i
    oVhA6pfw+8U5L7jr41tk7XIubGqa8hc9B7V4lrueMXSYYdEURdQiASp0hIWdqyjy
    hMm8GAT1GHUXUmbfe+coXprQBTHAbdUJ4uoMCcD1+p5ZERPXcPs6wcb2BbRfgiW6
    iPsLWjk5L4rfh3BtCpVvxJ4qDQNg2Kmzy4ZrDyuoz6XVpvk/4oXGpd2UUkINLnHy
    XH7w+m1T24cvo6NQFjyQNjhqbCY2Mc6SreCtkSHqDqVF5091dyU+AU/lpJHN+WnE
    QcCi/DHIMJ/c0S+YljQCrPZiUfySCHg9qT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406743; bh=fkndUVbHQNJHYsSJLUheH3+/YKqrr5
    ZUgcOxqFYU9QM=; b=byP5jP2vMGeJ7Qse4DSzFB8rAEOWCy93w9fR4SXw9JpAAv
    DEGAKDbqIDthySkuQusNHS6lKlJ5iWiU5txxpD/P2JRFPp+Xheep5rRLLrQNU3XQ
    1YqF4rywkFfbVMF8bgwve2Kog2+2xavokPptkq0Q0mgWRHS8lftOsKY6nZFdJsK5
    1IhJrtHyoXI/yWg7hktCrw9fVwC7084fPWeTPBSrk+iWpTnvNdjeiCIjqBpcjCIj
    fdD2NJLAQm5x8RF7+5nAlSGixthYJuylIzNAjm+k63zg12tnh8lZQA9XkZLfF0ea
    e7sAsRIyMAT8WoaXBAoczV7hlrvHQdTGnZNlKG1g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfCUPRrSf8C/cz7j0KDFZ75wyyS40pthmKxtXS5tvKwqVeieq78NqbSjmOPjTeBdA9L++IvWTNdCob7+6BfVAu1YTkKL8f8OawQM+73eQjeKytwg+oyPE
    FDSzch6U84hn0HNb8ROVl/FNCRsKmb0a0gLg95wK0o1/LTmlPmfu+saLQysbQNZwmJgFC97cLLc5HKfJ7I4UGONgHEOrB4CdJWn0yuVZsCqSuim/bo9FA7vA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gPJu0pBYAAAA:8 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8 a=ag1SF4gXAAAA:8
    a=XXJ65cnBx-co3NGCiokA:9 a=QEXdDO2ut3YA:10 a=AlIIF0cMT2hfDT4axODj:22
    a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeDVOTB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:19:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeDVOSz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:18:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 85/97] MIPS: memset.S: Fix clobber of v1 in last_fixup
Date: Sun, 22 Apr 2018 15:54:03 +0200
Message-Id: <20180422135309.843519668@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Matt Redfearn <matt.redfearn@mips.com>

commit c96eebf07692e53bf4dd5987510d8b550e793598 upstream.

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

Reported-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/19109/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/memset.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -255,7 +255,7 @@
 
 .Llast_fixup\@:
 	jr		ra
-	andi		v1, a2, STORMASK
+	 nop
 
 .Lsmall_fixup\@:
 	PTR_SUBU	a2, t1, a0
