Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CC520989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545309554;
	bh=Eqcysuw+4eV/9t/SALYWhpClGWSSRDMsJYQPUNqLvPY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mVJit6I4ysetCraLwelFxCIhKGABrsk4GvciK/PNinLJIetVUYnW8AfV+KnevUfiY
	 U1c7FnvN4+cLWAZ/6Jxfggdx7ooIKh/t4NV+45cACetgA7//236Un9M19pplIdPskO
	 tw0Ahg03eM/qCC+QLZneTmwSH3k3bJJo4MnZsX/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbeLTMjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbeLTMjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:39:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0026C20866;
        Thu, 20 Dec 2018 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545309552;
        bh=Eqcysuw+4eV/9t/SALYWhpClGWSSRDMsJYQPUNqLvPY=;
        h=Date:From:To:Cc:Subject:From;
        b=XsGBH5FgDSfztiS1yr91ZqD8bAUVIBikofiGabDVU6TuhecFRKLkeidzQ7nZRo67a
         +67WYptvB9WEhwvolM5+CkkuPA8PxC7jO7Sdg2lzXoMLmYNQhHIrXdpG1tA2W+Ckh3
         9KqMoRw/L9t61mYvF86n+ImhE3qVUaIN4taH810c=
Date:   Thu, 20 Dec 2018 13:39:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 4.20-rc8
Message-ID: <20181220123910.GA18277@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.20-rc8

for you to fetch changes up to 3c9dc275dba1124c1e16e7037226038451286813:

  Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again" (2018-12-17 16:18:29 +0100)

----------------------------------------------------------------
TTY/Serial fix for 4.20-rc8

Here is a single fix, a revert, for the 8250 serial driver to resolve a
reported problem.  There was some attempted patches to fix the issue,
but people are arguing about them, so reverting the patch to revert back
to the 4.19 and older behavior is the best thing to do at this late in
the release cycle.

The revert has been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Paul Burton (1):
      Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"

 drivers/tty/serial/8250/8250_port.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)
