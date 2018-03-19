Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484232-2-1984118109157410933
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
    t=1521484231; b=CVu6Toc9HEFHk8jbuoMu4XFW7WMT/8+kjazBHju4akzhnRN
    kG5lJDoimgFXjxHC0jpX3cDwiO+NgDYZUUCse5hpLq29ztyt9cxiZbBxXl515BeF
    1cvE252mcqmRB7iEEDiLYsADWzZ+Dll5J61LkuClxS4aMm77soR/9aeoX1MtQFkS
    seqbck4XbibO74icGqU61p6LLhXPb4hs5m5ZyxkNqNneH77uJiKdGg0b2M3s+xe+
    VZ9hkXM7l3vo0vbS2YaqDGAWM9LRfvXUTJshfjC26PSGvRF+0crI3m2zpY1dafdc
    Eh5q3fNBEC59bPglGBsEXcK1mz8wjjHJxrJ+lvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484231; bh=M81bpAsIRmhjXPvLA5c9j2XLXn
    UZrlO340I7H3DRA8g=; b=bIvE+9IL/R56DoCW4t0kLIg2ejSUxNfc1jp9gM5bJs
    3yKFhNPhTS94vF5OI6OROkEivwywrSYnCwGB7+MtBHdxhMg/d1j4DARNMkg4BVXD
    ABnQss3N6jwfsB2Ucze5KkadJL3xleSQP7TjEuudnGn3jCaH3NoUoWX08ZwyWc7O
    iWutxq7ezc/53A0+rKy4so8YtyW+/f6rfGdoaLU3Aj/E65M3jDIGi+aN0/qYy4T0
    YrnYQBDzZlLKU+5BlTPU68tkE4Rtc74NHW4L3409rFd6z+eTv+rgYykj8tONGL0w
    9q8d3iOpOMUuXTyWZFJzdwvxzIqDmpWwXBHlKDToX8sw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegvdeiieenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegvdeiieenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031924AbeCSSaZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:30:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935692AbeCSSaW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:30:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 34/41] btrfs: remove spurious WARN_ON(ref->count < 0) in find_parent_nodes
Date: Mon, 19 Mar 2018 19:08:34 +0100
Message-Id: <20180319180734.440233720@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
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

From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>

commit c8195a7b1ad5648857ce20ba24f384faed8512bc upstream.

Until v4.14, this warning was very infrequent:

	WARNING: CPU: 3 PID: 18172 at fs/btrfs/backref.c:1391 find_parent_nodes+0xc41/0x14e0
	Modules linked in: [...]
	CPU: 3 PID: 18172 Comm: bees Tainted: G      D W    L  4.11.9-zb64+ #1
	Hardware name: System manufacturer System Product Name/M5A78L-M/USB3, BIOS 2101    12/02/2014
	Call Trace:
	 dump_stack+0x85/0xc2
	 __warn+0xd1/0xf0
	 warn_slowpath_null+0x1d/0x20
	 find_parent_nodes+0xc41/0x14e0
	 __btrfs_find_all_roots+0xad/0x120
	 ? extent_same_check_offsets+0x70/0x70
	 iterate_extent_inodes+0x168/0x300
	 iterate_inodes_from_logical+0x87/0xb0
	 ? iterate_inodes_from_logical+0x87/0xb0
	 ? extent_same_check_offsets+0x70/0x70
	 btrfs_ioctl+0x8ac/0x2820
	 ? lock_acquire+0xc2/0x200
	 do_vfs_ioctl+0x91/0x700
	 ? __fget+0x112/0x200
	 SyS_ioctl+0x79/0x90
	 entry_SYSCALL_64_fastpath+0x23/0xc6
	 ? trace_hardirqs_off_caller+0x1f/0x140

Starting with v4.14 (specifically 86d5f9944252 ("btrfs: convert prelimary
reference tracking to use rbtrees")) the WARN_ON occurs three orders of
magnitude more frequently--almost once per second while running workloads
like bees.

Replace the WARN_ON() with a comment rationale for its removal.
The rationale is paraphrased from an explanation by Edmund Nadolski
<enadolski@suse.de> on the linux-btrfs mailing list.

Fixes: 8da6d5815c59 ("Btrfs: added btrfs_find_all_roots()")
Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Reviewed-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/backref.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1252,7 +1252,16 @@ again:
 	while (node) {
 		ref = rb_entry(node, struct prelim_ref, rbnode);
 		node = rb_next(&ref->rbnode);
-		WARN_ON(ref->count < 0);
+		/*
+		 * ref->count < 0 can happen here if there are delayed
+		 * refs with a node->action of BTRFS_DROP_DELAYED_REF.
+		 * prelim_ref_insert() relies on this when merging
+		 * identical refs to keep the overall count correct.
+		 * prelim_ref_insert() will merge only those refs
+		 * which compare identically.  Any refs having
+		 * e.g. different offsets would not be merged,
+		 * and would retain their original ref->count < 0.
+		 */
 		if (roots && ref->count && ref->root_id && ref->parent == 0) {
 			if (sc && sc->root_objectid &&
 			    ref->root_id != sc->root_objectid) {
