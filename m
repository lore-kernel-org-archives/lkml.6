Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49C4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C8820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjU6CVsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C8820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbeGaQGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:06:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37386 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732255AbeGaQGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:06:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so9178805pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=44oHVkGiFDpGlQCTw8wYQWe0+KH9sd6sUuKKJogMrPw=;
        b=kjU6CVsGMouh5GJvbKDsWUF4WyabwcVGNO7yyxmvP0L2eFByLN5N91wlt9TCg19eeO
         s5Zz6Xb69WwiSUnKYE45jCOpfRErEjYVN2HESeMSLbjoXmc6xqJEX0WTmk1IXYT59obe
         sHwgtwd5O5+cj4xIQwElxEXZbve2jpEFiJSZ60fkh2VNr2c4ERPjSWE5/xqn7HV3l/4k
         1TQEAMKE9RVVN8gUCz7r3/XF9XbHzZn4Au+lrc1NeIrYAsRBdBeVlH3enrsBexoNEWlI
         y4PJC8pzEdXdyXq8Q4iUKLlu5redoMnJRc0opBcoco2JxsNatgeULqFED/uKM32bPiDz
         p6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=44oHVkGiFDpGlQCTw8wYQWe0+KH9sd6sUuKKJogMrPw=;
        b=N2a4RiMEqPpTGduLYJnvHMq1EWgNNsrmO6tsG7wFndhEhP+N8PClhB7Uevw+4gOvqf
         nsWXSLTeVyHcjUJF2o5UYYvZnOoEyA7UbMfcIJM+84slmPrLHYbtXqM1ZQ4WptiXi9op
         osqgf7DLMmTBp2HdiYnerjcTM+8iMVuFwM1HUiyh16cHQ/YpLrUw3mLh2RwrOiI27GZg
         fVa0lNURP7/iMcBWt6ua9xdj4yO4juaO+LTFjjpHp2Aj6pTwi7K1MMc15+Pac3K2Vxpr
         Ks00dhbr+Qxp0hYl+TVfSDUufjZaF6+jxVpeWPE7gh9FH6aomsDPhnbZDhQNPjuWpyg1
         ozJg==
X-Gm-Message-State: AOUpUlH1zLPzq0LhDYPY7nxFDc1bfoiadRE+ul6nagEWWiFQ3NbP+4Tf
        lgL4hiWaH4PsvH6mwJ/JQsg=
X-Google-Smtp-Source: AAOMgpdAbPcmbE9IdRhPUXDUUijNBB5nmtgJw+RXMoJrgC7ozZspl2nnIOyoX/x/KYhWiA7WjZA9iQ==
X-Received: by 2002:a63:7454:: with SMTP id e20-v6mr21187819pgn.410.1533047163870;
        Tue, 31 Jul 2018 07:26:03 -0700 (PDT)
Received: from pjb1027-Latitude-E5410 ([58.227.15.43])
        by smtp.gmail.com with ESMTPSA id v6-v6sm28482800pfa.28.2018.07.31.07.26.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 07:26:03 -0700 (PDT)
Date:   Tue, 31 Jul 2018 23:25:57 +0900
From:   Jinbum Park <jinb.park7@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH] perf/core: Fix possible Spectre-v1 for perf_swevent_enabled
Message-ID: <20180731142557.GA12460@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User controls @event_id which to be used as index of perf_swevent_enabled.
So, It can be exploited via Spectre-like attack. (speculative execution)

So sanitize @event_id before using it to prevent attack.

I leveraged strategy [1] to find this gadget.

[1] https://github.com/jinb-park/linux-exploit/
tree/master/exploit-remaining-spectre-gadget/

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f6ea33a..3313552 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -50,6 +50,7 @@
 #include <linux/sched/mm.h>
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
+#include <linux/nospec.h>
 
 #include "internal.h"
 
@@ -8200,6 +8201,7 @@ static int perf_swevent_init(struct perf_event *event)
 		if (err)
 			return err;
 
+		event_id = array_index_nospec(event_id, PERF_COUNT_SW_MAX);
 		static_key_slow_inc(&perf_swevent_enabled[event_id]);
 		event->destroy = sw_perf_event_destroy;
 	}
-- 
1.9.1

