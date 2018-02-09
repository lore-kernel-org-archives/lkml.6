Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBIPPx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:15:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeBIPPw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:15:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F148B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Feb 2018 12:15:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf report: Fix wrong jump arrow
Message-ID: <20180209151549.GL3451@kernel.org>
References: <1517223473-14750-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517223473-14750-1-git-send-email-yao.jin@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 29, 2018 at 06:57:53PM +0800, Jin Yao escreveu:
> When we use perf report interactive annotate view, we can see
> the position of jump arrow is not correct. For example,
> 
> 1. perf record -b ...
> 2. perf report
> 3. In interactive mode, select Annotate 'function'
> 
> Percent│ IPC Cycle
>        │                                if (flag)
>   1.37 │0.4┌──   1      ↓ je     82
>        │   │                                    x += x / y + y / x;

Applied and added this to the cset log, please check:

Committer notes:

Please note that only from LBRv5 (according to Jiri) onwards, i.e. >=
Skylake is that we'll have the cycles counts in each branch record
entry, so to see the Cycles and IPC columns, and be able to test this
patch, one need a capable hardware.

While applying this I first tested it on a Broadwell class machine and
couldn't get those columns, will add code to the annotate browser to
warn the user about that, i.e. you have branch records, but no cycles,
use a more recent hardware to get the cycles and IPC columns.

- Arnaldo
