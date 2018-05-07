Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeEGSkI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:40:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:11590 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbeEGSkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:40:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,375,1520924400";
   d="scan'208";a="38098397"
Date: Mon, 7 May 2018 11:40:01 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Josh Hunt <johunt@akamai.com>
Cc: mingo@redhat.com, acme@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, wangnan0@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] perf tools: allow map files to specify DSO
Message-ID: <20180507184001.GE4050@tassilo.jf.intel.com>
References: <1525717456-21475-1-git-send-email-johunt@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525717456-21475-1-git-send-email-johunt@akamai.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 02:24:16PM -0400, Josh Hunt wrote:
> Add the ability to specify a DSO in the /tmp/perf-<PID>.map file.
> The DSO should be the first line in the file and readable by the
> running user. If a valid DSO is found all other contents of the
> file will be ignored. This allows things like callchain unwinding
> with DWARF to work.

FWIW it's ok, but also obsolete with Kirill's large-pages-in-tmpfs
work in newer kernels. With that you can just copy the executable into
a 2MB tmpfs and disable the manual huge page copying and everything
should work as usually.

So essentially it's only a hack for old kernels and old binaries.

But doesn't hurt I guess.

-Andi
