Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C61C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C6D20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="lwiwwx1z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jd8swQE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C6D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbeFTEU6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:20:58 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51777 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750871AbeFTEU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:20:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C22FA21C97;
        Wed, 20 Jun 2018 00:20:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Jun 2018 00:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=JhBqvKkj9RdCSy/Kzo/gNP1jFkYhiP38CX6NauQda
        M8=; b=lwiwwx1z6O6noXFtrHeznl9TLMgkpoQ0V9Ng8C089TmbsdO7rGXKcHlLd
        Qjfzaz+oJXzKeLffDZbYslgNTiwX4+/Er7z2VpbrWudfzvy7xqOb2778vUvdlznz
        pFAXpP/2UCdjsIdf/AsyWyG8MNn6rnocUemhp6onQBRP5eqEu2ckoSnDq1lpjvnw
        eGNg0VPPgpTJW0TmhSV10Q/B9/bVZlrA8SuOXnCZZf8aet52i5rnRqo/yq9etpM5
        BblvoytzfQmhEw1wXCL4iYlr2TjgOGyMyYt9WS2aQEfMM8dI8JNZ6m0QEuw+2TWS
        Z0xEG4gVxFjFwgh8Ey4KBv5kVkZxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JhBqvKkj9RdCSy/Kz
        o/gNP1jFkYhiP38CX6NauQdaM8=; b=jd8swQE3PBFiiCIF1i09o69OCJUzUY2B/
        ziml+UgOkR2JAMmZiUeAXZ28a09ufCcGEGL2prMwV804cdNlXZczfnAUwa0+Wbuj
        ZazT2A7xHRDQrdGWbdImq9RpAgqj2pHLZOTp09w34zkT4PoFG46d4c1QQnbtkAFK
        6wJVMZXmy1DNgoDgppHvn6aAeOgyIicHzAakIieiR7l9HgSKRVx9j666IDm3GfBA
        pbqi46oZg1p4vcGNlmKk0Re+ALq/TDfwM6U+Gy1lohgVPuwdUYsQXZDudgFs+Pei
        rUrRYfDpkhFUJzIZ8N2B3haAsRykD/xB39ZKELH+Bb49FEaynyW9w==
X-ME-Proxy: <xmx:KNYpW9Wvx2EdUvnhFZfasf70KxAFqpKx0s5rZeQAtSCdUBcrZRv56Q>
    <xmx:KNYpWws-f6tAIfbTWhIfONlQdX0IByHHSizlgnirszuocg5FHQzq8Q>
    <xmx:KNYpW23eTzcrmFucA460pdiWQUH7-OzmGqHUQ8km51Y7pVf-axfMJA>
    <xmx:KNYpW04hdvCuBNqo3SYIdwZ64eLDphfK9z1nwBxN4c5TsZ3h9sO_NA>
    <xmx:KNYpW2Nw_RbySylQZKljrvE4L-W5nxxq2aIhaju9EialP_PkRuX1ug>
    <xmx:KNYpWzyGcQuuNxEo4MopGzzQn7wQbyyqWhUtnYkuGUJKBecVO4NkVw>
X-ME-Sender: <xms:KNYpWziWbxe80pzSOL-i749L9fjo8gQGDVVviHcWPNVczk0SX210Ow>
Received: from localhost (ppp118-211-207-6.bras1.syd2.internode.on.net [118.211.207.6])
        by mail.messagingengine.com (Postfix) with ESMTPA id D027BE4076;
        Wed, 20 Jun 2018 00:20:55 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/4] enable early printing of hashed pointers
Date:   Wed, 20 Jun 2018 14:20:42 +1000
Message-Id: <20180620042046.30806-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ted,

Version 8 changes patch 2 which you previously acked.  Change is to
remove integer cast as suggested on LKML.  I've kept the ACK.

Changes made to patch with reviewed-by tag from Steve were acknowledged
on LKML, I've also kept Steve's tag.



Currently printing pointers early in the boot sequence can result in a
dummy string '(____ptrval____)' being printed.  While resolving this
issue it was noticed that we can use the hw RNG if available for hashing
pointers.

Patch one and two do the ground work to be able to use hw RNG removing
from get_random_bytes_arch() the call to get_random_bytes() and
returning the number of bytes of random material successfully returned. 

Patch three uses the hw RNG to get keying material if it is available.

Patch four further assists debugging early in the boot sequence for
machines that do not have a hw RNG by adding a command line option
'debug_boot_weak_hash'.  If enabled, non-cryptographically secure hashing
is used instead of siphash so we can hash at any time. 


thanks,
Tobin.

v8
 - Remove pointless EXPORT_SYMBOL on static variable (thanks Steve).
 - Remove unnecessary integer cast from min_t() argument (thanks Andy).

v7
 - Remove unused variable, clearing compiler warning (found by Stephen
   Rothwell's linux-next build infrastructure).

v6
 - Rebase on top of Steve's patch (fixing race condition).  Uses static
   branch instead of memory barrier.

v5
 - Use 'upside-down-xmas-tree' style to declare local variables (Steve)
 - Added Reviewed-by tag from Steve (patch 2 and 3).

v4
 - remove last patch of series (command line option patch)

v3
 - Add __ro_after_init (suggested by Kees).

v2
 - Use min_t() instead of min() (thanks checkpatch).
 - Add __must_check to function declaration (thanks Steve).
 - Use hw RNG by default if available (as originally suggested by Kees).
 - Add command line option to use cryptographically insecure hashing.
   If debug_early_boot is enabled use hash_long() instead of siphash
   (as requested by Steve, and solves original problem for Anna-Maria).
 - Added Acked-by tag from Ted (patch 1 and 2)


Tobin C. Harding (4):
  random: Fix whitespace pre random-bytes work
  random: Return nbytes filled from hw RNG
  vsprintf: Use hw RNG for ptr_key
  vsprintf: Add command line option debug_boot_weak_hash

 .../admin-guide/kernel-parameters.txt         |  9 +++++++
 drivers/char/random.c                         | 19 ++++++-------
 include/linux/random.h                        |  2 +-
 lib/vsprintf.c                                | 27 ++++++++++++++++++-
 4 files changed, 46 insertions(+), 11 deletions(-)

-- 
2.17.1

