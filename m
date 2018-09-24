Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4C6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2629320C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FD8pLyRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2629320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeIXKYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:24:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53399 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIXKYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:24:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so8192695wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 21:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c5HF0jYr16gGL3z80h5CxAC4aDebU06EfnaFYSLQo/4=;
        b=FD8pLyRXipdNQTYnjAdPFIh4SVmo7BfF9ajeIEE+T/qr/DL12AJ5mlGesAiAKIAljg
         xwSJJTY+769BPZ3T67KwjX9KEF4CBPCofFVwwZJMuva6KxBLr+8PfeVWHhU+jBTF+KKt
         gP81hmFR68scp9BPnncUDHWDmCCTr+rphVXpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c5HF0jYr16gGL3z80h5CxAC4aDebU06EfnaFYSLQo/4=;
        b=pM7VmC484r1fcb8BbyTPgcBAasAd69OvHIM4Ot5SZekcgi2Tv1hiEwhxIOBZYDm5MZ
         0yClkfJeggozBDrY6P0t6qUrfBsXWmKJbGZBx72pKzwQ8jaE63AuMrLbWk+71cJg3Cp3
         WDVNxZZdYi4hJEyXlLh9c6Ye0reBRsYsGD0J2rw65TJ06pPN+LTq8/dchVLiWOvHypew
         K5wCjV5DznK9nqLhSHmxf96aeLG1SP9ZIv0j9EbEEpKPvR8+z00ivHQIWOLVWtLGIJN5
         1JweTzCQ2bv9qmOOS+AcfNJsbe4DD6Ib9oNB1xHdWEuP95FCSjqhwnVaufCGnNCi8M9U
         EP4w==
X-Gm-Message-State: ABuFfohwq/yVjjXItBQzG6VEsWF/heV4yRdSXUvqn5z6FiSwlbm6eVas
        IVh8EH/Ed0u6zzoIegwA1CEORQ==
X-Google-Smtp-Source: ANB0Vdbv/Us4hAVGtEWxXb7Hboa3JkjdJHVEFoL8Lis0yVYqKq0Ggc4PEIo0nXjOywyttePtDxQTcA==
X-Received: by 2002:a1c:dcf:: with SMTP id 198-v6mr5532857wmn.131.1537763038926;
        Sun, 23 Sep 2018 21:23:58 -0700 (PDT)
Received: from localhost.localdomain (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.gmail.com with ESMTPSA id j2-v6sm10269435wmj.5.2018.09.23.21.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Sep 2018 21:23:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 2/2] clocksource: Remove obsolete CLOCKSOURCE_OF_DECLARE
Date:   Mon, 24 Sep 2018 06:15:18 +0200
Message-Id: <1537762569-18657-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537762569-18657-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537762569-18657-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro CLOCKSOURCE_OF_DECLARE was renamed more TIMER_OF_DECLARE, and we
kept an alias CLOCKSOURCE_OF_DECLARE in order to smooth the transition for
drivers.

This change was done 1.5 year ago, we can reasonably remove this backward
compatible macro as it is no longer used anywhere.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/clocksource.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 3089189..4c58c1e 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -257,9 +257,6 @@ extern int clocksource_i8253_init(void);
 #define TIMER_OF_DECLARE(name, compat, fn) \
 	OF_DECLARE_1_RET(timer, name, compat, fn)
 
-#define CLOCKSOURCE_OF_DECLARE(name, compat, fn) \
-	TIMER_OF_DECLARE(name, compat, fn)
-
 #ifdef CONFIG_TIMER_PROBE
 extern void timer_probe(void);
 #else
-- 
2.7.4

