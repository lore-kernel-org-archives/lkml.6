Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67084ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162752087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvwuEo/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162752087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeGNUS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 16:18:26 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36018 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeGNUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 16:18:26 -0400
Received: by mail-yw0-f196.google.com with SMTP id v197-v6so518127ywg.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IAld3TDQQCTGsd3XsnvFy8W9MNKBlUQnytTbyo6OPGw=;
        b=TvwuEo/2YWvJEu1pdHfxI67KgDWG+bBRtB1+UUW9+v4kg+BuXHl0DmfeqPYMeqjwq+
         MnjpFr/cHIdlUyC9ioD952RWlbLcgZ2dTmA2km39FmwCRGrY34Q7qrXy7jZnuuLhjJwv
         PbGQ/pUnCJEP/h7jNAZp1+Wrz5jfGGKy50cu11JN+ns9hCA4iPBEXxK3Dr0J1pua8Z6s
         Dj8ewn/ZwApJ+A1Z7AkwLVI5DN8DhHuMUDc1Co2AZSvfXNpCbu0AncU43mkTg4fKuWMv
         N3QdC8qtCvWMB5BxyTi2pI0DTfxpU9tpATgOu0/SvW5rhTWwUbLCPqlHXOQTzbCEIjTk
         D/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IAld3TDQQCTGsd3XsnvFy8W9MNKBlUQnytTbyo6OPGw=;
        b=fHXuL1Y3sxoOP3kxAAXy7ERH1XiEw/9fhGKW8z43pGNof6XJqaogodQzB064ksB7kL
         xugKm37PUc5snKef9DfCgUslS6Cv+oQdc/7W4Qsx47PBdoS+Mw/eHqTJ7o+qKj0xpF9q
         5nqY/9JOtpzp9R2n+wCaTGdOJRBFvGuJNiUAE/YUeLRFZ0a9LqlcgKGm20xnocmUo4Uk
         YsFwALivhDtKVWvlQQJIZQ0PAmbbZv3LchH5skc7ZDg0pETWROao+316bFXT3BRseeOy
         8B4c4GrTfQIYfMx+NmpvUpIbDvXoiE9aT2hsOoTta7heefoOWqNINC+AoIZoczIA7iwA
         qmFQ==
X-Gm-Message-State: AOUpUlFvHwrsmAvn/bvPhOa3x6IkgPtGn75FmA1YApQem12Mwb4CScaf
        yS5Q604D49mFDSJMjMUAKpHOTA==
X-Google-Smtp-Source: AAOMgpcwWBRnzI6UyNOL/WXwClfNRL4JiTUY2gfQbADBDPsDMYFtuHBl1Ttmcb4Bsekf2YLBjALXDg==
X-Received: by 2002:a81:1947:: with SMTP id 68-v6mr5661429ywz.466.1531598296866;
        Sat, 14 Jul 2018 12:58:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u64-v6sm4799433ywu.107.2018.07.14.12.58.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 12:58:16 -0700 (PDT)
Date:   Sat, 14 Jul 2018 12:58:07 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/events/intel/ds: Fix bts_interrupt_threshold alignment
In-Reply-To: <alpine.LSU.2.11.1807131542130.7074@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1807141248290.1614@eggly.anvils>
References: <alpine.LSU.2.11.1807131542130.7074@eggly.anvils>
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
Sorry for the spam: I missed out [PATCH] and x86@kernel.org yesterday.

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
 
