Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeDQC4d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 22:56:33 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:58542 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeDQC4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 22:56:31 -0400
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Tue, 17 Apr 2018 11:56:28 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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
Message-ID: <20180417025628.GB31947@sejong>
References: <20180413140111.25313-1-acme@kernel.org>
 <20180413140111.25313-18-acme@kernel.org>
 <20180413162043.GD6694@tassilo.jf.intel.com>
 <20180413172035.GB26496@kernel.org>
 <20180413173940.GE6694@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180413173940.GE6694@tassilo.jf.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 13, 2018 at 10:39:40AM -0700, Andi Kleen wrote:
> > What do I miss? Or where is it that I'm misinterpreting the calculations
> > that objdump did in its output?
> 
> The calculations are right, but these are still two different address modes.
> You cannot just turn one silently into the other.
> 
> I think it would be ok to use the syntax in the assembler
> 
> symbol(%rip)  with no # ...

One thing I find useful is to show string constant if the address is
in the rodata (and printable of course).  Maybe something like below..

  lea    0x1234(%rip),%rdi    # "hello world\n"
  callq  printf


Just an idea.

Thanks,
Namhyung


> 
> > About something mildly related: what do you think about this:
> > http://ref.x86asm.net/, there is a xml file there[1] I'm thinking about
> > using, if available on the developer's HOME or some other standard place,
> > to provide help about the instructions :-)
> 
> I don't know how well it's going to be maintained. x86 changes a lot
> and I've seen a lot of disassembler libraries etc. go stale as the
> owner cannot keep up.
> 
> The only semi official maintained descriptions are the XED tables (but those
> don't have descriptions) or the PDFs from Intel/AMD.
> I suppose could have some hack that talks to a PDF reader and automatically
> downloads/searches the PDF.
> 
> If unofficial is ok I would rather port some functionality
> from https://github.com/HJLebbink/asm-dude
> which has a lot of cool stuff.
> 
> -Andi
