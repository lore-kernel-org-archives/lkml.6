Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967192AbeEYPyd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:54:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39228 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966831AbeEYPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:54:30 -0400
X-Google-Smtp-Source: AB8JxZoyeF+nDbIYqmEXJsoioBcDugTN4/KjfHfrVs+gVADjiZWNf1nsyIEJ/QcC9NU9rRKtHL0qRQ==
Date: Fri, 25 May 2018 23:54:18 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tor Jeremiassen <tor@ti.com>,
        mike.leach@linaro.org, kim.phillips@arm.com,
        coresight@lists.linaro.org, Mike Leach <mike.leach@arm.com>
Subject: Re: [RFT v2 1/4] perf cs-etm: Generate sample for missed packets
Message-ID: <20180525155418.GA27273@leoy-ThinkPad-X240s>
References: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
 <1526892748-326-2-git-send-email-leo.yan@linaro.org>
 <bc320d6d-a21d-b5a4-e30d-511bb69aba32@arm.com>
 <20180522083920.GD31075@leoy-ThinkPad-X240s>
 <03a53a72-8af5-02de-21a8-fd02a0974ed6@arm.com>
 <20180525152713.GD4091@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525152713.GD4091@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, Rob,

On Fri, May 25, 2018 at 12:27:13PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 25, 2018 at 03:03:47PM +0100, Robert Walker escreveu:
> > Hi Leo,
> > 
> > Following the discussions from your reply to this with a simplified patch,
> > this version of the patch works better as you also need to emit a branch
> > sample when handling a CS_ETM_TRACE_ON packet to indicate the end of a block
> > of trace.

I also will follow the suggestion as Rob mentioned in another email:
"The deadbeefdeadbeef addresses are a bit ugly - these are just dummy
values emitted in the decoder layer - maybe these should be changed
to 0."

> > This patch does not break the output from perf inject to generate
> > instruction samples for AutoFDO, so I am happy with that.

Thanks for confirmation.

> > Regards
> > 
> > Rob
> > 
> > Reviewed-by: Robert Walker <robert.walker@arm.com>
> 
> So, Leo, can you please resubmit, bumping the v2 to v3 (or the latest
> one, I haven't fully reread this thread) add this "Reviewed-by: Robert"
> tag and any other that people may have provided, so that I can merge it?

Sure!  I will respin the v3 patch series by following up Rob's
suggestion and add Rob's review tag.

BTW, I'd like to get ack from Mathieu as well.  Mathieu is working on
CPU wide tracing, so I talked with Mathieu he will review the patch
series if has conflict with CPU wide tracing.

[...]

Thanks,
Leo Yan
