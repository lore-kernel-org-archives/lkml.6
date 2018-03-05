Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeCERzg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:55:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:24263 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCERzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:55:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="39372858"
From: Andi Kleen <ak@linux.intel.com>
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V2 1/3] perf, tools: Support wildcards on pmu name in dynamic pmu events
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
        <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
        <20180303143436.GA14563@krava>
        <20180304171245.GB25017@tassilo.jf.intel.com>
        <20180304181010.GA7030@krava>
        <1ddac3f4900267b0c9a69ef4c598be51@codeaurora.org>
Date: Mon, 05 Mar 2018 09:55:19 -0800
In-Reply-To: <1ddac3f4900267b0c9a69ef4c598be51@codeaurora.org> (Agustin
        Vega-Frias's message of "Mon, 05 Mar 2018 10:08:18 -0500")
Message-ID: <87efky76go.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Agustin Vega-Frias <agustinv@codeaurora.org> writes:
>
> An option to keep backward compatibility and consistency would be
> to wrap the pattern/string passed in *'s, that way we can just use
> fnmatch and have all the examples Jiri brought up work the same.
> With that in place we can actually also drop the explicit ignoring
> of the uncore_ prefix since the globbing would take care of that.

Prepending with * would seem dangerous, could result in false
matches. But adding it at the end should be ok.

-Andi
