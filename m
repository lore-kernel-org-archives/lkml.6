Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-121539-1525856268-2-14679865433598601471
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525856267; b=U8pr5z7JZV2qKJr4Gfi5u2GNFnKG3k5MhrwNGCBCair3aAJ8FO
    9k2fHtF94NyncRqcWVvRR+PA2Oic9sQG/rPFk3NAM1Z0Boe9BwFudPR3LKNcGyNm
    7lf6T5PhGTN6lJ7nxSS7CywcZ5tRxGLSqV20n2So60uMmJciQIxySJLBC38Z/U75
    kkmL7hWEycJyQ6g9iW8DqIwiqt15+TKZPQ7aST/D+obz09OMQxQ0Kixv+J0DTTkY
    d18qyzVSIu0JpBnuKbNVZNwwVpwsG5m3GzlmvY3P6UBd4x4a/Uewa5L0UiwB5Bee
    K6ND2qSbMMqayP0Z5+tOi6IwwTJwtudmogkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525856267;
    bh=YM366IcmfFSNnY2pjftAtDZ6tGF6Tn0Z0w/93eHnu3E=; b=chFCpbaPOlXX
    VAoE2Qz5KEfZleDYHerx8yFCwlDKn2V4TXmqYID8duArQWsi+Q7nMRv6Xir4Be/+
    ZOkvvmNvqwk4ZBHBGdF76RYxUB+gmTqKWH7DY3sNkvCfJTqULXzugg9CvGDNzDiW
    TR/D4hLmLsMT0sUxcWiTNBW2EDhkzygTT9SRN1UFJeZnKNdGS/MKua4Xe1iPlhDp
    tmc41MXmptQnQe8PsKEhoVdZm7DSR0yYlA8aY470h6JZj9KywTfI0ZVC2TDfLX57
    KyLPz4syuu9ZZZ/P26dzy8Ji1LI7u/x6Id3cUmMxkLo5XdcZOJqZEAh7XxSNrWav
    SHBnIp/p9Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rock-chips.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rock-chips.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMWyk5AWEfshDWBtFzQjPHJQWSIiTtbNFePd8jmWkxFYEech+Gw/TNaphbjn3rIzQA3p45w0yuPCcefL4jFCyqJ1BtKdie6+WieBKeMLE8B54BY7RN4M
    9w1yQSI7jdaGVrCiYpTmV4g8D79L36wfsC+pfDO15r1V+mhoXYnetw/H705jYtec2Ji1R4TYSB2GvDoZElYosSN/Q1yI3o6jZ4xMc1y6BlGbDRfY7wvQPASH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=4_-BN3WEXhEA:10
    a=VUJBJC2UJ8kA:10 a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=cwuY2uGcyqMHOERdpUQA:9
    a=a7zV0tIkbIxXDH1_:21 a=a-l7twEsdB_jAMdG:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934337AbeEIIzl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 04:55:41 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:51317 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934084AbeEIIzi (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 9 May 2018 04:55:38 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: wulf@rock-chips.com
X-FST-TO: milesschofield@aopen.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: wulf@rock-chips.com
X-UNIQUE-TAG: <138c7427948d4a22cd0d911e98abfedc>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v3 1/2] usb: dwc2: alloc dma aligned buffer for isoc split
 in
To: Doug Anderson <dianders@google.com>
Cc: William Wu <william.wu@rock-chips.com>, hminas@synopsys.com,
        felipe.balbi@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
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
References: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
 <1525748846-7767-2-git-send-email-william.wu@rock-chips.com>
 <CAD=FV=VKBVp++gPXzYN0N46NVarPNWqs1YZjfcd7twkU25WNyQ@mail.gmail.com>
 <f2e0fba2-da0b-38ba-6e25-3da9ccf1e4ee@rock-chips.com>
 <CAD=FV=W0Aufw1=UH2eZjb4cpiLjt9ty49CrUOdM5B2wF+WoY-A@mail.gmail.com>
From: wlf <wulf@rock-chips.com>
Message-ID: <196bd304-3c6b-91b6-1743-50d6d13fc5a5@rock-chips.com>
Date: Wed, 9 May 2018 16:55:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W0Aufw1=UH2eZjb4cpiLjt9ty49CrUOdM5B2wF+WoY-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Doug,

在 2018年05月08日 23:29, Doug Anderson 写道:
> Hi,
>
> On Tue, May 8, 2018 at 12:43 AM, wlf <wulf@rock-chips.com> wrote:
>> Dear Doug,
>>
>> 在 2018年05月08日 13:11, Doug Anderson 写道:
>>> Hi,
>>>
>>> On Mon, May 7, 2018 at 8:07 PM, William Wu <william.wu@rock-chips.com>
>>> wrote:
>>>> +static int dwc2_alloc_split_dma_aligned_buf(struct dwc2_hsotg *hsotg,
>>>> +                                           struct dwc2_qh *qh,
>>>> +                                           struct dwc2_host_chan *chan)
>>>> +{
>>>> +       if (!hsotg->unaligned_cache)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       if (!qh->dw_align_buf) {
>>>> +               qh->dw_align_buf =
>>>> kmem_cache_alloc(hsotg->unaligned_cache,
>>>> +                                                   GFP_ATOMIC |
>>>> GFP_DMA);
>>>> +               if (!qh->dw_align_buf)
>>>> +                       return -ENOMEM;
>>>> +
>>>> +               qh->dw_align_buf_size = min_t(u32, chan->max_packet,
>>>> +
>>>> DWC2_KMEM_UNALIGNED_BUF_SIZE);
>>> Rather than using min_t, wouldn't it be better to return -ENOMEM if
>>> "max_packet" > DWC2_KMEM_UNALIGNED_BUF_SIZE?  As it is, you might
>>> allocate less space than you need, right?  That seems like it would be
>>> bad (even though this is probably impossible).
>> Yes, good idea! So is it good to fix it like this?
>>
>> if (!qh->dw_align_buf || chan->max_packet >
>>      DWC2_KMEM_UNALIGNED_BUF_SIZE)
>>          return -ENOMEM;
>>
>> qh->dw_align_buf_size = chan->max_packet;
> Won't that orphan memory in the case that the allocation is OK but the
> size is wrong?
>
> I would have put it all the way at the top:
>
> if (!hsotg->unaligned_cache ||
>      chan->max_packet > DWC2_KMEM_UNALIGNED_BUF_SIZE)
>    return -ENOMEM;
Ah, yes, you're right! Thank you for correcting me.
>
> It also feels like you should get rid of "qh->dw_align_buf_size".  The
> buffer is always DWC2_KMEM_UNALIGNED_BUF_SIZE.
>
> ...if you need to keep track of how many bytes you mapped with
> dma_map_single() and somehow can't get back to "chan", rename this to
> qh->dw_align_buf_mapped_bytes or something.  I haven't followed
> through all the code, but I _think_ you'd want to make sure to set
> qh->dw_align_buf_mapped_bytes every time through
> dwc2_alloc_split_dma_aligned_buf(), even if dw_align_buf was already
> allocated.  Specifically, my worry is in the case where you enter
> dwc2_alloc_split_dma_aligned_buf() and qh->dw_align_buf is non-NULL.
> Could "max_packet" be different in this case compared to what it was
> when dw_align_buf was first allocated?
Sorry to make you feel confused. It's really not suitable to use 
"qh->dw_align_buf_size" for the dma mapped size. And I think the 
"max_packet" should be  always be the same. However, just in case, maybe 
I can get rid of "qh->dw_align_buf_size" and just use 
DWC2_KMEM_UNALIGNED_BUF_SIZE to do dma_map_single().
>
>
>>>> @@ -2797,6 +2837,32 @@ static int dwc2_assign_and_init_hc(struct
>>>> dwc2_hsotg *hsotg, struct dwc2_qh *qh)
>>>>           /* Set the transfer attributes */
>>>>           dwc2_hc_init_xfer(hsotg, chan, qtd);
>>>>
>>>> +       /* For non-dword aligned buffers */
>>>> +       if (hsotg->params.host_dma && qh->do_split &&
>>>> +           chan->ep_is_in && (chan->xfer_dma & 0x3)) {
>>>> +               dev_vdbg(hsotg->dev, "Non-aligned buffer\n");
>>>> +               if (dwc2_alloc_split_dma_aligned_buf(hsotg, qh, chan)) {
>>>> +                       dev_err(hsotg->dev,
>>>> +                               "Failed to allocate memory to handle
>>>> non-aligned buffer\n");
>>>> +                       /* Add channel back to free list */
>>>> +                       chan->align_buf = 0;
>>>> +                       chan->multi_count = 0;
>>>> +                       list_add_tail(&chan->hc_list_entry,
>>>> +                                     &hsotg->free_hc_list);
>>>> +                       qtd->in_process = 0;
>>>> +                       qh->channel = NULL;
>>>> +                       return -ENOMEM;
>>>> +               }
>>>> +       } else {
>>>> +               /*
>>>> +                * We assume that DMA is always aligned in non-split
>>>> +                * case or split out case. Warn if not.
>>>> +                */
>>>> +               WARN_ON_ONCE(hsotg->params.host_dma &&
>>>> +                            (chan->xfer_dma & 0x3));
>>>> +               chan->align_buf = 0;
>>>> +       }
>>>> +
>>>>           if (chan->ep_type == USB_ENDPOINT_XFER_INT ||
>>>>               chan->ep_type == USB_ENDPOINT_XFER_ISOC)
>>>>                   /*
>>>> @@ -5241,6 +5307,17 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>>>>                           hsotg->params.dma_desc_enable = false;
>>>>                           hsotg->params.dma_desc_fs_enable = false;
>>>>                   }
>>>> +       } else if (hsotg->params.host_dma) {
>>> Are you sure this is "else if"?  Can't you have descriptor DMA enabled
>>> in the controller and still need to do a normal DMA transfer if you
>>> plug in a hub?  Seems like this should be just "if".
>> Sorry, I don't understand the case "have descriptor DMA enabled in the
>> controller and still need to do a normal DMA transfer". But maybe it still
>> has another problem if just use "if" here, because it will create kmem
>> caches for Slave mode which actually doesn't need aligned DMA buf.
> So right now your code looks like:
>
> if (hsotg->params.dma_desc_enable ||
>      hsotg->params.dma_desc_fs_enable) {
>      ...
>      ...
> } else if (hsotg->params.host_dma) {
>     ...
> }
>
>
> I've never played much with "descriptor DMA" on dwc2 because every
> time I enabled it (last I tried was years ago) a whole bunch of
> peripherals stopped working and I didn't dig (I just left it off).
> Thus, I'm no expert on descriptor DMA.  ...that being said, my
> understanding is that if you enable descriptor DMA in the controller
> then it will enable a smarter DMA mode for some of the transfers.
> IIRC Descriptor DMA mode specifically can't handle splits.  Is my
> memory correct there?  Presumably that means that when you enable
> descriptor DMA in the controller the driver will automatically fall
> back to normal Address DMA mode if things get too complicated.  When
> it falls back to Address DMA mode, presumably dwc2_hcd_init() won't
> get called again.  That means that any data structures that are needed
> for Address DMA need to be allocated in dwc2_hcd_init() even if
> descriptor DMA is enabled because we might need to fall back to
> Address DMA.
>
> Thus, I'm suggesting changing the code to:
>
> if (hsotg->params.dma_desc_enable ||
>      hsotg->params.dma_desc_fs_enable) {
>      ...
>      ...
> }
>
> if (hsotg->params.host_dma) {
>     ...
> }
>
>
> ...as I said, I'm no expert and I could just be confused.  If
> something I say seems wrong please correct me.
Ah, I got it. Thanks for your detailed explanation. Although I don't 
know if it's possible that dwc2 driver automatically fall back to normal 
Address DMA mode when desc DMA work abnormally with split, I agree with 
your suggestion. I'll fix it in V4 patch.
>
>>>> +                                               SLAB_CACHE_DMA, NULL);
>>>> +               if (!hsotg->unaligned_cache)
>>>> +                       dev_err(hsotg->dev,
>>>> +                               "unable to create dwc2 unaligned
>>>> cache\n");
>>>>           }
>>>>
>>>>           hsotg->otg_port = 1;
>>>> @@ -5279,6 +5356,7 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>>>>    error4:
>>>>           kmem_cache_destroy(hsotg->desc_gen_cache);
>>>>           kmem_cache_destroy(hsotg->desc_hsisoc_cache);
>>>> +       kmem_cache_destroy(hsotg->unaligned_cache);
>>> nitty nit: freeing order should be opposite of allocation, so the new
>>> line should be above the other two.
>> Ah, I got it. But note that it's impossible to allocate the
>> "unaligned_cache" and "desc *cache" at the same time. Should we still fix
>> the free order? If yes, maybe the correct free order is:
>>
>> kmem_cache_destroy(hsotg->unaligned_cache);
>> kmem_cache_destroy(hsotg->desc_hsisoc_cache);
>> kmem_cache_destroy(hsotg->desc_gen_cache);
>>
>> Right?
>>
>> And should we also need to fix the same free order in the "dwc2_hcd_remove"?
> Right.  Yes, it totally doesn't matter which is why I tagged it with
> "nitty nit" (or, another way of saying it is: I'm just being totally
> obsessive here).  It's just that, for me, I always expect frees to be
> in the opposite order of allocations so it makes it easier for me to
> parse the code if this is consistent.
It seems like a good idea to me. I'll fix it.
>
Best regards，
         wulf
>
>
>


