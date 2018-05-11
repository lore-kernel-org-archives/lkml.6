Return-Path: <wulf@rock-chips.com>
X-Google-Smtp-Source: AB8JxZo51FSqGJ3xQL7YBXJK2kHdpfiUtJ2p8PPjVrTpDwm0+rIRPSGk7yzjnv6yDt1+jenDx2cj
ARC-Seal: i=1; a=rsa-sha256; t=1526030828; cv=none;
        d=google.com; s=arc-20160816;
        b=WRWABgWohd1FYAo2Cvi8dqjgUdk5IA4/I4kDB/AxooCWWl+h12AseTzx3daNl21cUQ
         UM1ISolEk55guXkF6HqA79CLTSUVJJFrlhynC/VJLqSP1DCydUm+vZfayZdWcZIKVqmX
         PPDQvH2LcKYS5R4iG7/f/tssXTSFmRJ1C+zSK0tXTVzj9yPb+ElYrpeA/DeVKYuFSrtr
         VWZ1YkmJRi3TCXwsP0bHsDohoO1b2e0L/kGte8kveCeKLYCciNsx3UoumxsJ4N0UXl+u
         4xucR4DUuFjPba+LIuYdR2mL7E2cz/R++VhhHeWZMpjHigkONlDqPtw2gFciqt4P8ntG
         P4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=y3lxbBelTSNH/Q5u2B+ZE29IXXrU4i3C3ECr/m0XZNw=;
        b=cftW7GoFiP9+6jQoA5HdKsDa7V21gkahoES3NvsDxKVqCZVKDVr8pl725W2B+KqzoM
         WJWO/Xr23E4i1NewpOZL31AWrnIONdkuBQoSxZTNUB7P9R1086Lnt+cOb/zQa9u1Q3AX
         RjoGmYx+GZjqZb6gM6x8iU3exqazHxbrCdgviKnFqBkOkcNISTHjpsANOWPLIhVvNIcs
         VgwVdAH5oyjFQkim9fnOA5MVYs7ln6cszKGpCPFn/ZJLg7uzkja04KGbq2qLmF1vAw1B
         UWqWUO8XurZfAzMAMAwvAwf+VpUr2Ipj9IbiQZQpLFCGgLqOYtel2iBfa8qxNystUTS+
         eMwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.14 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.14 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
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
X-UNIQUE-TAG: <aa500f6fe005f08c93475bbf3d37fc0a>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v3 1/2] usb: dwc2: alloc dma aligned buffer for isoc split
 in
To: Doug Anderson <dianders@google.com>
Cc: William Wu <william.wu@rock-chips.com>, hminas@synopsys.com,
 felipe.balbi@linux.intel.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
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
References: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
 <1525748846-7767-2-git-send-email-william.wu@rock-chips.com>
 <CAD=FV=VKBVp++gPXzYN0N46NVarPNWqs1YZjfcd7twkU25WNyQ@mail.gmail.com>
 <f2e0fba2-da0b-38ba-6e25-3da9ccf1e4ee@rock-chips.com>
 <CAD=FV=W0Aufw1=UH2eZjb4cpiLjt9ty49CrUOdM5B2wF+WoY-A@mail.gmail.com>
 <196bd304-3c6b-91b6-1743-50d6d13fc5a5@rock-chips.com>
 <CAD=FV=Xsa9MAw==_Oi28B69oqZehwL2JTwEzjKAnH5PS5wKC_A@mail.gmail.com>
From: wlf <wulf@rock-chips.com>
Message-ID: <3768eb42-98c4-5bd0-a796-5ba36d03cd35@rock-chips.com>
Date: Fri, 11 May 2018 17:26:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Xsa9MAw==_Oi28B69oqZehwL2JTwEzjKAnH5PS5wKC_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599863711876607151?=
X-GMAIL-MSGID: =?utf-8?q?1600159301580589441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Doug,


在 2018年05月11日 04:59, Doug Anderson 写道:
> Hi,
>
> On Wed, May 9, 2018 at 1:55 AM, wlf <wulf@rock-chips.com> wrote:
>>>>>> +       } else if (hsotg->params.host_dma) {
>>>>> Are you sure this is "else if"?  Can't you have descriptor DMA enabled
>>>>> in the controller and still need to do a normal DMA transfer if you
>>>>> plug in a hub?  Seems like this should be just "if".
>>>> Sorry, I don't understand the case "have descriptor DMA enabled in the
>>>> controller and still need to do a normal DMA transfer". But maybe it
>>>> still
>>>> has another problem if just use "if" here, because it will create kmem
>>>> caches for Slave mode which actually doesn't need aligned DMA buf.
>>> So right now your code looks like:
>>>
>>> if (hsotg->params.dma_desc_enable ||
>>>       hsotg->params.dma_desc_fs_enable) {
>>>       ...
>>>       ...
>>> } else if (hsotg->params.host_dma) {
>>>      ...
>>> }
>>>
>>>
>>> I've never played much with "descriptor DMA" on dwc2 because every
>>> time I enabled it (last I tried was years ago) a whole bunch of
>>> peripherals stopped working and I didn't dig (I just left it off).
>>> Thus, I'm no expert on descriptor DMA.  ...that being said, my
>>> understanding is that if you enable descriptor DMA in the controller
>>> then it will enable a smarter DMA mode for some of the transfers.
>>> IIRC Descriptor DMA mode specifically can't handle splits.  Is my
>>> memory correct there?  Presumably that means that when you enable
>>> descriptor DMA in the controller the driver will automatically fall
>>> back to normal Address DMA mode if things get too complicated.  When
>>> it falls back to Address DMA mode, presumably dwc2_hcd_init() won't
>>> get called again.  That means that any data structures that are needed
>>> for Address DMA need to be allocated in dwc2_hcd_init() even if
>>> descriptor DMA is enabled because we might need to fall back to
>>> Address DMA.
>>>
>>> Thus, I'm suggesting changing the code to:
>>>
>>> if (hsotg->params.dma_desc_enable ||
>>>       hsotg->params.dma_desc_fs_enable) {
>>>       ...
>>>       ...
>>> }
>>>
>>> if (hsotg->params.host_dma) {
>>>      ...
>>> }
>>>
>>>
>>> ...as I said, I'm no expert and I could just be confused.  If
>>> something I say seems wrong please correct me.
>> Ah, I got it. Thanks for your detailed explanation. Although I don't know if
>> it's possible that dwc2 driver automatically fall back to normal Address DMA
>> mode when desc DMA work abnormally with split, I agree with your suggestion.
>> I'll fix it in V4 patch.
> Hmm, I guess you're right.  I did a quick search and I can't find any
> evidence of a fallback like this.  Maybe I dreamed that.  I found some
> old comment in the commit history that said:
I think you're right. I find that it's possible to fall back to Address 
DMA mode if desc DMA initialization failure. The error case is：in 
dwc2_hcd_init(),  if it fails to create dwc2 generic desc cache or dwc2 
hs isoc desc cache, then it will disable desc DMA and fall back to 
Address DMA mode.
>
> /*
>   * Disable descriptor dma mode by default as the HW can support
>   * it, but does not support it for SPLIT transactions.
>   * Disable it for FS devices as well.
>   */
>
> ...and it looks there's currently nobody using descriptor DMA anyway
> (assuming I read the code correctly).  It does seem like people were
> ever going to turn it on then it would have to be dynamic as I was
> dreaming it was...
Yes, the dwc2 desc DMA mode can't support split transaction. So few 
people use desc DMA mode for OTG Host mode. BTW, I find that the latest 
code enable desc DMA mode by default for the OTG peripheral mode if the 
dwc2 hardware support desc DMA.
>
