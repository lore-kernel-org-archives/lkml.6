Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B699DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBCE208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="VxN5gddZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBCE208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933748AbeGCPQB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:16:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37067 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934121AbeGCPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:28 -0400
Received: by mail-qt0-f194.google.com with SMTP id a18-v6so1868612qtj.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YsNSDaMPA55NV6tYVklfnMwegywAAoI3iEit0/l5+2A=;
        b=VxN5gddZ64mTCTUQWkuS46wK/b1oDOvID/LFzpV2u8kdjpKRLh4b5wPkyqnk9derKW
         rHoGtt3vW2+XtikpgQcMPZsCbOBPzkR6AmltYc6l28NJM9KpViUQKZLoukcEi1f08AVp
         sp+HF3JifCiCjLjLnB/2fdUzGET7/5ujPU6UAz0jklJS6lV5qOpjccJrlYjdvhsQoZ7s
         SRmhg8AqmdC45bEvN3lyZ201aPjOxM1HAz1cf81BH+QSnqZX+PZ0w4DiyVp5CTWkD3JM
         k9H3ih5dtGw8NNY5yFl/PCLJgNhkwGZB6RXiGvui2qaF6MFI1U5v4feWMqgDpiQJ383i
         CY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YsNSDaMPA55NV6tYVklfnMwegywAAoI3iEit0/l5+2A=;
        b=TCs9eEmVBn44vFSsVMvud1OnBl1lcwseR19ILwiqFTazIuYo5IQUfQd1NjNE82VfUx
         pRqmEErCFb14Y1tITQe5YTppQqELvO1GRsalZjIKk+5X2bIHjbCFonRH8fhTF3Ad5WMo
         ClokKIWA44lme8TgrOpsQZ349fB9tKHNzaGGwf2UqdF9Y63BRdek34LFC+q/qI08XVLq
         5cBCldE+RZ+sWJ4Mt2NfF1Oxgb5TVm9g1zL5Y1yTORJyi9AqMwO84SeT5p3j8orv9Cpm
         U1Y4y4koXI80f2z1L6+XS0rFvidpOwSpUFBMTtUOEr5iBi69Ncxun6/lEHRRKugg6h27
         lGzA==
X-Gm-Message-State: APt69E2x87Rs6+kCWiuutg7VHm5Ddzf5xulWfnxf7WWouaKxJT4he1lK
        jYPnyuDEsNJGH9uo5bPJPyX0ag==
X-Google-Smtp-Source: AAOMgpdp+VxCgleNtMxMZpOClY7HS8ickDeDsZBgAADI2YNULl+c6VGOwVpXL3DqxAs5ojnZhN9Wcw==
X-Received: by 2002:ac8:2463:: with SMTP id d32-v6mr18392998qtd.41.1530630927787;
        Tue, 03 Jul 2018 08:15:27 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 16-v6sm817680qkd.93.2018.07.03.08.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 13/14] Documentation: add a doc for blk-iolatency
Date:   Tue,  3 Jul 2018 11:15:02 -0400
Message-Id: <20180703151503.2549-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

A basic documentation to describe the interface, statistics, and
behavior of io.latency.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 79 +++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8a2c52d5c53b..569ce27b85e5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
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
@@ -1446,6 +1449,82 @@ writeback as follows.
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
+supports.  Experiment to find the value that works best for your workload.
+Start at higher than the expected latency for your device and watch the
+total_lat_avg value in io.stat for your workload group to get an idea of the
+latency you see during normal operation.  Use this value as a basis for your
+real setting, setting at 10-15% higher than the value in io.stat.
+Experimentation is key here because total_lat_avg is a running total, so is the
+"statistics" portion of "lies, damned lies, and statistics."
+
+How IO Latency Throttling Works
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+io.latency is work conserving; so as long as everybody is meeting their latency
+target the controller doesn't do anything.  Once a group starts missing its
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
+Once the victimized group starts meeting its latency target again it will start
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

