Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8198C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CCE2064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nptHH9+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CCE2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeJEQet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:34:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38706 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJEQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:34:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id a13-v6so12830192wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 02:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kGzM4xTqlGpe32GISfVIdFrlVFgMOsfGROpaokWRl84=;
        b=nptHH9+gJXmtzOiO5mlOeeZhFzUt+eoWhyP4XxVcdOOA2zpT0rEjp8/FwaPnRTDibP
         xs/S6J/wpLidCwNpPIDjTNhns0SJzWYDd5tpFeaVkkPRMl6VADRhbyaQMMLnLKM70238
         CVlXNsKzZ2pLcrz9BL5fGxPKm9EzWb4P/8RSkz52Ya/tfdg3Kh4a9iDu8zOIOHns2s5E
         37uNOzb8iCn/k1bBNKA4BacQ/1n8v6nE+VPrBswtZHWGrOjAUuU7d2icuieJZYPwZUOK
         pYEZe635bt4yqyPkE7KEr83AAr/EtkywS8y8fjrP1WwM0DX1BJ8GUm3jAkeXplMFIkKF
         60bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=kGzM4xTqlGpe32GISfVIdFrlVFgMOsfGROpaokWRl84=;
        b=EgRATDDhbWAjDiluVH896oPhnCaDJ3xtWMsompXV7CRH10CH9KAYrjqM95UVBtpVTC
         +LziiQCGa5cjFCre54QzgS+MW883WOhzFeAVxP/ryMODf4iQNCHqBh46xV4Sn7z79Pzr
         DXn4C1lSw5Ef91Bb/MS37JpobbDPsp5R7klGjIB18iRV+WApyQlSEIDqixVw77OIARk/
         KJuqaZI3sMUlmJrouXZZfIB8IrIgLNuGQbh9R8DLquiCeJP7FWCAOiuvo9yg3v+a364N
         dn2Tt9Ynf07wZ79MnzAlq+09mlJHg14WMyabErRYVconeaHXBOnRW/xWWppsWA6l3SBb
         EWXQ==
X-Gm-Message-State: ABuFfohcXsOiScZhn+G9XUO3byiZh3V20+rZ3zL9ITW8Xy6SngOBe/ZE
        UCAsZigpSNABLdZpLSn4YoS+lh0K
X-Google-Smtp-Source: ACcGV63wJ3j0AUTDXCyxSMHmM4UNV11KZQroOlWcvfuW29xbPyCrjsQyWfGQ/jEZKv71D7n/AwNhtg==
X-Received: by 2002:adf:9a38:: with SMTP id z53-v6mr7923927wrb.75.1538732210457;
        Fri, 05 Oct 2018 02:36:50 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p1-v6sm3648466wrw.12.2018.10.05.02.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 02:36:49 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:36:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20181005093647.GA52472@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: e4a02ed2aaf447fa849e3254bfdb3b9b01e1e520 locking/ww_mutex: Fix runtime warning in the WW mutex selftest

A fix in the ww_mutex self-test that produces a scary splat, plus an updates to the 
maintained-filed patters in MAINTAINER.

 Thanks,

	Ingo

------------------>
Guenter Roeck (1):
      locking/ww_mutex: Fix runtime warning in the WW mutex selftest

Will Deacon (1):
      MAINTAINERS: Remove dead path from LOCKING PRIMITIVES entry


 MAINTAINERS                    |  1 -
 kernel/locking/test-ww_mutex.c | 10 ++++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a255240d1452..3bd8913b2d78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8598,7 +8598,6 @@ F:	include/linux/spinlock*.h
 F:	arch/*/include/asm/spinlock*.h
 F:	include/linux/rwlock*.h
 F:	include/linux/mutex*.h
-F:	arch/*/include/asm/mutex*.h
 F:	include/linux/rwsem*.h
 F:	arch/*/include/asm/rwsem.h
 F:	include/linux/seqlock.h
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 0be047dbd897..65a3b7e55b9f 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -260,7 +260,7 @@ static void test_cycle_work(struct work_struct *work)
 {
 	struct test_cycle *cycle = container_of(work, typeof(*cycle), work);
 	struct ww_acquire_ctx ctx;
-	int err;
+	int err, erra = 0;
 
 	ww_acquire_init(&ctx, &ww_class);
 	ww_mutex_lock(&cycle->a_mutex, &ctx);
@@ -270,17 +270,19 @@ static void test_cycle_work(struct work_struct *work)
 
 	err = ww_mutex_lock(cycle->b_mutex, &ctx);
 	if (err == -EDEADLK) {
+		err = 0;
 		ww_mutex_unlock(&cycle->a_mutex);
 		ww_mutex_lock_slow(cycle->b_mutex, &ctx);
-		err = ww_mutex_lock(&cycle->a_mutex, &ctx);
+		erra = ww_mutex_lock(&cycle->a_mutex, &ctx);
 	}
 
 	if (!err)
 		ww_mutex_unlock(cycle->b_mutex);
-	ww_mutex_unlock(&cycle->a_mutex);
+	if (!erra)
+		ww_mutex_unlock(&cycle->a_mutex);
 	ww_acquire_fini(&ctx);
 
-	cycle->result = err;
+	cycle->result = err ?: erra;
 }
 
 static int __test_cycle(unsigned int nthreads)
