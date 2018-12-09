Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE79C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0A820831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544354290;
	bh=a9O3cJGuImwcQjTaf3ykLPUFEyjNdTZuF6fo7tuxgU4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CQyr/L99Q5VY+QKYbEkISplYk0XrI9+T/nW2fk5M4FCzn44ahe4bbMv4JWyikcaT5
	 uIMxw9gbwNh6PNLHMs0ieuZf6eUZuo98jVw6zXmTs389AJboiYWYRVSjF8LBjeS80V
	 jk8xTatQYLMdD6JsHNb/GRxvvUOnDwva43ZmpZyU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0A820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeLILSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeLILSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:18:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4268D20661;
        Sun,  9 Dec 2018 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544354287;
        bh=a9O3cJGuImwcQjTaf3ykLPUFEyjNdTZuF6fo7tuxgU4=;
        h=Date:From:To:Cc:Subject:From;
        b=SlL+5BYihNLl8jqV8DmQOSRn5F+877seM9YoCLwrPGuwFL7M/tXwYgC7XMASL1VbP
         MwJxZ0rG54UMFBnpLaYcJqnrxN/03C58ojb+g9FsQNZ/n5R3cmcfbPxqMknTXRJq6O
         KPA0Zo3Jfpi7hVIag+qdQeD3cBbgBQRnzS4AjwqA=
Date:   Sun, 9 Dec 2018 12:18:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.20-rc6
Message-ID: <20181209111805.GA9885@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.20-rc6

for you to fetch changes up to dbde117c31263fb632a5bfcafe4fe769663e8991:

  Merge tag 'gnss-4.20-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss into char-misc-linus (2018-12-07 14:05:28 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 4.20-rc6

Here are some small driver fixes for 4.20-rc6.

There is a hyperv fix that for some reaon took forever to get into a
shape that could be applied to the tree properly, but resolves a
much reported issue.  The others are some gnss patches, one a bugfix and
the two others updates to the MAINTAINERS file to properly match the
gnss files in the tree.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dexuan Cui (1):
      Drivers: hv: vmbus: Offload the handling of channels to two workqueues

Greg Kroah-Hartman (1):
      Merge tag 'gnss-4.20-rc6' of https://git.kernel.org/.../johan/gnss into char-misc-linus

Johan Hovold (3):
      gnss: sirf: fix activation retry handling
      MAINTAINERS: add gnss scm tree
      MAINTAINERS: exclude gnss from SIRFPRIMA2 regex matching

 MAINTAINERS               |   2 +
 drivers/gnss/sirf.c       |   6 +-
 drivers/hv/channel_mgmt.c | 189 ++++++++++++++++++++++++++++++----------------
 drivers/hv/connection.c   |  24 +++++-
 drivers/hv/hyperv_vmbus.h |   7 ++
 include/linux/hyperv.h    |   7 ++
 6 files changed, 166 insertions(+), 69 deletions(-)
