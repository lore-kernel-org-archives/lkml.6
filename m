Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2377225-1525765466-2-14604756149299310796
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
    1525765465; b=Z44y15XCRgzmqBzIQd7O+8n5wxF+F9X9URg188GFAp3fQHBpmd
    Y8xeqMNkFXzkF4xhSYUFaniBlUkBfOpwS79hjgltqJz5nINZF8Exks6SH6Yagv5X
    JyDdXPUP16zr0Iem83a0/i1/m/tS3bmsCeML/YJleHfA7DWQEqVAlGUCh4Sft0om
    jzNR6RRxLHa8WUX+UkZmd7oCWCB74Ux49O2XOHrxVqsDd53FBtx2rsIf+PU70W+e
    XQnmuW0Yeq1yeG9xmTTBmwPNm9Rh62MLbZdLc4O8uoggNUqTPHjNLGyYhTlQtaJV
    /wfHfKV4izjyvKtVcFv0MzQCYo5x00bu21DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525765465;
    bh=SoiWtWpITDQi318TNgpqIJ2OSTa3Aq9SJKaCdlzFUec=; b=MA/R7iA3jWeb
    wUVoA/qQCKxLOF27YcNWkC7CiwivfVWVLOSbjPhUx/gAHdjU3W+SbzSYRrYfZDto
    /BmOw1ilFU/4LY4HHE+R12bZPzw1B1ik2TqzQi03B3HKnYLrFf4i2eEN7NLuZ0Nw
    hJnBJ1JYriSsM+Br9C09x5i1+Dzjl475NfXlftBeXwVD7lLKeMo8feB8/FKJw78Z
    YBBdpZbUofbChEL8fZEjhVhjValccr9NNfEF105W8prXT4OTyh+r4y+p9L0fz+3d
    tmwEZ9mdtfPbmifjIqB01mlqwqk4eZFj7Gz4u+XlaKpZdgcjFMjrplPWmDLT5a0d
    4pmyYO4uMA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfJMn2bdGALDZ1gV/SUKHy3x8Kz8pfZ5uwmOqDtdvl1RKNoRLbD6yfeWcyEkSRY9y9V7AcsxsUtP9c8vDw3pr38gVLaUSon4hA6QVm5DIiksA/4Pr6knK
    69kZeGYHAfm8ZMhF+0/YAsvspAujG7iAl5wrbtrhjOYXRC4WNSuxydVCIZ9PP+0X3O3UnXALi1IAujjtNc5CbpSLNrxv4bTbawJUZYRK7aL0asrMNT2MqisH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=4_-BN3WEXhEA:10
    a=VUJBJC2UJ8kA:10 a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=lYurYwihvsYxgE493KcA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbeEHHoJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 03:44:09 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:44364 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754599AbeEHHoI (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 8 May 2018 03:44:08 -0400
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
X-UNIQUE-TAG: <71a5b4fe9ad932ea2224971746d5a494>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v3 1/2] usb: dwc2: alloc dma aligned buffer for isoc split
 in
To: Doug Anderson <dianders@google.com>,
        William Wu <william.wu@rock-chips.com>
Cc: hminas@synopsys.com, felipe.balbi@linux.intel.com,
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
From: wlf <wulf@rock-chips.com>
Message-ID: <f2e0fba2-da0b-38ba-6e25-3da9ccf1e4ee@rock-chips.com>
Date: Tue, 8 May 2018 15:43:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VKBVp++gPXzYN0N46NVarPNWqs1YZjfcd7twkU25WNyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Doug,

在 2018年05月08日 13:11, Doug Anderson 写道:
> Hi,
>
> On Mon, May 7, 2018 at 8:07 PM, William Wu <william.wu@rock-chips.com> wrote:
>> +static int dwc2_alloc_split_dma_aligned_buf(struct dwc2_hsotg *hsotg,
>> +                                           struct dwc2_qh *qh,
>> +                                           struct dwc2_host_chan *chan)
>> +{
>> +       if (!hsotg->unaligned_cache)
>> +               return -ENOMEM;
>> +
>> +       if (!qh->dw_align_buf) {
>> +               qh->dw_align_buf = kmem_cache_alloc(hsotg->unaligned_cache,
>> +                                                   GFP_ATOMIC | GFP_DMA);
>> +               if (!qh->dw_align_buf)
>> +                       return -ENOMEM;
>> +
>> +               qh->dw_align_buf_size = min_t(u32, chan->max_packet,
>> +                                             DWC2_KMEM_UNALIGNED_BUF_SIZE);
> Rather than using min_t, wouldn't it be better to return -ENOMEM if
> "max_packet" > DWC2_KMEM_UNALIGNED_BUF_SIZE?  As it is, you might
> allocate less space than you need, right?  That seems like it would be
> bad (even though this is probably impossible).
Yes, good idea! So is it good to fix it like this?

if (!qh->dw_align_buf || chan->max_packet >
     DWC2_KMEM_UNALIGNED_BUF_SIZE)
	return -ENOMEM;	

qh->dw_align_buf_size = chan->max_packet;

>
>> @@ -2797,6 +2837,32 @@ static int dwc2_assign_and_init_hc(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
>>          /* Set the transfer attributes */
>>          dwc2_hc_init_xfer(hsotg, chan, qtd);
>>
>> +       /* For non-dword aligned buffers */
>> +       if (hsotg->params.host_dma && qh->do_split &&
>> +           chan->ep_is_in && (chan->xfer_dma & 0x3)) {
>> +               dev_vdbg(hsotg->dev, "Non-aligned buffer\n");
>> +               if (dwc2_alloc_split_dma_aligned_buf(hsotg, qh, chan)) {
>> +                       dev_err(hsotg->dev,
>> +                               "Failed to allocate memory to handle non-aligned buffer\n");
>> +                       /* Add channel back to free list */
>> +                       chan->align_buf = 0;
>> +                       chan->multi_count = 0;
>> +                       list_add_tail(&chan->hc_list_entry,
>> +                                     &hsotg->free_hc_list);
>> +                       qtd->in_process = 0;
>> +                       qh->channel = NULL;
>> +                       return -ENOMEM;
>> +               }
>> +       } else {
>> +               /*
>> +                * We assume that DMA is always aligned in non-split
>> +                * case or split out case. Warn if not.
>> +                */
>> +               WARN_ON_ONCE(hsotg->params.host_dma &&
>> +                            (chan->xfer_dma & 0x3));
>> +               chan->align_buf = 0;
>> +       }
>> +
>>          if (chan->ep_type == USB_ENDPOINT_XFER_INT ||
>>              chan->ep_type == USB_ENDPOINT_XFER_ISOC)
>>                  /*
>> @@ -5241,6 +5307,17 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>>                          hsotg->params.dma_desc_enable = false;
>>                          hsotg->params.dma_desc_fs_enable = false;
>>                  }
>> +       } else if (hsotg->params.host_dma) {
> Are you sure this is "else if"?  Can't you have descriptor DMA enabled
> in the controller and still need to do a normal DMA transfer if you
> plug in a hub?  Seems like this should be just "if".
Sorry, I don't understand the case "have descriptor DMA enabled in the 
controller and still need to do a normal DMA transfer". But maybe it 
still has another problem if just use "if" here, because it will create 
kmem caches for Slave mode which actually doesn't need aligned DMA buf.
>
>
>> +               /*
>> +                * Create kmem caches to handle non-aligned buffer
>> +                * in Buffer DMA mode.
>> +                */
>> +               hsotg->unaligned_cache = kmem_cache_create("dwc2-unaligned-dma",
>> +                                               DWC2_KMEM_UNALIGNED_BUF_SIZE, 4,
> Worth using "DWC2_USB_DMA_ALIGN" rather than 4?
>
>
>> +                                               SLAB_CACHE_DMA, NULL);
>> +               if (!hsotg->unaligned_cache)
>> +                       dev_err(hsotg->dev,
>> +                               "unable to create dwc2 unaligned cache\n");
>>          }
>>
>>          hsotg->otg_port = 1;
>> @@ -5279,6 +5356,7 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>>   error4:
>>          kmem_cache_destroy(hsotg->desc_gen_cache);
>>          kmem_cache_destroy(hsotg->desc_hsisoc_cache);
>> +       kmem_cache_destroy(hsotg->unaligned_cache);
> nitty nit: freeing order should be opposite of allocation, so the new
> line should be above the other two.
Ah, I got it. But note that it's impossible to allocate the 
"unaligned_cache" and "desc *cache" at the same time. Should we still 
fix the free order? If yes, maybe the correct free order is:

kmem_cache_destroy(hsotg->unaligned_cache);
kmem_cache_destroy(hsotg->desc_hsisoc_cache);
kmem_cache_destroy(hsotg->desc_gen_cache);

Right?

And should we also need to fix the same free order in the "dwc2_hcd_remove"?
Best regards,
         wulf
>
>


