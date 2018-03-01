Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033781AbeCASIY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:08:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:47138 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033196AbeCASIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:08:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="24365001"
Date: Thu, 1 Mar 2018 10:08:05 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitri Prokhorov <Dmitry.Prohorov@intel.com>
Subject: Re: [RFC PATCH] perf/core: exposing type of context-switch-out event
Message-ID: <20180301180805.GI21543@tassilo.jf.intel.com>
References: <06006a92-3745-0785-cb11-ddbf70e84ded@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06006a92-3745-0785-cb11-ddbf70e84ded@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 06:40:04PM +0300, Alexey Budankov wrote:
> Hi,
> 
> This patch prototypes exposing the type of context-switch-out event using
> PERF_RECORD_MISC_EXT_RESERVED bit for PERF_RECORD_SWITCH[_CPU_WIDE] records.

It would be better to define an actually named bit in perf_event.h.
It can be the same value.

Also we would need a patch for perf script / perf report -D to print this
information.

The rest looks good to me.

-Andi
