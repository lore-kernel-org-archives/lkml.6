Return-Path: <wulf@rock-chips.com>
X-Google-Smtp-Source: AB8JxZqb8kzeqEMhx1D3TEPenIG9/iHFYnePQzsq8osfgEZSSIc8m2A8K4xLNS52xVP/8+a0+8lH
ARC-Seal: i=1; a=rsa-sha256; t=1526031250; cv=none;
        d=google.com; s=arc-20160816;
        b=PRU2YiIXRJnEJrN5qNmPuFvBCKkUrsgMzKh6ldT32LcJRymjCZYbzXlfjWoy8x3MXG
         ukLMVaQyM4/93x9oMJX2soBMTxQtzsCEoLgk7n6qM4suigwOPNcBgiyvnTCJBTB/yXC2
         2es3hpA3ckBOfrwca+ovbKj8R8WHCS75idK8Z9KSefKtL38EYmMZBpOR9EV4bWNINVZE
         USxc74iVaXelcXFdjM5EmvONIPkMubnDjMQzrfJqSvvZK5ZPuWn4mPjPC5uXVpdDdXOU
         ha8nrvTgRfmZv61+LpxKrG+MbFNegVeMKoo3iqBGDdUh+GrrsP8k/fTHEnw3pQ4Hv34K
         3GZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=JwskvU6ndEmzRXc5o6WhHLqmTnzwaHiBAYi7mizFZqE=;
        b=kFpBcvRVW6xe0Tv4p8+H3ZJIpGhEKRtATNRH3hzKx+6ZX9yCtfJ3HaGL5YT9hs5rmo
         wtvd06goL+Ir9QyrSEtvRs3XOgaAySt75Aoqv0TfD0TLxvZ4PD46figGTckqj92mrDKh
         wBFayquXIoTxO6Au9OPBXudUWhoOBE3N36gg9eQaZuT4KLCu5Tpr3/Yzk8oYX1TLIaDi
         cfGJ5Kf3RWEciRXFVzKA3JoM5d5XeJxTjJLnvoj9IjfWGcJzdzvsKcaE9oij+fc651mg
         9YKv1QDe9vOVfhMiNsMyH3l3yBzbDW+ZlWBpHOWaa890UjSlWOhz1N4i0BT5KwFX3qGE
         iTjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.17 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.17 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
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
X-UNIQUE-TAG: <67274dbab7315ca3e374fadefd25b041>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v4 1/2] usb: dwc2: alloc dma aligned buffer for isoc split
 in
To: Doug Anderson <dianders@google.com>,
 William Wu <william.wu@rock-chips.com>
Cc: hminas@synopsys.com, felipe.balbi@linux.intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
 LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Frank Wang <frank.wang@rock-chips.com>, =?UTF-8?B?6buE5rab?=
 <huangtao@rock-chips.com>, "daniel.meng" <daniel.meng@rock-chips.com>,
 John Youn <John.Youn@synopsys.com>, =?UTF-8?B?546L5b6B5aKe?=
 <wzz@rock-chips.com>, zsq@rock-chips.com, =?UTF-8?B?6Kix5ZiJ6YqY?=
 <Allen.Hsu@quantatw.com>, Stan Tsui <StanTsui@aopen.com>,
 =?UTF-8?B?U3BydWNlIFd1ICjlkLPlu7rli7Mp?= <Spruce.Wu@quantatw.com>,
 Martin Tsai <Martin.Tsai@quantatw.com>, Kevin Hsueh
 <Kevin.Shai@quantatw.com>, =?UTF-8?B?TW9uLUplciBXdSAo5ZCz5a2f5ZOyKQ==?=
 <Mon-Jer.Wu@quantatw.com>, =?UTF-8?B?Q2xhdWQgQ2hhbmcgKOW8teaBreeviSk=?=
 <Claud.Chang@quantatw.com>, =?UTF-8?B?U2FuIExpbiAo5p6X5bu66I+xKQ==?=
 <San.Lin@quantatw.com>, Ren Kuo <Ren.Kuo@quantatw.com>,
 "David H.T. Wang" <davidhtwang@aopen.com>, Fong Lin <fonglin@aopen.com>,
 Steven Cheng <stevencheng@aopen.com>, Tom Chen <tomchen@aopen.com>,
 Don Chang <donchang@aopen.com>, milesschofield@aopen.com
References: <1525860661-18619-1-git-send-email-william.wu@rock-chips.com>
 <1525860661-18619-2-git-send-email-william.wu@rock-chips.com>
 <CAD=FV=VGhnQ2NQqn+HYNadxor8a4gNwj8hmSvGXxxstKiUJmdA@mail.gmail.com>
From: wlf <wulf@rock-chips.com>
Message-ID: <60703355-c0e5-f6f4-0933-1efb7b46dded@rock-chips.com>
Date: Fri, 11 May 2018 17:33:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VGhnQ2NQqn+HYNadxor8a4gNwj8hmSvGXxxstKiUJmdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599980959305070262?=
X-GMAIL-MSGID: =?utf-8?q?1600159744441288250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Doug,

在 2018年05月11日 05:01, Doug Anderson 写道:
> Hi,
>
> On Wed, May 9, 2018 at 3:11 AM, William Wu <william.wu@rock-chips.com> wrote:
>> The commit 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in
>> a more supported way") rips out a lot of code to simply the
>> allocation of aligned DMA. However, it also introduces a new
>> issue when use isoc split in transfer.
>>
>> In my test case, I connect the dwc2 controller with an usb hs
>> Hub (GL852G-12), and plug an usb fs audio device (Plantronics
>> headset) into the downstream port of Hub. Then use the usb mic
>> to record, we can find noise when playback.
>>
>> It's because that the usb Hub uses an MDATA for the first
>> transaction and a DATA0 for the second transaction for the isoc
>> split in transaction. An typical isoc split in transaction sequence
>> like this:
>>
>> - SSPLIT IN transaction
>> - CSPLIT IN transaction
>>    - MDATA packet
>> - CSPLIT IN transaction
>>    - DATA0 packet
>>
>> The DMA address of MDATA (urb->dma) is always DWORD-aligned, but
>> the DMA address of DATA0 (urb->dma + qtd->isoc_split_offset) may
>> not be DWORD-aligned, it depends on the qtd->isoc_split_offset (the
>> length of MDATA). In my test case, the length of MDATA is usually
>> unaligned, this cause DATA0 packet transmission error.
>>
>> This patch use kmem_cache to allocate aligned DMA buf for isoc
>> split in transaction. Note that according to usb 2.0 spec, the
>> maximum data payload size is 1023 bytes for each fs isoc ep,
>> and the maximum allowable interrupt data payload size is 64 bytes
>> or less for fs interrupt ep. So we set the size of object to be
>> 1024 bytes in the kmem cache.
>>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> ---
>> Changes in v4:
>> - get rid of "qh->dw_align_buf_size"
>> - allocate unaligned_cache for Address DMA mode and Desc DMA mode
>> - freeing order opposite of allocation
> You only did half of this.  You changed the order under "error4" but
> forgot to make dwc2_hcd_remove() match.
Ah, sorry, I'm careless.
>
>
>> - do dma_map_single() with the size of DWC2_KMEM_UNALIGNED_BUF_SIZE
>>
>> Changes in v3:
>> - Modify the commit message
>> - Use Kmem_cache to allocate aligned DMA buf
>> - Fix coding style
>>
>> Changes in v2:
>> - None
>>
>>   drivers/usb/dwc2/core.h      |  3 ++
>>   drivers/usb/dwc2/hcd.c       | 87 ++++++++++++++++++++++++++++++++++++++++++--
>>   drivers/usb/dwc2/hcd.h       |  8 ++++
>>   drivers/usb/dwc2/hcd_intr.c  |  8 ++++
>>   drivers/usb/dwc2/hcd_queue.c |  3 ++
>>   5 files changed, 105 insertions(+), 4 deletions(-)
> My only remaining comment is a really nitty detail.  Unless someone
> else feels strongly about it, I'm not sure it's worth spinning the
> patch just for that nit unless someone else has review comments.
>
> I believe I've looked at this enough to say:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
Thank you very much for your review. I will submit V5 patches to fix the 
order of memory free in dwc2_hcd_remove()， and also add Review-by.
>
>
>
