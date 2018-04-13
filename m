Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754147AbeDMKE4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:04:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:29491 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754118AbeDMKEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:04:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,444,1517904000";
   d="scan'208";a="46625565"
Date: Fri, 13 Apr 2018 15:39:22 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] dmaengine: stm32-mdma: Fix incomplete Hw
 descriptors allocator
Message-ID: <20180413100921.GM6014@localhost>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com>
 <20180413040233.GJ6014@localhost>
 <CAMuHMdWNyvveQ73SDrVy=EwkkO6Gd_4hmOkdstpcgzOL44a_mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWNyvveQ73SDrVy=EwkkO6Gd_4hmOkdstpcgzOL44a_mA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 10:39:48AM +0200, Geert Uytterhoeven wrote:
> Hi Vinod,
> 
> On Fri, Apr 13, 2018 at 6:02 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Wed, Apr 11, 2018 at 04:44:39PM +0200, Pierre-Yves MORDRET wrote:
> >
> >>  struct stm32_mdma_desc {
> >>       struct virt_dma_desc vdesc;
> >>       u32 ccr;
> >> -     struct stm32_mdma_hwdesc *hwdesc;
> >> -     dma_addr_t hwdesc_phys;
> >>       bool cyclic;
> >>       u32 count;
> >> +     struct stm32_mdma_desc_node node[];
> >
> > some ppl use node[0] for this but i think either is fine..
> 
> node[] is the correct one, node[0] may hide future bugs, cfr. commit
> a158531f3c92467d ("gpio: 74x164: Fix crash during .remove()")

Yeah but it this case it is the last element. But yes it helps to avoid such
mistakes in future..

-- 
~Vinod
