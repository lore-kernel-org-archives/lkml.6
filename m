Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB29C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A712082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jbjpx/rL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A712082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeLERGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:06:23 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:38482 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeLERGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:06:23 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C7F7424E0607;
        Wed,  5 Dec 2018 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544029582; bh=OC0of18FgcdO5fHsK9VsjVhGocB8GGXqcmRcGn7d1Eo=;
        h=From:To:Cc:Subject:Date:From;
        b=jbjpx/rLrgNe4YCX4z1sacKa/HU809ZqlX+TDYdI/hNsLDW+6ViRJqDnW7rFOu+qk
         tu4XH49RZ9NSv6Gk4JeHA77L3VijmRwTeYw8/I1UVhK8GCE1KlMqUNT/pHo9oIjkUk
         c0+KmNUYvegGAfKonNpalA1w0iN4AzAAt0lbJtNG9wUUcrr50/qUY+mBePEL+b1prg
         w2aaVbU0chszi4EtuTiorma2Fagmm/hdG76dX04p8VQhgGreiGIuV8jRku3x3jdZY6
         cQRvAlTw24SEuSAkobkoYkDMtoLg48905Qq729fylDa6OXj//2HHB6biSqqm5SdzgK
         Qu7eDs+/d6aLg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 344935896;
        Wed,  5 Dec 2018 09:06:19 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/5] introduce Kernel PMU events support
Date:   Wed,  5 Dec 2018 20:06:04 +0300
Message-Id: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Kernel PMU events support and refactor ARC-specific perf code. 

Eugeniy Paltsev (5):
  ARC: perf: trivial code cleanup
  ARC: perf: introduce Kernel PMU events support
  ARC: perf: fix of kernel data types using
  ARC: perf: fix description comment
  ARC: perf: remove useless ifdefs

 arch/arc/kernel/perf_event.c | 179 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 141 insertions(+), 38 deletions(-)

-- 
2.14.5

