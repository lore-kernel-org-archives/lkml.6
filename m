Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753750AbeEHAe0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:34:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:24709 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753505AbeEHAeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:34:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,376,1520924400";
   d="scan'208";a="53244021"
Date: Mon, 7 May 2018 17:34:16 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Josh Hunt <johunt@akamai.com>
Cc: mingo@redhat.com, acme@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, wangnan0@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2] perf tools: allow map files to specify DSO
Message-ID: <20180508003416.GG4050@tassilo.jf.intel.com>
References: <1525717456-21475-1-git-send-email-johunt@akamai.com>
 <20180507184001.GE4050@tassilo.jf.intel.com>
 <e6272e7c-25fd-0d2d-4199-fcf3ec604546@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6272e7c-25fd-0d2d-4199-fcf3ec604546@akamai.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 02:30:32PM -0700, Josh Hunt wrote:
> On 05/07/2018 11:40 AM, Andi Kleen wrote:
> > On Mon, May 07, 2018 at 02:24:16PM -0400, Josh Hunt wrote:
> > > Add the ability to specify a DSO in the /tmp/perf-<PID>.map file.
> > > The DSO should be the first line in the file and readable by the
> > > running user. If a valid DSO is found all other contents of the
> > > file will be ignored. This allows things like callchain unwinding
> > > with DWARF to work.
> > 
> > FWIW it's ok, but also obsolete with Kirill's large-pages-in-tmpfs
> > work in newer kernels. With that you can just copy the executable into
> > a 2MB tmpfs and disable the manual huge page copying and everything
> > should work as usually.
> > 
> > So essentially it's only a hack for old kernels and old binaries.
> > 
> > But doesn't hurt I guess.
> 
> Ah, very interesting. I wasn't aware of this. Can you point me to some more
> details on this process?

See commit 5a6e75f8110c97e2a5488894d4e922187e6cb343

-Andi
