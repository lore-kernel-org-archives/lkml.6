Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76157C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207E121527
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207E121527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeI0DiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:38:12 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:38437 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0DiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:38:11 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id CA5CB6E;
        Wed, 26 Sep 2018 21:23:17 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 0D9F94B;
        Wed, 26 Sep 2018 21:23:16 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     shuah@kernel.org, erosca@de.adit-jv.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [V3 PATCH 0/2] selftests: watchdog: Add get/set/pre timeout
Date:   Wed, 26 Sep 2018 15:23:07 -0600
Message-Id: <1537996989-13092-1-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add command line arguments to call ioctl WDIOC_GETTIMEOUT,
WDIOC_GETPRETIMEOUT and WDIOC_SETPRETIMEOUT.

Changes  v2
1) Update usage to include argument
2) Update usage to give example.
3) Made printf of WDIOC_GETTIMEOUT distinct from WDIOC_SETTIMEOUT
4) Made WDIOC_GETTIMEOUT a "one shot"
5) Made printf of WDIOC_GETPRETIMEOUT disnct from WDIOC_SETPRETIMEOUT
6) Made WDIOC_GETPRETIMEOUT a "one shot"

Change v3
1) Printf says errno, but prints the string version of the error.
   Make the printf consistent.
2) As above error was cut/paste from prior printf in application
   add new patch 1 to fix the existing printf first.

Jerry Hoemann (2):
  selftests: watchdog: Fix error message.
  selftests: watchdog: Add gettimeout and get|set pretimeout

 tools/testing/selftests/watchdog/watchdog-test.c | 41 +++++++++++++++++++++---
 1 file changed, 36 insertions(+), 5 deletions(-)

-- 
1.8.3.1

