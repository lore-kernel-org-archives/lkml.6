Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27E3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C8520658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C8520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeICWAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:00:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbeICWAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:00:45 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D866BC4;
        Mon,  3 Sep 2018 17:39:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 117/123] PM / clk: signedness bug in of_pm_clk_add_clks()
Date:   Mon,  3 Sep 2018 18:57:41 +0200
Message-Id: <20180903165724.442947507@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 5e2e2f9f76e157063a656351728703cb02b068f1 upstream.

"count" needs to be signed for the error handling to work.  I made "i"
signed as well so they match.

Fixes: 02113ba93ea4 (PM / clk: Add support for obtaining clocks from device-tree)
Cc: 4.6+ <stable@vger.kernel.org> # 4.6+
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/power/clock_ops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -185,7 +185,7 @@ EXPORT_SYMBOL_GPL(of_pm_clk_add_clk);
 int of_pm_clk_add_clks(struct device *dev)
 {
 	struct clk **clks;
-	unsigned int i, count;
+	int i, count;
 	int ret;
 
 	if (!dev || !dev->of_node)


