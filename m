Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12B4C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DD820895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC8Sr95G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DD820895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJMJGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:06:19 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:42263 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeJMJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:06:19 -0400
Received: by mail-pf1-f176.google.com with SMTP id f26-v6so6997979pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 18:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9WTCU60JatrdpvRrS2IH0y8TcpbAR03WlwV4W3dygc=;
        b=SC8Sr95G9osLgXvk7f7sbRXFe1ECjw0pfL1/blrsj6AqgvxC5z7hNCnPT+F5QTDwuv
         gm5SeYDy0qSzRwA4NwTK2mD5nupoSHZZu+to2Rfqfo5rxgbvhOJ7hmQu0gkEbrHfDSId
         l6xHF3JLd9ID5xkd18LvbW4zrKv4WLessAwOAzgFlQmJpSRGtN5yWk+XBzgf+R6CSRaU
         vqvbukeeZWPQlU3ZgMdGrnIhkIv05xY36QxZsfZ7lmK6OoGdsBLkzcTJowd57Fc5lsvG
         EmmsHFTieWDEyGTUXuCQM7jBZN5KpLoWCWM742eKMpcop1wNRpurc9JSeDMP44R4LbpK
         f/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9WTCU60JatrdpvRrS2IH0y8TcpbAR03WlwV4W3dygc=;
        b=l2CL8F7nxmiy0tnHpuN++U7ZrgKdypBTY7GICOwSCgSP08l1OyajTHheJWvqMjTd7v
         E/cMCP46iHe4LXWOtImHHOTN2ScYATPbr5ziKWd2GufQx6F506hFNwC7Hc8Cttw5xLlw
         LB12zTuPwFBCGFhpW6ZWNyD909BqWGlpMJqfTUr8mdLdM/AP8XHcdUTLQca5zkLjS8Ds
         NQoc2Rrc1oxs8IMCtLbUNpHNkfJ880cLZkv5ShzfmiVziRNjh5hsf7DIifGOz4fmRTsZ
         8OJb3BZsqjYnP07iGbvuIH57QCK+MrNHyIljuOWIKt8yq+jGztBWIOak3ZwP3FB9tSgH
         gFBA==
X-Gm-Message-State: ABuFfoj82T0o8Yz/YRr1mq+SdiVd6ypWvCNibMOHsl726SMssRUtCdBE
        0je/1PAJMzWv+QG7wlvbkMY=
X-Google-Smtp-Source: ACcGV63ijgt0Lfspy+SQ0/EWBOCVziJu7JHUDiWf7fd/6x29HWl9Gw1kpxuJmFPFe624riEDrpYj4w==
X-Received: by 2002:a62:798e:: with SMTP id u136-v6mr8223379pfc.95.1539394270791;
        Fri, 12 Oct 2018 18:31:10 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id o131-v6sm3941924pgo.53.2018.10.12.18.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 18:31:10 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 1B3C720067B; Sat, 13 Oct 2018 10:30:59 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     corbet@lwn.net, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] docs: Fix typos in histogram.rst
Date:   Sat, 13 Oct 2018 10:30:57 +0900
Message-Id: <20181013013057.10677-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.19.1.328.g5a0cc8aca797
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typos.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/trace/histogram.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 5ac724baea7d..7dda76503127 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1765,7 +1765,7 @@ For example, here's how a latency can be calculated::
   # echo 'hist:keys=pid,prio:ts0=common_timestamp ...' >> event1/trigger
   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...' >> event2/trigger
 
-In the first line above, the event's timetamp is saved into the
+In the first line above, the event's timestamp is saved into the
 variable ts0.  In the next line, ts0 is subtracted from the second
 event's timestamp to produce the latency, which is then assigned into
 yet another variable, 'wakeup_lat'.  The hist trigger below in turn
@@ -1811,7 +1811,7 @@ the command that defined it with a '!'::
     /sys/kernel/debug/tracing/synthetic_events
 
 At this point, there isn't yet an actual 'wakeup_latency' event
-instantiated in the event subsytem - for this to happen, a 'hist
+instantiated in the event subsystem - for this to happen, a 'hist
 trigger action' needs to be instantiated and bound to actual fields
 and variables defined on other events (see Section 2.2.3 below on
 how that is done using hist trigger 'onmatch' action). Once that is
@@ -1837,7 +1837,7 @@ output can be displayed by reading the event's 'hist' file.
 A hist trigger 'action' is a function that's executed whenever a
 histogram entry is added or updated.
 
-The default 'action' if no special function is explicity specified is
+The default 'action' if no special function is explicitly specified is
 as it always has been, to simply update the set of values associated
 with an entry.  Some applications, however, may want to perform
 additional actions at that point, such as generate another event, or
-- 
2.19.1.328.g5a0cc8aca797

