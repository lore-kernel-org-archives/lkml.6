Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCE6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B7126CD2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="IEpihqDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B7126CD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeFZPh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:37:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55600 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeFZPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:37:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so2493985wmv.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Abv/BVquM3G1rdpOyLBh043BOt7/FURCkbDS6eSLwX4=;
        b=IEpihqDSVTUyQCaUqMufiliAfAI93Pu9qmB15mKu6kz0OB2titpeaUWBWZeVwh5XrE
         hEfWygbj4b9QpDENl9e34edH4bPm2R/8uJ5ubYqDw9U5HEweHs/0x81urTBNcdBskGm7
         BGujQM1ckoenQ4MpGNIvpmt1Wp0haAMy3+JEVJHwLtRTRP3Ze8KdwL86MrqOYIZwWPNj
         GecUbUbj1hkOGi0NCYO14p4iHjJpsYCs7TqGPRyDN+0pMV9NVNnsux8sNkPRydbKOyYz
         Tc7HPw8R2JX6HTnlcHoB8VCB3NloA7SkPyYNX8T1WAXnLlYA/LIhT23ncv+/nSlIezqb
         +pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Abv/BVquM3G1rdpOyLBh043BOt7/FURCkbDS6eSLwX4=;
        b=GwtzwrfyWZ1NWqG4oj9T4suOD8GLieKGyAsjNa/I7ZIarApZIIZa4aamgtRhYvDKWE
         duKa/UM7hrdqT+v4cbWAVvZuHXh9STaEEDi1oY+Fv8Y7p7404MkkneLEcQ/VNSSzfBKW
         9zn5XBMZiUboW6CCgwPyvswYEPSitXDDe63Os1pZ2P+XT0+l4go/FDKD0tOwTi/5xR+s
         kXsvySekSRVA+Wuon4AagmpHISqX7bIHeLNA5+vt2gPRjH27bzs7W6Cwok70RORxGld8
         jWcGCXcIsj03Zzf03aL6vNdHJFLirNKYcv+Q1IVhZJTokWKmEEY/PHjIaH26iZz+XQow
         0RbA==
X-Gm-Message-State: APt69E3iTWlSqpTRh0TODKr5yWV5EASNRh2ceaks390eRhuvkcvVVYY/
        W4xHTOx2nN3AN3F8Vp+ndnQhPOEp
X-Google-Smtp-Source: AAOMgpdEstMtq83E9mqTuQKYPRK5AnJkzEIwhCSGXp+/o687uTbgCbqR0XSpWVot0LihxvzHCgQL7w==
X-Received: by 2002:a1c:9e95:: with SMTP id h143-v6mr2079172wme.68.1530027440610;
        Tue, 26 Jun 2018 08:37:20 -0700 (PDT)
Received: from localhost.localdomain ([95.146.151.144])
        by smtp.gmail.com with ESMTPSA id l84-v6sm3411176wmi.3.2018.06.26.08.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 08:37:20 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
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
Subject: [RFC 4/4] perf Documentation: Document the per PMU perf_event_paranoid interface
Date:   Tue, 26 Jun 2018 16:36:42 +0100
Message-Id: <20180626153642.5587-5-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
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

