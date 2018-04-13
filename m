Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeDMQUp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:20:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:56980 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750837AbeDMQUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:20:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="34069572"
Date: Fri, 13 Apr 2018 09:20:43 -0700
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
Message-ID: <20180413162043.GD6694@tassilo.jf.intel.com>
References: <20180413140111.25313-1-acme@kernel.org>
 <20180413140111.25313-18-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413140111.25313-18-acme@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 11:01:11AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Just like is done for 'mov' and others that can have as source or
> targets variables resolved by objdump, to make them more compact:
> 
> -               orb    $0x4,0x224d71(%rip)        # 226ca4 <_rtld_global+0xca4>
> +               orb    $0x4,_rtld_global+0xca4

That's not equivalent.  It could be non rip relative too. You would need
to keep at least the (%rip).

-Andi
