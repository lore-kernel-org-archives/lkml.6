Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02F9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E6C208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgs+GXf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E6C208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeGNGQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38554 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeGNGQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id v15-v6so3748006pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oTIwZvp6fRaz4OInkzkeU1SS9J6FDLKbetb9RuRxzDc=;
        b=Rgs+GXf9ROmhAkC8uu4rThvwc0Q1A5MA0FBx40dNatEEL+Fu7ksTB4Sd0VTxRJhyuL
         g0ipswgSIalX6OzqatYpxTG9+tWTcT/2ZbMzYawQDw098Dr601D/NyOcGqTio7DyV5re
         6Uks937Ulm8USYlvlYx0/RtLDumHl578dvtTYifVzls1Cllluoil3tsOCFCk8fKCAJBq
         00rAgWy2uePkYZ0uy1OGNJDf3T8x5vOp8U3ST3DyvwUKmCDzCfgni2uGwjvj9jeKP/Gl
         QgDeqJF5WQUVafrZXxGhxviikU6BK+o/r4GrUkHc6GH8r7dWK73YZC+9nrM8AhD/SLhG
         9ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oTIwZvp6fRaz4OInkzkeU1SS9J6FDLKbetb9RuRxzDc=;
        b=YWF5jbSh9LzabY3Bah/5Xyqypf048r2r6jahysBsrxPL4QKlcNyYmXzoAqYUE4miYA
         m/0/3KgTGbhiRageL844dbfpmuO9G566HJ51ILk/WEipiMtw30mFKNZycyW8GefLK0cI
         y8W+vUdJ/x1+867D22xedRAOrkmPWB8k/6NbB/rnXo4rDvZav+GzUKFStOWbq+Hvyf//
         In2Xgc7wqRYNBXxK3Ii/q69WNp/XY71/ACo/eLIGiGBcKysTDU5VPx6BRSlA6vi0D8wq
         8EdcYKxsP4nDdW9HZvCgFNrbfEySOB0+9GBqCcqwpYk6hJPICEbwKJzRCAKNV69wpN4s
         uclg==
X-Gm-Message-State: AOUpUlGG7mgL9oHoYhut/ucIeefxE8Eajq0yzyYVnBPo9ByhJ1dH0+uk
        29FOBMp+Oxm617Xp0w3Wj1g=
X-Google-Smtp-Source: AAOMgpfjMiyGPSySB8Ob6KuxlENN3X5+Yv2ag4FA9a8sDeunf0Ju0SAMrkQ3u7BnWivFmcNhhgLLhg==
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr8262013pgf.84.1531547926630;
        Fri, 13 Jul 2018 22:58:46 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:46 -0700 (PDT)
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
Subject: [PATCH 02/18] MAINTAINERS: Add maintainer for drivers/staging/gasket
Date:   Fri, 13 Jul 2018 22:58:00 -0700
Message-Id: <20180714055816.223754-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Todd Poynor <toddpoynor@google.com> will be a maintainer of the Gasket
and Apex drivers.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 562ee1e1cfd6..8f44e7bed49e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5968,6 +5968,7 @@ GASKET DRIVER FRAMEWORK
 M:	Rob Springer <rspringer@google.com>
 M:	John Joseph <jnjoseph@google.com>
 M:	Ben Chan <benchan@chromium.org>
+M:	Todd Poynor <toddpoynor@mgail.com>
 S:	Maintained
 F:	drivers/staging/gasket/
 
-- 
2.18.0.203.gfac676dfb9-goog

