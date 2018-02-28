Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836442-2-16121434027484848745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836441; b=mbWdgTHbMGBbBP/vAfRGiHYHAu9xLYLED3DYJFCAWw8idpF
    vfwJBtroVpE3yi0AAiC8B7WhTRS1lIiX2n40DC4nmbam1RNRVJbdGNawRhfmamzJ
    JzqCaf/u+VrCVtEwmSKmv/mOqWhENwfzNg1xTR/NsNVEtjh69/fIlYFCuI2bCmEc
    6zlh7MFt8fY6nv22WO3RQMuZr/+8eBDCB8IP8/1p3093jQHyvzYCz5FFScKTJqzA
    fFAYB1j1PXoDxRExec/lKCz4+1As7t8l+OAsbInF+7ofCwWeG/TVdPcE+wMtHU9s
    2uYe0/CXDJpfBR6vahbBR4YpXhw3l9cG6THC9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836441; bh=mBHyTIi4R8+iz95nVEW
    O5z4Rhj2sYY7X9qxrccDoszc=; b=HosEF6e8MIGzsK1aTnSof4lRgzi3XfCKTLg
    8P5ya3LUjGpLbdYMNAN4G2pUPsII88GYV84fusvx9dNw3PkimUTOnkYZxeaa+KNt
    J3dGegUSr/dj2JG9E/mUod+dTUXa0oAhQ85c5iGIZ1jAk8grqJtkZ6lYBzU2CXAg
    Q1IxjTi+GBLsUeIGgjNMnpTzWhoSagERBKwJYnSge0fGnmRw0PY9+5YVlnjGAKd0
    aukSFPupbhY//cSpbLNDDcOgRVdhGRRVho/jUpP8/qX07zY3aXeHqaeqrCf6E40z
    q70mz3QPCSGt4wVo3tjBjONdoGQQWGCRojEk1hNZlKuF/PxnayQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeB1QrH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:47:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34602 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934122AbeB1P7B (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:59:01 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "James Hogan" <jhogan@kernel.org>,
        "Paul Burton" <paul.burton@mips.com>, linux-mips@linux-mips.org,
        "James Hogan" <james.hogan@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.652977295@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 091/254] MIPS: CPS: Fix r1 .set mt assembler warning
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

From: James Hogan <jhogan@kernel.org>

commit 17278a91e04f858155d54bee5528ba4fbcec6f87 upstream.

MIPS CPS has a build warning on kernels configured for MIPS32R1 or
MIPS64R1, due to the use of .set mt without a prior .set mips{32,64}r2:

arch/mips/kernel/cps-vec.S Assembler messages:
arch/mips/kernel/cps-vec.S:238: Warning: the `mt' extension requires MIPS32 revision 2 or greater

Add .set MIPS_ISA_LEVEL_RAW before .set mt to silence the warning.

Fixes: 245a7868d2f2 ("MIPS: smp-cps: rework core/VPE initialisation")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <james.hogan@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17699/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/cps-vec.S | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -229,6 +229,7 @@ LEAF(mips_cps_core_init)
 	has_mt	t0, 3f
 
 	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	mt
 
 	/* Only allow 1 TC per VPE to execute... */
@@ -347,6 +348,7 @@ LEAF(mips_cps_boot_vpes)
 	 nop
 
 	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	mt
 
 1:	/* Enter VPE configuration state */
