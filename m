Return-Path: <wulf@rock-chips.com>
X-Google-Smtp-Source: AB8JxZoDZvgpczAfpD0kojdYYSLR83j0/rzuOWQXyks0CwiFiJjI2rilNuyG0L7M+BeNLflpcg3H
ARC-Seal: i=1; a=rsa-sha256; t=1525699733; cv=none;
        d=google.com; s=arc-20160816;
        b=JQuzct/QJpSCytRhsW3so+9YuCwxff5CmLXIHOvnnyXI7QyqJR5wR+rS1+DiGELbPf
         SwiSk/hlC8U05qDcnIDUw/v1EUxNX6jlSNzXJkFtezzUazL3b1LkZiKVQMpwCnHpKTDj
         QWEpjfdsr4c9/mSJwxswbexK4cNE2O8jl3CDk+87eVeXm59WwWWCu2R7act8m03+rEvp
         JHPei8Ove05To3VYdb6UNBdt+Tdl3jWb8EErsRQe6ffFkD5HK6b/d/J+C/1jNut0Skh2
         pDwx6KFo7KQrFixylQCt0qrRoKipYaF2bOgw282zqrwVEW2pFA6s/3XqbYDvtReD5K15
         9QbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=jg25J39shvHHPcvAgCdN29gi2FoEy5sc7jNGUh0EkN8=;
        b=lhcFFmgeFPoXMS/0lad4Ig9Iuu2hYEqSbigeI99Rprk9vgsmk0pEGj5T4my714H8J3
         cygXrKTsS0FnhxwwAFiA7eQ1PNDjHewz2fRWbd05u/uGsg+3pv0hpfN8MDtQvV9UxvIi
         WcC4hqWpWL0FgPLqr0XHY9hhvLJ03HpZLr6JTmvVY4NZybyD7rRDuSIqDxdZ/FU8Mchm
         45bKlPzdw8TXhGCJoX/N9Q71KaHf6sBBGRpOQUvLsVnvOMb2yZWMghxgnULXqDXGMi5S
         WdsGkybM2ngooWYww7bYsryr9HXcYQ7nuWSkN45D36Cyh1a9rZfkkNwNflgVAiHkjurh
         SxNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.22 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.22 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: wulf@rock-chips.com
X-FST-TO: stantsui@aopen.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: wulf@rock-chips.com
X-UNIQUE-TAG: <439be94572dea47b7d57502496c18874>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 1/2] usb: dwc2: alloc dma aligned buffer for isoc split
 in
To: =?UTF-8?B?QWxsZW4gSHN1ICjoqLHlmInpipgp?= <Allen.Hsu@quantatw.com>,
 Doug Anderson <dianders@google.com>
Cc: William Wu <william.wu@rock-chips.com>,
 "hminas@synopsys.com" <hminas@synopsys.com>,
 "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Frank Wang <frank.wang@rock-chips.com>, =?UTF-8?B?6buE5rab?=
 <huangtao@rock-chips.com>, "daniel.meng" <daniel.meng@rock-chips.com>,
 John Youn <John.Youn@synopsys.com>,
 =?UTF-8?B?Q2xhdWQgQ2hhbmcgKOW8teaBreeviSk=?= <Claud.Chang@quantatw.com>,
 =?UTF-8?B?546L5b6B5aKe?= <wzz@rock-chips.com>,
 "zsq@rock-chips.com" <zsq@rock-chips.com>, Stan Tsui <StanTsui@aopen.com>
References: <1525230288-6014-1-git-send-email-william.wu@rock-chips.com>
 <1525230288-6014-2-git-send-email-william.wu@rock-chips.com>
 <CAD=FV=UTjLbh+Qj8JcyGa5dMH8=hFurA2qyWpi9vCJkE1_ExRg@mail.gmail.com>
 <8ce56264-cdd1-1a12-c642-79224c65f639@rock-chips.com>
 <CAD=FV=V1gFsyG+PDp6xF2w+=t87vcoSNcXGvwVu_YchY4MyNAQ@mail.gmail.com>
 <c257333733244cf680f43128153956fd@quantatw.com>
From: wlf <wulf@rock-chips.com>
Message-ID: <377a3b28-bec6-3922-889a-94614277d390@rock-chips.com>
Date: Mon, 7 May 2018 21:28:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c257333733244cf680f43128153956fd@quantatw.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599319987763096118?=
X-GMAIL-MSGID: =?utf-8?q?1599812123337132983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Doug,

在 2018年05月07日 15:19, Allen Hsu (許嘉銘) 写道:
> Add more:
>
>
> Best regards,
> BU4 EE
> Allen Hsu
> QCI 886-3-327-2345 ext 15410
>
> -----Original Message-----
> From: Doug Anderson [mailto:dianders@google.com]
> Sent: Friday, May 4, 2018 11:58 PM
> To: wlf <wulf@rock-chips.com>
> Cc: William Wu <william.wu@rock-chips.com>; hminas@synopsys.com; felipe.balbi@linux.intel.com; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>; Heiko Stübner <heiko@sntech.de>; LKML <linux-kernel@vger.kernel.org>; linux-usb@vger.kernel.org; open list:ARM/Rockchip SoC... <linux-rockchip@lists.infradead.org>; Frank Wang <frank.wang@rock-chips.com>; 黄涛 <huangtao@rock-chips.com>; daniel.meng <daniel.meng@rock-chips.com>; John Youn <John.Youn@synopsys.com>; 王征增 <wzz@rock-chips.com>; zsq@rock-chips.com; Allen Hsu (許嘉銘) <Allen.Hsu@quantatw.com>; Stan Tsui <StanTsui@aopen.com>
> Subject: Re: [PATCH v2 1/2] usb: dwc2: alloc dma aligned buffer for isoc split in
>
> Hi,
>
> On Wed, May 2, 2018 at 10:14 AM, wlf <wulf@rock-chips.com> wrote:
>> It's a good way to allocate an extra 3 bytes in the original bounce
>> buffer for this unaligned
>> issue， it's similar to the tailroom of sk_buff. However, just as you
>> said, we'd better find the special cases where we need an oversized
>> bounce buffer, otherwise，we
>> need to allocate
>> a bounce buffer for all of urbs.
>>
>> It's hard for me to know the special cases in the
>> dwc2_alloc_dma_aligned_buffer(), because it's called from
>> usb_submit_urb() in the device class driver, and I hardly know the
>> split state in this process, much less if the split transaction need
>> aligned buffer. Do you have any idea?
>>
>> I suppose that we can't find the special cases where we need an
>> oversized bounce buffer in the dwc2_alloc_dma_aligned_buffer(), and if
>> we still want to re-use the original bounce buffer with extra 3 bytes,
>> then we need to allocate a  bounce buffer for all of urbs, and do
>> unnecessary  data copy for these urbs  whose transfer_buffer were
>> already aligned.  This may reduce the transmission rate of USB.
>>
>> Can we just pre-allocate an additional aligned buffer (the size is 200
>> bytes) for split transaction
>> in dwc2_map_urb_for_dma for all of urbs. And if we find the split
>> transaction is unaligned，
>> we can easily use the pre-allocated aligned buffer.
> OK, so thinking about this more...
>
> Previously things got really slow at interrupt time because we were trying to allocate as much as 64K at interrupt time.  That wasn't so great.  In your case, you're only allocating 200 bytes.  As I understand things, allocating 200 bytes at interrupt time is probably not a huge deal.
>
> ...so I guess it come down to a tradeoff here: is it worth eating 200 bytes for each URB to save an 200 byte allocation at interrupt time in this one rare case.
>
> I'd certainly welcome anyone's opinion here, but I'm going to go with saying it's fine to allocate the 200 bytes at interrupt time (like your patch does).  ...but, I _think_ you want to use
> kmem_cache_create() to create a cache and then kmem_cache_zalloc().
> Since all allocations are the same size and you want this to be fast, I think using kmem_cache is good.
Yes, it seems good to use kmem_cache. I'm trying to test a new patch 
with kmem_cache, and I will upstream v3 patch as soon as possible.
>>>> +       /* For non-dword aligned buffers */
>>>> +       if (hsotg->params.host_dma > 0 && qh->do_split &&
>>>> +           chan->ep_is_in && (chan->xfer_dma & 0x3)) {
>>> So what happens if were unaligned (AKA (chan->xfer_dma & 0x3)) but
>>> we're not doing split or it's not an IN EP?  Do we just fail then?
>>>
>>> I guess the rest of this patch only handles the "in" case and maybe
>>> you expect that the problems will only come about for do_split, but
>>> it still might be wise to at least print a warning in the other cases?
>>> >From reading dwc2_hc_init_xfer() it seems like you could run into 
>>>> this
>>> same problem in the "out" case?
>> Actually, I only find non-dword aligned issue in the case of split in
>> transaction.
>> And I think that if we're not doing split or it's an OUT EP, we can
>> always get aligned buffer in the current code. For non-split case, the
>> dwc2_alloc_dma_aligned_buffer() is enough. And for split out case, if
>> the transaction is subdivided into multiple start-splits, each with a
>> data payload of 188 bytes or less, so the DMA address is always
>> aligned.
> Can you at least print an error message if you end up with non-aligned DMA in one of the other cases?
That's an excellent suggestion. I will add warning message if end up 
with unexpected non-aligned DMA.
>>>> DMA_FROM_DEVICE);
>>>> +               memcpy(qtd->urb->buf + frame_desc->offset +
>>>> +                      qtd->isoc_split_offset,
>>>> + chan->qh->dw_align_buf,
>>>> len);
>>> Assuming I'm understanding this patch correctly, I think it would be
>>> better to write:
>>>
>>>     memcpy(qtd->xfer_dma, chan->qh->dw_align_buf, len);
>> Sorry, there's no "xfer_buf" in qtd, do you means the
>> "chan->xfer_dma"? If it's, I think we can't do memcpy from a transfer
>> buffer to a DMA address. Maybe chan->xfer_buf is more suitable, but it
>> seems that the dwc2 driver doesn't update the chan->xfer_buf for isoc
>> transfer with dma enabled in dwc2_hc_init_xfer().
> Yes, I meant chan->xfer_dma.  Ah, right.  xfer_dma is a DMA address.
>
> I guess you could in theory you could do:
>
> memcpy(qtd->urb->buf + (chan->xfer_dma - urb->dma),
>      chan->qh->dw_align_buf);
>
> That at least avoids duplicating the math.  Maybe either do that, or if you don't like it at least add a comment saying that the math needs to match the math in dwc2_hc_init_xfer().
Thanks, I will fix it in V3 patch according to your suggestion.
>>> Then if you ever end up having to align a transfer other than a split
>>> you won't be doing the wrong math.  As it is it's very non-obvious
>>> that you're hardcoding the same formula that's in dwc2_hc_init_xfer()
>> Actually, I'm hardcoding the same formula from the old code which has
>> been ripped out in the commit 3bc04e28a030 ("usb: dwc2: host: Get
>> aligned DMA in a more supported way").
> Ah, got it.  Well, I think the old code was just hardcoding the same formula in two places then.  ;-)
>
>
>>>> -       if (qh->desc_list)
>>>> +       if (qh->desc_list) {
>>>>                   dwc2_hcd_qh_free_ddma(hsotg, qh);
>>>> +       } else {
>>>> +               /* kfree(NULL) is safe */
>>>> +               kfree(qh->dw_align_buf);
>>>> +               qh->dw_align_buf_dma = (dma_addr_t)0;
>>> Why assign qh->dw_align_buf_dma to 0?  The next thing you're doing is
>>> kfree(qh).  If you want extra debugging, turn on slub_debug.
>> I just copy the same code from the old code which has been ripped out
>> in the commit 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in a
>> more supported way").
>> I really don't know why assign qh->dw_align_buf_dma to 0.
> There's no reason.  Just remove it.
OK, thank you for reminding me!
> -Doug
Best regards,
         wulf
