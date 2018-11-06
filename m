Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9ACC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495232084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495232084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeKFNIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:08:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39102 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeKFNIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:08:50 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 051A914920CDF;
        Mon,  5 Nov 2018 19:45:42 -0800 (PST)
Date:   Mon, 05 Nov 2018 19:45:42 -0800 (PST)
Message-Id: <20181105.194542.476367332910923203.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181105203447.GA25674@krava>
References: <20181104201821.GA22049@krava>
        <20181104.165039.878682622135788379.davem@davemloft.net>
        <20181105203447.GA25674@krava>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 19:45:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Mon, 5 Nov 2018 21:34:47 +0100

> I pushed it in perf/fixes branch in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git

Build fix for sparc below, I'm playing with this now.

perf: Use PRIu64 for printing top lost events count.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index db3413e..2c8eac8 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -46,7 +46,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 							samples_per_sec;
 		ret = SNPRINTF(bf, size,
 			       "   PerfTop:%8.0f irqs/sec  kernel:%4.1f%%"
-			       "  exact: %4.1f%% lost: %lu [", samples_per_sec,
+			       "  exact: %4.1f%% lost: %" PRIu64 " [", samples_per_sec,
 			       ksamples_percent, esamples_percent, top->lost);
 	} else {
 		float us_samples_per_sec = top->us_samples / top->delay_secs;
