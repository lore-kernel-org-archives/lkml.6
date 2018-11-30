Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A09C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC6C20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKNS8NyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC6C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeLADQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:16:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbeLADQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:16:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395DA20868;
        Fri, 30 Nov 2018 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543593985;
        bh=0ArGgN9LSVOUQ8bXOLE1P6hYA7wpynVjr4Jw5u5te/4=;
        h=Date:From:To:Cc:Subject:From;
        b=VKNS8NyVc0nYU87luwARIraJaIgF9gpzozd8gWUYXUr3mdA3UfQJ4OdNjDu3F0ebu
         Cu4pKS5dDBwKz6qDIcFi2PM/JQzgo84kFEneXp1mp9bjUge1kOiyrNNpB3ZIM45RAs
         PCrlKMWbdYwf1lP7PQVQqCvXcwhUeyQCh3oJayUo=
Date:   Fri, 30 Nov 2018 17:06:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.20-rc5
Message-ID: <20181130160623.GA3143@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.20-rc5

for you to fetch changes up to 6484a677294aa5d08c0210f2f387ebb9be646115:

  misc: mic/scif: fix copy-paste error in scif_create_remote_lookup (2018-11-27 09:00:38 +0100)

----------------------------------------------------------------
Char/Misc fixes for 4.20-rc5

Here are a few small char/misc driver fixes for 4.20-rc5 that resolve a
number of reported issues.

The "largest" here is the thunderbolt patch, which resolves an issue
with NVM upgrade, the smallest being some fsi driver fixes.  There's
also a hyperv bugfix, and the usual binder bugfixes.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      fsi: master-ast-cf: select GENERIC_ALLOCATOR

Brajeswar Ghosh (1):
      fsi: fsi-scom.c: Remove duplicate header

Dexuan Cui (1):
      Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpadl()

Greg Kroah-Hartman (1):
      Merge tag 'fsi-updates-2018-11-26' of git://git.kernel.org/.../benh/linux-fsi char-misc-linus

Mika Westerberg (1):
      thunderbolt: Prevent root port runtime suspend during NVM upgrade

Todd Kjos (1):
      binder: fix race that allows malicious free of live buffer

YueHaibing (1):
      misc: mic/scif: fix copy-paste error in scif_create_remote_lookup

 drivers/android/binder.c         | 21 ++++++++++++---------
 drivers/android/binder_alloc.c   | 16 ++++++----------
 drivers/android/binder_alloc.h   |  3 +--
 drivers/fsi/Kconfig              |  1 +
 drivers/fsi/fsi-scom.c           |  1 -
 drivers/hv/channel.c             |  8 ++++++++
 drivers/misc/mic/scif/scif_rma.c |  2 +-
 drivers/thunderbolt/switch.c     | 40 ++++++++++++++++++++++++++++++++++++++--
 8 files changed, 67 insertions(+), 25 deletions(-)
