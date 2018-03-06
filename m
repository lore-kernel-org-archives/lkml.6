Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbeCFS5g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:57:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:35778 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753308AbeCFS5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:57:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="35972688"
Date: Tue, 6 Mar 2018 10:57:19 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>, Ilya Pronin <ipronin@twitter.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
Message-ID: <20180306185719.GF25017@tassilo.jf.intel.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
 <20180306170011.GD25017@tassilo.jf.intel.com>
 <20180306173006.GB2213@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306173006.GB2213@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> My understanding was that at some place there is a if/else
> 
> 	if (supported counters)
> 		fprintf_something with N fields, all filled in
>         else
> 		fprintf_empty_fields with != N fields
> 
> So I think this is not about using things like 'a,b,,,,,,' but about
> using different number of commas (fields) for supported/unsupported
> counters, no?

I believe it's only about empty fields at the end. I don't think
we ever get the columns wrong.

The original patch just moved the problem because there are still
cases where we can output different number of columns. 

If a tool looks only at the first row to allocate the number of columns 
it might error out if there are lines with more columns later. 

All outputs have to be padded to the maximum number of columns,
so removing columns is never the right fix.

-Andi
