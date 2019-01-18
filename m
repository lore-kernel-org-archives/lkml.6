Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBDCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A59208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547816268;
	bh=/PHdplVUqH8gRGxUccG820izvR+E/zeqIzOESWDnPF4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Cp4WDBki7jwGd+kgsn7SX9Y8C48Xra7HEE9MICLYDTmmRZ5V7TDZPn36v8iOgJHrm
	 xGZJLnfiwYUFAX0vzmMpaxr6hSD1mqX1Mp/8ELMT8SIyRwGCBnk3HOKpqPpwWE7kkk
	 DJgA/QbcgfxmblGm6OktpvuzGKrnTzeIprtsUnQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfARM5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:57:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfARM5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:57:46 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D9820823;
        Fri, 18 Jan 2019 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547816265;
        bh=/PHdplVUqH8gRGxUccG820izvR+E/zeqIzOESWDnPF4=;
        h=Date:From:To:Cc:Subject:From;
        b=Mwp+BdrRQNqpY2JWaoZ41DWVlW9XMZol+5BzhxJiC/DPMO4C2xGKHkiEDcbruQ2J9
         sUVMlHzt0Bej/9ekwqvh21DJ7rOfP9f0HfXmVdgMYS6e0s72nM+S+/Rgwd0VIYQelN
         FRBsGYoJc0xKFL7iNJLm5vP2eULPsbtzcGMngqQM=
Date:   Fri, 18 Jan 2019 13:57:37 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] i3c: Fixes for 5.0-rc3
Message-ID: <20190118135716.5cb2cc64@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C fixes PR for 5.0-rc3.

Regards,

Boris

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/fixes-for-5.0-rc3

for you to fetch changes up to f29fd331aa055fbeb5a496b4af937b7952111b6b:

  i3c: master: dw-i3c-master: fix i3c_attach/reattach (2019-01-15 11:15:11 +0100)

----------------------------------------------------------------
- Fix the error check on master->sysclk val in the Cadence driver
- Fix reattach implementation in the Designware driver

----------------------------------------------------------------
Christophe JAILLET (1):
      i3c: master: Fix an error checking typo in 'cdns_i3c_master_probe()'

Vitor Soares (1):
      i3c: master: dw-i3c-master: fix i3c_attach/reattach

 drivers/i3c/master/dw-i3c-master.c   | 7 ++-----
 drivers/i3c/master/i3c-master-cdns.c | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)
