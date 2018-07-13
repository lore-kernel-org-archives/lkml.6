Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33524ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B372084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQSfeQjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B372084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeGMXF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:05:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41674 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMXF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:05:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id c21-v6so18776063pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=bnariFpju5boGLaI1TyTX/wwJHjG2/05GNftLn6KdWE=;
        b=DQSfeQjJgdg5FrQZ5SdsRePjtmoLCJWAmBwTzrI5v8IUs7X4MCw5enA94J9/6LWKbC
         Qkny1HZcIIjo1hc7+B0cXEB+XQwHtcVbRuzQtX8EKvHvLWNyRXUicbjbq+WwiASdvoLs
         qLvWAIRs/lRGJa41z25WHOyKJCJFIlBi01yHMF7FwnGqwYfyAJfrIcozXdVpBw6XeeNJ
         ex0FGuLm9yW0Zr+4QapsRo6lfzce/ETcQ4/Qt0qoBxwzPefnYdiFaTf8Wc4u/JGbIrQ/
         cmvnpezWePV9GicU0OfSsQGVepQO2LcRrZSHzG08tX4HQc0tZFNsNvGm2MZOxv5CgHxy
         jJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=bnariFpju5boGLaI1TyTX/wwJHjG2/05GNftLn6KdWE=;
        b=dyWvXD/bIKlDdJg7+z8RvFvO3SfccZZAu0NDI+1X7MQxAKV5K1EkILzvEf/6qeTN4S
         zqvDGpKjOTwmruBNBYEJN5blV4QakkhXxCqRaTurNRFAynS+9/ovIN0HFqp0YS4b7MJN
         BYK/UYRaBiOadFNSFdXDxVOZLc12Gp4SzAfUMccK8wUCuIcbfu0hlYGHtnW1B1BQkbgp
         djBhbvxeQQp3xroWFGXHpch2s4Bn+1MvyjbcsYcIWsEmUb/GN+lwalZ6oRaY7CYYsHWJ
         ppIinLXQGM6RRrOa84+4U6Nn4/6zmeYIf1V1UpUgd7xK3loEqCNU/jww1SuXt6DXQf8X
         18cg==
X-Gm-Message-State: AOUpUlG57mG6yQ/nc/IOu4hL3VMpZ+WwZNhs9ykvGyOXc5NAHCdRNljp
        a23hzlO4gAVD81q2O7NqAnB0Nw==
X-Google-Smtp-Source: AAOMgpcasvpj/wk29I+vHe+LQ9uSUZEZW0aaWKrs874QRjqjFvTPuDcZ6qT9Q7yOYIUFFOF7szawtQ==
X-Received: by 2002:a65:5bc4:: with SMTP id o4-v6mr7640586pgr.448.1531522127402;
        Fri, 13 Jul 2018 15:48:47 -0700 (PDT)
Received: from [100.112.85.58] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id v3-v6sm91468801pgb.54.2018.07.13.15.48.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 15:48:46 -0700 (PDT)
Date:   Fri, 13 Jul 2018 15:48:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Ingo Molnar <mingo@redhat.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: x86/events/intel/ds: Fix bts_interrupt_threshold alignment
Message-ID: <alpine.LSU.2.11.1807131542130.7074@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus reported that BTS is sporadically missing the tail of the trace
in the perf_event data buffer: [decode error (1): instruction overflow]
shown in GDB; and bisected it to the conversion of debug_store to PTI.

A little "optimization" crept into alloc_bts_buffer(), which mistakenly
placed bts_interrupt_threshold away from the 24-byte record boundary.
Intel SDM Vol 3B 17.4.9 says "This address must point to an offset from
the BTS buffer base that is a multiple of the BTS record size."

Revert "max" from a byte count to a record count, to calculate the
bts_interrupt_threshold correctly: which turns out to fix problem seen.

Fixes: c1961a4631da ("x86/events/intel/ds: Map debug buffers in cpu_entry_area")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reported-and-tested-by: Markus T Metzger <markus.t.metzger@intel.com>
Cc: <stable@vger.kernel.org> # v4.14+
---

 arch/x86/events/intel/ds.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- 4.18-rc4/arch/x86/events/intel/ds.c	2018-06-03 14:15:21.000000000 -0700
+++ linux/arch/x86/events/intel/ds.c	2018-07-12 17:38:28.471378616 -0700
@@ -408,9 +408,11 @@ static int alloc_bts_buffer(int cpu)
 	ds->bts_buffer_base = (unsigned long) cea;
 	ds_update_cea(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
 	ds->bts_index = ds->bts_buffer_base;
-	max = BTS_RECORD_SIZE * (BTS_BUFFER_SIZE / BTS_RECORD_SIZE);
-	ds->bts_absolute_maximum = ds->bts_buffer_base + max;
-	ds->bts_interrupt_threshold = ds->bts_absolute_maximum - (max / 16);
+	max = BTS_BUFFER_SIZE / BTS_RECORD_SIZE;
+	ds->bts_absolute_maximum = ds->bts_buffer_base +
+					max * BTS_RECORD_SIZE;
+	ds->bts_interrupt_threshold = ds->bts_absolute_maximum -
+					(max / 16) * BTS_RECORD_SIZE;
 	return 0;
 }
 
