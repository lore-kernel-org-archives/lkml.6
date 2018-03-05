Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCEPI0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:08:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCEPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:08:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 05 Mar 2018 10:08:18 -0500
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V2 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
In-Reply-To: <20180304181010.GA7030@krava>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
 <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
 <20180303143436.GA14563@krava> <20180304171245.GB25017@tassilo.jf.intel.com>
 <20180304181010.GA7030@krava>
Message-ID: <1ddac3f4900267b0c9a69ef4c598be51@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-04 13:10, Jiri Olsa wrote:
> On Sun, Mar 04, 2018 at 09:12:45AM -0800, Andi Kleen wrote:
>> > > +#include <fnmatch.h>
>> > >  #include <linux/compiler.h>
>> > >  #include <linux/list.h>
>> > >  #include <linux/types.h>
>> > > @@ -241,7 +242,7 @@ PE_NAME opt_event_config
>> > >  			if (!strncmp(name, "uncore_", 7) &&
>> > >  			    strncmp($1, "uncore_", 7))
>> > >  				name += 7;
>> > > -			if (!strncmp($1, name, strlen($1))) {
>> > > +			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
>> >
>> > could we now get rid of the strncmp in here and keep the
>> > glob matching only?
>> 
>> That would break existing command lines. Not a good idea.
> 
> I hoped that only you guys are using this and would rewrite your 
> scripts ;-)
> 
> I had no idea there's fnmatch func before.. too bad, ok
> 
> jirka

An option to keep backward compatibility and consistency would be
to wrap the pattern/string passed in *'s, that way we can just use
fnmatch and have all the examples Jiri brought up work the same.
With that in place we can actually also drop the explicit ignoring
of the uncore_ prefix since the globbing would take care of that.

Thoughts?

Agustín

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
