Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168AEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA73C20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547375026;
	bh=Ez69DLleDKB/eMBm5ccZpNOuyYQlravx0j477lqFiqc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EiMIU6G9xINWsX9in805eP+DVUzOiaEOqaXwhwkFhcMnpvh9wIyFW71IMer7zeNbu
	 7+YGzk6XeL90xQdZHVZh0He+rQIqXhO1ss2mX1zIObNsd2oYep0RS2WtjtH5HFSYkV
	 LQ0F+xhew09Hsd6MEX+ZHv8PSKCXSd5Pbo01zdis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfAMKXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 05:23:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfAMKXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 05:23:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E23C20657;
        Sun, 13 Jan 2019 10:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547375024;
        bh=Ez69DLleDKB/eMBm5ccZpNOuyYQlravx0j477lqFiqc=;
        h=Date:From:To:Cc:Subject:From;
        b=ba4msl04pFXZeHpcgJOqrxq7du2CulRE2mzUmN58KDG8wvri8LZKjzbZ6/8xCoHhV
         OhEI0NqiVbH3dYi2DLGWRW+HnSZrO6Spgk/8I11x8QmYBAMbKCK5WfsWAADiu6q+7k
         tTDz4FQkv5F3IRcqzwxlyglRx//ktNY7D40vp4Vs=
Date:   Sun, 13 Jan 2019 11:23:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.0-rc2
Message-ID: <20190113102342.GA27738@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.0-rc2

for you to fetch changes up to 06382deac2b8a49bbc5aaa3c9118fed6da4a1ac1:

  Revert "staging: rtl8723bs: Mark ACPI table declaration as used" (2019-01-11 10:40:13 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.0-rc2

Here are some small staging driver fixes for some reported issues.

One reverts a patch that was made to the rtl8723bs driver that turned
out to not be needed at all as it was a bug in clang.  The others fix up
some reported issues in the rtl8188eu driver and update the MAINTAINERS
file to point to Larry for this driver so he can get the bug reports
easier.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Revert "staging: rtl8723bs: Mark ACPI table declaration as used"

Larry Finger (3):
      MAINTAINERS: Add entry for staging driver r8188eu
      staging: rtl8188eu: Fix module loading from tasklet for CCMP encryption
      staging: rtl8188eu: Fix module loading from tasklet for WEP encryption

 MAINTAINERS                                   | 5 +++++
 drivers/staging/rtl8188eu/core/rtw_security.c | 6 +++---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)
