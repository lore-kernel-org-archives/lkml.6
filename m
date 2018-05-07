Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEGTTC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:19:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeEGTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:19:01 -0400
Date: Mon, 7 May 2018 12:18:57 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Huaisheng Ye <yehs1@lenovo.com>, Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, chengnt@lenovo.com,
        pasha.tatashin@oracle.com, Sasha Levin <alexander.levin@verizon.com>,
        Linux MM <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, colyli@suse.de,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem) zone
Message-ID: <20180507191857.GA15604@bombadil.infradead.org>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
 <20180507184622.GB12361@bombadil.infradead.org>
 <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 11:57:10AM -0700, Dan Williams wrote:
> I think adding yet one more mm-zone is the wrong direction. Instead,
> what we have been considering is a mechanism to allow a device-dax
> instance to be given back to the kernel as a distinct numa node
> managed by the VM. It seems it times to dust off those patches.

I was wondering how "safe" we think that ability is.  NV-DIMM pages
(obviously) differ from normal pages by their non-volatility.  Do we
want their contents from the previous boot to be observable?  If not,
then we need the BIOS to clear them at boot-up, which means we would
want no kernel changes at all; rather the BIOS should just describe
those pages as if they were DRAM (after zeroing them).
