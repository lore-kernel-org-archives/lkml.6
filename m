Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4404C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A78D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gnlKHOCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A78D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeLMQ4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:56:31 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:37682 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeLMQ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:56:31 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F11E810C17BE;
        Thu, 13 Dec 2018 08:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544720191; bh=Uqk0FlryvHLCm1CtQ711xM4f2AH3qBL7/NhhnZxf/PY=;
        h=From:To:Cc:Subject:Date:From;
        b=gnlKHOCVvbs3iV5Fo7XWDpw+fAnFKm7jtWm2gBlDWY1j0LQxHUeC48Rn+TBM4yFJo
         gLK/83WdkmmSMSoGuwg99+rg9cXHgVQFFtleUS9U1w9KeNQ4K7vy3qyCwl1xkeFSy1
         BuHJBu7TAbBuD5UABvYfia4BWObWgan8N7cKIjBIaArimRll31i6USlISUzik5aP2+
         qt85N7s4nuhQXXpoTG9iNwH5waK3uRblY3tk++hgvBtTxUddLxaWpK38dUcxzQIq74
         ghnUITEnm1WYgQbecRkUol4TpiP0mVTcqCkIEpjSnEN0I/QQDCnMXsuoYKcX+eRQsZ
         ePDX4nlneM0VQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id AD6663FEC;
        Thu, 13 Dec 2018 08:56:25 -0800 (PST)
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
Subject: [PATCH v2 0/4] introduce Kernel PMU events support
Date:   Thu, 13 Dec 2018 19:56:17 +0300
Message-Id: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Kernel PMU events support and refactor ARC-specific perf code. 

Eugeniy Paltsev (4):
  ARC: perf: trivial code cleanup
  ARC: perf: introduce Kernel PMU events support
  ARC: perf: move HW events mapping to separate function
  ARC: perf: avoid kernel killing where it is possible

 arch/arc/kernel/perf_event.c | 228 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 169 insertions(+), 59 deletions(-)

-- 
2.14.5

