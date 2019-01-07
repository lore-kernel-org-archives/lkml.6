Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB15C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C23020665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865017;
	bh=F+RI8U4jZ9mGiFJCL9O8kaKdn3dL7xP2+E8/X4vCFPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZvtA07sPydyfh/6MKk4X/nwbB1eDLhsTDWFbaCtewKQknjl72Z5RqHQak5JjQuJ74
	 p1MeNofQLDodl3/im+5Ctr+tLiH567ZTY0UTbnrXtt/gpuCNwvPGP/bfmuDR3+kcZi
	 Gs814ZX3gt59SCP1QdeReQG6bDXWniHKHAdsNilc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfAGMng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfAGMne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241672147C;
        Mon,  7 Jan 2019 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865013;
        bh=F+RI8U4jZ9mGiFJCL9O8kaKdn3dL7xP2+E8/X4vCFPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3rVcrSSiNGElpUIBKzF9K5SfVfHSUXC+ewQptcNblKZKxsonwmU0TWB9qnBF2rDH
         M/0WXw70bBIDoKU6WJZG852GtFCiKmRtFo2ifqsxvEJgSU6U0bcbMC4c/gc4+VTHBa
         Pxpa9XVi+6KS8+fJvI6vVgdqLaBJM0VcpeR0wSiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 118/145] media: v4l2-fwnode: Fix setting V4L2_MBUS_DATA_ACTIVE_HIGH/LOW flag
Date:   Mon,  7 Jan 2019 13:32:35 +0100
Message-Id: <20190107104452.667507156@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Jirman <megous@megous.com>

commit fa09d06522ceac428fdc5c2b57c572f6cfd0a8bb upstream.

When parallel bus is used and data-active is being parsed, incorrect
flags are cleared.

Clear the correct flag bits.

Fixes: e9be1b863e2c2948deb003df8edd9635b4611a8a (media: v4l: fwnode:
Use default parallel flags).

Cc: stable@vger.kernel.org # for Kernel 4.20
Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-fwnode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -310,8 +310,8 @@ v4l2_fwnode_endpoint_parse_parallel_bus(
 	}
 
 	if (!fwnode_property_read_u32(fwnode, "data-active", &v)) {
-		flags &= ~(V4L2_MBUS_PCLK_SAMPLE_RISING |
-			   V4L2_MBUS_PCLK_SAMPLE_FALLING);
+		flags &= ~(V4L2_MBUS_DATA_ACTIVE_HIGH |
+			   V4L2_MBUS_DATA_ACTIVE_LOW);
 		flags |= v ? V4L2_MBUS_DATA_ACTIVE_HIGH :
 			V4L2_MBUS_DATA_ACTIVE_LOW;
 		pr_debug("data-active %s\n", v ? "high" : "low");


