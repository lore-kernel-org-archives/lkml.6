Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeCZJHK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:07:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750955AbeCZJHJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:07:09 -0400
Date: Mon, 26 Mar 2018 11:07:04 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/3] Support perf -vv
Message-ID: <20180326090704.GH6207@krava>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <20180326090031.GN13724@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326090031.GN13724@tassilo.jf.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 02:00:31AM -0700, Andi Kleen wrote:
> On Tue, Mar 27, 2018 at 12:07:01AM +0800, Jin Yao wrote:
> > We keep having bug reports that when users build perf on their own,
> > but they don't install some needed libraries such as libelf,
> > libbfd/libibery.
> > 
> > The perf can build, but it is missing important functionality. And
> > users may complain that perf has issue or bug. 
> > 
> > This patch-set support 'perf -vv' which will print the compiled-in
> > status of libraries. Once users think perf missing some functionality,
> > it should be very easy for them to check the libraries status.
> 
> I don't think this solves the problem. How should the user know
> that they need to run perf -vv. Also normal users don't know
> that libelf is needed for symbols for example.
> 
> We need a warning that is visible together with the symbols
> and that clearly describes the problem.

IIRC we decided to go *with* the message in the perf report
or other affected command that would suggest to run 'perf -vv'
for more details

jirka

> 
> -Andi
> 
> > 
> > For example:
> > 
> > $ ./perf -vv
> > perf version 4.13.rc5.g9b7a81b
> >                  dwarf: [  on ]
> >     dwarf_getlocations: [  on ]
> >                  glibc: [  on ]
> >                   gtk2: [  on ]
> >               libaudit: [ off ]
> >                 libbfd: [  on ]
> >                 libelf: [  on ]
> >                libnuma: [  on ]
> > numa_num_possible_cpus: [  on ]
> >                libperl: [  on ]
> >              libpython: [  on ]
> >               libslang: [  on ]
> >              libcrypto: [  on ]
> >              libunwind: [  on ]
> >     libdw-dwarf-unwind: [  on ]
> >                   zlib: [  on ]
> >                   lzma: [  on ]
> >              get_cpuid: [  on ]
> >                    bpf: [  on ]
> > 
> > Jin Yao (3):
> >   perf config: Add -DNO_GLIBC to CFLAGS
> >   perf version: Print the status of compiled-in libraries
> >   perf: Support perf -vv
> > 
> >  tools/perf/Makefile.config   |   2 +
> >  tools/perf/builtin-version.c | 125 +++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/builtin.h         |   1 +
> >  tools/perf/perf.c            |   6 +++
> >  4 files changed, 134 insertions(+)
> > 
> > -- 
> > 2.7.4
> > 
