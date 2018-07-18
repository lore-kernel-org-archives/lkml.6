Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D89120858
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLrlVLVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D89120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeGRQjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:39:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41086 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeGRQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:39:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so2236651ply.8;
        Wed, 18 Jul 2018 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1Yoek57KSFJtVkxJxOeciB/rQgVNF892Bwm1MkYCpn8=;
        b=RLrlVLVkG4bGOCoVoUILcq21pCGbuZzX/2sL0bZ/eG52S12rga/0UvRSKdNOaFnVbk
         P92sBOEIsJnYZcK87HjLdywExw18qTesxS48zAryl93FxvRiWLZUvzp1wLzYyJmFiWu1
         AK7odWxMKI89agsOVLDegACf9NiJYjCuNmcQAH2LdS49JaM/pIUy4FXlx3qXv3syLVax
         44Pdfk0Sm+ZJzJBpMXTRMsAXdUyent0SDl5MuXWafNNnM8bKdNNTEX7V/x9tyQQDMdDN
         lu3q/bOtKiCWcEUGHeZx5VcEaSLOhgBYPx4Bj3JvRYfdBma4eBY58R1eWGY1yFGd3xQf
         E9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Yoek57KSFJtVkxJxOeciB/rQgVNF892Bwm1MkYCpn8=;
        b=RO1tSuE/umiLEtbuhRiCvtZ+XSMKPx+wyauLMhfw8XNC//ONrjhE9tNUynTplhyQfZ
         wmO9288wRJRI65RKdzCjOKUU7344seFd5EzZtbY52yIuzNt/MhSy8uNxX7wfdMGHfM6e
         t35jWYg1fNf1Etv66KAKkWaiiyheO8LUEf173BbUSUvJfw9smKWxAe+9/Qfwh1tiwx6y
         lPkvewF8fUnHTDURHAGp+9o3cDy06oOBol9ApP4w7MX1E7w+e1hke8XQGBgfXAA/vdLA
         lbyixVoicA1uRmVZzroziHdp4BmT2ZYYww+qfqKjg0qsmXW0bnE4uIgjukrlsvYu/CAA
         Nspg==
X-Gm-Message-State: AOUpUlGBDLKLre2EDTX504FU+c/GHTE64j5lmkqtFWqRll5cUYne3xwS
        aZoHg629P+NY/ZgBOqozvhc27GUX
X-Google-Smtp-Source: AAOMgpdTEWBDQcikWeuoDGw/GX3FE2CrJ0lL6cMpLsoZxqVheOaIuaRN0SniafKuh8l/3P5V085DdA==
X-Received: by 2002:a17:902:bd44:: with SMTP id b4-v6mr6534470plx.144.1531929666952;
        Wed, 18 Jul 2018 09:01:06 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.14])
        by smtp.gmail.com with ESMTPSA id t21-v6sm5533977pfh.45.2018.07.18.09.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 09:01:05 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, axboe@kernel.dk
Subject: [PATCH] pktcdvd:checkpatch:remove static initialise null
Date:   Wed, 18 Jul 2018 20:25:50 +0530
Message-Id: <20180718145550.3894-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*  Remove checkpatch error due to initialization of static variables to
NULL

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 drivers/block/pktcdvd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a4b4d524c3af..a7dbb7157115 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -100,8 +100,8 @@ static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
 static mempool_t psd_pool;
 static struct bio_set pkt_bio_set;
 
-static struct class	*class_pktcdvd = NULL;    /* /sys/class/pktcdvd */
-static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
+static struct class	*class_pktcdvd;    /* /sys/class/pktcdvd */
+static struct dentry	*pkt_debugfs_root; /* /sys/kernel/debug/pktcdvd */
 
 /* forward declaration */
 static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
-- 
2.17.1

