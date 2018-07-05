Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7BCC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D0924163
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D0924163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skyboo.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbeGEEwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 00:52:31 -0400
Received: from skyboo.net ([94.40.87.198]:46290 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751612AbeGEEwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 00:52:30 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1fawFn-0005QK-ME; Thu, 05 Jul 2018 06:52:28 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>
Date:   Thu,  5 Jul 2018 06:51:36 +0200
Message-Id: <20180705045135.20182-1-manio@skyboo.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704091033.GA25411@kroah.com>
References: <20180704091033.GA25411@kroah.com>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, zbr@ioremap.net, greg@kroah.com, manio@skyboo.net
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: [PATCH v2] w1: fix w1_ds2438 documentation
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous documentation was wrongly stating about the order
of magnitude of CONVERT_V result files contents (vad, vdd).
This commit is correcting this.

Reported-by: Adam Stolarczyk <adam@stolarczyk.net.pl>
Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
---

Resending as V2 because it was malformed by mail mail app recently.
I also added the Reported-by line and added a commit message
to describe the problem (to comply with Greg's review points).

 Documentation/w1/slaves/w1_ds2438 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/w1/slaves/w1_ds2438 b/Documentation/w1/slaves/w1_ds2438
index b99f3674c5b4..e64f65a09387 100644
--- a/Documentation/w1/slaves/w1_ds2438
+++ b/Documentation/w1/slaves/w1_ds2438
@@ -60,4 +60,4 @@ vad: general purpose A/D input (VAD)
 vdd: battery input (VDD)
 
 After the voltage conversion the value is returned as decimal ASCII.
-Note: The value is in mV, so to get a volts the value has to be divided by 10.
+Note: To get a volts the value has to be divided by 100.
-- 
2.18.0

