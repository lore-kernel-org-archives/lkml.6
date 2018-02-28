Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832336-2-13285615326164049432
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
    t=1519832336; b=nPcLwxzLaRAJzeGzssgRMollPez9MhFFYpnxIQnqvej8p7+
    Uf2qk4pwwPPZGO4+UZ5+nMmMg+XQ555hgiBrHCqoY+9di90xZrKOaDcnXNmgasxz
    rLLkfLxtdlhNRsp4jFI8QWBGlWm9eIEbujav5lkx+XLDTWU/7OLvL68N/unPn9vs
    c1lZhdgDUU0vAlj4CjXUKG83XjHdkgDO+4v+wQURVCs8SntQ9C7qGDpJFPUmHBis
    7Zn8R9wilZvvagX6pveGt8cI0+JbOwpTrM5dsACBp0q1y5DLBcyKK4dweZ/rxTOf
    WpOwbopac7TfjVUP4mev7BnmMg3646o4F02vsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832336; bh=C5zFCdT/yw5b88mrpNa
    kWvAUfemLJ0/9Zw+MQt7Yemg=; b=INwHtubR1gc1lTzBpUMocjmEvln+lXyQwuH
    wwPGRKjicXeqv/51ANGltr5H7W4ZWfJu1HJRE9r1AYviNaHWXT9I5I9OTxHlsDbM
    YSC7a1VFL44WbIcBVWl2nMU32jd5BnmENv0K2GEFiwpBvYL6JGONZ3wI+1uCGWWw
    jSPcLGmNeahP+4GUHjF2mdL4fe0xvQJOzsLrQWBCltQMIxZsD4uoqRSuPcnikavk
    V3/4C5SyJ7l2q2vqrWS4SQzINzkF/pOEzHtNubkr4jmKLsSlvCURLRQ61tn+lkI5
    nscjM2/+9jN1CtGKhNCEqr2UwL3BpjxJMJKrJLDZm7AEgN6cnRw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeB1Pgj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:36:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33294 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752778AbeB1PWf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:35 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Marc Zyngier" <marc.zyngier@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        "Kristina Martsenko" <kristina.martsenko@arm.com>,
        "Christoffer Dall" <christoffer.dall@linaro.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.496839452@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 033/254] arm64: KVM: fix VTTBR_BADDR_MASK BUG_ON
 off-by-one
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

From: Kristina Martsenko <kristina.martsenko@arm.com>

commit 26aa7b3b1c0fb3f1a6176a0c1847204ef4355693 upstream.

VTTBR_BADDR_MASK is used to sanity check the size and alignment of the
VTTBR address. It seems to currently be off by one, thereby only
allowing up to 47-bit addresses (instead of 48-bit) and also
insufficiently checking the alignment. This patch fixes it.

As an example, with 4k pages, before this patch we have:

  PHYS_MASK_SHIFT = 48
  VTTBR_X = 37 - 24 = 13
  VTTBR_BADDR_SHIFT = 13 - 1 = 12
  VTTBR_BADDR_MASK = ((1 << 35) - 1) << 12 = 0x00007ffffffff000

Which is wrong, because the mask doesn't allow bit 47 of the VTTBR
address to be set, and only requires the address to be 12-bit (4k)
aligned, while it actually needs to be 13-bit (8k) aligned because we
concatenate two 4k tables.

With this patch, the mask becomes 0x0000ffffffffe000, which is what we
want.

Fixes: 0369f6a34b9f ("arm64: KVM: EL2 register definitions")
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/include/asm/kvm_arm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -164,8 +164,7 @@
 #define VTTBR_X		(37 - VTCR_EL2_T0SZ_40B)
 #endif
 
-#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
-#define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
+#define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_X)
 #define VTTBR_VMID_SHIFT  (UL(48))
 #define VTTBR_VMID_MASK	  (UL(0xFF) << VTTBR_VMID_SHIFT)
 
