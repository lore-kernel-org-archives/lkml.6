Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E731C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536AF20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536AF20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeICVOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:14:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38164 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeICVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:14:32 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCB7ECF5;
        Mon,  3 Sep 2018 16:53:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 17/80] tools/power turbostat: fix -S on UP systems
Date:   Mon,  3 Sep 2018 18:48:55 +0200
Message-Id: <20180903164934.851569556@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Len Brown <len.brown@intel.com>

[ Upstream commit 9d83601a9cc1884d1b5706ee2acc661d558c6838 ]

The -S (system summary) option failed to print any data on a 1-processor system.

Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/power/x86/turbostat/turbostat.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -663,9 +663,7 @@ void format_all_counters(struct thread_d
 	if (!printed || !summary_only)
 		print_header();
 
-	if (topo.num_cpus > 1)
-		format_counters(&average.threads, &average.cores,
-			&average.packages);
+	format_counters(&average.threads, &average.cores, &average.packages);
 
 	printed = 1;
 


