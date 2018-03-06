Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbeCFRxh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:53:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:16110 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFRxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:53:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="32864010"
Date: Tue, 6 Mar 2018 09:53:20 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ilya Pronin <ipronin@twitter.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
Message-ID: <20180306175320.GE25017@tassilo.jf.intel.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
 <20180306170011.GD25017@tassilo.jf.intel.com>
 <CAM_iQpUfRMW4aGfaTdFqCRwuuLXFX69Aewg+k-aa6BMUKSrhTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpUfRMW4aGfaTdFqCRwuuLXFX69Aewg+k-aa6BMUKSrhTA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the output from your own commit:
> 
>       423470,,stalled-cycles-frontend,509102,100.00,65.69,frontend cycles idle
>       <not supported>,,stalled-cycles-backend,0,100.00,,,,
> 
> so line 1 has 7 fields, line 2 has 9 fields, and this is expected?

If you had metrics on line 1 it would be correct.

So you just shifted it to break that case.

If you always want to have the same number of fields
you need to add two empty fields to the normal output
when there are no metrics.

-Andi
