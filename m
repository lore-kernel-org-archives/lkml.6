Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 944A2C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32633208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="pZYY7+d1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnzS3jWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32633208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934800AbeFLAj1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:39:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51383 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933759AbeFLAj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:39:26 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BE1E21D06;
        Mon, 11 Jun 2018 20:39:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Jun 2018 20:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=p2rHTWRTzkhS9MARCBdciSsLyRZLHsUZPSEYyUUn7
        gA=; b=pZYY7+d1cV2hmAIQ+ACHP41Dh40WaWBQlRZthdpHT7CBCvFtCfTH53/+K
        my8GxNpO/bLc+MmGQpwAgmZr2C1j1hpEtEU3qybIFh8UlqRfB8IyuIwAMI0n/5D/
        252NyDwJbq5B9z50qvGwgzdCcpsXJXhoudVD3sTxJ9DnphIkQPQTISOh5zI84s52
        QAQGVVAe0RXnMuKiDfkpKsm4vdLchPcOou/dNMUe3dCmCe76qBjveDkZb96gzbJt
        vivGH+M6nJ58Hnq0JY2l5H2xh3jMI8KwQgk0RulVrFn8r4iYCE9ZYxjtsZulGRy/
        EoreJ+LSKmduRLQfnEL3Uz3g+LSmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=p2rHTWRTzkhS9MARC
        BdciSsLyRZLHsUZPSEYyUUn7gA=; b=EnzS3jWQlz3vOzovK385ucL6qL5h14iC8
        Exl/BUWzu9nGcuJ+xUfaEUNGHOqhI0efVh48kmsR1t+SOuuyTBOAww0enloeuSxh
        IciAlkmbodnVzHgtopUldDjPKY/VaAUl9i9qNr4ouhsUoNL73Ldum4qh2lUGUPD2
        WsUJXZtRjlqumakN/XkS33NVWkWArks+eVf0Teox+Ma2N2J3wPcMLH20MAOI0q6D
        9Bbqe2nub7g39UqjRJgBPz0f2xGZimD9RjExlI2oVAV8KZz60wKRIqo/ij25aAeG
        VEhRWXuY/b+bpGDsE/LFoztQn3omDDn4EiZNf4djG95sHsEaMgFQA==
X-ME-Proxy: <xmx:PhYfWw0j3Pt33x84xrbZM4S2HUecA81FDh56MeKjQD-uTKj5CmDKQg>
X-ME-Proxy: <xmx:PhYfW7SQfc7TViKA0DU4CqoVS73zqoNrh63XFY4M9pV9BEwnsOHCaw>
X-ME-Proxy: <xmx:PhYfW6udQmE_sDDVzmu7FKz3dnOxTy8oltbUpdDDFR1pdCtfoiC0Ug>
X-ME-Proxy: <xmx:PhYfW4ZBb9AzvGt27kMaKhReWQEaGj18aHV6bmfOyjnJR-0IY-QqTQ>
X-ME-Proxy: <xmx:PhYfW3s1Xe34BbpahXibZTgl8RdRavwRtvRAG7kA3Eddi1CVwGW7Ag>
X-ME-Proxy: <xmx:PhYfW6wdBll89-FB3GTwcgWkR2_QD9idoHFMhfH0NALlWT7lVqzi8g>
X-ME-Sender: <xms:PRYfW6hqpFbGFQE3oSAflYhlt4OPo_kO1et4qMIR_G_wF05sUstcZQ>
Received: from localhost (124-169-136-87.dyn.iinet.net.au [124.169.136.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46C39E464A;
        Mon, 11 Jun 2018 20:39:25 -0400 (EDT)
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
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] enable early printing of hashed pointers
Date:   Tue, 12 Jun 2018 10:39:10 +1000
Message-Id: <1528763954-27731-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

No changes to logic since v6.

thanks,
Tobin.

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

 Documentation/admin-guide/kernel-parameters.txt |  9 ++++++++
 drivers/char/random.c                           | 19 +++++++++--------
 include/linux/random.h                          |  2 +-
 lib/vsprintf.c                                  | 28 ++++++++++++++++++++++++-
 4 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.7.4

