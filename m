Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23EBC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DB020831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544354241;
	bh=sQR2f1sQXs7tUuesvTAi0EUVvw4D7XPi6nPkvmhi0jM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OTAxvnhsb+PTyvCFzkKrVWi1ETF566hOdJl3HeOFti34YYVoD/bqid3VywdyDU1MB
	 31DFqrXHBe4wU72ENpDeto6BcB8aWFHsVWCkrxT0PB4ad9fBe2R0AMb44SkDquD5Md
	 VQlxbAEseyaKarn8YQKhgUbv4GFgbjiyhAoGDdQo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DB020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLILRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:17:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbeLILRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:17:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B99320661;
        Sun,  9 Dec 2018 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544354239;
        bh=sQR2f1sQXs7tUuesvTAi0EUVvw4D7XPi6nPkvmhi0jM=;
        h=Date:From:To:Cc:Subject:From;
        b=G/DwUHtLPA9MMRHNYcC3skea5xMXAzp0SQtyJJ+lgsLhdtEkI/Ur6ZRf2FiEYvdQw
         oHyl4hpryKMfC/+TM3fEK0/DbUKiMnBlQp/zuiWib4xiKyHhj4f9QijVNGRetzU/80
         A/pFUiwpBvlJOIYchE7MvECS75x+3oA3x39uE7Fs=
Date:   Sun, 9 Dec 2018 12:17:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 4.20-rc6
Message-ID: <20181209111717.GA9735@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.20-rc6

for you to fetch changes up to dada6a43b0402eba438a17ac86fdc64ac56a4607:

  kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var() (2018-12-06 15:59:07 +0100)

----------------------------------------------------------------
TTY driver fixes for 4.20-rc6

Here are three small tty driver fixes for 4.20-rc6

Nothing major, just some bug fixes for reported issues.  Full details
are in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chanho Park (1):
      tty: do not set TTY_IO_ERROR flag if console port

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Peter Shih (1):
      tty: serial: 8250_mtk: always resume the device in probe.

 drivers/tty/serial/8250/8250_mtk.c | 16 +++++++---------
 drivers/tty/serial/kgdboc.c        |  4 ++--
 drivers/tty/tty_port.c             |  3 ++-
 3 files changed, 11 insertions(+), 12 deletions(-)
