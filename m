Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7756C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A3821580
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3821580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbeHBXRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:17:14 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:30765 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeHBXRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:17:14 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 59CC1198D;
        Thu,  2 Aug 2018 21:24:18 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id B90DC84;
        Thu,  2 Aug 2018 21:24:17 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 13E4136;
        Thu,  2 Aug 2018 21:24:16 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 0/4] watchdog: hpwdt: Bug Fixes/Enhancement
Date:   Thu,  2 Aug 2018 15:15:37 -0600
Message-Id: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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


0004: Update version number.

Bump version number to reflect changes.




Jerry Hoemann (4):
  watchdog: hpwdt: Initialize pretimeout from module parameter.
  watchdog: hpwdt: Claim NMI from iLO
  watchdog: hpwdt: Display module parameters.
  watchdog: hpwdt: Update version number.

 drivers/watchdog/hpwdt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
1.8.3.1

