Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA5C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A264B2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A264B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbeJNXej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:34:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36110 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727864AbeJNXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:57 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cH-02; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000hR-KL; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Peter Rosin" <peda@axentia.se>,
        "Wolfram Sang" <wsa@the-dreams.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.875984091@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 319/366] i2c: pmcmsp: fix error return from master_xfer
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>

commit 12d9bbc5a7f347eaa65ff2a9d34995cadc05eb1b upstream.

Returning -1 (-EPERM) is not appropriate here, go with -EIO.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Fixes: 1b144df1d7d6 ("i2c: New PMC MSP71xx TWI bus driver")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -596,7 +596,7 @@ static int pmcmsptwi_master_xfer(struct
 		 * TODO: We could potentially loop and retry in the case
 		 * of MSP_TWI_XFER_TIMEOUT.
 		 */
-		return -1;
+		return -EIO;
 	}
 
 	return num;

