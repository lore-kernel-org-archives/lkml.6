Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85851C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A192088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A192088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeJGNOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 09:14:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJGNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 09:14:09 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E16ED08;
        Sun,  7 Oct 2018 06:07:58 +0000 (UTC)
Date:   Sun, 7 Oct 2018 08:07:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.19-rc7 - take 2
Message-ID: <20181007060755.GA13996@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.19-rc7

for you to fetch changes up to eafa717bc145963c944bb0a64d16add683861b35:

  thunderbolt: Initialize after IOMMUs (2018-10-02 10:51:16 -0700)

----------------------------------------------------------------
Char/Misc fixes for 4.19-rc7

Here are 8 small fixes for some char/misc driver issues

Included here are:
	- fpga driver fixes
	- thunderbolt bugfixes
	- firmware core revert/fix
	- hv core fix
	- hv tool fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Tull (3):
      fpga: do not access region struct after fpga_region_unregister
      fpga: bridge: fix obvious function documentation error
      docs: fpga: document fpga manager flags

Bjorn Andersson (1):
      firmware: Always initialize the fw_priv list object

Dexuan Cui (1):
      Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()

Mika Westerberg (2):
      thunderbolt: Do not handle ICM events after domain is stopped
      thunderbolt: Initialize after IOMMUs

Vitaly Kuznetsov (1):
      tools: hv: fcopy: set 'error' in case an unknown operation was requested

 Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++
 drivers/base/firmware_loader/main.c        |  7 +++--
 drivers/fpga/dfl-fme-region.c              |  4 ++-
 drivers/fpga/fpga-bridge.c                 |  2 +-
 drivers/fpga/of-fpga-region.c              |  3 +-
 drivers/hv/connection.c                    |  8 +++--
 drivers/thunderbolt/icm.c                  | 49 ++++++++++++------------------
 drivers/thunderbolt/nhi.c                  |  2 +-
 include/linux/fpga/fpga-mgr.h              | 20 ++++++++----
 tools/hv/hv_fcopy_daemon.c                 |  1 +
 10 files changed, 57 insertions(+), 44 deletions(-)
