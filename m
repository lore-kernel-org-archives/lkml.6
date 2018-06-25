Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172FBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AFE208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ujuLvrpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AFE208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935003AbeFYPOT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:14:19 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37471 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934868AbeFYPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:13:06 -0400
Received: by mail-qt0-f195.google.com with SMTP id a18-v6so12243158qtj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oGWHcF+I1FAb0T0RllTc5crNDw5hGehwQIUcOHp09k0=;
        b=ujuLvrpn9ebOxrjRdqiM+INsd8aJOEn/mvet/IPajucCdnrYlfIsYDV9OG1265eNri
         /byfJUi10fq2pYA6xDQenDfUEW4HyLXtSqk0iRQSBbIR1BP2ppmMYXaNl5geO/9aSHB0
         JZybvJ5P0+Eu9LEpU2uR2nED4e+96rMK6wcNDpWVYoyxYEuRDTuzR87DDwEObwO1Vno+
         tuv4CrZsTI8LmubWli3HS819fI79wuDqjhv3jo66kPLp8Dpkggx4W8OwRSU+hqXXLff+
         06AwO7rwumanWMBFwUEE0HF5U61J0YR8MDxp11w30sBJWP/R3go+Jut78tkZypaVTOCO
         DtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oGWHcF+I1FAb0T0RllTc5crNDw5hGehwQIUcOHp09k0=;
        b=S+/qCxLAw7B73x3m4i03Ndx6R/PGbzRZfM8r1bkz4ZoUDfr64CyNSzuWzvVHyfS7hp
         yeEX9jknOM3XnqBhyOqIYdjBhQwUkrN0fW5GO82sMyXE8hctiVzvySm4KowG5ubsYh2R
         miUMnBt5ndeQXe1Gqck8V3VdOAHQ181/A4vKfaQDUCAjqgqhVLqCeQPNnmlCcVhOEJbi
         KbPMdHqWAPGOayQAZ7r/CvBXJBwfgI1ML8evExDUFC/Pmb7uOeiX8z0Mj2Iw4lfPypg6
         Ab3mscMZatD6lD9x5wliU3XeWaUQ+KAfbnfD6bRIJ4QNdVCLVDrzm4dS5sPhtsd1ctNK
         LsKg==
X-Gm-Message-State: APt69E3d0WHDA8AIcnbESotZnLTVjehLr12Q6jQzkrUf4mE1f0wcFeUW
        3A9VS86pBo9/KefOE0aYHmJJ6A==
X-Google-Smtp-Source: AAOMgpcrsTjq904z7XzZ07cIkkorVYYx7ju/v5HPGooWPlF/Z/jIYDnsx6+d4H5/+QmKJm3Mo9cnAw==
X-Received: by 2002:a0c:f989:: with SMTP id t9-v6mr11213894qvn.96.1529939585217;
        Mon, 25 Jun 2018 08:13:05 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g188-v6sm10537703qkc.37.2018.06.25.08.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:13:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 13/15] Documentation: add a doc for blk-iolatency
Date:   Mon, 25 Jun 2018 11:12:41 -0400
Message-Id: <20180625151243.2132-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

A basic documentation to describe the interface, statistics, and
behavior of io.latency.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 Documentation/cgroup-v2.txt | 79 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index 74cdeaed9f7a..f6684ec99720 100644
--- a/Documentation/cgroup-v2.txt
+++ b/Documentation/cgroup-v2.txt
@@ -51,6 +51,9 @@ v1 is available under Documentation/cgroup-v1/.
      5-3. IO
        5-3-1. IO Interface Files
        5-3-2. Writeback
+       5-3-3. IO Latency
+         5-3-3-1. How IO Latency Throttling Works
+         5-3-3-2. IO Latency Interface Files
      5-4. PID
        5-4-1. PID Interface Files
      5-5. Device
@@ -1395,6 +1398,82 @@ writeback as follows.
 	vm.dirty[_background]_ratio.
 
 
+IO Latency
+~~~~~~~~~~
+
+This is a cgroup v2 controller for IO workload protection.  You provide a group
+with a latency target, and if the average latency exceeds that target the
+controller will throttle any peers that have a lower latency target than the
+protected workload.
+
+The limits are only applied at the peer level in the hierarchy.  This means that
+in the diagram below, only groups A, B, and C will influence each other, and
+groups D and F will influence each other.  Group G will influence nobody.
+
+			[root]
+		/	   |		\
+		A	   B		C
+	       /  \        |
+	      D    F	   G
+
+
+So the ideal way to configure this is to set io.latency in groups A, B, and C.
+Generally you do not want to set a value lower than the latency your device
+supports.  Experiment to find the value that works best for your workload, start
+at higher than the expected latency for your device and watch the total_lat_avg
+value in io.stat for your workload group to get an idea of the latency you see
+during normal operation.  Use this value as a basis for your real setting,
+setting at 10-15% higher than the value in io.stat.  Experimentation is key here
+because total_lat_avg is a running total, so is the "statistics" portion of
+"lies, damned lies, and statistics."
+
+How IO Latency Throttling Works
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+io.latency is work conserving, so as long as everybody is meeting their latency
+target the controller doesn't do anything.  Once a group starts missing it's
+target it begins throttling any peer group that has a higher target than itself.
+This throttling takes 2 forms:
+
+- Queue depth throttling.  This is the number of outstanding IO's a group is
+  allowed to have.  We will clamp down relatively quickly, starting at no limit
+  and going all the way down to 1 IO at a time.
+
+- Artificial delay induction.  There are certain types of IO that cannot be
+  throttled without possibly adversely affecting higher priority groups.  This
+  includes swapping and metadata IO.  These types of IO are allowed to occur
+  normally, however they are "charged" to the originating group.  If the
+  originating group is being throttled you will see the use_delay and delay
+  fields in io.stat increase.  The delay value is how many microseconds that are
+  being added to any process that runs in this group.  Because this number can
+  grow quite large if there is a lot of swapping or metadata IO occurring we
+  limit the individual delay events to 1 second at a time.
+
+Once the victimized group starts meeting it's latency target again it will start
+unthrottling any peer groups that were throttled previously.  If the victimized
+group simply stops doing IO the global counter will unthrottle appropriately.
+
+IO Latency Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+  io.latency
+	This takes a similar format as the other controllers.
+
+		"MAJOR:MINOR target=<target time in microseconds"
+
+  io.stat
+	If the controller is enabled you will see extra stats in io.stat in
+	addition to the normal ones.
+
+	  depth
+		This is the current queue depth for the group.
+
+	  avg_lat
+		The running average IO latency for this group in microseconds.
+		Running average is generally flawed, but will give an
+		administrator a general idea of the overall latency they can
+		expect for their workload on the given disk.
+
 PID
 ---
 
-- 
2.14.3

