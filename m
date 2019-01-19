Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BBAC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC602084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyRB6oDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfASQQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:16:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41996 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfASQQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:16:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so18521141wrx.9;
        Sat, 19 Jan 2019 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Y8/KD/t1457g2rhN8kwOJyAZn1/qLZf2s1MYK2X4I0=;
        b=GyRB6oDGZjtoszrokJ7iwaw5qLuEUUgxNoGE5d5qBGDbaRf1e1HVTuPN1l2c8Xj7mw
         tN8ORFAULB7Us4Tu1lQin1loWNBZ5Y6Iu/kwbPLLxN7Rkt9HdbU0SY93aPegzYQSfHPp
         PolCHHfq/Ah6LfGuthghXMCNG+t7hPEzRw4gxuMlGhYTEyNOLYu6lSw0H0XpfhC+6OyD
         w+EoKpp+MQV39Ud4KqE1Io+Md5uPqXsbimd7qVfv6a8rIUPBWxrpxRxD4ndTiS8I2aHU
         f0q/nxMzMLbjMtgfQnc137zc6PgVDx2bNqTSMm/tUy1uWkrTLpUVZeR3vyLbG/Ng30Ze
         L6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Y8/KD/t1457g2rhN8kwOJyAZn1/qLZf2s1MYK2X4I0=;
        b=UTtoQA9BT3I6n2e8Onch40d9N/RXZ8Y6FX4evW2GSSaF/+HCiSU1R/LTfFA90dlNy0
         tqQDplzhuX2csCOWgEUtzxlsA2GrPoAvM9Xg/7wZLXzCpiVBmvwaXKFz/nHYhEfvu7pU
         4jfo+9Nb3XKzYQz7MxegwnYZ3k7nFmwErDgjMKaPfZHBl6efqGDeGf4NtTFKHTkGLzae
         kpJXyoyEK00wuVhjSSKgesCGhMgvY5AMHEcTVUyaG8mdxQ+dKoAhS5K4Cr7Mdh/UR1a0
         zovjbOiy5vubteakwR/5AJmzSigzfYUb6F14+bxoXhjxIpTVP9TWPVUeSCLpNoRYAH7m
         FSgQ==
X-Gm-Message-State: AJcUukfrEN2mDb8tUxNngY6h9NYWEPmIHcHrebBFAkL9f0G9xjYXHuBJ
        bKr/gy+r/eojD01jGj6eDuA=
X-Google-Smtp-Source: ALg8bN6o3U4U0C/TQSg+mbVfgJMXQuAfUDZmFoDLcSrNeY4ayByHSuxcTBGfjd3j+lVNr8JYPQRZqQ==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr21952937wrx.302.1547914598073;
        Sat, 19 Jan 2019 08:16:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40eb:400:bcef:d6e3:7d06:ac3])
        by smtp.gmail.com with ESMTPSA id v12sm86976151wmd.27.2019.01.19.08.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 08:16:37 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] thermal/intel_powerclamp: fix __percpu declaration of worker_data
Date:   Sat, 19 Jan 2019 17:15:23 +0100
Message-Id: <20190119161523.87999-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is declared as:
	static struct powerclamp_worker_data * __percpu worker_data;
In other words, a percpu pointer to struct ...

But this variable not used like so but as a pointer to a percpu
struct powerclamp_worker_data.

So fix the declaration as:
	static struct powerclamp_worker_data __percpu *worker_data;

This also quiets Sparse's warnings from __verify_pcpu_ptr(), like:
  494:49: warning: incorrect type in initializer (different address spaces)
  494:49:    expected void const [noderef] <asn:3> *__vpp_verify
  494:49:    got struct powerclamp_worker_data *

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 7571f7c2e..c7cba20bd 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -101,7 +101,7 @@ struct powerclamp_worker_data {
 	bool clamping;
 };
 
-static struct powerclamp_worker_data * __percpu worker_data;
+static struct powerclamp_worker_data __percpu * worker_data;
 static struct thermal_cooling_device *cooling_dev;
 static unsigned long *cpu_clamping_mask;  /* bit map for tracking per cpu
 					   * clamping kthread worker
-- 
2.20.0

