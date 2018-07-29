Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC6EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 00:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A31C20842
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 00:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="RyJCqKb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A31C20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbeG2B7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 21:59:12 -0400
Received: from imap.thunk.org ([74.207.234.97]:38930 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731558AbeG2B7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 21:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gu10ZKH1wxiDcFftUCAEyp6OppT7gFusGDVaUJ+FjJY=; b=RyJCqKb4efLWJGENacnkfFUgyQ
        M9Qf+RSia3mrWTlrm91o7HWCt8Pav/Fjr3Mq62VQRXecz+2dle9ysHOF5EV0PvQ7MS3xAlStg5trc
        Dmne/TUQQbZsDFCtca+oMgaGvNX+OMOUja2ILPby2PstkXndpZenbF3spQFB8XT6Fezs=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fjZbk-0000mB-2k; Sun, 29 Jul 2018 00:30:48 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D3FDA7A6174; Sat, 28 Jul 2018 20:30:46 -0400 (EDT)
Date:   Sat, 28 Jul 2018 20:30:46 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random fixes for 4.18-rc7
Message-ID: <20180729003046.GA24909@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
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

The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:

  Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus_stable

for you to fetch changes up to 81e69df38e2911b642ec121dec319fad2a4782f3:

  random: mix rdrand with entropy sent in from userspace (2018-07-17 21:32:36 -0400)

----------------------------------------------------------------
In reaction to the fixes to address CVE-2018-1108, some Linux
distributions that have certain systemd versions in some cases
combined with patches to libcrypt for FIPS/FEDRAMP compliance, have
led to boot-time stalls for some hardware.  The reaction by some
distros and Linux sysadmins has been to install packages that try to
do complicated things with the CPU and hope that leads to randomness.
To mitigate this, if RDRAND is available, mix it into entropy provided
by userspace.  It won't hurt. and it will probably help.

----------------------------------------------------------------
Theodore Ts'o (1):
      random: mix rdrand with entropy sent in from userspace

 drivers/char/random.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
