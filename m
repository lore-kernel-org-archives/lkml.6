Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44917ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E821120693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBrvf9uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E821120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbeGQVj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45971 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbeGQVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id i26-v6so1082325pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cZqQ+0STNP8Wu+z3QaCwW8tEg30GGpgU3a6O1NX7GMY=;
        b=RBrvf9uHIbhiH87oIWqGJKhbGLh0abWIJw94g0SWnsyrfcD1Yr1RoMDVa/gq0MQs7E
         +gE999UrM0OMB5NevoZvoGnrXoTnV6jJCMgF5zINcv183PFO+kt3HAsFf4RkjQuq25mu
         mE2L0h3aiTSPtbjzU53NXryQG4LqoQPL8j2X/EdcqN2V7FqSuTRiMWS8PA0gxDLmXCY8
         3Pj4bRAlosEOgezhv+elsrWkq2myXcEgzBzobVeB77S8WNYj9NUsUk8xdyH1HBL0mzV7
         9TMyzLt2ZOkBkGCEONOjgN9vSNJV+Lhr5nXWdpaEHy7FchjqzTviCPHP9fv9moPlDMJ/
         /4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cZqQ+0STNP8Wu+z3QaCwW8tEg30GGpgU3a6O1NX7GMY=;
        b=fqCpNMPW45NpQxHVB9LnEY0kFTUOBTmgy0Omhcn/YTNm8Qxqrek98nXFW0GDZC6F7N
         lHMKZI6hpyjdxE7NwN0Yiph8bZVp7fD8IuYgDa/I/yOpFnLWFRnhakQHQr7j0yqbCvRC
         E+2AcpNlBeJHfqnmPUFG9cBRfON8176Bsq20THPGtfAOXr8BY9Qp8rKeS5SXj8ll6qIr
         izUbJa7c1sbjLbY+vT+HYpyBNtUUCwizazrJzVPivtVeiTA31Tw7vQiCHeFggW9rYXYe
         xVcSupuAZ4FR9g7YX+NhqeVHHuzbEtr6UtTVEOxs+GGj3jrhJCQINWWYrKJmuGSFljUh
         ypFA==
X-Gm-Message-State: AOUpUlHVCR5lfcmxXcTCTUULwMXQZxTbNnsB9brghWYh6j1aeF6J59JR
        IxOtmYLUkL3qPTjmqfnwkaE=
X-Google-Smtp-Source: AAOMgpc09chO+e4wc5Xvt+3KlFCIdzyItGan/KaPA83aJHvGB7GP3vYfn7iFxdReZZwdcVDIgz+iUA==
X-Received: by 2002:a62:4cd3:: with SMTP id e80-v6mr2260369pfj.234.1531861529676;
        Tue, 17 Jul 2018 14:05:29 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:28 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 31/32] staging: gasket: remove extra parens in gasket_write_mappable_regions
Date:   Tue, 17 Jul 2018 13:57:11 -0700
Message-Id: <20180717205712.29495-32-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unneeded parentheses around subexpressions.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 98d5a200aaa5a..bb47a63f4e49d 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1893,7 +1893,7 @@ static ssize_t gasket_write_mappable_regions(
 	if (bar_desc.permissions == GASKET_NOMAP)
 		return 0;
 	for (i = 0;
-	     (i < bar_desc.num_mappable_regions) && (total_written < PAGE_SIZE);
+	     i < bar_desc.num_mappable_regions && total_written < PAGE_SIZE;
 	     i++) {
 		min_addr = bar_desc.mappable_regions[i].start -
 			   driver_desc->legacy_mmap_address_offset;
-- 
2.18.0.203.gfac676dfb9-goog

