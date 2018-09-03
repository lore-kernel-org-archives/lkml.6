Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B831C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C8A20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQ1hGN/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C8A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeIDAPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:15:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41962 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbeIDAPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bBws5L/d6F23my0en+G36DhOzf5dsKCIFzR03M323cQ=; b=UQ1hGN/cYVK+VeGA5ADQo1eTSW
        7Gi5dTbAmStLzlSqxhSzDrokQrlkS+XFdLV8ESzPt/XEI1OmWr+FtP2VEGjoXaQODHZ2vHoww6OMw
        DvmTI2CdYF0sR9NvAxGAp9SBEZeGnkXh6nfilRkU8zw7b2v/Jy2NMy1h/cOUz2cYKOPCiUZAyuAet
        oA5Me2VxTKrrEzSHE9mvGEn9HBIV8drRuZGRnVWN7sQttcJrvgGFOY/vh8g+M4zG3MzJEsO32gUma
        s+YR43O0T5UZyxZzLn6izgEyyatE9AOjWaNuLM3Z+J1flXNwN2OOPl2LY+JGFB2iUNg4GOyMr6SAU
        dRxsdSnA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwuuU-0001yv-T3; Mon, 03 Sep 2018 19:53:19 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sched/fair.c: fix kernel-doc notation warning
Message-ID: <cdda0d42-880d-4229-a9f7-5899c977a063@infradead.org>
Date:   Mon, 3 Sep 2018 12:53:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning for missing 'flags' parameter description:

../kernel/sched/fair.c:3371: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'

Fixes: ea14b57e8a18 ("sched/cpufreq: Provide migration hint")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-419-rc2.orig/kernel/sched/fair.c
+++ lnx-419-rc2/kernel/sched/fair.c
@@ -3362,6 +3362,7 @@ update_cfs_rq_load_avg(u64 now, struct c
  * attach_entity_load_avg - attach this entity to its cfs_rq load avg
  * @cfs_rq: cfs_rq to attach to
  * @se: sched_entity to attach
+ * @flags: migration hints
  *
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.


