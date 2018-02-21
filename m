Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519217991-2-783776812952656622
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217990; b=IomcsWG9rhIEqHNSPvn/QJsN9sP9cg+7WXl4u6ZaeTjNbIx
    Zd4mjiuv1uGbkmkDx7huKZOeBopL6w1tp92DYNbfzBVFUGdFdeOIzWnF6jXs3D14
    YHAmTkx6MlgfPaaVFV55Hv0l53iYIEcioQDgo5nkPOOYUEBd1O0SG+LkXN7T95Jl
    Q8uXunbDSoNv7Cu7BEs7lMZ1MXihMG8esTGP/Cd7ifFtxWeZTaNx529xezazE+fG
    DalOGO08jSKMPiiFOGzFdIA6J5x8D/RSC4ZAQgB1gK7ZvG2AOfJFAGXIE6s9LjeJ
    PRtFKw94jqA4T9WDkRTjA5HAtdFUtcevPW52Qqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217990; bh=0s3dYrv+r+GdYcnka6VKnioBBZ
    QqOeDk+QDF8L5Q/Vo=; b=l2mVyGDxQBD4JLVNPwOCm/G872dHNFb2t3QhkjLF4K
    MuceSiJ9PXPeWy0xn/VgfealSoodjbj+wY+N+zsFvehBBz4YJOlQuuzeyDWj4V0D
    qrZYuTHL6H6vpgQy78NH4w2UsQk3ZIIA6PLE362y+NJFXrpLnw6CIPLEm1NMFgcx
    VNa1cKiqhNPYxOQCdx0JLJmKsl1t0tdjkwo6lFTtloJ/vrsD3cxA8UgIU4WM010X
    i0fap3YDQTlX2gHOuSPpCM0qyOJuoIKVk/3+ojv1xG6JNuforafro082vzpfOxEo
    8dIjb1OpKYFTidAsQeJh8qw9v8Bys7CsMtvneQ8iuBJQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935157AbeBUM7o (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:59:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932964AbeBUM7n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:59:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        arjan.van.de.ven@intel.com, jmattson@google.com,
        karahmed@amazon.de, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, sironi@amazon.de,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 048/167] x86/speculation: Update Speculation Control microcode blacklist
Date: Wed, 21 Feb 2018 13:47:39 +0100
Message-Id: <20180221124527.183752188@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

commit 1751342095f0d2b36fa8114d8e12c5688c455ac4 upstream.

Intel have retroactively blessed the 0xc2 microcode on Skylake mobile
and desktop parts, and the Gemini Lake 0x22 microcode is apparently fine
too. We blacklisted the latter purely because it was present with all
the other problematic ones in the 2018-01-08 release, but now it's
explicitly listed as OK.

We still list 0x84 for the various Kaby Lake / Coffee Lake parts, as
that appeared in one version of the blacklist and then reverted to
0x80 again. We can change it if 0x84 is actually announced to be safe.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Cc: sironi@amazon.de
Link: http://lkml.kernel.org/r/1518305967-31356-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/intel.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -123,8 +123,6 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
@@ -136,8 +134,6 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
 	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
-	/* Updated in the 20180108 release; blacklist until we know otherwise */
-	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
 	/* Observed in the wild */
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
