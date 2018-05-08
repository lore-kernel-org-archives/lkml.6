Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2166636-1525756321-2-16610554262977328739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525756321; b=lUUkmspOhO5HpSlenbGiW0LEegJck3U6osd6ZD5V3p4fMrwcSa
    3bX9Qz2ZrzY7mx/8rE9y1KeA7WSHZWgOltoqxjhScYv8AEOyvKjWbghjLqrhl3ka
    k3LuwbmZxD4v017t81JzrIQ3g4TISQZHBe5429kCuokiO3QBF2sw2wJ/bh/D0uOC
    7/ht1fqPBBlxX6Ch2dSX7+zKosLKK7u1zWas835AJowG9OKu1h78YGxaz8iI35o0
    /paVs3esANCltKUdJaWFNHQ67m+iH9AhQxXod2qPAngquh8u9M9Ez3L9wnTsOqR4
    aEbLHDtmUAmVDKvwA5jI6DFjBTPIetB7Ywqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525756321; bh=KfX2Sj1gmJ4VzS8LjQXO8ZmdIW/NwaotVy5CNk6fMu
    E=; b=Znxc12T69txWyftmrBHKGlNLVqSgyets5W2YL019Gqg7zEQV8QhsiP4uUr
    DaeUswafLHU2S5BN0Ayv+lv+cpCsYf5HBUsWBcDDNx6jp2AG9HK7YBTeTmXVwydJ
    ux33ezYD7Hdvri0e93m+oU0hy80mD3nQ5xoznVsC/Zkj3wzakkUdETgJFASFd6Ni
    XdyMcK5WM+7BL+p8mcoMYY5ZExgWoXj15uzJqW3q3giJG3AAPhcu3j1vHKuxo2+0
    mMPrntjyFszebe/vwNcQgTIJDx0pn4NM2LFqc4SunlSOadnDMP3tOwpCRIK/gWeZ
    BdwbZA0/7dYjUl0BOK/a3iIR7tsg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=SXZOoSWT x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=siRy7jTr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=SXZOoSWT x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=siRy7jTr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOHolwRPOsHlVwb2GB8aX2bEmb3T9ebJy+vKe1Z9tFoC16xG5Es+SN2fzSUWIhYauw512K/6GB81aAaD4tgYI9b4o7tPaXmITa5DvT1t97+I0ZhiOXPi
    pyN8saOyVW/YwY8nAGdZGG68G5GE7FLAWyvRspgl3o7uN03Z0OTccRoeOfA7WemaI2zd6rFFxTtdNDpILHhG3pGqdEc46X5CZ9QeFEZEEQxV6HAA5PoN8Ke6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=6Y5ik2Ok9E24_ZOrMsYA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeEHFLr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 01:11:47 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44252 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeEHFLq (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 8 May 2018 01:11:46 -0400
X-Google-Smtp-Source: AB8JxZrQcXclpbZBMy0wsJD66m68S/7xqvGtj2tlpQN31Q36RhWP9KpKkCVrjXT9kUfqzuqFHIQ5vv0Q9DyBwh4qpDI=
MIME-Version: 1.0
In-Reply-To: <1525748846-7767-2-git-send-email-william.wu@rock-chips.com>
References: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com> <1525748846-7767-2-git-send-email-william.wu@rock-chips.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 7 May 2018 22:11:43 -0700
Message-ID: <CAD=FV=VKBVp++gPXzYN0N46NVarPNWqs1YZjfcd7twkU25WNyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] usb: dwc2: alloc dma aligned buffer for isoc split in
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
        zsq@rock-chips.com,
        =?UTF-8?B?6Kix5ZiJ6YqY?= <Allen.Hsu@quantatw.com>,
        Stan Tsui <StanTsui@aopen.com>,
        =?UTF-8?B?U3BydWNlIFd1ICjlkLPlu7rli7Mp?= <Spruce.Wu@quantatw.com>,
        Martin.Tsai@quantatw.com, Kevin.Shai@quantatw.com,
        =?UTF-8?B?TW9uLUplciBXdSAo5ZCz5a2f5ZOyKQ==?=
        <Mon-Jer.Wu@quantatw.com>,
        =?UTF-8?B?Q2xhdWQgQ2hhbmcgKOW8teaBreeviSk=?=
        <Claud.Chang@quantatw.com>,
        =?UTF-8?B?U2FuIExpbiAo5p6X5bu66I+xKQ==?= <San.Lin@quantatw.com>,
        Ren.Kuo@quantatw.com, "David H.T. Wang" <davidhtwang@aopen.com>,
        Fong Lin <fonglin@aopen.com>,
        Steven Cheng <stevencheng@aopen.com>,
        Tom Chen <tomchen@aopen.com>, donchang@aopen.com,
        milesschofield@aopen.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Mon, May 7, 2018 at 8:07 PM, William Wu <william.wu@rock-chips.com> wrote:
> +static int dwc2_alloc_split_dma_aligned_buf(struct dwc2_hsotg *hsotg,
> +                                           struct dwc2_qh *qh,
> +                                           struct dwc2_host_chan *chan)
> +{
> +       if (!hsotg->unaligned_cache)
> +               return -ENOMEM;
> +
> +       if (!qh->dw_align_buf) {
> +               qh->dw_align_buf = kmem_cache_alloc(hsotg->unaligned_cache,
> +                                                   GFP_ATOMIC | GFP_DMA);
> +               if (!qh->dw_align_buf)
> +                       return -ENOMEM;
> +
> +               qh->dw_align_buf_size = min_t(u32, chan->max_packet,
> +                                             DWC2_KMEM_UNALIGNED_BUF_SIZE);

Rather than using min_t, wouldn't it be better to return -ENOMEM if
"max_packet" > DWC2_KMEM_UNALIGNED_BUF_SIZE?  As it is, you might
allocate less space than you need, right?  That seems like it would be
bad (even though this is probably impossible).


> @@ -2797,6 +2837,32 @@ static int dwc2_assign_and_init_hc(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
>         /* Set the transfer attributes */
>         dwc2_hc_init_xfer(hsotg, chan, qtd);
>
> +       /* For non-dword aligned buffers */
> +       if (hsotg->params.host_dma && qh->do_split &&
> +           chan->ep_is_in && (chan->xfer_dma & 0x3)) {
> +               dev_vdbg(hsotg->dev, "Non-aligned buffer\n");
> +               if (dwc2_alloc_split_dma_aligned_buf(hsotg, qh, chan)) {
> +                       dev_err(hsotg->dev,
> +                               "Failed to allocate memory to handle non-aligned buffer\n");
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
> +               /*
> +                * We assume that DMA is always aligned in non-split
> +                * case or split out case. Warn if not.
> +                */
> +               WARN_ON_ONCE(hsotg->params.host_dma &&
> +                            (chan->xfer_dma & 0x3));
> +               chan->align_buf = 0;
> +       }
> +
>         if (chan->ep_type == USB_ENDPOINT_XFER_INT ||
>             chan->ep_type == USB_ENDPOINT_XFER_ISOC)
>                 /*
> @@ -5241,6 +5307,17 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>                         hsotg->params.dma_desc_enable = false;
>                         hsotg->params.dma_desc_fs_enable = false;
>                 }
> +       } else if (hsotg->params.host_dma) {

Are you sure this is "else if"?  Can't you have descriptor DMA enabled
in the controller and still need to do a normal DMA transfer if you
plug in a hub?  Seems like this should be just "if".


> +               /*
> +                * Create kmem caches to handle non-aligned buffer
> +                * in Buffer DMA mode.
> +                */
> +               hsotg->unaligned_cache = kmem_cache_create("dwc2-unaligned-dma",
> +                                               DWC2_KMEM_UNALIGNED_BUF_SIZE, 4,

Worth using "DWC2_USB_DMA_ALIGN" rather than 4?


> +                                               SLAB_CACHE_DMA, NULL);
> +               if (!hsotg->unaligned_cache)
> +                       dev_err(hsotg->dev,
> +                               "unable to create dwc2 unaligned cache\n");
>         }
>
>         hsotg->otg_port = 1;
> @@ -5279,6 +5356,7 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>  error4:
>         kmem_cache_destroy(hsotg->desc_gen_cache);
>         kmem_cache_destroy(hsotg->desc_hsisoc_cache);
> +       kmem_cache_destroy(hsotg->unaligned_cache);

nitty nit: freeing order should be opposite of allocation, so the new
line should be above the other two.
