Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F096C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB7F217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115087;
	bh=qi2Apa9P2sx32cBfNSZHCsfaJLxSlC0SJ0zFa95GVJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kd88o90i+HPcHjYZNLqJ2NjHbsHY3RAiPu/zlBuPnOkyyslXbP+RswLZ/oJlDEkhY
	 ZU63JC1r7mkZyq32WLFogd1PWjzlJJEPGhQqcfGJp/nZSWjWoL2LzoPjN7NnJeRIEU
	 51zxI/H2ESOHeLf04N5AESlcA3nlkHcBTrRqEkZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfAUX6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:58:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfAUX6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:58:04 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A3D217D6;
        Mon, 21 Jan 2019 23:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115083;
        bh=qi2Apa9P2sx32cBfNSZHCsfaJLxSlC0SJ0zFa95GVJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAP4MC1sgG79IjSW1cl2P7scH4LT+zJXSgQ1Mx+JwTmdJmVJUbSAkSX/plXVDvMVL
         f0cpbFrXV+tUm1d3yxJpmhHrpP6MS0ZqC6Bf/cO9Fs7u9To0D6dhpQ1QFS0Kdyypon
         223TLVZHS213OVP0f8CkZpLSNuN86nB1xyYj42FI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/24] perf: Remove duplicated workqueue.h include from perf_event.h
Date:   Mon, 21 Jan 2019 20:56:50 -0300
Message-Id: <20190121235706.20005-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

It is already included a little bit higher up in that file.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190117072504.14428-1-yuehaibing@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/perf_event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index cec02dc63b51..f8ec36197718 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -53,7 +53,6 @@ struct perf_guest_info_callbacks {
 #include <linux/atomic.h>
 #include <linux/sysfs.h>
 #include <linux/perf_regs.h>
-#include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <asm/local.h>
 
-- 
2.20.1

