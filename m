Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E728ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B6A20891
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcEvW+vP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B6A20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeG1Gr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 02:47:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37212 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeG1Gr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 02:47:28 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so3172368plc.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2qwS5d18diVtYQAwvO43LSCHFFvGOn8r297xyQL0Lo=;
        b=NcEvW+vPiVEn3RFR2+CHKqzhMsWA7Sud6d3ENL1NCQW9JUmkrDEV68EbyTFJ2q5gme
         rZTfM7SKLCHuYUXRwznbodtOiefGOTWi61hW7Z9Iq3mkp8x7xyuL0Xk3nBVhvA/5xHe5
         kKZMR+rLjpZ8fNlZLACIX96wnEVa5SF0T/1FAJM/Y63lcaVw7N3UDqFVpFOkYwboHY8f
         m4498QSAKKETyOtXAeVFcOqRj8eOTX/WB0BYhEXpiQJtY0CG+gK5/cuCDMIVvoHYZLPt
         pB+W/Lr6KJdowTp6KGTfr3kep8gsCdXfzNqlJrARZjRD4828SrkogTYS+A3LVdYFQvS6
         9caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2qwS5d18diVtYQAwvO43LSCHFFvGOn8r297xyQL0Lo=;
        b=rOEkh9fipmgtwtrrBIZO/nzYSb/NoD+9LU+wVZiu+IB7YqzIMCG6sKxR6yfXOkDsGC
         mZFAs0W/KvZ9wCDdPqzoxyATI7j5jOj/SmkwL4kaMZlc+fzBZVQcReiKKpaSodAhTgNJ
         egkLf126V8kU1TJcYfuVNJagSMGxxdpIEg7mOsREdw843RKmZaL/ScX4iRRB4ckwvYzQ
         QRDYHz5mAiQpUKksBMzm/t0Zrx7YUjCboaLp1Vs5U23V9rNEsSszIRBqzGbU28b8PBX2
         HyeoG1ks2rr291MJTYs3Wber5OKW2RS/6b43lqzmJRWib47fkeDwTm4e18uG+7UkhZ8x
         GacA==
X-Gm-Message-State: AOUpUlG3T5KL5WuaOjFy41zeygzQXaELeJm7J5OHqkHJB6yj1MCL7L7Q
        l/kuO1gpCnSKmwAbp22pUr4=
X-Google-Smtp-Source: AAOMgpcDQpTjLhFTL3X+mL0Jw+41KBAS1Jy5pB5QQ40/AhJA6Fa/xhAClvp+Aq722HExow2NLZTPOw==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7-v6mr8469399plm.90.1532755341262;
        Fri, 27 Jul 2018 22:22:21 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id y85-v6sm8837195pfa.170.2018.07.27.22.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 22:22:20 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 1/5] staging: gasket: sysfs: remove check for refcount already zero
Date:   Fri, 27 Jul 2018 22:21:56 -0700
Message-Id: <20180728052200.228796-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180728052200.228796-1-toddpoynor@gmail.com>
References: <20180728052200.228796-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove the check for refcount already zero, which shouldn't be
necessary.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index 418b81797e638..2d8647de697cd 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -111,8 +111,6 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
 	}
 
 	mutex_lock(&mapping->mutex);
-	if (refcount_read(&mapping->refcount.refcount) == 0)
-		dev_err(mapping->device, "Refcount is already 0\n");
 	if (kref_put(&mapping->refcount, release_entry)) {
 		dev_dbg(mapping->device, "Removing Gasket sysfs mapping\n");
 		/*
-- 
2.18.0.345.g5c9ce644c3-goog

