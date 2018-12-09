Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A740DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55920831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544354261;
	bh=xX2k+9OwIfpm9WpD1CiQxk2oa3LBRdYMNlChMOlgwQs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KlvBp/dEsoSLe/FL9dS7B3gFmuFBn9lqLvW0VathOpD1pqM0Cf9l4VtNOOGCJubgN
	 YG+75NZeUTg7fo2336ENiQMzLh5+jAcnP38rokM76/IfMZfw458VILHtv51Sm5ODL5
	 j1RoHJqUjhYjJm3L07t+UHnfSlUtlR1hchp/hqmI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D55920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeLILRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeLILRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:17:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C04520661;
        Sun,  9 Dec 2018 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544354259;
        bh=xX2k+9OwIfpm9WpD1CiQxk2oa3LBRdYMNlChMOlgwQs=;
        h=Date:From:To:Cc:Subject:From;
        b=YSs4lNvPtzCKeqzXXzEaBtEAtyjoQAUQi/vU66kfRJnBd6Gn2TW5uPcbelhtKzzKv
         VfA2Z3dD82OSBgR1FIZ3yh22LKbdH6eGoiLKQPPZrDhR9Ef9qLapUkOOIzE7P4bQ+X
         mudROdtbx76xmTk5NY1oQKHggYXytn6/GkF96FZU=
Date:   Sun, 9 Dec 2018 12:17:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO driver fixes for 4.20-rc6
Message-ID: <20181209111737.GA9811@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.20-rc6

for you to fetch changes up to 87e4a5405f087427fbf8b437d2796283dce2b38f:

  Revert commit ef9209b642f "staging: rtl8723bs: Fix indenting errors and an off-by-one mistake in core/rtw_mlme_ext.c" (2018-12-05 09:56:09 +0100)

----------------------------------------------------------------
Staging fixes for 4.20-rc6

Here are two staging driver bugfixes for 4.20-rc6.

One is a revert of a previously incorrect patch that was merged a while
ago, and the other resolves a possible buffer overrun that was found by
code inspection.

Both of these have been in the linux-next tree with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Young Xiao (2):
      staging: rtl8712: Fix possible buffer overrun
      Revert commit ef9209b642f "staging: rtl8723bs: Fix indenting errors and an off-by-one mistake in core/rtw_mlme_ext.c"

 drivers/staging/rtl8712/mlme_linux.c          | 2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c        | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
