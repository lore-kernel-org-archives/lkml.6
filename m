Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67AF20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547375000;
	bh=RAJ93jZwo7OUsRc5S2wy9Yn0b2QS39ANhx2I9NF+5PE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VMAe4Rhf0gcAhisc7rNzWTEbrnaftU4Jg1EqrvdAhtsOMJ8Mof/7tKuvPJp3j3+SO
	 BTmBAcnpP+W6tIZUiAp3lmU15byNDLTM/xteU13fek9H8R+NxGCk7iQ9IAjF5580bb
	 tSFNSkTqHZp2/T0sv545CeeKSJ8tuSUYPf0Xj89I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfAMKXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 05:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfAMKXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 05:23:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5741920657;
        Sun, 13 Jan 2019 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547374998;
        bh=RAJ93jZwo7OUsRc5S2wy9Yn0b2QS39ANhx2I9NF+5PE=;
        h=Date:From:To:Cc:Subject:From;
        b=EtrVusSAcGl6aGnR76sIjsixZHIhwW+06rPEcXyKi3j2Vu5zn+x3wurEX36uNRUN9
         Pc0Kwj6mX94g5EnlR84c4EsPD2Y3Qur+O4a9chazw89UIzP6Vqfg+IvncIMumim4xR
         WdCX38aEDdrF+6/blJyicvr833WaUtp8yi5+R0Sw=
Date:   Sun, 13 Jan 2019 11:23:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 5.0-rc2
Message-ID: <20190113102316.GA17169@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc2

for you to fetch changes up to d3736d82e8169768218ee0ef68718875918091a0:

  tty: Don't hold ldisc lock in tty_reopen() if ldisc present (2019-01-11 17:03:42 +0100)

----------------------------------------------------------------
tty/serial fixes for 5.0-rc2

Here are 2 tty and serial fixes for 5.0-rc2 that resolve some reported
issues.

The first is a simple serial driver fix for a regression that showed up
in 5.0-rc1.  The second one resolves a number of reported issues with
the recent tty locking fixes that went into 5.0-rc1.  Lots of people
have tested the second one and say it resolves their issues.

Both have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dmitry Safonov (1):
      tty: Don't hold ldisc lock in tty_reopen() if ldisc present

Hauke Mehrtens (1):
      serial: lantiq: Do not swap register read/writes

 drivers/tty/serial/lantiq.c | 36 +++++++++++++++++++-----------------
 drivers/tty/tty_io.c        | 20 +++++++++++++-------
 2 files changed, 32 insertions(+), 24 deletions(-)
