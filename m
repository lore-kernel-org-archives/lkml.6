Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3018566-1525793417-2-5147500038692213413
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
    1525793416; b=e8S5MlJDZOPq5RxwdhvstAhehGa7Ota48mF7eT2nOBIRIr56TO
    22mLULhFMFki77EfhkVBkcz+Xok/EH5bImEymJ6Rpe14bofvzojoNGr1pfqig9i0
    ktMOooovXq2i5MQyH+YNBvXGqG9Z41Jki5xLGIYbqg3ZNg1+0EjKCWd9B1itI0eY
    JdlFXWNwOMRPlKPwOI/y/qi4qRctLT3i6xrmqz7ySFb3EUjZtTDjkkqoLa05uxDB
    ASNgi+pQM8nr2DR8zhLKuUWQwLJIZKPkf5MvztCge9IF+9ZHRHQGO/izSn084Rv2
    iN9RImi5Y3EbGu6R0lOt3982Kh8AelySYMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525793416;
    bh=YySkXOtzks2xKA2I1WB4YakYVxlo9y8nxHk8S7xarZE=; b=d65ApF1hpJid
    tcqRCyQibr8To849zFDRH4jKdfxxNW6JtpWgabuDKqcho6n0te+Ih8AH6q3I66dK
    B6NcZxrUCaQjLKkcni29se8ZDkQhOqX2Dk6pVYxQts5OvVV2JLdMf9bxcNNbDQ7E
    Q5ODMxdounGJKnqGwRtc3y/wPE2ViNXraSwNR098nvOBBesaQs7w17Rp6cCePHQ0
    4Djn00cV1DBwe9yzQHffUVvE4Q+RxLojhfnfsm/xHL1IaqGDgG2zrZaHUnK74zHS
    Da/O/IW04r0N0WtMBvdVKBuVwwACaCVGEHCOqBlzVME2mvkq9JSoSPnXsviB/8r/
    +eFxXS1HTg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=SPnpUo+X x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=QERWakko;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=SPnpUo+X x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=QERWakko;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB4EAGuTNw7t+Y7V64b6B/taJWqBwn5syqG/FwKnj+gKEO182ZMs1lpdICUhZCnj+W8Bfcq7zcmdseBJV3Hu+CkosJFaolpuok6lbghWSF8rEg88husG
    ldS2OrO6GCokXCbx3P8dBmTFPNx1v0m7wYDzSB+0maRKBrDJZKFkyVX6MmEw/jcG6WAxxPYrYVdxiMbhBb6Afvo7k7sxx+3aX1yLn/GcAcmRD3TdBO61XGfU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=8bAJjcIoq6sFdeCcb4QA:9
    a=x1cOW5j1DgzCFevq:21 a=1xXR6jr8l1YFT-bI:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeEHPaE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 11:30:04 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:38217 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932715AbeEHPaD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 8 May 2018 11:30:03 -0400
X-Google-Smtp-Source: AB8JxZpxV1zBPIW71IE1L+uzPvWzY0WTJ34UU0DcXhICu0U5oqfRFym0iIEdqrMju4Mjd9yHfS2nT4hMg8Pa92EL37A=
MIME-Version: 1.0
In-Reply-To: <f2e0fba2-da0b-38ba-6e25-3da9ccf1e4ee@rock-chips.com>
References: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
 <1525748846-7767-2-git-send-email-william.wu@rock-chips.com>
 <CAD=FV=VKBVp++gPXzYN0N46NVarPNWqs1YZjfcd7twkU25WNyQ@mail.gmail.com> <f2e0fba2-da0b-38ba-6e25-3da9ccf1e4ee@rock-chips.com>
From: Doug Anderson <dianders@google.com>
Date: Tue, 8 May 2018 08:29:59 -0700
Message-ID: <CAD=FV=W0Aufw1=UH2eZjb4cpiLjt9ty49CrUOdM5B2wF+WoY-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] usb: dwc2: alloc dma aligned buffer for isoc split in
To: wlf <wulf@rock-chips.com>
Cc: William Wu <william.wu@rock-chips.com>, hminas@synopsys.com,
        felipe.balbi@linux.intel.com,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Tue, May 8, 2018 at 12:43 AM, wlf <wulf@rock-chips.com> wrote:
> Dear Doug,
>
> =E5=9C=A8 2018=E5=B9=B405=E6=9C=8808=E6=97=A5 13:11, Doug Anderson =E5=86=
=99=E9=81=93:
>>
>> Hi,
>>
>> On Mon, May 7, 2018 at 8:07 PM, William Wu <william.wu@rock-chips.com>
>> wrote:
>>>
>>> +static int dwc2_alloc_split_dma_aligned_buf(struct dwc2_hsotg *hsotg,
>>> +                                           struct dwc2_qh *qh,
>>> +                                           struct dwc2_host_chan *chan=
)
>>> +{
>>> +       if (!hsotg->unaligned_cache)
>>> +               return -ENOMEM;
>>> +
>>> +       if (!qh->dw_align_buf) {
>>> +               qh->dw_align_buf =3D
>>> kmem_cache_alloc(hsotg->unaligned_cache,
>>> +                                                   GFP_ATOMIC |
>>> GFP_DMA);
>>> +               if (!qh->dw_align_buf)
>>> +                       return -ENOMEM;
>>> +
>>> +               qh->dw_align_buf_size =3D min_t(u32, chan->max_packet,
>>> +
>>> DWC2_KMEM_UNALIGNED_BUF_SIZE);
>>
>> Rather than using min_t, wouldn't it be better to return -ENOMEM if
>> "max_packet" > DWC2_KMEM_UNALIGNED_BUF_SIZE?  As it is, you might
>> allocate less space than you need, right?  That seems like it would be
>> bad (even though this is probably impossible).
>
> Yes, good idea! So is it good to fix it like this?
>
> if (!qh->dw_align_buf || chan->max_packet >
>     DWC2_KMEM_UNALIGNED_BUF_SIZE)
>         return -ENOMEM;
>
> qh->dw_align_buf_size =3D chan->max_packet;

Won't that orphan memory in the case that the allocation is OK but the
size is wrong?

I would have put it all the way at the top:

if (!hsotg->unaligned_cache ||
    chan->max_packet > DWC2_KMEM_UNALIGNED_BUF_SIZE)
  return -ENOMEM;


It also feels like you should get rid of "qh->dw_align_buf_size".  The
buffer is always DWC2_KMEM_UNALIGNED_BUF_SIZE.

...if you need to keep track of how many bytes you mapped with
dma_map_single() and somehow can't get back to "chan", rename this to
qh->dw_align_buf_mapped_bytes or something.  I haven't followed
through all the code, but I _think_ you'd want to make sure to set
qh->dw_align_buf_mapped_bytes every time through
dwc2_alloc_split_dma_aligned_buf(), even if dw_align_buf was already
allocated.  Specifically, my worry is in the case where you enter
dwc2_alloc_split_dma_aligned_buf() and qh->dw_align_buf is non-NULL.
Could "max_packet" be different in this case compared to what it was
when dw_align_buf was first allocated?



>>> @@ -2797,6 +2837,32 @@ static int dwc2_assign_and_init_hc(struct
>>> dwc2_hsotg *hsotg, struct dwc2_qh *qh)
>>>          /* Set the transfer attributes */
>>>          dwc2_hc_init_xfer(hsotg, chan, qtd);
>>>
>>> +       /* For non-dword aligned buffers */
>>> +       if (hsotg->params.host_dma && qh->do_split &&
>>> +           chan->ep_is_in && (chan->xfer_dma & 0x3)) {
>>> +               dev_vdbg(hsotg->dev, "Non-aligned buffer\n");
>>> +               if (dwc2_alloc_split_dma_aligned_buf(hsotg, qh, chan)) =
{
>>> +                       dev_err(hsotg->dev,
>>> +                               "Failed to allocate memory to handle
>>> non-aligned buffer\n");
>>> +                       /* Add channel back to free list */
>>> +                       chan->align_buf =3D 0;
>>> +                       chan->multi_count =3D 0;
>>> +                       list_add_tail(&chan->hc_list_entry,
>>> +                                     &hsotg->free_hc_list);
>>> +                       qtd->in_process =3D 0;
>>> +                       qh->channel =3D NULL;
>>> +                       return -ENOMEM;
>>> +               }
>>> +       } else {
>>> +               /*
>>> +                * We assume that DMA is always aligned in non-split
>>> +                * case or split out case. Warn if not.
>>> +                */
>>> +               WARN_ON_ONCE(hsotg->params.host_dma &&
>>> +                            (chan->xfer_dma & 0x3));
>>> +               chan->align_buf =3D 0;
>>> +       }
>>> +
>>>          if (chan->ep_type =3D=3D USB_ENDPOINT_XFER_INT ||
>>>              chan->ep_type =3D=3D USB_ENDPOINT_XFER_ISOC)
>>>                  /*
>>> @@ -5241,6 +5307,17 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>>>                          hsotg->params.dma_desc_enable =3D false;
>>>                          hsotg->params.dma_desc_fs_enable =3D false;
>>>                  }
>>> +       } else if (hsotg->params.host_dma) {
>>
>> Are you sure this is "else if"?  Can't you have descriptor DMA enabled
>> in the controller and still need to do a normal DMA transfer if you
>> plug in a hub?  Seems like this should be just "if".
>
> Sorry, I don't understand the case "have descriptor DMA enabled in the
> controller and still need to do a normal DMA transfer". But maybe it stil=
l
> has another problem if just use "if" here, because it will create kmem
> caches for Slave mode which actually doesn't need aligned DMA buf.

So right now your code looks like:

if (hsotg->params.dma_desc_enable ||
    hsotg->params.dma_desc_fs_enable) {
    ...
    ...
} else if (hsotg->params.host_dma) {
   ...
}


I've never played much with "descriptor DMA" on dwc2 because every
time I enabled it (last I tried was years ago) a whole bunch of
peripherals stopped working and I didn't dig (I just left it off).
Thus, I'm no expert on descriptor DMA.  ...that being said, my
understanding is that if you enable descriptor DMA in the controller
then it will enable a smarter DMA mode for some of the transfers.
IIRC Descriptor DMA mode specifically can't handle splits.  Is my
memory correct there?  Presumably that means that when you enable
descriptor DMA in the controller the driver will automatically fall
back to normal Address DMA mode if things get too complicated.  When
it falls back to Address DMA mode, presumably dwc2_hcd_init() won't
get called again.  That means that any data structures that are needed
for Address DMA need to be allocated in dwc2_hcd_init() even if
descriptor DMA is enabled because we might need to fall back to
Address DMA.

Thus, I'm suggesting changing the code to:

if (hsotg->params.dma_desc_enable ||
    hsotg->params.dma_desc_fs_enable) {
    ...
    ...
}

if (hsotg->params.host_dma) {
   ...
}


...as I said, I'm no expert and I could just be confused.  If
something I say seems wrong please correct me.


>>> +                                               SLAB_CACHE_DMA, NULL);
>>> +               if (!hsotg->unaligned_cache)
>>> +                       dev_err(hsotg->dev,
>>> +                               "unable to create dwc2 unaligned
>>> cache\n");
>>>          }
>>>
>>>          hsotg->otg_port =3D 1;
>>> @@ -5279,6 +5356,7 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>>>   error4:
>>>          kmem_cache_destroy(hsotg->desc_gen_cache);
>>>          kmem_cache_destroy(hsotg->desc_hsisoc_cache);
>>> +       kmem_cache_destroy(hsotg->unaligned_cache);
>>
>> nitty nit: freeing order should be opposite of allocation, so the new
>> line should be above the other two.
>
> Ah, I got it. But note that it's impossible to allocate the
> "unaligned_cache" and "desc *cache" at the same time. Should we still fix
> the free order? If yes, maybe the correct free order is:
>
> kmem_cache_destroy(hsotg->unaligned_cache);
> kmem_cache_destroy(hsotg->desc_hsisoc_cache);
> kmem_cache_destroy(hsotg->desc_gen_cache);
>
> Right?
>
> And should we also need to fix the same free order in the "dwc2_hcd_remov=
e"?

Right.  Yes, it totally doesn't matter which is why I tagged it with
"nitty nit" (or, another way of saying it is: I'm just being totally
obsessive here).  It's just that, for me, I always expect frees to be
in the opposite order of allocations so it makes it easier for me to
parse the code if this is consistent.


-Doug
