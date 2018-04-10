Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeDJPdU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:33:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:33422 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbeDJPdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:33:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,432,1517904000";
   d="scan'208";a="32578637"
Date: Tue, 10 Apr 2018 21:07:18 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Frank Mori Hess <fmh6jj@gmail.com>
Cc: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: pl330: flush before wait, and add dev
 burst support.
Message-ID: <20180410153718.GS6014@localhost>
References: <20180311150151.GB15443@localhost>
 <2863317.1ZoR41yQkl@bear>
 <CAJz5OpdV1=L3fsQESZusAp8Cir9wE-VqPXqBa=zOGjBcPE78DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJz5OpdV1=L3fsQESZusAp8Cir9wE-VqPXqBa=zOGjBcPE78DA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 08:41:18PM -0400, Frank Mori Hess wrote:
> On Tue, Mar 13, 2018 at 2:34 PM, Frank Mori Hess <fmh6jj@gmail.com> wrote:
> > Do DMAFLUSHP _before_ the first DMAWFP to ensure controller
> > and peripheral are in agreement about dma request state before first
> > transfer.  Add support for burst transfers to/from peripherals. In the new
> > scheme, the controller does as many burst transfers as it can then
> > transfers the remaining dregs with either single transfers for
> > peripherals, or with a reduced size burst for memory-to-memory transfers.
> 
> Hi, what is the state of this patch?  I just noticed in patchwork it
> is now listed as "Not applicable"?  The original broken-by-wordwrap
> patch is listed as "Accepted"?
> 
> https://patchwork.kernel.org/project/linux-dmaengine/list/?submitter=178687&state=*

That is not correct state, my script would update as not applicable when it
doesn't find patch in my queue..

> I found it has a bug handling dregs btw, I'll include a fix for that
> in the next version or as a follow-on patch as appropriate.

Looks like I have missed this one somehow, so please update the patch with
fix and I shall look into it.

Thanks

-- 
~Vinod
