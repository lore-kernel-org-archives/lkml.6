Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4CC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2879C20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2879C20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeJNXZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:25:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37059 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728144AbeJNXZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:25:22 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMH-0004cA-HX; Sun, 14 Oct 2018 16:31:09 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000BE-8E; Sun, 14 Oct 2018 16:30:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jerome Brunet" <jbrunet@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.147866242@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 035/366] clk: fix mux clock documentation
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

From: Jerome Brunet <jbrunet@baylibre.com>

commit fe3f338f0cb2ed4d4f06da054c21ae2f8a36ef2d upstream.

The mux documentation mentions the non-existing parameter width instead
of mask, so just sed this.

The table field is missing in the documentation of clk_mux.
Add a small blurb explaining what it is

Fixes: 9d9f78ed9af0 ("clk: basic clock hardware types")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/clk-provider.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -356,8 +356,9 @@ struct clk *clk_register_divider_table(s
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling multiplexer
+ * @table:	array of register values corresponding to the parent index
  * @shift:	shift to multiplexer bit field
- * @width:	width of mutliplexer bit field
+ * @mask:	mask of mutliplexer bit field
  * @flags:	hardware-specific flags
  * @lock:	register lock
  *

