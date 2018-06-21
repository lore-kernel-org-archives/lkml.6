Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6795CC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093572252A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="pfV0xmqh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6h8fmHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093572252A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933887AbeFUXPs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:15:48 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44947 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933729AbeFUXPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:15:47 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8688321ADC;
        Thu, 21 Jun 2018 19:15:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 19:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=ezFNTReJe1JXgRAEi8472EaQ2jJYUKb753WBH+da+
        HI=; b=pfV0xmqh6cj2C+t7JXxJlyW24J1hzTdjMCWJtpGfhamcVZckwzxhWz8Rt
        PIw2y9yBBpmJuwGFonfmZvh0Mi0AMrmdNRp0QaVsjRsXNXrDjyu1DJnXXlfEm+Q/
        7dx8lUZCULEDosxhTmHV0YQMQcLV8tY/nk53dHCJb5IdYYv+oZbA0ML+grG1Csnu
        nSmvktonveBfg41fq9O5y7OH7QujIkWACma4Vfm2jGOGUv6LzhMs6bky9I0/hEg/
        AWlmPYt0OJ3Q/iDfh+HmXrts2h2pyDCaAY2rCWy1CAOQ2ymOXb5DBNmiPDpipMcA
        v/C91cKvbuzsBgbBOPdO6BYeTLOaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ezFNTReJe1JXgRAEi
        8472EaQ2jJYUKb753WBH+da+HI=; b=e6h8fmHSTvTtxXKNIPqlxG5HclL46HytW
        t156IyVQRf5Zsw7fDtDZnUaJt1Fin5oTFK+mdNDumcmvVS8nhwoA7g4bqsylkCVL
        Im+6gIwRu+pBUpp+UH7yQ7lg8ymOckW9WnDijJNaveZTmtRqhUyz/3tCIAkrgEOt
        K8KwH8Ms2AMCbfBZqxHCAKfC9EidO/YGc3Ymn3F5QKS6k0dS3IWEbU68xqDvj4jL
        WsVoA67OPa7Of3cEqQEdzx0XCl+ZxTuB/0KLTvpd2nM+N2kUoyJCxnI/a7RKlftw
        ajQbTdS8z1rCizvngMBYGy9cBRhh/iVZgRnYD/OW9V3axzVjA3Zig==
X-ME-Proxy: <xmx:ojEsW1isbBVXXWU-qk4lcrNEygshXMmeeLIjPD15SwZAy-aVJQW_Yg>
    <xmx:ojEsW6rhH1RdT64MMrtuTR4LfhN5SonOzJKh7sqE7MfkuQPeo3fUKA>
    <xmx:ojEsWwOhm0Fkp0jHanxbdjUHeQAQpqCVilt2pt6i3_-HxLk2iAovFg>
    <xmx:ojEsW-1KW-Whg4l9WSXNHC51Qu2uZYfQT-vnBcklIkrqNxqDRbc1FA>
    <xmx:ojEsW2o0X_niI-jAw12Lme54tWHz_UFX4fgt6a6LJFQaGrtvUj6efg>
    <xmx:ojEsWwt8SdOTG1cjzLDyNbBvATtjQ4nfkzcUB8Je-ElTgVMG9f-UJg>
X-ME-Sender: <xms:ojEsW97Mm6e-C07sQbPRedZXiONI4XoTOPyHWXi7bO0YVMfZDpRzhQ>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id A750BE4449;
        Thu, 21 Jun 2018 19:15:45 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Theodore Ts'o <tytso@mit.edu>
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
Subject: [PATCH v9 0/4] enable early printing of hashed pointers
Date:   Fri, 22 Jun 2018 09:15:30 +1000
Message-Id: <20180621231534.32278-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is v9, only change is to update kernel parameters documentation
after discussion on LKML with Randy. (And add a full stop to comment
string.)


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

v9
 - Improve documentation text of new kernel parameter
   debug_boot_weak_hash (thanks Randy).
 - Add full stop to comment string.

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

 .../admin-guide/kernel-parameters.txt         |  8 ++++++
 drivers/char/random.c                         | 19 ++++++-------
 include/linux/random.h                        |  2 +-
 lib/vsprintf.c                                | 27 ++++++++++++++++++-
 4 files changed, 45 insertions(+), 11 deletions(-)

-- 
2.17.1

