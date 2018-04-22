Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406909-2-16749546656091447681
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
    1524406909; b=NiNnfDaHNTD5bBEeRm1VmN/wQilC+pSajCcYAUgN2mDeL7T2es
    rsNfCfrF4tSdyVo+K9sk5nFn1wGGenhdqtZ8nR1iqEJyhuSl8reNxO+s8Qqc2R40
    liq8XSVealMZ+69EExVr0ZOr4GMoMRDq3fg28Wm/XkTAWYCAjGXOtiluuCMEmTcA
    u7vW4V+B+/51eLoxIRuguGWX5znoYWXxZlm2t5PxrMtZlKkNk/R66xw60atYTDFw
    M/pWsziGi7ux6TWtrWxSYE2OlTpxT+6vcPGZtYnVy1nrmOIlWRnShojoR3yb5DWD
    +GzacD4nFfYmYXD5TNb/VgykXBKkVcASbTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406909; bh=W30zG5Oo2EQ3kHa+zoc0Zv7tdc7dTs
    02nRZrxT4w4Wc=; b=RsuH7qqmbmDvtzeBMrdhMqnylutqQxJqRshkG6To0ZwN8I
    d7OR55TAL3vpFT9lVxzv3PvbDpVrBMtNvJO97AefA0uee9Et29p4Hk3zHNeRSJem
    KNYldGCyFSwJxQwsmERwWBxUICs2FEz2RHXVh6dOmRTCJr9ej6aPo8Zhsn+j9k7u
    dypQNQ/hygWl/dPr0MlWjRRt7Lfs45+afy5DoEsRHy6YnYuXjuoBGIuymyBY6jME
    nIcMwFKzDHZJHUWiNBPPONLM4/Zk/r1i2vRRCdfSp3gu7OLbzHeltskYBOSTg1wt
    f0uD4jkUNYKjbqFC8++X67ZiJjqDFJsFKyp3Fi6Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLDURcFRxcyXNat6HkkZ+cgGxFUWvFs4/66Q8rc1em37YlFjZy4jw5jrhRfy80s6JcVm8DoPdqsqJrSq1vdIEDaKlRCUW222P/G10ZhF4MsRbapPlDbF
    BL2OzdGnJY0J+zZ/eBEJIU0M1Fw3ziNqZeX4SJZjyNG7Exk0XOY4HcR02NblLZLCmaLQRBDXang+nM0fb/BwA2QvzQkpoC7hl5LPSnF+FsG64aTZruvenFSx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=zkkJT_EHekSEDCfo8j4A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756347AbeDVOVp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:21:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757566AbeDVOVn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:21:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3.18 46/52] powerpc/lib: Fix off-by-one in alternate feature patching
Date: Sun, 22 Apr 2018 15:54:19 +0200
Message-Id: <20180422135317.478837951@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit b8858581febb050688e276b956796bc4a78299ed upstream.

When we patch an alternate feature section, we have to adjust any
relative branches that branch out of the alternate section.

But currently we have a bug if we have a branch that points to past
the last instruction of the alternate section, eg:

  FTR_SECTION_ELSE
  1:     b       2f
         or      6,6,6
  2:
  ALT_FTR_SECTION_END(...)
         nop

This will result in a relative branch at 1 with a target that equals
the end of the alternate section.

That branch does not need adjusting when it's moved to the non-else
location. Currently we do adjust it, resulting in a branch that goes
off into the link-time location of the else section, which is junk.

The fix is to not patch branches that have a target == end of the
alternate section.

Fixes: d20fe50a7b3c ("KVM: PPC: Book3S HV: Branch inside feature section")
Fixes: 9b1a735de64c ("powerpc: Add logic to patch alternative feature sections")
Cc: stable@vger.kernel.org # v2.6.27+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/lib/feature-fixups.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -52,7 +52,7 @@ static int patch_alt_instruction(unsigne
 		unsigned int *target = (unsigned int *)branch_target(src);
 
 		/* Branch within the section doesn't need translating */
-		if (target < alt_start || target >= alt_end) {
+		if (target < alt_start || target > alt_end) {
 			instr = translate_branch(dest, src);
 			if (!instr)
 				return 1;
