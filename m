Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033740AbeBOPKW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033445AbeBOPKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:10:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC1F217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 12:10:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Ahern <dsahern@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: Re: [PATCH 9/9] perf tests: Use arch__compare_symbol_names to
 compare symbols
Message-ID: <20180215151018.GI30974@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org>
 <20180215122635.24029-10-jolsa@kernel.org>
 <20180215142711.GH22818@kernel.org>
 <1518705799.8kkjgp6cbr.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518705799.8kkjgp6cbr.naveen@linux.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 15, 2018 at 08:18:51PM +0530, Naveen N. Rao escreveu:
> Arnaldo Carvalho de Melo wrote:
> > Em Thu, Feb 15, 2018 at 01:26:35PM +0100, Jiri Olsa escreveu:
> > > The symbol search called by machine__find_kernel_symbol_by_name
> > > is using internally arch__compare_symbol_names function to compare
> > > 2 symbol names, because different archs have different ways of
> > > comparing symbols. Mostly for skipping '.' prefixes and similar.
> > > 
> > > In test 1 when we try to find matching symbols in kallsyms and
> > > vmlinux, by address and by symbol name. When either is found
> > > we compare the pair symbol names  by simple strcmp, which is not
> > > good enough for reasons explained in previous paragraph.
> > > 
> > > On powerpc this can cause lockup, because even thought we found
> > > the pair, the compared names are different and don't match
> > > simple strcmp. Following code path is executed, that leads
> > > to lockup:
> > 
> > Added a:
> > 
> >     Fixes: 031b84c407c3 ("perf probe ppc: Enable matching against dot symbols automatically")
> > 
> > And CCed Naveen, the author of that patch, so that gets notified of this
> > fix.
> 
> Thanks! This does fix the test on ppc64 BE. So:
> Acked-and-Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks!

- Arnaldo
