Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A12AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ECB21523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ECB21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=svenluthi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeHYAwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:52:55 -0400
Received: from svenluthi.com ([208.67.1.164]:34666 "EHLO mail.svenluthi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbeHYAwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:52:55 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2018 20:52:54 EDT
Received: by mail.svenluthi.com (Postfix, from userid 1003)
        id 63DCCA2EEA; Fri, 24 Aug 2018 16:07:29 -0500 (CDT)
Received: from localhost.localdomain (111.189.202.62.dynamic.cgnat.res.cust.swisscom.ch [62.202.189.111])
        by mail.svenluthi.com (Postfix) with ESMTPSA id B4369A2EEE;
        Fri, 24 Aug 2018 16:07:27 -0500 (CDT)
From:   Sven Luthi <dev@svenluthi.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: drivers: dt3000: Fixes warning on multiline dereference.
Date:   Fri, 24 Aug 2018 23:06:57 +0200
Message-Id: <20180824210657.16926-2-dev@svenluthi.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180824210657.16926-1-dev@svenluthi.com>
References: <20180824210657.16926-1-dev@svenluthi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch complains about a pointer dereference
on line 442-444 being split across multiple lines.

Merged the pointer dereference into one line and moved it
along with the other function call parameters onto the following
line so it would fit without exceeding the 80 character line limit.

Signed-off-by: Sven Luthi <dev@svenluthi.com>
---
 drivers/staging/comedi/drivers/dt3000.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/dt3000.c b/drivers/staging/comedi/drivers/dt3000.c
index 2edf3ee91300..b3b5fe707659 100644
--- a/drivers/staging/comedi/drivers/dt3000.c
+++ b/drivers/staging/comedi/drivers/dt3000.c
@@ -439,9 +439,8 @@ static int dt3k_ai_cmdtest(struct comedi_device *dev,
 
 		if (cmd->scan_begin_src == TRIG_TIMER) {
 			arg = cmd->convert_arg * cmd->scan_end_arg;
-			err |= comedi_check_trigger_arg_min(&cmd->
-							    scan_begin_arg,
-							    arg);
+			err |= comedi_check_trigger_arg_min
+			       (&cmd->scan_begin_arg, arg);
 		}
 	}
 
-- 
2.14.1

