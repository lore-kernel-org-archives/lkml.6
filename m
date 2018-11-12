Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11653C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4B920896
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4B920896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbeKMIAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:00:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58581 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbeKMIAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:00:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D88A220756; Mon, 12 Nov 2018 23:04:54 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 83C0920379;
        Mon, 12 Nov 2018 23:04:54 +0100 (CET)
Date:   Mon, 12 Nov 2018 23:04:54 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC fixes for 4.20
Message-ID: <20181112220454.GA6189@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are three fixes worth taking for 4.20.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.20-2

for you to fetch changes up to 9bde0afb7a906f1dabdba37162551565740b862d:

  rtc: pcf2127: fix a kmemleak caused in pcf2127_i2c_gather_write (2018-11-07 17:13:56 +0100)

----------------------------------------------------------------
RTC fixes for 4.20

Drivers:
 - cmos: stop exporting alarms when not supported
 - hctosys: correctly report range error
 - pcf2127: fix a memory leak

----------------------------------------------------------------
Hans de Goede (1):
      rtc: cmos: Do not export alarm rtc_ops when we do not support alarms

Maciej W. Rozycki (1):
      rtc: hctosys: Add missing range error reporting

Xulin Sun (1):
      rtc: pcf2127: fix a kmemleak caused in pcf2127_i2c_gather_write

 drivers/rtc/hctosys.c     |  4 +++-
 drivers/rtc/rtc-cmos.c    | 16 ++++++++++++----
 drivers/rtc/rtc-pcf2127.c |  3 +++
 3 files changed, 18 insertions(+), 5 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
