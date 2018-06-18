Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C200C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20534208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20534208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968158AbeFRIrH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:47:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030332AbeFRIhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:37:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 617DBC49;
        Mon, 18 Jun 2018 08:37:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 170/189] i2c: pmcmsp: fix error return from master_xfer
Date:   Mon, 18 Jun 2018 10:14:26 +0200
Message-Id: <20180618081216.057083821@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 12d9bbc5a7f347eaa65ff2a9d34995cadc05eb1b ]

Returning -1 (-EPERM) is not appropriate here, go with -EIO.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Fixes: 1b144df1d7d6 ("i2c: New PMC MSP71xx TWI bus driver")
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-pmcmsp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -564,7 +564,7 @@ static int pmcmsptwi_master_xfer(struct
 		 * TODO: We could potentially loop and retry in the case
 		 * of MSP_TWI_XFER_TIMEOUT.
 		 */
-		return -1;
+		return -EIO;
 	}
 
 	return num;


