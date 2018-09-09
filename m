Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39594C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A2D20866
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="FfUqm52d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A2D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeIIRRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 13:17:45 -0400
Received: from imap.thunk.org ([74.207.234.97]:40450 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeIIRRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 13:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=31yAyMRZvvzhJ6NIv0dAPVQcWfaf51sfaVWNklgSxKo=; b=FfUqm52dDykvBnbFAA8cG/kkZ1
        6XkWIUtMCVs5h0vXuE4wkvgV0v2g1FJ74CKcQcu0aUFAr14l2WXhBVhywS6DQReQjbSHDvEAFPe9r
        0JQjLMd73mk9cDrsekT6vQo2WFv+KrSqeHKIM8RHF8yHWA0kTATJFBVIBMURwxsu+K88=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fyyp3-000878-2r; Sun, 09 Sep 2018 12:28:13 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0C6607A56AD; Sun,  9 Sep 2018 08:28:12 -0400 (EDT)
Date:   Sun, 9 Sep 2018 08:28:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-crypt@vger.kernel.org
Subject: [GIT PULL] random fixes for 4.19-rc3
Message-ID: <20180909122811.GA5355@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-crypt@vger.kernel.org
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

The following changes since commit 9a47249d444d344051c7c0e909fad0e88515a5c2:

  random: Make crng state queryable (2018-08-02 17:33:06 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/for_linus

for you to fetch changes up to 9b25436662d5fb4c66eb527ead53cab15f596ee0:

  random: make CPU trust a boot parameter (2018-09-01 12:51:54 -0400)

----------------------------------------------------------------
Fix things so the choice of whether or not to trust RDRAND to
initialize the CRNG is configurable via the boot option
random.trust_cpu={on,off}

----------------------------------------------------------------
Kees Cook (1):
      random: make CPU trust a boot parameter

 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/char/Kconfig                            |  4 ++--
 drivers/char/random.c                           | 11 ++++++++---
 3 files changed, 16 insertions(+), 5 deletions(-)
