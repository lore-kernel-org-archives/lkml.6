Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186C9C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE372178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE372178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeHHVm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:42:57 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:29765 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHVm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:42:56 -0400
X-Greylist: delayed 159153 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2018 17:42:56 EDT
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 14A3E54;
        Wed,  8 Aug 2018 19:21:51 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id B1FF848;
        Wed,  8 Aug 2018 19:21:50 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 0/5] watchdog: hpwdt: Bug Fixes/Enhancement
Date:   Wed,  8 Aug 2018 13:13:22 -0600
Message-Id: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes for v2

1) Patch 0001: Simplify initialization of pretimeout removing #ifdef.
2) Patch 0002: Loosen check on mynmi to accommodate potential FW issue.
3) Patch 0003: Split dev_info into mulitple calls as output was getting long.
4) Patch 0004: New: Add alias to module parameter soft_margin.


-----------------------------

Two defect fixes and one enhancement.  

0001: Initialize pretimeout from module parameter.

Bug Fix.

Pretimeout was getting programmed correctly in the hardware,
but this issue caused it to not be displayed correctly
in sysfs.



0002: Claim NMI from iLO

Bug Fix.

Default configuration worked, but if user were to disable the
pretimeout for the watchdog, then an explicit request to NMI
the system from the iLO virutal button would fail.


0003: Display module parameters

Enhancement.

Display all the module parameters when loading the driver.
Makes it easier to diagnose problems.


Jerry


Jerry Hoemann (5):
  watchdog: hpwdt: Initialize pretimeout from module parameter.
  watchdog: hpwdt: Claim NMI from iLO
  watchdog: hpwdt: Display module parameters.
  watchdog: hpwdt: Module paramerter alias.
  watchdog: hpwdt: Update version number.

 drivers/watchdog/hpwdt.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
1.8.3.1

