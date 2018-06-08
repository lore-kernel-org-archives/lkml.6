Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NuDRL60UGlv/bAAAmS7hNA
	; Fri, 08 Jun 2018 05:33:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 486D8607E4; Fri,  8 Jun 2018 05:33:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D529D601C3;
	Fri,  8 Jun 2018 05:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D529D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeFHFdb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:33:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35902 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeFHFda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:33:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRA1h-0005wB-DX; Fri, 08 Jun 2018 05:33:29 +0000
Date: Fri, 8 Jun 2018 06:33:29 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git fix proc_fill_cache() regression
Message-ID: <20180608053329.GA30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Regression fix for proc_fill_cache() braino introduced when
switching instantiate() callback to d_splice_alias().

[with apologies for being MIA for several days - flu started on Sunday and
got really nasty on Tuesday; back to normal now, hopefully]

The following changes since commit 888e2b03ef56694290e58bd9ac23f8033bf6369f:

  switch the rest of procfs lookups to d_splice_alias() (2018-05-26 14:20:50 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.lookup

for you to fetch changes up to d85b399b64e85a311c09205c675d4ae1c5af6246:

  fix proc_fill_cache() in case of d_alloc_parallel() failure (2018-06-08 01:17:11 -0400)

----------------------------------------------------------------
Al Viro (1):
      fix proc_fill_cache() in case of d_alloc_parallel() failure

 fs/proc/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
