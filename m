Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A672089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbd5BQy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A672089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389559AbeKPUZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:25:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38441 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKPUZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:25:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so3196838pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=844rQ1+LX5JJI0KGO3rkG5BaLL61m0A/6Ix8iiVJSR0=;
        b=hbd5BQy2UzMGaaelqf53ZhkcX74AmrmBStWFxJp1RDoqYDvQKKy+ES+4aGpbCU/qes
         7J76shDauzRJy3yoNLTUVkhFFIL7TbwquMKzHWIr/YjsWSGDwj38S2+fegf3oTXTpDoY
         OcG2OwkH/7n5U0pTnAAFjvhW/lNqatvJ9BFxDpecnle57fNrSC4Vbd7ikbbJPgcOPrq8
         MaGpgghdTTRQrA2QwGSDCv7iyYu4iaPwaCgEx2o+wbZJKsSa1aYFocTn104JCmDPDqAr
         CSpVU8STN2iY02hpDPg7E2Iq4F5cCaRQ4wfZDN6ByarF6mteXjVfH4+SsNpu1l4FTBgQ
         iUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=844rQ1+LX5JJI0KGO3rkG5BaLL61m0A/6Ix8iiVJSR0=;
        b=RUhxMNj/dTymJPFY8yKLSfgobNNNalH/2khBPBfh++JwY+Y00tHoGVoRpMHE+spPYF
         pQ0IIs2k6aZHiQJ6X5awuEA2aRqNmH6PbBKxvQuir/O85nm0FA4/h4qmELO3CyA3wlBx
         nDlT1xiVCqq03XyfVhp95lxmZbMYj03Cvn1a0nbNrZCwb7hSMOF2qvB28hJ3EpQ0bOTb
         qMyO9i5+XVTOfrqIGC+dDNoQhMTM/pwe5hWuGdVV+foa0IR8ICulM2poNra41tPOk2L2
         WjDyo+GWGKsr6i5VIEULBSfVn6WkMPT/8TZS7tYPTYRw3kewMVmZF4V1lmY7EiA3m4wp
         VHiw==
X-Gm-Message-State: AGRZ1gI8jfGUZoZP89npAKT/qIwA6Qw3YZGyK7makBSdVwxcDQq+tySE
        eg90C6buAQVqXK40wzP1Dg9EHLB9
X-Google-Smtp-Source: AJdET5eSOCjFrLs8HAr7zsGgEfDtoPaEd3KQXnKmA1mLuuVC57HCAn11Qiw0Dlq0hdYUbQjpx7Qqqg==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr9573699pgv.438.1542363236863;
        Fri, 16 Nov 2018 02:13:56 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.99])
        by smtp.gmail.com with ESMTPSA id g15sm49381313pfj.131.2018.11.16.02.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 02:13:56 -0800 (PST)
Date:   Fri, 16 Nov 2018 15:43:53 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drivers/bus/qcom-ebi2.c: Remove duplicate header
Message-ID: <20181116101353.GA2752@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/io.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/bus/qcom-ebi2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
index a6444244c411..56b01e4344d3 100644
--- a/drivers/bus/qcom-ebi2.c
+++ b/drivers/bus/qcom-ebi2.c
@@ -21,7 +21,6 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/init.h>
-#include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/bitops.h>
-- 
2.17.1

