Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-42162-1525235609-2-17241756780879449023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525235608; b=fGniAg6H4mAawf9Sq9ehJJznVM2YFL5LEejKpc3A4jYf/SfZrS
    L25Oswgu1t8RjNRzeQfZzpudcr8X2PsvT2yCLOVwHXsSFTLUObk4RAd9gCRqNXL3
    UszuOsorIn04QJ0Y+x4oRNRxc+bsRQfx0lAWmNmuchOccuZAKUUoTnzTz3GQBrPm
    +XaeKCCPYMs/PdVwXWdYBQztXgNsMHQ1eQheayQyeDVA6t2lArbpe+rcAvdoV4Ld
    QW2CY3nYCv/9Ra5wDgn9WzLEaEaHDca7iJ37ggJepYQGbteNhGbl6FMWVnIdDNiY
    /yVHaXO8kRrCw9nXe0slrgrMG2qMTSeuEhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525235608; bh=57LmVci6Tg3WXNW0+wWb319Fmi1sTWYe0LFCoSLR71
    I=; b=Z5g02BON16P4Pv2yLMk2vJsLYCwUT4xBTT6nj40755LIjoUpA+Hx3Xptbv
    lAWFf2Ei7ohEPx5rVRlSzjnA8mnScjACIKdFN5yHShvQSb0yghHVSsJXYjMqzQRt
    r4YQTG3NLiq8kwnV3gyO7N++tzc4Kuv+HpLZ8s0CpSOuqlT206XKZ1DGUAyzSSYC
    krGag40SwNmLJR9WrcwFVAe7CB4qXtFOYITHTOAsiy4121tFTCyDciTBEQQtcqPA
    lM2vrnylOxDiSvH9uWnuU+mC4fsHvYr5e9RtSNkauLINdFGD4lGjNpwF45MC/MtO
    t/ZucsHe3obeSdzzNWKhXWAyuTDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=e9Qb7DHs x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KupNNdTL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=e9Qb7DHs x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KupNNdTL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDvJ8jAvaRIE88EBVFQV/33k19Q07JT++8F13a5Uxkigs4vkXXJBO+ALhHck3pTgX3z5mGo61+3o09JxrG2Dd5lMUnXm2diQVCrapuuNdT0pxNmQ7Iq6
    EbiIryVcmNihhgxIrjBUusp2r3WtWq6AXQwy6YyWmQPbClaYxAEk8oQVtiZtcMHf+XG6sJwKQZQ2YKCJHywLZHo1w+Iz7mbv+07VR464GU3AKUR7DroyFmYl
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=iG3_0quYikZhQDIwXXYA:9
    a=17WDtCKw0jf77siT:21 a=hM4zBEnfnJpeSs9P:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbeEBEdP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 00:33:15 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43828 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeEBEdN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 00:33:13 -0400
X-Google-Smtp-Source: AB8JxZpP8HuWksddepq6Gu+vUDKPfgI9qjBcWqj+h7LLsQWp1RnHxXa/F3u7C69zvE8sQyh51/rAP1CWaH9L3rpcqus=
MIME-Version: 1.0
In-Reply-To: <1525230288-6014-2-git-send-email-william.wu@rock-chips.com>
References: <1525230288-6014-1-git-send-email-william.wu@rock-chips.com> <1525230288-6014-2-git-send-email-william.wu@rock-chips.com>
From: Doug Anderson <dianders@google.com>
Date: Tue, 1 May 2018 21:33:10 -0700
Message-ID: <CAD=FV=UTjLbh+Qj8JcyGa5dMH8=hFurA2qyWpi9vCJkE1_ExRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: dwc2: alloc dma aligned buffer for isoc split in
To: William Wu <william.wu@rock-chips.com>
Cc: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Frank Wang <frank.wang@rock-chips.com>,
        =?UTF-8?B?6buE5rab?= <huangtao@rock-chips.com>,
        "daniel.meng" <daniel.meng@rock-chips.com>,
        John Youn <John.Youn@synopsys.com>,
        =?UTF-8?B?546L5b6B5aKe?= <wzz@rock-chips.com>,
        zsq@rock-chips.com, Allen.Hsu@quantatw.com, StanTsui@aopen.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Tue, May 1, 2018 at 8:04 PM, William Wu <william.wu@rock-chips.com> wrote:
> The commit 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in
> a more supported way") rips out a lot of code to simply the
> allocation of aligned DMA. However, it also introduces a new
> issue when use isoc split in transfer.
>
> In my test case, I connect the dwc2 controller with an usb hs
> Hub (GL852G-12), and plug an usb fs audio device (Plantronics
> headset) into the downstream port of Hub. Then use the usb mic
> to record, we can find noise when playback.
>
> It's because that the usb Hub uses an MDATA for the first
> transaction and a DATA0 for the second transaction for the isoc
> split in transaction. An typical isoc split in transaction sequence
> like this:
>
> - SSPLIT IN transaction
> - CSPLIT IN transaction
>   - MDATA packet
> - CSPLIT IN transaction
>   - DATA0 packet
>
> The DMA address of MDATA (urb->dma) is always DWORD-aligned, but
> the DMA address of DATA0 (urb->dma + qtd->isoc_split_offset) may
> not be DWORD-aligned, it depends on the qtd->isoc_split_offset (the
> length of MDATA). In my test case, the length of MDATA is usually
> unaligned, this casue DATA0 packet transmission error.
>
> This patch base on the old way of aligned DMA allocation in the
> dwc2 driver to get aligned DMA for isoc split in.
>
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
> Changes in v2:
> - None
>
>  drivers/usb/dwc2/hcd.c       | 63 +++++++++++++++++++++++++++++++++++++++++---
>  drivers/usb/dwc2/hcd.h       | 10 +++++++
>  drivers/usb/dwc2/hcd_intr.c  |  8 ++++++
>  drivers/usb/dwc2/hcd_queue.c |  8 +++++-
>  4 files changed, 85 insertions(+), 4 deletions(-)

A word of warning that I'm pretty rusty on dwc2 and even when I was
making lots of patches I still considered myself a bit clueless.
...so if something seems wrong, please call me on it...


> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 190f959..8c2b35f 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -1562,11 +1562,20 @@ static void dwc2_hc_start_transfer(struct dwc2_hsotg *hsotg,
>         }
>
>         if (hsotg->params.host_dma) {
> -               dwc2_writel((u32)chan->xfer_dma,
> -                           hsotg->regs + HCDMA(chan->hc_num));
> +               dma_addr_t dma_addr;
> +
> +               if (chan->align_buf) {
> +                       if (dbg_hc(chan))
> +                               dev_vdbg(hsotg->dev, "align_buf\n");
> +                       dma_addr = chan->align_buf;
> +               } else {
> +                       dma_addr = chan->xfer_dma;
> +               }
> +               dwc2_writel((u32)dma_addr, hsotg->regs + HCDMA(chan->hc_num));
> +
>                 if (dbg_hc(chan))
>                         dev_vdbg(hsotg->dev, "Wrote %08lx to HCDMA(%d)\n",
> -                                (unsigned long)chan->xfer_dma, chan->hc_num);
> +                                (unsigned long)dma_addr, chan->hc_num);
>         }
>
>         /* Start the split */
> @@ -2620,6 +2629,33 @@ static void dwc2_hc_init_xfer(struct dwc2_hsotg *hsotg,
>         }
>  }
>
> +static int dwc2_alloc_split_dma_aligned_buf(struct dwc2_hsotg *hsotg,
> +                                           struct dwc2_qh *qh,
> +                                           struct dwc2_host_chan *chan)
> +{
> +       if (!qh->dw_align_buf) {
> +               qh->dw_align_buf = kmalloc(chan->max_packet,

So you're potentially doing a bounce buffer atop a bounce buffer now,
right?  That seems pretty non-optimal.  You're also back to doing a
kmalloc at interrupt time which I found was pretty bad for
performance.

Is there really no way you can do your memory allocation in
dwc2_alloc_dma_aligned_buffer() instead of here?  For input packets,
if you could just allocate an extra 3 bytes in the original bounce
buffer you could just re-use the original bounce buffer together with
a memmove?  AKA:

transfersize = 13 + 64;
buf = alloc(16 + 64);

// Do the first transfer, no problems.
dma_into(buf, 13);

// 2nd transfer isn't aligned, so align.
// we allocated a little extra to account for this
dma_into(buf + 16, 64);

// move back where it belongs.
memmove(buf + 13, buf + 16, 64);


To make the above work you'd need to still allocate a bounce buffer
even if the original "urb->transfer_buffer" was already aligned.
Ideally you'd be able to know when dwc2_alloc_dma_aligned_buffer()
that this is one of the special cases where you need a slightly
oversized bounce buffer.

---

If you somehow need to do something for output, you'd do the opposite.
You'd copy backwards top already transferred data to align.


> +                                          GFP_ATOMIC | GFP_DMA);
> +               if (!qh->dw_align_buf)
> +                       return -ENOMEM;
> +
> +               qh->dw_align_buf_size = chan->max_packet;
> +       }
> +
> +       qh->dw_align_buf_dma = dma_map_single(hsotg->dev, qh->dw_align_buf,
> +                                             qh->dw_align_buf_size,
> +                                             DMA_FROM_DEVICE);
> +
> +       if (dma_mapping_error(hsotg->dev, qh->dw_align_buf_dma)) {
> +               dev_err(hsotg->dev, "can't map align_buf\n");
> +               chan->align_buf = 0;
> +               return -EINVAL;
> +       }
> +
> +       chan->align_buf = qh->dw_align_buf_dma;
> +       return 0;
> +}
> +
>  #define DWC2_USB_DMA_ALIGN 4
>
>  struct dma_aligned_buffer {
> @@ -2797,6 +2833,27 @@ static int dwc2_assign_and_init_hc(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
>         /* Set the transfer attributes */
>         dwc2_hc_init_xfer(hsotg, chan, qtd);
>
> +       /* For non-dword aligned buffers */
> +       if (hsotg->params.host_dma > 0 && qh->do_split &&
> +           chan->ep_is_in && (chan->xfer_dma & 0x3)) {

So what happens if were unaligned (AKA (chan->xfer_dma & 0x3)) but
we're not doing split or it's not an IN EP?  Do we just fail then?

I guess the rest of this patch only handles the "in" case and maybe
you expect that the problems will only come about for do_split, but it
still might be wise to at least print a warning in the other cases?
>From reading dwc2_hc_init_xfer() it seems like you could run into this
same problem in the "out" case?


> +               dev_vdbg(hsotg->dev, "Non-aligned buffer\n");
> +               if (dwc2_alloc_split_dma_aligned_buf(hsotg, qh, chan)) {
> +                       dev_err(hsotg->dev,
> +                               "%s: Failed to allocate memory to handle non-dword aligned buffer\n",
> +                               __func__);

Here and elsewhere in this patch: In general I think policy is that
you shouldn't include __func__ for dev_err().  The string together
with the name of the device is supposed to uniquely determine where
you are.


> +                       /* Add channel back to free list */
> +                       chan->align_buf = 0;
> +                       chan->multi_count = 0;
> +                       list_add_tail(&chan->hc_list_entry,
> +                                     &hsotg->free_hc_list);
> +                       qtd->in_process = 0;
> +                       qh->channel = NULL;
> +                       return -ENOMEM;
> +               }
> +       } else {
> +               chan->align_buf = 0;
> +       }
> +
>         if (chan->ep_type == USB_ENDPOINT_XFER_INT ||
>             chan->ep_type == USB_ENDPOINT_XFER_ISOC)
>                 /*
> diff --git a/drivers/usb/dwc2/hcd.h b/drivers/usb/dwc2/hcd.h
> index 96a9da5..adf1fd0 100644
> --- a/drivers/usb/dwc2/hcd.h
> +++ b/drivers/usb/dwc2/hcd.h
> @@ -76,6 +76,8 @@ struct dwc2_qh;
>   *                      (micro)frame
>   * @xfer_buf:           Pointer to current transfer buffer position
>   * @xfer_dma:           DMA address of xfer_buf
> + * @align_buf:         In Buffer DMA mode this will be used if xfer_buf is not
> + *                     DWORD aligned

Your patch uses tabs but everything else in this comment uses spaces.
Please be consistent with surrounding code.  It looks like I may have
screwed this up in the past on the comment of "struct dwc2_qh", but
that's no reason to mess it up again...


>   * @xfer_len:           Total number of bytes to transfer
>   * @xfer_count:         Number of bytes transferred so far
>   * @start_pkt_count:    Packet count at start of transfer
> @@ -133,6 +135,7 @@ struct dwc2_host_chan {
>
>         u8 *xfer_buf;
>         dma_addr_t xfer_dma;
> +       dma_addr_t align_buf;
>         u32 xfer_len;
>         u32 xfer_count;
>         u16 start_pkt_count;
> @@ -303,6 +306,10 @@ struct dwc2_hs_transfer_time {
>   *                           is tightly packed.
>   * @ls_duration_us:     Duration on the low speed bus schedule.
>   * @ntd:                Actual number of transfer descriptors in a list
> + * @dw_align_buf:      Used instead of original buffer if its physical address
> + *                     is not dword-aligned
> + * @dw_align_buf_size: Size of dw_align_buf
> + * @dw_align_buf_dma:  DMA address for dw_align_buf
>   * @qtd_list:           List of QTDs for this QH
>   * @channel:            Host channel currently processing transfers for this QH
>   * @qh_list_entry:      Entry for QH in either the periodic or non-periodic
> @@ -350,6 +357,9 @@ struct dwc2_qh {
>         struct dwc2_hs_transfer_time hs_transfers[DWC2_HS_SCHEDULE_UFRAMES];
>         u32 ls_start_schedule_slice;
>         u16 ntd;
> +       u8 *dw_align_buf;
> +       int dw_align_buf_size;
> +       dma_addr_t dw_align_buf_dma;
>         struct list_head qtd_list;
>         struct dwc2_host_chan *channel;
>         struct list_head qh_list_entry;
> diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
> index a5dfd9d..5e2378f 100644
> --- a/drivers/usb/dwc2/hcd_intr.c
> +++ b/drivers/usb/dwc2/hcd_intr.c
> @@ -938,6 +938,14 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
>
>         frame_desc->actual_length += len;
>
> +       if (chan->align_buf) {
> +               dev_vdbg(hsotg->dev, "%s(): non-aligned buffer\n", __func__);
> +               dma_unmap_single(hsotg->dev, chan->qh->dw_align_buf_dma,
> +                                chan->qh->dw_align_buf_size, DMA_FROM_DEVICE);
> +               memcpy(qtd->urb->buf + frame_desc->offset +
> +                      qtd->isoc_split_offset, chan->qh->dw_align_buf, len);

Assuming I'm understanding this patch correctly, I think it would be
better to write:

  memcpy(qtd->xfer_dma, chan->qh->dw_align_buf, len);

Then if you ever end up having to align a transfer other than a split
you won't be doing the wrong math.  As it is it's very non-obvious
that you're hardcoding the same formula that's in dwc2_hc_init_xfer()



> +       }
> +
>         qtd->isoc_split_offset += len;
>
>         hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
> diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
> index e34ad5e..a120bb0 100644
> --- a/drivers/usb/dwc2/hcd_queue.c
> +++ b/drivers/usb/dwc2/hcd_queue.c
> @@ -1693,8 +1693,14 @@ void dwc2_hcd_qh_free(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
>
>         dwc2_host_put_tt_info(hsotg, qh->dwc_tt);
>
> -       if (qh->desc_list)
> +       if (qh->desc_list) {
>                 dwc2_hcd_qh_free_ddma(hsotg, qh);
> +       } else {
> +               /* kfree(NULL) is safe */
> +               kfree(qh->dw_align_buf);
> +               qh->dw_align_buf_dma = (dma_addr_t)0;

Why assign qh->dw_align_buf_dma to 0?  The next thing you're doing is
kfree(qh).  If you want extra debugging, turn on slub_debug.


> +       }
> +
>         kfree(qh);
>  }
