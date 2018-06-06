Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YsqpIeprGFvyeAAAmS7hNA
	; Wed, 06 Jun 2018 23:19:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7422E608BA; Wed,  6 Jun 2018 23:19:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 08DAD607E4;
	Wed,  6 Jun 2018 23:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08DAD607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeFFXTE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:19:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:27388 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbeFFXTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:19:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 16:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,485,1520924400";
   d="scan'208";a="57156872"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 06 Jun 2018 16:19:02 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2D051300B48; Wed,  6 Jun 2018 16:19:02 -0700 (PDT)
Date: Wed, 6 Jun 2018 16:19:02 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@linux.intel.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 01/10] perf tools: Uniquify the event name if there's no
 other matched event
Message-ID: <20180606231902.GE7220@tassilo.jf.intel.com>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606221513.11302-2-jolsa@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:15:04AM +0200, Jiri Olsa wrote:
> Currently by default we try to match the user specified PMU
> name to all PMU units available and use them to aggregate
> all matched PMUs event counts into one 'pattern' event.
> 
> While this is useful for uncore events, it screws up names
> for other events, where this is not desirable, like:
> 
> Before:
>   # perf stat -e cp/cpu-cycles/ kill

I assume you mean cpU/cpu-cycles/
> 
>    Performance counter stats for 'kill':
> 
>            1,573,757      cp/cpu-cycles/
> 
> Keeping the pattern matching logic, but making the name unique
> in case there's no other match found. That fixes the example
> above and hopefully does not screw up anything else.
> 
> After:
>   # perf stat -e cp/cpu-cycles/ kill
> 
>    Performance counter stats for 'kill':
> 
>            1,573,757      cpu/cpu-cycles/


The output is 100% identical?

-Andi
