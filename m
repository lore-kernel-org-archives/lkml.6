Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-364912-1525449502-2-4188333496630000945
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
    1525449501; b=UgZyLKYu4q3V8+YK1stW/qILZCZirX1YUeinppHMLY/z4pC9B/
    KhxI1xIHz/ykCJ0hmSF06xdSOMpKsw9gTrpDgS3dZdUCyEJtzujbSkEx8LZRT8Gi
    OFiZahit5WjxYrh3zqlZpGFTxvHSOD60SPWw9n4+G8GtMY0FOKO8CxQc5BVrrAXT
    9FxvgaCe1saM2RvvAZ+HwX5hFFruJgilyo16MNTf9zSKSsUKw0TgNFtC8tFPXTRZ
    0TA21WLv9nkuL+NDsKvJR2bUxSN8qtCWUE2NFbfQSAwoAW5jh6uAIkRNNKah7xh1
    WIeSXlhOV/iSURs8qmAooq8+42vpAtCzRu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525449501;
    bh=t10uREUaGfRB1o8yYGQG8+z2hiMKHxOR83duLSLT8bs=; b=GTxRVEJWPj/v
    PRfFcWyyKRETV4/kg3CnVqNUZDsN0t16WfyYn1zvYTMo1m5a5rnqSiO6znjz2NsY
    U2B1wm6pcyajAMebiK5J1Lsv/28/j0SQbqarjeG8BRHc6fgT/LRWFjSSzWeCstwt
    mN+5ONykoZYyR+tq74XWk5mkEFHRew98bNO+45cX0zf7C8d+8HsNnlSOmswblCcs
    KDfXn6S1zlktuDLFaQxfCDvTYKVuUHR+OIGsBhWOY9b2yJWH+8e8LhIbEUO339RE
    txty3U7o1Faw5uAuJzcR4CaTm+woabFkhyziqKndsY9+f+nfTzbiMamOEAZ2CrQh
    L84Z3eTZLA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=kQwqA5L+ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qQk/ws17;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=kQwqA5L+ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qQk/ws17;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFui/Nj/Y4N6Q6bKfM903FEAjWWEwOWVVyLq/o2r/imf9B6YLfyfoj/ZfKHYQy4nuIc4qRVyn2Ag6mvuBDexxeE5WpgC6nampFf4xwqEP44krFlz/gj4
    5nHkhEuGrifXii3n2ygb0f7xqEikIZdcKwKSyzcrStwlmWnRxgUHb2bn2eqsBOeEOgock7Yv5Zh4R53dQqKnmUyHb3QzMf49vp/GFgsQe7oho1rVDMKCk4Io
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=rND40vrxrjbhfPZvLiIA:9
    a=u--3X6zGtXkJvsrw:21 a=gt5fB3bjh2wI7RYU:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeEDP6J (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 11:58:09 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:40156 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEDP6H (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 11:58:07 -0400
X-Google-Smtp-Source: AB8JxZo7+rpem0glBU5uUmMs6hxyDgriAlQc8MaJ2l+RDKpb96LW7/xUROzK1YaYY9T26/K5HrD/K2mAqTwe/YbqHcc=
MIME-Version: 1.0
In-Reply-To: <8ce56264-cdd1-1a12-c642-79224c65f639@rock-chips.com>
References: <1525230288-6014-1-git-send-email-william.wu@rock-chips.com>
 <1525230288-6014-2-git-send-email-william.wu@rock-chips.com>
 <CAD=FV=UTjLbh+Qj8JcyGa5dMH8=hFurA2qyWpi9vCJkE1_ExRg@mail.gmail.com> <8ce56264-cdd1-1a12-c642-79224c65f639@rock-chips.com>
From: Doug Anderson <dianders@google.com>
Date: Fri, 4 May 2018 08:58:04 -0700
Message-ID: <CAD=FV=V1gFsyG+PDp6xF2w+=t87vcoSNcXGvwVu_YchY4MyNAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: dwc2: alloc dma aligned buffer for isoc split in
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
        zsq@rock-chips.com, Allen.Hsu@quantatw.com,
        Stan Tsui <StanTsui@aopen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, May 2, 2018 at 10:14 AM, wlf <wulf@rock-chips.com> wrote:
> It's a good way to allocate an extra 3 bytes in the original bounce buffe=
r
> for this unaligned
> issue=EF=BC=8C it's similar to the tailroom of sk_buff. However, just as =
you said,
> we'd better find
> the special cases where we need an oversized bounce buffer, otherwise=EF=
=BC=8Cwe
> need to allocate
> a bounce buffer for all of urbs.
>
> It's hard for me to know the special cases in the
> dwc2_alloc_dma_aligned_buffer(), because
> it's called from usb_submit_urb() in the device class driver, and I hardl=
y
> know the split state
> in this process, much less if the split transaction need aligned buffer. =
Do
> you have any idea?
>
> I suppose that we can't find the special cases where we need an oversized
> bounce buffer
> in the dwc2_alloc_dma_aligned_buffer(), and if we still want to re-use th=
e
> original bounce
> buffer with extra 3 bytes, then we need to allocate a  bounce buffer for =
all
> of urbs, and do
> unnecessary  data copy for these urbs  whose transfer_buffer were already
> aligned.  This
> may reduce the transmission rate of USB.
>
> Can we just pre-allocate an additional aligned buffer (the size is 200
> bytes) for split transaction
> in dwc2_map_urb_for_dma for all of urbs. And if we find the split
> transaction is unaligned=EF=BC=8C
> we can easily use the pre-allocated aligned buffer.

OK, so thinking about this more...

Previously things got really slow at interrupt time because we were
trying to allocate as much as 64K at interrupt time.  That wasn't so
great.  In your case, you're only allocating 200 bytes.  As I
understand things, allocating 200 bytes at interrupt time is probably
not a huge deal.

...so I guess it come down to a tradeoff here: is it worth eating 200
bytes for each URB to save an 200 byte allocation at interrupt time in
this one rare case.

I'd certainly welcome anyone's opinion here, but I'm going to go with
saying it's fine to allocate the 200 bytes at interrupt time (like
your patch does).  ...but, I _think_ you want to use
kmem_cache_create() to create a cache and then kmem_cache_zalloc().
Since all allocations are the same size and you want this to be fast,
I think using kmem_cache is good.



>>> +       /* For non-dword aligned buffers */
>>> +       if (hsotg->params.host_dma > 0 && qh->do_split &&
>>> +           chan->ep_is_in && (chan->xfer_dma & 0x3)) {
>>
>> So what happens if were unaligned (AKA (chan->xfer_dma & 0x3)) but
>> we're not doing split or it's not an IN EP?  Do we just fail then?
>>
>> I guess the rest of this patch only handles the "in" case and maybe
>> you expect that the problems will only come about for do_split, but it
>> still might be wise to at least print a warning in the other cases?
>> >From reading dwc2_hc_init_xfer() it seems like you could run into this
>> same problem in the "out" case?
>
> Actually, I only find non-dword aligned issue in the case of split in
> transaction.
> And I think that if we're not doing split or it's an OUT EP, we can alway=
s
> get aligned buffer
> in the current code. For non-split case, the dwc2_alloc_dma_aligned_buffe=
r()
> is enough. And for split out case, if the transaction is subdivided into
> multiple start-splits,
> each with a data payload of 188 bytes or less, so the DMA address is alwa=
ys
> aligned.

Can you at least print an error message if you end up with non-aligned
DMA in one of the other cases?


>>> DMA_FROM_DEVICE);
>>> +               memcpy(qtd->urb->buf + frame_desc->offset +
>>> +                      qtd->isoc_split_offset, chan->qh->dw_align_buf,
>>> len);
>>
>> Assuming I'm understanding this patch correctly, I think it would be
>> better to write:
>>
>>    memcpy(qtd->xfer_dma, chan->qh->dw_align_buf, len);
>
> Sorry, there's no "xfer_buf" in qtd, do you means the "chan->xfer_dma"? I=
f
> it's, I think we can't
> do memcpy from a transfer buffer to a DMA address. Maybe chan->xfer_buf i=
s
> more suitable,
> but it seems that the dwc2 driver doesn't update the chan->xfer_buf for i=
soc
> transfer with dma
> enabled in dwc2_hc_init_xfer().

Yes, I meant chan->xfer_dma.  Ah, right.  xfer_dma is a DMA address.

I guess you could in theory you could do:

memcpy(qtd->urb->buf + (chan->xfer_dma - urb->dma),
    chan->qh->dw_align_buf);

That at least avoids duplicating the math.  Maybe either do that, or
if you don't like it at least add a comment saying that the math needs
to match the math in dwc2_hc_init_xfer().


>> Then if you ever end up having to align a transfer other than a split
>> you won't be doing the wrong math.  As it is it's very non-obvious
>> that you're hardcoding the same formula that's in dwc2_hc_init_xfer()
>
> Actually, I'm hardcoding the same formula from the old code which has bee=
n
> ripped out
> in the commit 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in a more
> supported way").

Ah, got it.  Well, I think the old code was just hardcoding the same
formula in two places then.  ;-)


>>> -       if (qh->desc_list)
>>> +       if (qh->desc_list) {
>>>                  dwc2_hcd_qh_free_ddma(hsotg, qh);
>>> +       } else {
>>> +               /* kfree(NULL) is safe */
>>> +               kfree(qh->dw_align_buf);
>>> +               qh->dw_align_buf_dma =3D (dma_addr_t)0;
>>
>> Why assign qh->dw_align_buf_dma to 0?  The next thing you're doing is
>> kfree(qh).  If you want extra debugging, turn on slub_debug.
>
> I just copy the same code from the old code which has been ripped out in =
the
> commit 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in a more supporte=
d
> way").
> I really don't know why assign qh->dw_align_buf_dma to 0.

There's no reason.  Just remove it.


-Doug
