Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeEBObP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:31:15 -0400
Received: from mail.netline.ch ([148.251.143.178]:36142 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEBObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:31:13 -0400
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
To: Christoph Hellwig <hch@lst.de>, Daniel Vetter <daniel@ffwll.ch>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        iommu@lists.linux-foundation.org
References: <20180501132411.2311-1-michel@daenzer.net>
 <786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com>
 <CAKMK7uH2+v3_UUqXdCjz_8=H4VRt1zB+dgE99PuuPqd+XM2=-w@mail.gmail.com>
 <20180502124151.GA22857@lst.de>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <1066dfa2-2f78-815d-c65a-9d09eb35458c@daenzer.net>
Date: Wed, 2 May 2018 16:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502124151.GA22857@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-02 02:41 PM, Christoph Hellwig wrote:
> On Wed, May 02, 2018 at 02:18:56PM +0200, Daniel Vetter wrote:
>> Other dma-api backends like cma just shut up when __GFP_NOWARN is
>> passed. And afaiui Christoph Hellwig has plans to nuke the DMA_ATTR
>> stuff (or at least clean it up) - should we just remove
>> DMA_ATTR_NO_WARN and instead only look at __GFP_NOWARN?
> 
> No.  __GFP_NOWARN (and gfp_t flags in general) are the wrong interface
> for dma allocations and just cause problems.  I actually plan to
> get rid of the gfp_t argument in dma_alloc_attrs sooner, and only
> allow either GFP_KERNEL or GFP_DMA passed in dma_alloc_coherent.

How about GFP_TRANSHUGE_LIGHT? TTM uses that to opportunistically
allocate huge pages (GFP_TRANSHUGE can result in unacceptably long
delays with memory pressure).


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
