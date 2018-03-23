Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCWPRn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:17:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751831AbeCWPRm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:17:42 -0400
Date: Fri, 23 Mar 2018 16:17:39 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf util: Display warning when perf report/annotate is
 missing some libs
Message-ID: <20180323151739.GC4096@krava>
References: <1515668586-14327-1-git-send-email-yao.jin@linux.intel.com>
 <20180111153028.GB20406@krava>
 <ef52d9de-54b6-88a6-625d-bd048a098222@linux.intel.com>
 <42a90e87-f2fd-293d-bd25-591fcdff14e1@linux.intel.com>
 <20180321153807.GA2707@krava>
 <e02a4bff-78e3-67b4-29b4-e0c7c4cd8ea2@linux.intel.com>
 <20180322085147.GI2707@krava>
 <5f7ae627-572d-fc02-e9ea-ec56b640c636@linux.intel.com>
 <20180323145049.GF4229@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323145049.GF4229@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 11:50:49AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > > I just don't like the idea that when you run perf report,
> > > or annotate it spits out lines for every missing feature
> > > 
> > > maybe we could detect missing features for given command
> > > and display line about missing features and say something
> > > like:
> > > 
> > > 'Warning: symbol,dwarf support not compiled in (for more details run perf -vv)'
> > > 
> > > or somwthing like that.. ;-)
> > > 
> > > jirka
> > > 
> > 
> > Hi Jiri,
> > 
> > I think your idea is very good!
> > 
> > I guess following it's just an example copied from perf building process,
> > right?

yes

> > 
> > $ ./perf -vv
> > perf version 4.16.rc6.g18fd48
> > 
> >                  dwarf: [ on  ]
> >     dwarf_getlocations: [ on  ]
> >                  glibc: [ on  ]
> >                   gtk2: [ on  ]
> >               libaudit: [ on  ]
> >                 libbfd: [ on  ]
> >                 libelf: [ on  ]
> >                libnuma: [ on  ]
> > numa_num_possible_cpus: [ on  ]
> >                libperl: [ on  ]
> >              libpython: [ on  ]
> >               libslang: [ on  ]
> >              libcrypto: [ on  ]
> >              libunwind: [ on  ]
> >     libdw-dwarf-unwind: [ on  ]
> >                   zlib: [ on  ]
> >                   lzma: [ on  ]
> >              get_cpuid: [ on  ]
> >                    bpf: [ on  ]
> > 
> > We can check some CFLAGS like "#ifdef HAVE_XXX" in perf code to determine if
> > some libraries are compiled in.
> > 
> > For example,
> > 
> > #ifdef HAVE_LIBNUMA_SUPPORT
> > 	printf("libnuma: [ on  ]");
> > #endif

please display also the OFF status, to mirror the build output

#ifdef HAVE_LIBNUMA_SUPPORT
	printf("libnuma: [ on  ]");
#else
	printf("libnuma: [ OFF ]");
#endif

or in some other smarter way..

> > 
> > For some features, such as "numa_num_possible_cpus", which doesn't have
> > CFLAGS variables. Maybe we can ignore them in report?
> > 
> > I'd like to upgrade my patch to support perf -vv.
> 
> Please go ahead! :-) We're all on the same page now, I think.

yes ;-)

jirka
