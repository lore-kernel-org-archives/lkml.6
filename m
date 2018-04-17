Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDQMvJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbeDQMvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:51:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3CA21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 17 Apr 2018 09:51:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
Subject: Re: [PATCH 17/17] perf annotate: Handle variables in 'sub', 'or' and
 many other instructions
Message-ID: <20180417125104.GB3553@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
 <20180413140111.25313-18-acme@kernel.org>
 <20180413162043.GD6694@tassilo.jf.intel.com>
 <20180413172035.GB26496@kernel.org>
 <20180413173940.GE6694@tassilo.jf.intel.com>
 <20180417025628.GB31947@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417025628.GB31947@sejong>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 11:56:28AM +0900, Namhyung Kim escreveu:
> Hi,
> 
> On Fri, Apr 13, 2018 at 10:39:40AM -0700, Andi Kleen wrote:
> > > What do I miss? Or where is it that I'm misinterpreting the calculations
> > > that objdump did in its output?
> > 
> > The calculations are right, but these are still two different address modes.
> > You cannot just turn one silently into the other.
> > 
> > I think it would be ok to use the syntax in the assembler
> > 
> > symbol(%rip)  with no # ...
> 
> One thing I find useful is to show string constant if the address is
> in the rodata (and printable of course).  Maybe something like below..
> 
>   lea    0x1234(%rip),%rdi    # "hello world\n"
>   callq  printf
> 
> 
> Just an idea.

Send some more :-)

/me adds to the todo.annotate folder...

- Arnaldo
