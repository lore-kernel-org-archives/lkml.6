Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C31EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6787520A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6787520A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=svenluthi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeHYAwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:52:55 -0400
Received: from svenluthi.com ([208.67.1.164]:34668 "EHLO mail.svenluthi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeHYAwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:52:55 -0400
Received: by mail.svenluthi.com (Postfix, from userid 1003)
        id 04AC8A28B9; Fri, 24 Aug 2018 16:07:28 -0500 (CDT)
Received: from localhost.localdomain (111.189.202.62.dynamic.cgnat.res.cust.swisscom.ch [62.202.189.111])
        by mail.svenluthi.com (Postfix) with ESMTPSA id 03B72A28B9;
        Fri, 24 Aug 2018 16:07:25 -0500 (CDT)
From:   Sven Luthi <dev@svenluthi.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: drivers: adl_pci9118: Fixes format of line 1283.
Date:   Fri, 24 Aug 2018 23:06:56 +0200
Message-Id: <20180824210657.16926-1-dev@svenluthi.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch repored "Lines should not end with a '('" for line 1283.

Moved opening parenthesis of function on line 1283 onto next line.

Signed-off-by: Sven Luthi <dev@svenluthi.com>
---
 drivers/staging/comedi/drivers/adl_pci9118.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/adl_pci9118.c b/drivers/staging/comedi/drivers/adl_pci9118.c
index 2528ca0ede6d..07431dc9cde9 100644
--- a/drivers/staging/comedi/drivers/adl_pci9118.c
+++ b/drivers/staging/comedi/drivers/adl_pci9118.c
@@ -1280,8 +1280,8 @@ static int pci9118_ai_cmdtest(struct comedi_device *dev,
 			} else {
 				arg = cmd->convert_arg * cmd->chanlist_len;
 			}
-			err |= comedi_check_trigger_arg_min(
-				&cmd->scan_begin_arg, arg);
+			err |= comedi_check_trigger_arg_min
+			       (&cmd->scan_begin_arg, arg);
 		}
 	}
 
-- 
2.14.1

