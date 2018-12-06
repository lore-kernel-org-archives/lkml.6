Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9385EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6052920878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6052920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeLFAmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:42:36 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:33193 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeLFAmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:42:32 -0500
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 78E42606DB;
        Thu,  6 Dec 2018 00:42:33 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id AA8E8D8;
        Thu,  6 Dec 2018 00:42:30 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 88FD33B;
        Thu,  6 Dec 2018 00:42:29 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 0/3] watchdog/hpwdt: Do not claim on unsupported hardware
Date:   Wed,  5 Dec 2018 17:42:20 -0700
Message-Id: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hpwdt driver isn't supported on all iLO hardware.


Changes in version 2:
1) Instead of having explicit if statement to check device IDs,
   provide a pci_device_id table of devices to blacklist.
2) Convert the current instance where SSID 0x1979 was being skipped.
3) Add new patch to add SSID 0x0289 to the blacklist table.
4) Print via dev_dbg instead of dev_info.


Jerry Hoemann (3):
  watchdog/hpwdt: Exclude via blacklist
  watchdog/hpwdt: Do not claim unsupported hardware
  watchdog/hpwdt: Update driver version.

 drivers/watchdog/hpwdt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
1.8.3.1

