Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835811-2-3320195955466827661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835810; b=cap1ZI4hRZ/oc+uxjBPmEULrtgASKWWx5SBxBaaJyK0Nx7i
    bjShL8m8EMCiGtpvMFJXX3IVbqq3TB1sf6C2mSLoXgN+YgapoVx4tEqVJQ1bSwC0
    YYQVCkgJvmSRiW4bHMaJDEJlHZC1mSQwPpSnhSL44GdMtOpeszYeyY6GDCACKQ3H
    2NU7R9B1dAGVZn+rB4FhWXdZsq7y2r5udsOv7EKJ9WTao25Zr+MC1VpOI6gZiaJ1
    7yAKOC7H/EN0jgtlwHqRsxFd7DzV6hqXFBrYhdlKn0xvrqSo046+2UAl9NHxIZNb
    SrsEcuGt1x+jEzRRYAvdcJAphtGURmfc72Cw/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835810; bh=fXE6QcMBwJmfaaTpeEs
    rsoGPnO9ScnOF/SgUqMe4i1Q=; b=A42uAexIu7zaSW4fMgfzXKw/taSpzYqHUst
    GZ/EpZqx1q0/kj97ATfMOOdQCCabmxKfciPB/sbYCwtj1w8hnZpcHFuhNSerD5b0
    9W1h5rN36jcibk9lq5e/LJoHZEtNNkVBTZmrQKH3Zi8yT8HgmJnCd7cQw22Q+bVT
    pSIjcobdxrmTgErIvEJRZwNrVz3gfM+lbL1WuXvhANx1QlCfcyl+n2hrSFN8WlJj
    1ooUgcJJyR43UsXL8bd+IY6WWznQktfN6bRpNn8YRWVr0AzRK6TRdawc159Hc5f9
    R6dQ/0eFMwI3jz40BM4oQQSZQbgVeSD4z9pULNs1tqZ6zjHRL1g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeB1Qgd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:36:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34847 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932842AbeB1QEt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:49 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        "James Hogan" <james.hogan@imgtec.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.593229193@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 095/254] MIPS: lose_fpu(): Disable FPU when MSA enabled
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit acaf6a97d623af123314c2f8ce4cf7254f6b2fc1 upstream.

The lose_fpu() function only disables the FPU in CP0_Status.CU1 if the
FPU is in use and MSA isn't enabled.

This isn't necessarily a problem because KSTK_STATUS(current), the
version of CP0_Status stored on the kernel stack on entry from user
mode, does always get updated and gets restored when returning to user
mode, but I don't think it was intended, and it is inconsistent with the
case of only the FPU being in use. Sometimes leaving the FPU enabled may
also mask kernel bugs where FPU operations are executed when the FPU
might not be enabled.

So lets disable the FPU in the MSA case too.

Fixes: 33c771ba5c5d ("MIPS: save/disable MSA in lose_fpu")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9323/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/fpu.h | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -150,6 +150,7 @@ static inline void lose_fpu(int save)
 		}
 		disable_msa();
 		clear_thread_flag(TIF_USEDMSA);
+		__disable_fpu();
 	} else if (is_fpu_owner()) {
 		if (save)
 			_save_fp(current);
