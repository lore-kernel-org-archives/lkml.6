Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2539887-1528205427-2-16925729284772334192
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528205426; b=A9W1QJ4lsxmyWhg6ND4aVtN18M3l9tEr1z6GbU04UtC5KA3kyD
    O2UzqHC7zb1ZK6MzYJg/0rEvsUFZUARN9OH2YScRKWnbNcGL5LuUVV1si0/ltEuv
    0kLEUz+5PFQP2EU46sgsp0RPLd0my7m5Pjz4wTcZRjyVpO2KzB1mA8KwOAwXQlSO
    MmJvlZd/4miVC3BrbZutHhOgNKTtfSJUWERm9/isbsftpoC4byhcfMXaNJlKCZPx
    1EglS7/cRGPiQBqMvyKDHNPCwzKnRiNjGgQgt8nRJ0zxpYva+eGPEtT5g7UQFD08
    rybkzfUZn+A/6HWa+Uu6aJc9qgMSqwzfM7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1528205426; bh=
    oGWHcF+I1FAb0T0RllTc5crNDw5hGehwQIUcOHp09k0=; b=YSfJhy8xI+nd1apW
    m8ojKyNRep+fGRXiiX/pk9rXfm2ch49sxtMB8Ze8GNMTQuK5cNQHi/bJqAkEyA7K
    +pKezTc1oId5q7Y018OQ2/eGcs0afEpvY4ZBpWH/ZODe+OEPUey6ZFbSdpmNefwL
    btcVuDWcSveYBjqsU7xr6zWEkGv8Fi6S2zk28REJEs+LnsEkv8Ztlo4qqfhYGFFr
    PUJbazrZZodFd4iJqACs6Tr0cPfTd0Td9/Jl9nj8q2nNk9dvXEroe1vF+ziiP++a
    mGUjSzMv1Fxl0FLMPvdNkg1nekG9RjZWg+dk0OsbGg7s9CFJtcelXkNHo7+9f9UF
    JHMkLA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=toxicpanda-com.20150623.gappssmtp.com
    header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=yfT7pPdl
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=tAr60h04;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=toxicpanda.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=toxicpanda-com.20150623.gappssmtp.com
      header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=yfT7pPdl
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=tAr60h04;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=toxicpanda.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHdlV/K2bVn0PCkHVErO/eUmcO1tvSW4TyM5CuPDze71m5fY8DS7mbTWGOkoMlFpByRHDMpUn7lKZwH2jEK6v1qjsa/gC+z9ymm4SCziq2Kd/kUQ/bTg
    JUEpWqZYuxKyoHlcpk2/b7/VglG17/ftw/2VgjnuJiBB9+4TCcvxfcYsa4T8lZC0bxvC1QQAPpo1Y1jKHpwR4pro6VSSbM3CQaW7s22L/hpGFcRHaRcJA8It
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=FOH2dFAWAAAA:8
    a=yT1Yr64RZAxKqrA5kx4A:9 a=Hrk3NKplcuDbOPI0:21 a=CTt1pgX7CvQNXbmt:21
    a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeFENaX (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 09:30:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43903 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeFENaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:30:11 -0400
X-Google-Smtp-Source: ADUXVKKj1AjxfHxBIHrVhOw9q7bRsS6S8+t9j4V7jTNVt5hIntf3u47dV3FBZbEQ1Fu6pSZ8n2stIQ==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 13/13] Documentation: add a doc for blk-iolatency
Date: Tue,  5 Jun 2018 09:29:48 -0400
Message-Id: <20180605132948.1664-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605132948.1664-1-josef@toxicpanda.com>
References: <20180605132948.1664-1-josef@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
