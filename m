Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6417C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699EC216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699EC216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeI1CgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:36:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:4721 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbeI1CgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:36:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 13:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,312,1534834800"; 
   d="scan'208";a="95521806"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2018 13:15:59 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1ED983011B1; Thu, 27 Sep 2018 13:15:59 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:15:59 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Tvrtko Ursulin <tursulin@ursulin.net>
Cc:     linux-kernel@vger.kernel.org, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org
Subject: Re: [RFC 3/5] perf: Allow per PMU access control
Message-ID: <20180927201559.GH28040@tassilo.jf.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <20180919122751.12439-4-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919122751.12439-4-tvrtko.ursulin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	mutex_lock(&pmus_lock);
> +	list_for_each_entry(pmu, &pmus, entry)
> +		pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
> +	mutex_unlock(&pmus_lock);

What happens to pmus that got added later?

The rest looks good.

Can you post a non RFC version?

-Andi
