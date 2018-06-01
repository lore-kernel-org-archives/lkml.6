Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeFAXBE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 19:01:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:35319 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbeFAXBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 19:01:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="44633288"
Date: Fri, 1 Jun 2018 16:01:00 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2]: perf record: enable arbitrary event names thru name=
 modifier
Message-ID: <20180601230100.GN30764@tassilo.jf.intel.com>
References: <23f72f9b-c513-ecd4-d375-c5cf2eb30197@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f72f9b-c513-ecd4-d375-c5cf2eb30197@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 05:08:12PM +0300, Alexey Budankov wrote:
> 
> Enable complex event names containing [.:=,] symbols to be encoded into Perf 
> trace using name= modifier e.g. like this:
> 
> perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',\
> 		period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex
> 
> Below is how it looks like in the report output. Please note explicit escaped 
> quoting at cmdline string in the header so that thestring can be directly reused
> for another collection in shell:

Patch looks good, but new syntax also needs to be documented in some manpage
(e.g. perf list)

-Andi
