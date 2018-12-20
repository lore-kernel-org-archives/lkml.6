Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09137C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC73020866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545309579;
	bh=VZ39Xru/cA0kTeB/X9fXxC2c5ZIY8C5GuuSdmT2EohY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=T/EyoewT3VNeWCnrMaAPhMocF6XG0HY7IiQUfjQFjRq6i1d/RbmT+zOvKR2om7g02
	 UIPVWin7id2usmkY24I6IOsqMih6DjAgmXwxXBedFESIPhKOK1h9pjFpe5OUbOZoPg
	 nGbFFEoXTbR+0imfTM6dhBnB2xbQiu3GdxnfRtOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbeLTMjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:39:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbeLTMjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:39:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD4F920866;
        Thu, 20 Dec 2018 12:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545309574;
        bh=VZ39Xru/cA0kTeB/X9fXxC2c5ZIY8C5GuuSdmT2EohY=;
        h=Date:From:To:Cc:Subject:From;
        b=VQOCSBGPHTfH/DMrh+NnUnTUDb/wiiKOrz0Vv0HlZf2ZOx1XbVzOnUZWoKkPj7iJf
         bw2wLvFQBhbPgi1UEjpB5t3mdix0CxrY0dgSwjXgMyipZ8ZJvTyG2gmivThMO4btD4
         vhMEr6xc7DEWfAIYMRi3wayY4YAeQTO5D/vQZeOw=
Date:   Thu, 20 Dec 2018 13:39:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.20-rc8
Message-ID: <20181220123931.GA18376@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.20-rc8

for you to fetch changes up to 55449af1a17a4f32178b42d8ba4ee9477fe9a00c:

  Merge tag 'hyperv-fixes-4.20-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux into char-misc-linus (2018-12-14 15:36:56 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 4.20-rc8

Here are 3 tiny last-minute driver fixes for 4.20-rc8 that resolve some
reported issues, and one MAINTAINERS file update.

All of them are related to the hyper-v subsystem, it seems people are
actually testing and using it now, which is nice to see :)

The fixes are:
  - uio_hv_generic: fix for opening multiple times
  - Remove PCI dependancy on hyperv drivers
  - return proper error code for an unopened channel.

And Sasha has signed up to help out with the hyperv maintainership.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dexuan Cui (1):
      Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels

Greg Kroah-Hartman (1):
      Merge tag 'hyperv-fixes-4.20-rc6' of git://git.kernel.org/.../hyperv/linux into char-misc-linus

Sasha Levin (1):
      MAINTAINERS: Patch monkey for the Hyper-V code

Sinan Kaya (1):
      x86, hyperv: remove PCI dependency

Stephen Hemminger (1):
      uio_hv_generic: set callbacks on open

 MAINTAINERS                  |  4 +++-
 drivers/hv/Kconfig           |  2 +-
 drivers/hv/vmbus_drv.c       | 20 ++++++++++++++++++++
 drivers/uio/uio_hv_generic.c |  7 +++----
 4 files changed, 27 insertions(+), 6 deletions(-)
