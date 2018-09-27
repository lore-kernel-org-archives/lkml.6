Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE711C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FFE2154D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FFE2154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeI0JQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:16:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:40372 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbeI0JQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:16:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 20:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,308,1534834800"; 
   d="scan'208";a="74009939"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2018 20:00:35 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 42A053011B1; Wed, 26 Sep 2018 20:00:35 -0700 (PDT)
Date:   Wed, 26 Sep 2018 20:00:35 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf segmentation fault from NULL dereference
Message-ID: <20180927030035.GF28040@tassilo.jf.intel.com>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please me let me know if a valid issue so we can get a fix in.

If it crashes it must be a valid issue of course.

But I'm not sure about your bisect. Hard to see how my patch
could cause this. Sometimes bisects go wrong. 
You verified by just reverting the patch?

First thing I would also try is to run with valgrind or ASan and see if it
reports anything.

-Andi
