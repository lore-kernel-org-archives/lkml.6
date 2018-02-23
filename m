Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935743AbeBWTE0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:04:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:30784 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933966AbeBWTEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:04:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="206556621"
Date: Fri, 23 Feb 2018 11:02:04 -0800
From: Dongwon Kim <dongwon.kim@intel.com>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org, sumit.semwal@linaro.org,
        dri-devel@lists.freedesktop.org, mateuszx.potrola@intel.com
Subject: Re: [Xen-devel] [RFC PATCH v2 2/9] hyper_dmabuf: architecture
 specification and reference guide
Message-ID: <20180223190204.GA28019@downor-Z87X-UD5H>
References: <20180214015008.9513-1-dongwon.kim@intel.com>
 <20180214015008.9513-3-dongwon.kim@intel.com>
 <20180223161500.xpbqnpsxihoxi5o4@MacBook-Pro-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180223161500.xpbqnpsxihoxi5o4@MacBook-Pro-de-Roger.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comment, Roger
I will try to polish this doc and resubmit.
(I put some comments below as well.)

On Fri, Feb 23, 2018 at 04:15:00PM +0000, Roger Pau Monné wrote:
> On Tue, Feb 13, 2018 at 05:50:01PM -0800, Dongwon Kim wrote:
> > Reference document for hyper_DMABUF driver
> > 
> > Documentation/hyper-dmabuf-sharing.txt
> 
> This should likely be patch 1 in order for reviewers to have the
> appropriate context.
> 
> > 
> > Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> > ---
> >  Documentation/hyper-dmabuf-sharing.txt | 734 +++++++++++++++++++++++++++++++++
> >  1 file changed, 734 insertions(+)
> >  create mode 100644 Documentation/hyper-dmabuf-sharing.txt
> > 
> > diff --git a/Documentation/hyper-dmabuf-sharing.txt b/Documentation/hyper-dmabuf-sharing.txt
> > new file mode 100644
> > index 000000000000..928e411931e3
> > --- /dev/null
> > +++ b/Documentation/hyper-dmabuf-sharing.txt
> > @@ -0,0 +1,734 @@
> > +Linux Hyper DMABUF Driver
> > +
> > +------------------------------------------------------------------------------
> > +Section 1. Overview
> > +------------------------------------------------------------------------------
> > +
> > +Hyper_DMABUF driver is a Linux device driver running on multiple Virtual
> > +achines (VMs), which expands DMA-BUF sharing capability to the VM environment
> > +where multiple different OS instances need to share same physical data without
> > +data-copy across VMs.
> > +
> > +To share a DMA_BUF across VMs, an instance of the Hyper_DMABUF drv on the
> > +exporting VM (so called, “exporter”) imports a local DMA_BUF from the original
> > +producer of the buffer,
> 
> The usage of export and import in the above sentence makes it almost
> impossible to understand.

Ok, it looks confusing. I think the problem is that those words are used for both
local and cross-VMs cases. I will try to clarify those. 

> 
> > then re-exports it with an unique ID, hyper_dmabuf_id
> > +for the buffer to the importing VM (so called, “importer”).
> 
> And this is even worse.
> 
> Maybe it would help to have some kind of flow diagram of all this
> import/export operations, but please read below.

I will add a diagram here.

> 
> > +
> > +Another instance of the Hyper_DMABUF driver on importer registers
> > +a hyper_dmabuf_id together with reference information for the shared physical
> > +pages associated with the DMA_BUF to its database when the export happens.
> > +
> > +The actual mapping of the DMA_BUF on the importer’s side is done by
> > +the Hyper_DMABUF driver when user space issues the IOCTL command to access
> > +the shared DMA_BUF. The Hyper_DMABUF driver works as both an importing and
> > +exporting driver as is, that is, no special configuration is required.
> > +Consequently, only a single module per VM is needed to enable cross-VM DMA_BUF
> > +exchange.
> 
> IMHO I need a more generic view of the problem you are trying to solve
> in the overview section. I've read the full overview, and I still have
> no idea why you need all this.

I will add some more paragrahs here to give some more generic view (and possibly
diagrams) of this driver.

> 
> I think the overview should contain at least:
> 
> 1. A description of the problem you are trying to solve.
> 2. A high level description of the proposed solution.
> 3. How the proposed solution deals with the problem described in 1.
> 
> This overview is not useful for people that don't know which problem
> you are trying to solve, like myself.

Thanks again.

> 
> Thanks, Roger.
