Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935961AbeE3GcP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:32:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:13184 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeE3GcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:32:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,459,1520924400";
   d="scan'208";a="228434354"
Subject: Re: heads up: moving intel-pt-decoder/Build header checks to
 check_headers.sh
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20180529134809.GB20886@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a090016e-1cb9-2d49-fc47-40dcd6374451@intel.com>
Date: Wed, 30 May 2018 09:30:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529134809.GB20886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/18 16:48, Arnaldo Carvalho de Melo wrote:
> Hi Adrian,
> 
> 	We've made tools/perf/check-headers.sh the mechanism to check
> for drift on kernel file copies we have in tools/, and it assumes that
> if we have tools/a/b/c/d, then it came from a/b/c/d in the kernel
> sources, e.g. a copy of the kernel's arch/x86/lib/x86-opcode-map.txt
> would be in tools/arch/x86/lib/x86-opcode-map.txt.
> 
> 	That is not the case with the intel-pt-decoder, so I'm thinking
> about moving those files to comply with the model used for other copies,
> as having it in util/intel-pt-decoder/ isn't strictly required, i.e.
> those files could conceivably be used for other purposes besides
> decoding intel-pt traces, say for disassembly/annotate, that albeit not
> planned (at least by me) for the near future, would be something
> interesting to investigate doing.
> 
> 	IIRC Ingo was the one to point me out this, and now I saw the
> warning about it being different flying by in the middle of the build,
> differently from what is done by check-headers.sh, that is to show
> everything that drifted in one single block, at the start of the build.
> 
> 	So unless you have a strong objection to this, I'll continue
> investigation about how do do it with tools/perf/check-headers.sh,

I have no objection but currently it is (theoretically) possible to compile
Intel PT decoding support into perf script and perf report for any
architecture. i.e. decoding Intel PT from a perf.data file does not depend
on the build architecture.
