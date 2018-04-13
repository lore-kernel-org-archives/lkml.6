Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeDMRjq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:39:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:7682 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbeDMRjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:39:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="47690872"
Date: Fri, 13 Apr 2018 10:39:40 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 17/17] perf annotate: Handle variables in 'sub', 'or' and
 many other instructions
Message-ID: <20180413173940.GE6694@tassilo.jf.intel.com>
References: <20180413140111.25313-1-acme@kernel.org>
 <20180413140111.25313-18-acme@kernel.org>
 <20180413162043.GD6694@tassilo.jf.intel.com>
 <20180413172035.GB26496@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413172035.GB26496@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What do I miss? Or where is it that I'm misinterpreting the calculations
> that objdump did in its output?

The calculations are right, but these are still two different address modes.
You cannot just turn one silently into the other.

I think it would be ok to use the syntax in the assembler

symbol(%rip)  with no # ...

> About something mildly related: what do you think about this:
> http://ref.x86asm.net/, there is a xml file there[1] I'm thinking about
> using, if available on the developer's HOME or some other standard place,
> to provide help about the instructions :-)

I don't know how well it's going to be maintained. x86 changes a lot
and I've seen a lot of disassembler libraries etc. go stale as the
owner cannot keep up.

The only semi official maintained descriptions are the XED tables (but those
don't have descriptions) or the PDFs from Intel/AMD.
I suppose could have some hack that talks to a PDF reader and automatically
downloads/searches the PDF.

If unofficial is ok I would rather port some functionality
from https://github.com/HJLebbink/asm-dude
which has a lot of cool stuff.

-Andi
