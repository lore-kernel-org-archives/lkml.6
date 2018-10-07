Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E89CC65C31
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE8F2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE8F2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJGNNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 09:13:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJGNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 09:13:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4F314D10;
        Sun,  7 Oct 2018 06:06:55 +0000 (UTC)
Date:   Sun, 7 Oct 2018 08:06:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.19-rc7
Message-ID: <20181007060652.GA13828@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.19-rc7

for you to fetch changes up to 5b162cc4ac27ba76e576abc9090c54cf90a17980:

  Revert "serial: sh-sci: Allow for compressed SCIF address" (2018-10-02 14:38:16 -0700)

----------------------------------------------------------------
Serial driver fixes for 4.19-rc7

Here are 3 small serial driver fixes for 4.19-rc7
  - 2 sh-sci bugfixes for reported issues
  - a revert of the PM handling for the 8250_dw code

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Geert Uytterhoeven (2):
      Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
      Revert "serial: sh-sci: Allow for compressed SCIF address"

Guenter Roeck (1):
      Revert "serial: 8250_dw: Fix runtime PM handling"

 drivers/tty/serial/8250/8250_dw.c |  4 ---
 drivers/tty/serial/sh-sci.c       | 56 ++++++++++++++++++++++++++++-----------
 include/linux/serial_sci.h        |  1 +
 3 files changed, 42 insertions(+), 19 deletions(-)
