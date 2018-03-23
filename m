Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-947063-1521799973-2-5323290037837764724
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
    t=1521799972; b=mwJA/fRWHMqI9Y16T6gOBafipwaAJ4nnMclzui18sTokuzl
    KtGd7YD6v/jzdrvL4dVoJBUBkBoiRnaYEEu3MeKefAiBFVTpdKVUpPW8MP/q5vav
    uADqjTRXRvBR1b9IGzoS/en7eTSEF93R1QU2Tt4PA3qQpjgyCw1dhnUhbfilgRIo
    B0CGFlKW378hH81Icm1/8mbpo/AhADTReXRPSahxSfIavpM2xauWJjiHb3Szzwyz
    QBquJ+GcAq28dlmmMnMwrkMiHgfcCD68YMqO3Rzr1UFACEvx5KMqVF4iX4vz5WvC
    ctHqw4Q8lLFIglHm3sgcPi97yVADJe9nerP8xrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799972; bh=SdOZUEOzPu24Gm/eqNlkJggicD
    80jKXVFwfmmfHlRpM=; b=qXlOkFN3hV/IvOvlGGucNMpt5j+Bs5jDxAuojDX8yz
    ScUMnp6RI2dMM3Yhj+R7B0DdC49CMl/AHvrnuU6DIWONKL0qVvVoJX6ZJcZo00Xh
    EY8nnbm6V4G4OT2Mr0Zv8wp8HwNibg7GLg6rs0NNGwjXUfyAXOWq5tuLkob4IXsA
    8ydbbaJxHdytyIUprgLUYDkaHj2NwOJI6zOKX5PsZHPkVVlv0ha2LDES+7NenCLy
    E7GSTFl122NhEcXRGCiXd+VHZfv0Mj52aVjfhVD7WRcfK2J+Ws5mReYrY6v4MTQt
    jZgVJPttIWjE0ARYBlYtVD4i2aOlhKWqH2EzNsc0G44A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCWKMq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:12:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeCWKMo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 4.9 174/177] clk: migrate the count of orphaned clocks at init
Date: Fri, 23 Mar 2018 10:55:02 +0100
Message-Id: <20180323094212.819645938@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Jerome Brunet <jbrunet@baylibre.com>

commit 99652a469df19086d594e8e89757d4081a812789 upstream.

The orphan clocks reparents should migrate any existing count from the
orphan clock to its new acestor clocks, otherwise we may have
inconsistent counts in the tree and end-up with gated critical clocks

Assuming we have two clocks, A and B.
* Clock A has CLK_IS_CRITICAL flag set.
* Clock B is an ancestor of A which can gate. Clock B gate is left
  enabled by the bootloader.

Step 1: Clock A is registered. Since it is a critical clock, it is
enabled. The clock being still an orphan, no parent are enabled.

Step 2: Clock B is registered and reparented to clock A (potentially
through several other clocks). We are now in situation where the enable
count of clock A is 1 while the enable count of its ancestors is 0, which
is not good.

Step 3: in lateinit, clk_disable_unused() is called, the enable_count of
clock B being 0, clock B is gated and and critical clock A actually gets
disabled.

This situation was found while adding fdiv_clk gates to the meson8b
platform.  These clocks parent clk81 critical clock, which is the mother
of all peripheral clocks in this system. Because of the issue described
here, the system is crashing when clk_disable_unused() is called.

The situation is solved by reverting
commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting during registration").
To avoid breaking again the situation described in this commit
description, enabling critical clock should be done before walking the
orphan list. This way, a parent critical clock may not be accidentally
disabled due to the CLK_OPS_PARENT_ENABLE mechanism.

Fixes: f8f8f1d04494 ("clk: Don't touch hardware when reparenting during registration")
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/clk.c |   37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2438,22 +2438,37 @@ static int __clk_core_init(struct clk_co
 	core->rate = core->req_rate = rate;
 
 	/*
+	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
+	 * don't get accidentally disabled when walking the orphan tree and
+	 * reparenting clocks
+	 */
+	if (core->flags & CLK_IS_CRITICAL) {
+		unsigned long flags;
+
+		clk_core_prepare(core);
+
+		flags = clk_enable_lock();
+		clk_core_enable(core);
+		clk_enable_unlock(flags);
+	}
+
+	/*
 	 * walk the list of orphan clocks and reparent any that newly finds a
 	 * parent.
 	 */
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
 		struct clk_core *parent = __clk_init_parent(orphan);
-		unsigned long flags;
 
 		/*
-		 * we could call __clk_set_parent, but that would result in a
-		 * redundant call to the .set_rate op, if it exists
+		 * We need to use __clk_set_parent_before() and _after() to
+		 * to properly migrate any prepare/enable count of the orphan
+		 * clock. This is important for CLK_IS_CRITICAL clocks, which
+		 * are enabled during init but might not have a parent yet.
 		 */
 		if (parent) {
 			/* update the clk tree topology */
-			flags = clk_enable_lock();
-			clk_reparent(orphan, parent);
-			clk_enable_unlock(flags);
+			__clk_set_parent_before(orphan, parent);
+			__clk_set_parent_after(orphan, parent, NULL);
 			__clk_recalc_accuracies(orphan);
 			__clk_recalc_rates(orphan, 0);
 		}
@@ -2470,16 +2485,6 @@ static int __clk_core_init(struct clk_co
 	if (core->ops->init)
 		core->ops->init(core->hw);
 
-	if (core->flags & CLK_IS_CRITICAL) {
-		unsigned long flags;
-
-		clk_core_prepare(core);
-
-		flags = clk_enable_lock();
-		clk_core_enable(core);
-		clk_enable_unlock(flags);
-	}
-
 	kref_init(&core->ref);
 out:
 	clk_prepare_unlock();
