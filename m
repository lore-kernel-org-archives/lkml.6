Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406164-2-2844840344653045408
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
    1524406164; b=ac4oTEwoFyJCTpM08AShCpEx8rhQzTXK/jS8OJgGkSqwy4TizI
    EQ2jstL8pSizdMBZOlXKMTSZM2lsSSt3yYYRFyTIlVxiGsrdnmfl4ZCrxT8qHQQU
    E1L+3vY8R5P5xPLpX9umcePVN7mqKrQeu1GuNyrAiaRiVpaZVqNDSL7C2m4TnS3t
    MAzBBDu4ophbexbj14mvbr7008o3GPdLnHDGWAUx8SBeWaoAr28RQJwAva5yN7lU
    yMX0sAwGpzWgqfEHYBLkvjdFfEkoFMBsJEn4C4erxYjmOXCLhIsd2zwT7I0iicgu
    DoGYLYXwdt+rlPh3NmsJv8NRgWS58XD58aSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406164; bh=1U0Y1Yy1pYE/7d8MXg2hUG5g8X+jk9
    fiV4zJPKLxqCs=; b=fA+FE/l4+6OI565Qn0mJj46f7eBiVvPRRihmaU31DKraYC
    18LCHoUkFWqZX6sNb/8cGmViBEOx6BnsXbTpZjo7m8c5qU3qX1koMubdhcRJ5h38
    Jkd6IGODJN9joRfWzXQQvAADDjR6oXg2w0pltBfz8pwI2yC0Yy3MQ8rhoDtnWCLs
    E8bE7qN1yUNCB2eaQviXvW/IiAVmTRoFd3fpU3/Jy6M1qi5l2N0IYFxsG0qjthFp
    7pn7HrC/IhkdfpDn2gBddnMiowaIZglpJub2eqa0Or2sgO6OWpk/jcQqVI186aWQ
    WEZabaSo1xzYi5e6IpDSB7+7S8QxNf1XwYH2Cbzg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfIdjvl7o1qsMM494YAbJsExxYDBjGGs5iBWDTpBmuuwptcZhxf/ubhjgtpERn2XnOx7IqT7iNd4jOygKRLOAs0PHzvwURzGkYFF+ws/Gns1RHyo1jGgQ
    LWlELtzwMQceTgVSOVrZHxADLGeW3VXzmfKxch+8/Y5WEnB8TBmU1vh4y9ZiOIUmqkaX0AnHb4y/3/rnVNXL9bADjfxawGWXxHe9F8L35VwjYKvR0cSmX65k
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=4y9B8vKwVsSXWozFvOgA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755843AbeDVOJT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:09:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53052 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756094AbeDVOJQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:09:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.14 133/164] random: fix crng_ready() test
Date: Sun, 22 Apr 2018 15:53:20 +0200
Message-Id: <20180422135140.827983704@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit 43838a23a05fbd13e47d750d3dfd77001536dd33 upstream.

The crng_init variable has three states:

0: The CRNG is not initialized at all
1: The CRNG has a small amount of entropy, hopefully good enough for
   early-boot, non-cryptographical use cases
2: The CRNG is fully initialized and we are sure it is safe for
   cryptographic use cases.

The crng_ready() function should only return true once we are in the
last state.  This addresses CVE-2018-1108.

Reported-by: Jann Horn <jannh@google.com>
Fixes: e192be9d9a30 ("random: replace non-blocking pool...")
Cc: stable@kernel.org # 4.8+
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -427,7 +427,7 @@ struct crng_state primary_crng = {
  * its value (from 0->1->2).
  */
 static int crng_init = 0;
-#define crng_ready() (likely(crng_init > 0))
+#define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
 #define CRNG_INIT_CNT_THRESH (2*CHACHA20_KEY_SIZE)
 static void _extract_crng(struct crng_state *crng,
@@ -793,7 +793,7 @@ static int crng_fast_load(const char *cp
 
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
-	if (crng_ready()) {
+	if (crng_init != 0) {
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 		return 0;
 	}
@@ -855,7 +855,7 @@ static void _extract_crng(struct crng_st
 {
 	unsigned long v, flags;
 
-	if (crng_init > 1 &&
+	if (crng_ready() &&
 	    time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL))
 		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
 	spin_lock_irqsave(&crng->lock, flags);
@@ -1141,7 +1141,7 @@ void add_interrupt_randomness(int irq, i
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
 
-	if (!crng_ready()) {
+	if (unlikely(crng_init == 0)) {
 		if ((fast_pool->count >= 64) &&
 		    crng_fast_load((char *) fast_pool->pool,
 				   sizeof(fast_pool->pool))) {
@@ -2214,7 +2214,7 @@ void add_hwgenerator_randomness(const ch
 {
 	struct entropy_store *poolp = &input_pool;
 
-	if (!crng_ready()) {
+	if (unlikely(crng_init == 0)) {
 		crng_fast_load(buffer, count);
 		return;
 	}
