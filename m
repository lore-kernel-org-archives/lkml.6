Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934023AbeCGREi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:04:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:18004 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933487AbeCGRE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:04:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="23286036"
Date: Wed, 7 Mar 2018 09:04:11 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ilya Pronin <ipronin@twitter.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
Message-ID: <20180307170411.GI25017@tassilo.jf.intel.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
 <20180306170011.GD25017@tassilo.jf.intel.com>
 <CAM_iQpUfRMW4aGfaTdFqCRwuuLXFX69Aewg+k-aa6BMUKSrhTA@mail.gmail.com>
 <20180306175320.GE25017@tassilo.jf.intel.com>
 <CAM_iQpVQs0YTckbo9F0zjPsSL+=ksVZvdcLO-QHTONcZc84eKg@mail.gmail.com>
 <CA+Xn3kw2FZ4m1TossMT35KKJ7EsSV=ykdWKCHtjRs1oefdXWNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Xn3kw2FZ4m1TossMT35KKJ7EsSV=ykdWKCHtjRs1oefdXWNw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 12:31:03PM -0800, Ilya Pronin wrote:
> Speaking from the user's seat. An optional (not just empty) cgroup
> field is fine as long it consistently appears when requested with -G
> option. The problem with print_metric_csv() was that in the case of
> unsupported counters 2 additional empty fields in the output are
> completely unexpected and not documented anywhere.
> 
> Andi, in the output example in your commit
> 92a61f6412d3a09d6462252a522fa79c9290f405 stalled-cycles-backend event
> has counter run time field, counter run time percentage field, empty
> metric value, empty metric unit, and then 2 other empty fields. Are
> they expected? If yes, what are they and why other events, e.g.

No two extra empty fields are not expected. All lines should
have the same number of fields so that a tool that looks
at the first like can keep using the same number.

But I don't think that was it what the patch fixed, or did I 
misread it?

-Andi
