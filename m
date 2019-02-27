Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF6BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767B7218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551256796;
	bh=q39vvcCHlNCZBBZkUVJhAUUVFj0tBpcr29VxQESufmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=weLURx5Yk7NOW5ABOhPDbn9eD11wJLtCVA+FbzKVHRbASVV6/hHmYO8vjVn/YUL5F
	 g51vcrzA8uZMsjD2CO2hn5n9EB40VPcP0z3as55JLcGtuvcIVwlCuwMI00Brryn9qX
	 sgIs86dxCyiLrdmMXpff6TiqmcbGIpYR5wUCxAEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfB0Ijy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:39:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfB0Ijy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:39:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67379218C3;
        Wed, 27 Feb 2019 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551256792;
        bh=q39vvcCHlNCZBBZkUVJhAUUVFj0tBpcr29VxQESufmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1ExqZuDmcq+mIfgfb/VTbtp5P2UAqWlH2DBwsBXMO+aM8YrC5HNLPz7Punrbm9KF
         W2O+mPQjho3vC6IxvcNRnwTTH/ZkhwsHY90+yRisBl3SC4XTAEQw6DowTbGdAxxf/m
         2k/39oiXs+9l81OJP5dUcHF2T0yBG3jwCpvxdX5s=
Date:   Wed, 27 Feb 2019 09:39:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] habanalabs: goya: Make some functions static
Message-ID: <20190227083950.GC23471@kroah.com>
References: <20190227065759.21700-1-yuehaibing@huawei.com>
 <CAFCwf13G02DzJ+qhhPXHCLuuChW_=xyi6BcuAweRxEChxTwU+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13G02DzJ+qhhPXHCLuuChW_=xyi6BcuAweRxEChxTwU+Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:31:48AM +0200, Oded Gabbay wrote:
> On Wed, Feb 27, 2019 at 9:05 AM Yue Haibing <yuehaibing@huawei.com> wrote:
> >
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > Fixes the following sparse warnings:
> >
> > drivers/misc/habanalabs/goya/goya.c:1233:5: warning: symbol 'goya_init_cpu_queues' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:2914:5: warning: symbol 'goya_suspend' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:2939:5: warning: symbol 'goya_resume' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:2952:5: warning: symbol 'goya_mmap' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:2957:5: warning: symbol 'goya_cb_mmap' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:2973:6: warning: symbol 'goya_ring_doorbell' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3063:6: warning: symbol 'goya_flush_pq_write' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3068:6: warning: symbol 'goya_dma_alloc_coherent' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3074:6: warning: symbol 'goya_dma_free_coherent' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3080:6: warning: symbol 'goya_get_int_queue_base' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3138:5: warning: symbol 'goya_send_job_on_qman0' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3295:5: warning: symbol 'goya_test_queue' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3411:6: warning: symbol 'goya_dma_pool_zalloc' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3420:6: warning: symbol 'goya_dma_pool_free' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3426:6: warning: symbol 'goya_cpu_accessible_dma_pool_alloc' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3442:6: warning: symbol 'goya_cpu_accessible_dma_pool_free' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3452:5: warning: symbol 'goya_dma_map_sg' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3461:6: warning: symbol 'goya_dma_unmap_sg' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:3467:5: warning: symbol 'goya_get_dma_desc_list_size' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:396:5: warning: symbol 'goya_send_pci_access_msg' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:417:5: warning: symbol 'goya_pci_bars_map' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:4202:5: warning: symbol 'goya_parse_cb_no_mmu' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:4253:5: warning: symbol 'goya_parse_cb_no_ext_quque' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:4286:5: warning: symbol 'goya_cs_parser' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:4299:6: warning: symbol 'goya_add_end_of_cb_packets' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:557:6: warning: symbol 'goya_reset_link_through_bridge' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:774:5: warning: symbol 'goya_early_fini' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:857:6: warning: symbol 'goya_late_fini' was not declared. Should it be static?
> > drivers/misc/habanalabs/goya/goya.c:971:5: warning: symbol 'goya_sw_fini' was not declared. Should it be static?
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/misc/habanalabs/goya/goya.c | 86 +++++++++++++++++++------------------
> >  1 file changed, 44 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> > index fc53cdb..e0f1ba6 100644
> > --- a/drivers/misc/habanalabs/goya/goya.c
> > +++ b/drivers/misc/habanalabs/goya/goya.c
> > @@ -393,7 +393,7 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
> >         prop->high_pll = PLL_HIGH_DEFAULT;
> >  }
> >
> > -int goya_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
> > +static int goya_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
> >  {
> >         struct armcp_packet pkt;
> >
> > @@ -414,7 +414,7 @@ int goya_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
> >   * Returns 0 on success
> >   *
> >   */
> > -int goya_pci_bars_map(struct hl_device *hdev)
> > +static int goya_pci_bars_map(struct hl_device *hdev)
> >  {
> >         struct pci_dev *pdev = hdev->pdev;
> >         int rc;
> > @@ -554,7 +554,7 @@ static int goya_iatu_write(struct hl_device *hdev, u32 addr, u32 data)
> >         return 0;
> >  }
> >
> > -void goya_reset_link_through_bridge(struct hl_device *hdev)
> > +static void goya_reset_link_through_bridge(struct hl_device *hdev)
> >  {
> >         struct pci_dev *pdev = hdev->pdev;
> >         struct pci_dev *parent_port;
> > @@ -771,7 +771,7 @@ static int goya_early_init(struct hl_device *hdev)
> >   * Unmap PCI bars
> >   *
> >   */
> > -int goya_early_fini(struct hl_device *hdev)
> > +static int goya_early_fini(struct hl_device *hdev)
> >  {
> >         goya_pci_bars_unmap(hdev);
> >
> > @@ -854,7 +854,7 @@ static int goya_late_init(struct hl_device *hdev)
> >   *
> >   * Free sensors allocated structures
> >   */
> > -void goya_late_fini(struct hl_device *hdev)
> > +static void goya_late_fini(struct hl_device *hdev)
> >  {
> >         const struct hwmon_channel_info **channel_info_arr;
> >         int i = 0;
> > @@ -968,7 +968,7 @@ static int goya_sw_init(struct hl_device *hdev)
> >   * @hdev: pointer to hl_device structure
> >   *
> >   */
> > -int goya_sw_fini(struct hl_device *hdev)
> > +static int goya_sw_fini(struct hl_device *hdev)
> >  {
> >         struct goya_device *goya = hdev->asic_specific;
> >
> > @@ -1230,7 +1230,7 @@ static void goya_resume_external_queues(struct hl_device *hdev)
> >   * Returns 0 on success
> >   *
> >   */
> > -int goya_init_cpu_queues(struct hl_device *hdev)
> > +static int goya_init_cpu_queues(struct hl_device *hdev)
> >  {
> >         struct goya_device *goya = hdev->asic_specific;
> >         struct hl_eq *eq;
> > @@ -2911,7 +2911,7 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
> >         }
> >  }
> >
> > -int goya_suspend(struct hl_device *hdev)
> > +static int goya_suspend(struct hl_device *hdev)
> >  {
> >         int rc;
> >
> > @@ -2936,7 +2936,7 @@ int goya_suspend(struct hl_device *hdev)
> >         return rc;
> >  }
> >
> > -int goya_resume(struct hl_device *hdev)
> > +static int goya_resume(struct hl_device *hdev)
> >  {
> >         int rc;
> >
> > @@ -2949,13 +2949,13 @@ int goya_resume(struct hl_device *hdev)
> >         return rc;
> >  }
> >
> > -int goya_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
> > +static int goya_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
> >  {
> >         return -EINVAL;
> >  }
> >
> > -int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> > -               u64 kaddress, phys_addr_t paddress, u32 size)
> > +static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> > +                       u64 kaddress, phys_addr_t paddress, u32 size)
> >  {
> >         int rc;
> >
> > @@ -2970,7 +2970,7 @@ int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> >         return rc;
> >  }
> >
> > -void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
> > +static void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
> >  {
> >         u32 db_reg_offset, db_value;
> >         bool invalid_queue = false;
> > @@ -3060,25 +3060,25 @@ void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
> >                                 GOYA_ASYNC_EVENT_ID_PI_UPDATE);
> >  }
> >
> > -void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val)
> > +static void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val)
> >  {
> >         /* Not needed in Goya */
> >  }
> >
> > -void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
> > -                                       dma_addr_t *dma_handle, gfp_t flags)
> > +static void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
> > +                                    dma_addr_t *dma_handle, gfp_t flags)
> >  {
> >         return dma_alloc_coherent(&hdev->pdev->dev, size, dma_handle, flags);
> >  }
> >
> > -void goya_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
> > -                               dma_addr_t dma_handle)
> > +static void goya_dma_free_coherent(struct hl_device *hdev, size_t size,
> > +                                  void *cpu_addr, dma_addr_t dma_handle)
> >  {
> >         dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, dma_handle);
> >  }
> >
> > -void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
> > -                               dma_addr_t *dma_handle, u16 *queue_len)
> > +static void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
> > +                                    dma_addr_t *dma_handle, u16 *queue_len)
> >  {
> >         void *base;
> >         u32 offset;
> > @@ -3135,7 +3135,7 @@ void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
> >         return base;
> >  }
> >
> > -int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
> > +static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
> >  {
> >         struct goya_device *goya = hdev->asic_specific;
> >         struct packet_msg_prot *fence_pkt;
> > @@ -3214,7 +3214,7 @@ int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
> >  }
> >
> >  int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
> > -                               u32 timeout, long *result)
> > +                         u32 timeout, long *result)
> >  {
> >         struct goya_device *goya = hdev->asic_specific;
> >         struct armcp_packet *pkt;
> > @@ -3292,7 +3292,7 @@ int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
> >         return rc;
> >  }
> >
> > -int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
> > +static int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
> >  {
> >         struct packet_msg_prot *fence_pkt;
> >         dma_addr_t pkt_dma_addr;
> > @@ -3414,8 +3414,8 @@ static int goya_test_queues(struct hl_device *hdev)
> >         return ret_val;
> >  }
> >
> > -void *goya_dma_pool_zalloc(struct hl_device *hdev, size_t size, gfp_t mem_flags,
> > -                               dma_addr_t *dma_handle)
> > +static void *goya_dma_pool_zalloc(struct hl_device *hdev, size_t size,
> > +                                 gfp_t mem_flags, dma_addr_t *dma_handle)
> >  {
> >         if (size > GOYA_DMA_POOL_BLK_SIZE)
> >                 return NULL;
> > @@ -3423,14 +3423,15 @@ void *goya_dma_pool_zalloc(struct hl_device *hdev, size_t size, gfp_t mem_flags,
> >         return dma_pool_zalloc(hdev->dma_pool, mem_flags, dma_handle);
> >  }
> >
> > -void goya_dma_pool_free(struct hl_device *hdev, void *vaddr,
> > -                       dma_addr_t dma_addr)
> > +static void goya_dma_pool_free(struct hl_device *hdev, void *vaddr,
> > +                              dma_addr_t dma_addr)
> >  {
> >         dma_pool_free(hdev->dma_pool, vaddr, dma_addr);
> >  }
> >
> > -void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
> > -                       dma_addr_t *dma_handle)
> > +static void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev,
> > +                                               size_t size,
> > +                                               dma_addr_t *dma_handle)
> >  {
> >         u64 kernel_addr;
> >
> > @@ -3445,8 +3446,8 @@ void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
> >         return (void *) (uintptr_t) kernel_addr;
> >  }
> >
> > -void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
> > -                       void *vaddr)
> > +static void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev,
> > +                                             size_t size, void *vaddr)
> >  {
> >         /* roundup to CPU_PKT_SIZE */
> >         size = (size + (CPU_PKT_SIZE - 1)) & CPU_PKT_MASK;
> > @@ -3455,8 +3456,8 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
> >                         size);
> >  }
> >
> > -int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sg, int nents,
> > -                       enum dma_data_direction dir)
> > +static int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sg,
> > +                          int nents, enum dma_data_direction dir)
> >  {
> >         if (!dma_map_sg(&hdev->pdev->dev, sg, nents, dir))
> >                 return -ENOMEM;
> > @@ -3464,14 +3465,14 @@ int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sg, int nents,
> >         return 0;
> >  }
> >
> > -void goya_dma_unmap_sg(struct hl_device *hdev, struct scatterlist *sg,
> > -                       int nents, enum dma_data_direction dir)
> > +static void goya_dma_unmap_sg(struct hl_device *hdev, struct scatterlist *sg,
> > +                             int nents, enum dma_data_direction dir)
> >  {
> >         dma_unmap_sg(&hdev->pdev->dev, sg, nents, dir);
> >  }
> >
> > -u32 goya_get_dma_desc_list_size(struct hl_device *hdev,
> > -                                       struct sg_table *sgt)
> > +static u32 goya_get_dma_desc_list_size(struct hl_device *hdev,
> > +                                      struct sg_table *sgt)
> >  {
> >         struct scatterlist *sg, *sg_next_iter;
> >         u32 count, dma_desc_cnt;
> > @@ -4207,7 +4208,8 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
> >         return rc;
> >  }
> >
> > -int goya_parse_cb_no_mmu(struct hl_device *hdev, struct hl_cs_parser *parser)
> > +static int goya_parse_cb_no_mmu(struct hl_device *hdev,
> > +                               struct hl_cs_parser *parser)
> >  {
> >         u64 patched_cb_handle;
> >         int rc;
> > @@ -4258,7 +4260,7 @@ int goya_parse_cb_no_mmu(struct hl_device *hdev, struct hl_cs_parser *parser)
> >         return rc;
> >  }
> >
> > -int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
> > +static int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
> >                 struct hl_cs_parser *parser)
> >  {
> >         struct asic_fixed_properties *asic_prop = &hdev->asic_prop;
> > @@ -4291,7 +4293,7 @@ int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
> >         return 0;
> >  }
> >
> > -int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
> > +static int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
> >  {
> >         struct goya_device *goya = hdev->asic_specific;
> >
> > @@ -4304,8 +4306,8 @@ int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
> >                 return goya_parse_cb_no_mmu(hdev, parser);
> >  }
> >
> > -void goya_add_end_of_cb_packets(u64 kernel_address, u32 len, u64 cq_addr,
> > -                               u32 cq_val, u32 msix_vec)
> > +static void goya_add_end_of_cb_packets(u64 kernel_address, u32 len, u64 cq_addr,
> > +                                      u32 cq_val, u32 msix_vec)
> >  {
> >         struct packet_msg_prot *cq_pkt;
> >
> > --
> > 2.7.0
> >
> >
> 
> Hi,
> Thanks for this but I prefer not to merge this.
> I prefer to eliminate the warnings by adding declarations in goyaP.h
> for the above functions.
> These functions are called from different files who belong to the goya
> platform. That code has not yet been upstreamed,so when that happens,
> these functions will have to be not static.
> Therefore, no point in adding this patch now and then reverting it later.

One hint, if you do not take this patch now, people will keep sending it
over and over again :)

We don't know that you will be using these functions later, as that
patch hasn't even been posted yet.  So it's good to take this for now,
and when/if you really do need to use these functions in a future patch,
it's trivial for you to just make these non-static.

So I recommend taking this patch.

thanks,

greg k-h
