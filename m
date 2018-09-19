Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4204C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8EC2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="rDud9yTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8EC2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbeISSFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:05:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41803 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbeISSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:05:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id j15-v6so1524282wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Abv/BVquM3G1rdpOyLBh043BOt7/FURCkbDS6eSLwX4=;
        b=rDud9yTJ/CeVLl1kXquNaRJ5pkommUoJHosDRmi6kgwJX8pZHnowIYVE5WFmGcXIxf
         5GygPRt14E0iyTUf6M0clwyXjr4wJ8P1wXwXmpafSrTRymk70y6h/rD+x73Ato4yJQsK
         wehVEjr+24EoE+UL3mYP/foscopg8ATCpu4eGO611RVquw9flVLPVbGl9vFhF+ecpHya
         gbdr6SKPeztvIY/gWbuPuhj++DRRk+9MKprMcK3VsmBfR+Tk70i+DhGKBgMXpSRBl507
         YX6XpJf0VXuk8naOdHefJ1yr2TAIkSM7dW6T2P/Xmj0RemHW0WbDORbo07t/aNNQ8w5f
         fauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Abv/BVquM3G1rdpOyLBh043BOt7/FURCkbDS6eSLwX4=;
        b=QT6qBuBmm9wHISNxvsne3VAh/GwoFX45z0mu97ZO9UZvpt2gH7GFd4NSB9f5a3H9Fa
         vi4zqXuuXb4c2/wTQ+dtkwsqDeN/06gK2viX7KR+Pm1O/r+e1A0oKn5QVnMCM84xo21z
         oGdiyhwbDkWUdmt59H3reZCBY7ZbpqUT81Chret13RZkKQu1kJvcsWp9Tq+NeUb/4JVy
         ChNLq36hmSlsgXDZmvndIrSu4YOGNpAKJPjuJo4t1hLgOmH0crz9XpR0ZVGsf16oTNC4
         4HPtlH+66epk5Bkv5mHE6aVDMXRE+GgYkQRUms3xTq+PExb+8gGkpDfh5d6ClcKuqLpn
         +3yQ==
X-Gm-Message-State: APzg51AYwgi3LqGC/NPppfugHKiewYO23GFudW3+L0TvyL+57UuIojKC
        KnRhlLn/qCLkBDCitOU9LS2W+FXxCe0=
X-Google-Smtp-Source: ANB0VdZlTC6dlqPwp7ZmF4E9l5k+J4xgx7N/FZ+RfjaOj4DQmhbw4S5SZZrfW+OOSD+CwubOQg+Sjw==
X-Received: by 2002:a5d:4684:: with SMTP id u4-v6mr29347130wrq.76.1537360082223;
        Wed, 19 Sep 2018 05:28:02 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id l18-v6sm19412403wru.75.2018.09.19.05.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 05:28:01 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org
Subject: [RFC 4/5] perf Documentation: Document the per PMU perf_event_paranoid interface
Date:   Wed, 19 Sep 2018 13:27:50 +0100
Message-Id: <20180919122751.12439-5-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Explain behaviour of the new control knob along side the existing perf
event documentation.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 .../testing/sysfs-bus-event_source-devices-events  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 505f080d20a1..b3096ae9be6f 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -92,3 +92,17 @@ Description:	Perf event scaling factors
 
 		This is provided to avoid performing floating point arithmetic
 		in the kernel.
+
+What: /sys/bus/event_source/devices/<pmu>/perf_event_paranoid
+Date: 2018/06/26
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Per PMU access control file
+
+		This is the per PMU version of the perf_event_paranoid sysctl
+		which allows controlling the access control level for each
+		individual PMU.
+
+		Writes to the sysctl will propagate to all PMU providers.
+
+		For explanation of supported values please consult the sysctl
+		documentation.
-- 
2.17.1

