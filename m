Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063CFECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C397920831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C397920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeJYIpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:45:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36440 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYIpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:45:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFTIo-0006pU-4f; Thu, 25 Oct 2018 00:15:06 +0000
Date:   Thu, 25 Oct 2018 01:15:06 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] alpha syscall glue stuff
Message-ID: <20181025001506.GC32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	several old patches making alpha syscall glue a bit less mysterious.

The following changes since commit 5c60a7389d795e001c8748b458eb76e3a5b6008c:

  Merge tag 'for-linus-4.19-ofs1' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux (2018-08-16 10:53:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.alpha

for you to fetch changes up to 8a68060cefa6db0e02600ac35deed0dc2fa6a68f:

  alpha: unify the glue for sigreturn-like syscalls (2018-08-16 21:03:35 -0400)

----------------------------------------------------------------
Al Viro (2):
      alpha: use alpha_ni_syscall only for syscall zero
      alpha: unify the glue for sigreturn-like syscalls

 arch/alpha/kernel/entry.S   |  53 ++++----
 arch/alpha/kernel/systbls.S | 318 ++++++++++++++++++++++----------------------
 2 files changed, 183 insertions(+), 188 deletions(-)
