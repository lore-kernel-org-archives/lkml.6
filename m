Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AE2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446CD20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446CD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbeGWV3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:29:48 -0400
Received: from sauhun.de ([88.99.104.3]:51228 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388039AbeGWV3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:29:47 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id 15639631A49;
        Mon, 23 Jul 2018 22:26:52 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 00/12] i2c: quirks: add zero length checks and update drivers
Date:   Mon, 23 Jul 2018 22:26:04 +0200
Message-Id: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had this idea for quite some time on my todo list but a soon to be
implemented refactoring in the i2c-rcar driver now finally made me do it. Add a
'can't do 0 length messages' quirk to the quirk infrastructure for and remove
the manual handling from the drivers. This makes the quirk much more visible.
(Quite some prominent vendors in that list) We also have a centralized place to
handle updates to the quirk detection if that is ever needed.

I have tested this with the i2c-rcar and i2c-sh_mobile driver on a Renesas
SalvatorXS board equipped with M3-N (r8a77965).

A git branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirk-no-zero-len

Looking forward to comments, reviews, tests...

Thanks,

   Wolfram

Wolfram Sang (12):
  i2c: quirks: add zero length checks
  i2c: designware-master: use core to detect 'no zero length' quirk
  i2c: mxs: use core to detect 'no zero length' quirk
  i2c: omap: use core to detect 'no zero length' quirk
  i2c: pmcmsp: use core to detect 'no zero length' quirk
  i2c: qup: use core to detect 'no zero length' quirk
  i2c: stu300: use core to detect 'no zero length' quirk
  i2c: tegra: use core to detect 'no zero length' quirk
  i2c: zx2967: use core to detect 'no zero length' quirk
  i2c: rcar: use core to detect 'no zero length' quirk
  i2c: xlr: use core to detect 'no zero length' quirk
  i2c: sh_mobile: use core to detect 'no zero length read' quirk

 drivers/i2c/busses/i2c-designware-master.c | 12 +++++-------
 drivers/i2c/busses/i2c-mxs.c               |  8 +++++---
 drivers/i2c/busses/i2c-omap.c              |  8 +++++---
 drivers/i2c/busses/i2c-pmcmsp.c            | 17 +----------------
 drivers/i2c/busses/i2c-qup.c               | 14 ++++++--------
 drivers/i2c/busses/i2c-rcar.c              | 13 ++++++-------
 drivers/i2c/busses/i2c-sh_mobile.c         | 10 +++++-----
 drivers/i2c/busses/i2c-stu300.c            | 12 ++++++------
 drivers/i2c/busses/i2c-tegra.c             |  4 +---
 drivers/i2c/busses/i2c-xlr.c               | 11 +++++------
 drivers/i2c/busses/i2c-zx2967.c            |  8 +++++---
 drivers/i2c/i2c-core-base.c                |  6 ++++++
 include/linux/i2c.h                        |  4 ++++
 13 files changed, 60 insertions(+), 67 deletions(-)

-- 
2.11.0

