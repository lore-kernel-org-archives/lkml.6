Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30C5ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7112520831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7112520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJYIkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:40:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36394 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:40:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFTEG-0006kE-R7; Thu, 25 Oct 2018 00:10:24 +0000
Date:   Thu, 25 Oct 2018 01:10:24 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] compat_ioctl fixes
Message-ID: <20181025001024.GB32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	A bunch of compat_ioctl fixes, mostly in bluetooth.
Hopefully, most of fs/compat_ioctl.c will get killed off
over the next few cycles; between this, tty series already
merged and Arnd's work this cycle ought to take a good chunk
out of the damn thing...

One trivial conflict in fs/compat_ioctl.c (lines removed right
next to those taken out by tty_ioctl series).

The following changes since commit 10f3e23f07cb0c20f9bcb77a5b5a7eb2a1b2a2fe:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2018-08-13 22:34:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.compat

for you to fetch changes up to 702ec3072ae61cdf018725b353ff043e196548a6:

  hidp: fix compat_ioctl (2018-09-10 12:41:07 -0400)

----------------------------------------------------------------
Al Viro (5):
      compat_ioctl: trim the pointless includes
      bnep: fix compat_ioctl
      cmtp: fix compat_ioctl
      hidp: constify hidp_connection_add()
      hidp: fix compat_ioctl

 fs/compat_ioctl.c         | 70 +----------------------------------------
 net/bluetooth/bnep/sock.c | 19 +++++++-----
 net/bluetooth/cmtp/sock.c | 19 +++++++-----
 net/bluetooth/hidp/core.c | 10 +++---
 net/bluetooth/hidp/hidp.h |  2 +-
 net/bluetooth/hidp/sock.c | 79 ++++++++++++++++++++++++++++++-----------------
 6 files changed, 81 insertions(+), 118 deletions(-)
