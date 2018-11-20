Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FDFC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072D720672
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdbgmrMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072D720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeKTXXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:23:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40623 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbeKTXXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:23:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so872173pgp.7;
        Tue, 20 Nov 2018 04:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P/3VXg8b0/4qPYj4Pzh+gl0+DIckFaNnC0YLvJ86HAM=;
        b=BdbgmrMCK9QQDDwZaR89+Oeydl2jh6Rskdd6w6Un+ny/zC95QQTPnqTC/5b2nmXEFG
         lyf+U6ks0r5WVDj63Shna1DNOPO4M/NiBC8iCAxBwBaffDSuz8oKWaVbR0/1vFVs7wGf
         dtEIjauD0uyQnk8NzVAY2djyCY5xqC90I+wjQLdELPGv564IsvFnjH5GFzfuG/SMKXPz
         zv2RgVfBQ1AwiXjfbZ/CDo4mcTy2v9eUCJWen8KGfKRYS7ywx7gei9Ng9ffTJAbTNWdh
         dRHm1zv6rjT7POhMUc1BL8kosypSBYBTCe1O8WHnAsML86OKILmhssw6MrZop49AMz3y
         yhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P/3VXg8b0/4qPYj4Pzh+gl0+DIckFaNnC0YLvJ86HAM=;
        b=WvJWNaibAQ9D/cWwQVKkpSiZoNN2aV9xYBEgNurGbVOjfzoO6/yiQr+liFpf5m9R/J
         2Hvu4ICeSUGeV+NpleHHGFWy8xrqRXZaJxnlHcxHDMkhPW2m3p2XJSw9BzTt1TJ07dgZ
         0WkiYpXM4RjBIVhdVOvEv1cjYsgEucSvZbkfFObDAdq5IuepGP9JXFTJmrl6AlYRBZb0
         cA5Gfuxs8kfZzaMGso8ImD02l44T0pjPQ5rtL9KsoCl6FuAN1m7WcrDHmy2Ad4ubWrs0
         +OHE1V3tvZA6DyV3S9B3Ay9/lIEMarwQb0WtggplXnQmuQ3I470zhESnhg/uoEwcvFwj
         TG/w==
X-Gm-Message-State: AA+aEWaYpBVJt077k17y/YR/vlj9iq8UuKm9Rqjg0kmyIBlcImBmuSoj
        FFXNCPLFh37S0PIIaudybv9DYcCTLJE=
X-Google-Smtp-Source: AFSGD/VkkW0lTT545K+a1nU7mFd15HQLWJTtf6yT/OKOWVbrAtCOPjrcEqIDEg/82465TRbpqCKTIw==
X-Received: by 2002:a63:b94c:: with SMTP id v12mr1761215pgo.221.1542718471646;
        Tue, 20 Nov 2018 04:54:31 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j64-v6sm17959447pfc.43.2018.11.20.04.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 04:54:29 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: pmac64: add of_node_put()
Date:   Tue, 20 Nov 2018 07:54:09 -0500
Message-Id: <20181120125409.19314-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put to release the refcount of node.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/pmac64-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index be623dd7b9f2..1d32a863332d 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -411,6 +411,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
 		pfunc_vdnap0_complete =
 			pmf_find_function(root, "slewing-done");
+		of_node_put(root);
 		if (pfunc_set_vdnap0 == NULL ||
 		    pfunc_vdnap0_complete == NULL) {
 			pr_err("Can't find required platform function\n");
-- 
2.17.0

