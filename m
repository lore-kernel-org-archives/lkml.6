Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832188-2-9482218392527890885
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
    t=1519832187; b=ZP1YDpQjtF0JRhyuewhbv7m783KIyTwPhS0lfGVS5WQ3oTv
    C337ZkX2M3WYatEqcUVNFA5jqiNo/gi52+PyJ240xQeaJUS1RcHzmkSwjfD2DLr6
    9+OuvqFmOI+wOVCrhn7bYSw3wO3/Lr4RZ+/V97jl0zSqsfOCapaISpH6EfjCrVC5
    WQnVutV/42PPnx/B3onJU6zrpRdYwoDdggR+C5/7mhSQtiXXwkNtFGW7SmoLV/br
    OM6hmu7ROSHezBWh9XIwTRzXiRiNu/Wna22dejaKOAFQU3e0oT4fF7jH7v7OX6ra
    oKCKwmCycbJFcaoyom8sZZ3fYGCtGkKMbo/MYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832187; bh=q+i7BY2wyPmLMUamTzm
    tD9M8bphAr/G02me1JyHWoM8=; b=gmJmPSxd4Jj8gyxNQHUxLdfzQ7nsCibr12/
    0Cv7uCaX8hr4hCzLWySntQPsjwTRDyyQ5Ulq/6LDrVv91iUCJrdnn5eDN5ij9JKV
    ZMS75hrKUVUx8pIhNFXjFo6kDjlT2+/6Lzv4Wn4cmNjfaQcFUFF4heIJ53BAaKFX
    aCmxV3X9qpCioujAI1VIF7JT5sKg42AvScrlDVHxlGxg+wvUIoo/VUl9pUk+6QNB
    ZcL/YnoMh7hyYGmy97+swuAzlTjJkybUvSfnMfv9k/QHtrm8qLVb+g/UQLrX6P93
    1o9e3eGDEsoCfjirQPpZFgEYrNUSKKkXOrQXc+d5wksLW8dMAxw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbeB1Pen (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:34:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33323 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752833AbeB1PWh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:37 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Christoffer Dall" <christoffer.dall@linaro.org>,
        "Kristina Martsenko" <kristina.martsenko@arm.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.738136564@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 034/254] arm: KVM: Fix VTTBR_BADDR_MASK BUG_ON off-by-one
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

From: Marc Zyngier <marc.zyngier@arm.com>

commit 5553b142be11e794ebc0805950b2e8313f93d718 upstream.

VTTBR_BADDR_MASK is used to sanity check the size and alignment of the
VTTBR address. It seems to currently be off by one, thereby only
allowing up to 39-bit addresses (instead of 40-bit) and also
insufficiently checking the alignment. This patch fixes it.

This patch is the 32bit pendent of Kristina's arm64 fix, and
she deserves the actual kudos for pinpointing that one.

Fixes: f7ed45be3ba52 ("KVM: ARM: World-switch implementation")
Reported-by: Kristina Martsenko <kristina.martsenko@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/include/asm/kvm_arm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -161,8 +161,7 @@
 #else
 #define VTTBR_X		(5 - KVM_T0SZ)
 #endif
-#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
-#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
+#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_X)
 #define VTTBR_VMID_SHIFT  (48LLU)
 #define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
 
