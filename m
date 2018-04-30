Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116630-2-14306810337132753989
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
    1525116630; b=ZJsDxn0iVIbvF+s1W1BMjWo+Cn7lQ8rvdlxOFTXs1cFh2niR8r
    1MSgUsShvaznZaXGip3XECd9e+sRhuA7qdACYISpAIiu4fW0Js+wEETIZGwGFumJ
    Fe61M/d6Xi9cNDMdz0mkW2ESQ5fTWU4RaXkoMtaY62ck9Yt/Ie2ofl0iFPP5cEUQ
    DTFL5cLXGeA9ime8CO9EjrZ0neAEEQhbvY/URjBgzdk8oZBdWS9Zu9i0Tyg6EYTC
    4Uv8cq1fFjRkMLpsGFugAeIRoX7klD9bZGcXbckJTB5wuxT1BN9NMX48dyuJusur
    wnkrqpPBmNR+rqFwOMT+uhcdZbjeDbOl/N6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116630; bh=JJcj3L9+GW+jA+DTDkucgPyT4eKQf3
    RFEJFKL2Rb8vU=; b=RyWdxh4r/ExSH/XQcjU/xdQIdh7lV+CVxgUGdpXxzxfycd
    TByUH8bQUdnHeDesx2A/y3rfcDA+jLa72BC1EYBSC/R5ekRcD52W99oTuTDuX0zB
    Ltv0pfOF0QTFTPmNW4xVd4paBAlhaO9NdW2yBRrkZYri8Y1vRaAZDaKUVJA+qGoQ
    Cd8K09tAxE25si3hslkVrHci0D5WlYy27pO/3HJqxhYB5TOXIwh22d2cROXGtmNp
    3i5pYim7BSDLbFPgLMPvb4Kv6/ndIGvDj8ubY/0Pt1u19dOlWMny+eVskZACf8Gt
    3PxqJTl1jxC8/Df6OWpI3UMoybKcMq0jLp8CnQxA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfBzwk4/fRAoY0uXrZfrj/cakobiuBFUyz/twXmOYDuTvhnLS2xAtjh7XQbxsIS/U+FWlaRc0kGozdBZWrsM23B3Ivtcvpn9M0JIe67LGVGVaxgxVuzkM
    9WHWQGQtWqlpgJ1Z03Uz7NlPuBgze19REiRIQelISnleTd8kOdQaB5ZPx8WwgqMgYSDWZAHArpMxRlZNABvbFM0/lfDRpFHstTn9XKllg7gviCqOszpq1BR2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=vDTwGnz7tqcdVkfDgaMA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932450AbeD3TaX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756479AbeD3TaV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:30:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224D822DAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 05/61] random: set up the NUMA crng instances after the CRNG is fully initialized
Date: Mon, 30 Apr 2018 12:24:08 -0700
Message-Id: <20180430183951.779500324@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8ef35c866f8862df074a49a93b0309725812dea8 upstream.

Until the primary_crng is fully initialized, don't initialize the NUMA
crng nodes.  Otherwise users of /dev/urandom on NUMA systems before
the CRNG is fully initialized can get very bad quality randomness.  Of
course everyone should move to getrandom(2) where this won't be an
issue, but there's a lot of legacy code out there.  This related to
CVE-2018-1108.

Reported-by: Jann Horn <jannh@google.com>
Fixes: 1e7f583af67b ("random: make /dev/urandom scalable for silly...")
Cc: stable@kernel.org # 4.8+
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -819,6 +819,32 @@ static int crng_fast_load(const char *cp
 	return 1;
 }
 
+#ifdef CONFIG_NUMA
+static void numa_crng_init(void)
+{
+	int i;
+	struct crng_state *crng;
+	struct crng_state **pool;
+
+	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
+	for_each_online_node(i) {
+		crng = kmalloc_node(sizeof(struct crng_state),
+				    GFP_KERNEL | __GFP_NOFAIL, i);
+		spin_lock_init(&crng->lock);
+		crng_initialize(crng);
+		pool[i] = crng;
+	}
+	mb();
+	if (cmpxchg(&crng_node_pool, NULL, pool)) {
+		for_each_node(i)
+			kfree(pool[i]);
+		kfree(pool);
+	}
+}
+#else
+static void numa_crng_init(void) {}
+#endif
+
 static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 {
 	unsigned long	flags;
@@ -848,6 +874,7 @@ static void crng_reseed(struct crng_stat
 	memzero_explicit(&buf, sizeof(buf));
 	crng->init_time = jiffies;
 	if (crng == &primary_crng && crng_init < 2) {
+		numa_crng_init();
 		crng_init = 2;
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
@@ -1661,29 +1688,10 @@ static void init_std_data(struct entropy
  */
 static int rand_initialize(void)
 {
-#ifdef CONFIG_NUMA
-	int i;
-	struct crng_state *crng;
-	struct crng_state **pool;
-#endif
-
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
 	crng_initialize(&primary_crng);
 	crng_global_init_time = jiffies;
-
-#ifdef CONFIG_NUMA
-	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
-	for_each_online_node(i) {
-		crng = kmalloc_node(sizeof(struct crng_state),
-				    GFP_KERNEL | __GFP_NOFAIL, i);
-		spin_lock_init(&crng->lock);
-		crng_initialize(crng);
-		pool[i] = crng;
-	}
-	mb();
-	crng_node_pool = pool;
-#endif
 	return 0;
 }
 early_initcall(rand_initialize);
