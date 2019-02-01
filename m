Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC52CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC462184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549010468;
	bh=KFjME4w0Cw/dCj63Zy4Xj5zLM5thMat8d36t4esk99Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kXCxRjGkArTrn4SJxZ6xRCnAOrgd9pEfRhHoiF4g/if7gojTJmTZLL1NZbt7AnLLm
	 PpnbU/njDKe8IWuJ4Hqou7wtW9nKsz/QM6BbpmHiCieK5oRIltmpIjKhUvhT847R01
	 b3qtPw2uj8TSLqaMHEL8yHsWVAQL8DgLmH43foj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfBAIlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbfBAIlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:41:06 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9813020869;
        Fri,  1 Feb 2019 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549010465;
        bh=KFjME4w0Cw/dCj63Zy4Xj5zLM5thMat8d36t4esk99Y=;
        h=Date:From:To:Cc:Subject:From;
        b=uN/kgoHeKfKk21L657FbH5iyXCc2nEtydm6WR+coAT2P3Ck4GIC2Akdbc8qClr732
         pkSlzV89K/KjlqcdHh4rrlYm6pWzlpMKiuvz8/NBvL3cXGT3SgqhJUdjVSH/Syt57f
         iC63snak997SK6+REzhxl2vsXFFwBbOMvwVoxXLs=
Date:   Fri, 1 Feb 2019 09:40:58 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-i3c <linux-i3c@lists.infradead.org>
Subject: [GIT PULL] i3c: Fixes for 5.0-rc5
Message-ID: <20190201094058.74f3cb6a@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C fixes PR for 5.0-rc5.

Regards,

Boris

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/fixes-for-5.0-rc5

for you to fetch changes up to f36c1f9a8dfd6a78e6c3fe7aff5e722b84307597:

  i3c: master: dw: fix deadlock (2019-01-26 11:14:25 +0100)

----------------------------------------------------------------
- Fix a deadlock in the designware driver
- Fix the error path in i3c_master_add_i3c_dev_locked()

----------------------------------------------------------------
Jisheng Zhang (2):
      i3c: fix missing detach if failed to retrieve i3c dev
      i3c: master: dw: fix deadlock

 drivers/i3c/master.c               |  2 +-
 drivers/i3c/master/dw-i3c-master.c | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)
