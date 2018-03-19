Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484516-2-16764432993535755983
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484515; b=cEdubC0luFQz8vAjSv9BOmCDtOqJld6RZ58mrrQhrU5oqXd
    GEthxNVE2M9xjYKF3puoIo1kpxCOAEM6BWRcGMxadn//N6K7KEswq05i6mlnennm
    8uEERupd9sFZvy18f22ZsHYs9KYqow2rx4y8mAY56ENL2Nvopa7RIM2XwxmZdz4E
    UIa13PV5OTzebOQLglL1J3IF+QRfJs//81o/g2tJh+WorfTuukhC29XyJOxXHPFa
    cp8vV9C+cUFT1Z1wivFxtqUK32n19DRwKXaI/2+8G1EQZvo0rpukZfhdhsKJ8OQJ
    oHW/dmb1HVqAPD7kFD9WmxMnc+vZUq3/W6Sst8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484515; bh=+bP0nq2IT6b6GU/XjLtMEXfcy8
    Dh7CaTFQhEOwHT+P8=; b=hj+be0p9X5pzd0RhwbW+PAxHf/WM1cJ/lexZG84afx
    B5uB7wOQLH1Ag0zeVxu0xnIe/4/iTXjIb7SUGIchapaZNWN55Hb+U2KBhymMfUy4
    ofiQBDPUD9xY3WWrCKtDsLd5nZZ19JlYL+Dst+SDQ54CzGUCyBb2uuTcwxjUsZ/m
    ONPv2cbyLD5r6u1TGBAE+5wdPdWjm1nHBjMTopxsnZ5bNMtm0uNoGWi0+/ylgTBt
    JKNvJJqVNCkKiUBUW/CSqjOBGgVOco+b7+ga8GfqrSlnp4tlHZzlHehkzLmp/7Ei
    U7gAi0z9MOi5WdM67FFPjJ41aOha35E7HNchxygDme2w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegudeifeenucevlhhushhtvghrufhiiigvpeekvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegudeifeenucevlhhushhtvghrufhiiigvpeekvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032183AbeCSSdP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:33:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032180AbeCSSdN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:33:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.15 29/52] irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis
Date: Mon, 19 Mar 2018 19:08:27 +0100
Message-Id: <20180319180736.693337312@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 4f2c7583e33eb08dc09dd2e25574b80175ba7d93 upstream.

When struct its_device instances are created, the nr_ites member
will be set to a power of 2 that equals or exceeds the requested
number of MSIs passed to the msi_prepare() callback. At the same
time, the LPI map is allocated to be some multiple of 32 in size,
where the allocated size may be less than the requested size
depending on whether a contiguous range of sufficient size is
available in the global LPI bitmap.

This may result in the situation where the nr_ites < nr_lpis, and
since nr_ites is what we program into the hardware when we map the
device, the additional LPIs will be non-functional.

For bog standard hardware, this does not really matter. However,
in cases where ITS device IDs are shared between different PCIe
devices, we may end up allocating these additional LPIs without
taking into account that they don't actually work.

So let's make nr_ites at least 32. This ensures that all allocated
LPIs are 'live', and that its_alloc_device_irq() will fail when
attempts are made to allocate MSIs beyond what was allocated in
the first place.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[maz: updated comment]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1412,7 +1412,7 @@ static struct irq_chip its_irq_chip = {
  * This gives us (((1UL << id_bits) - 8192) >> 5) possible allocations.
  */
 #define IRQS_PER_CHUNK_SHIFT	5
-#define IRQS_PER_CHUNK		(1 << IRQS_PER_CHUNK_SHIFT)
+#define IRQS_PER_CHUNK		(1UL << IRQS_PER_CHUNK_SHIFT)
 #define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
 
 static unsigned long *lpi_bitmap;
@@ -2119,11 +2119,10 @@ static struct its_device *its_create_dev
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	/*
-	 * At least one bit of EventID is being used, hence a minimum
-	 * of two entries. No, the architecture doesn't let you
-	 * express an ITT with a single entry.
+	 * We allocate at least one chunk worth of LPIs bet device,
+	 * and thus that many ITEs. The device may require less though.
 	 */
-	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
+	nr_ites = max(IRQS_PER_CHUNK, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kzalloc(sz, GFP_KERNEL);
