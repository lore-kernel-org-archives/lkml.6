Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D4C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259182175A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="J0BWzmOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259182175A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeHNBzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:55:38 -0400
Received: from imap.thunk.org ([74.207.234.97]:39020 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbeHNBzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aF6ttjmZDaKlpi7Ehcn3TfWYDSpDoBue2hiA0j2BeLM=; b=J0BWzmOAyFZurgFf0xIanfqYC8
        hh+q1dt1RJVQ5n0IRGJDWcj5hJzIP0YqAMfzQ3DXfRAt75kXDCs0sjCNg8nBUFSAdFqjnT8I7JHQz
        FfucHeKREOUUntkVm5R3zbMDHULN0hYuC6XDgqvHLYDSNVT2UAZP3oR3Thli9+0HzbFw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fpLzX-0005KB-LF; Mon, 13 Aug 2018 23:11:15 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DEFA67A0391; Mon, 13 Aug 2018 19:11:14 -0400 (EDT)
Date:   Mon, 13 Aug 2018 19:11:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [GIT PULL] random updates for 4.19
Message-ID: <20180813231114.GA19929@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 81e69df38e2911b642ec121dec319fad2a4782f3:

  random: mix rdrand with entropy sent in from userspace (2018-07-17 21:32:36 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus

for you to fetch changes up to 9a47249d444d344051c7c0e909fad0e88515a5c2:

  random: Make crng state queryable (2018-08-02 17:33:06 -0400)

----------------------------------------------------------------
Some changes to trust cpu-based hwrng (such as RDRAND) for
initializing hashed pointers and (optionally, controlled by a config
option) to initialize the CRNG to avoid boot hangs.

----------------------------------------------------------------
Ingo Molnar (1):
      random: remove preempt disabled region

Jason A. Donenfeld (1):
      random: Make crng state queryable

Theodore Ts'o (1):
      random: add a config option to trust the CPU's hwrng

Tobin C. Harding (4):
      random: Fix whitespace pre random-bytes work
      random: Return nbytes filled from hw RNG
      vsprintf: Use hw RNG for ptr_key
      vsprintf: Add command line option debug_boot_weak_hash

 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 drivers/char/Kconfig                            | 14 ++++++++++++++
 drivers/char/random.c                           | 49 +++++++++++++++++++++++++++++++++++--------------
 include/linux/random.h                          |  3 ++-
 lib/vsprintf.c                                  | 27 ++++++++++++++++++++++++++-
 5 files changed, 85 insertions(+), 16 deletions(-)
