Return-Path: <wulf@rock-chips.com>
X-Google-Smtp-Source: AB8JxZr6Rnf5k4P1jglz2FB+WzosFYhl1Dbf8YlhL26MqYH5dOUXB35TwfLhbQsX9p79svJ86cyQ
ARC-Seal: i=1; a=rsa-sha256; t=1525762918; cv=none;
        d=google.com; s=arc-20160816;
        b=pYncTabjW3gSh0mL/rtpIayjvSHESP/b2UeTaVkXeNghURtiWCnA6prnYlIlkJQR2h
         PgMAvaZdldtCQIYTopBxrCn7/A2tkugOGM4qI/jqN6/0cB7+ZVAd3zuSBWemh+w67edf
         bZI9oj0PewRpqq30sNAXxfNMdm8DKBTPhOlp0PM3Mvp7nraqUMU8+Q+gYr5C+T1PVA9t
         v/rHilNgGlRPMQbUYNnK9RYvUvqMqgwkDPs7kf+zD7Hgya7CP/JavN9wr4Esil5CkuwD
         i1yXOCSdkAMuZdPe5g5cEpVAdcTl9Fnv8hp568grsx5tVARFjYCkNjyASDlbzoPYbSp3
         QqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=C4QhrQ91SqF+4/fsjT6TY5hThvnPOLRAaBENFrQbJ1s=;
        b=GaqwTBtwHYs3Y47qmg/kYdOSpn+e4CGZz+gZdRN/sTVqVxbUJI3yEKIAVvLQPtWcx8
         hOHz14pdEyFTBkz21diQcrhouPVuMha4JrHD+bf2Qvk8ecXQ7JlQ9h7FXUHHgMyP8m1x
         1zmTOsQ5UknS+LSaJ0XHMWGFbHW0INiBluKsVsdldrtev252k8VCr1PIJ3NjGuFuVzzQ
         qXSQPoWTjBOW+6KaG90AYTQkoedrP9svKQC+6RZ98C+/igtsZsg/D3x3u1mtXP4P9ouW
         Ji6sTYWcN+hD5evDM7aVXWTLkithLAbjGkf+Vn3gfkzI6peu5XjdW1M8Y6EZPOXMcALM
         ClZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.19 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.19 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: wulf@rock-chips.com
X-FST-TO: milesschofield@aopen.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: wulf@rock-chips.com
X-UNIQUE-TAG: <5a4c9904656581c8e84b306531bacaaa>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v3 2/2] usb: dwc2: fix isoc split in transfer with no data
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
 Martin.Tsai@quantatw.com, Kevin.Shai@quantatw.com,
 =?UTF-8?B?TW9uLUplciBXdSAo5ZCz5a2f5ZOyKQ==?= <Mon-Jer.Wu@quantatw.com>,
 =?UTF-8?B?Q2xhdWQgQ2hhbmcgKOW8teaBreeviSk=?= <Claud.Chang@quantatw.com>,
 =?UTF-8?B?U2FuIExpbiAo5p6X5bu66I+xKQ==?= <San.Lin@quantatw.com>,
 Ren.Kuo@quantatw.com, "David H.T. Wang" <davidhtwang@aopen.com>,
 Fong Lin <fonglin@aopen.com>, Steven Cheng <stevencheng@aopen.com>,
 Tom Chen <tomchen@aopen.com>, donchang@aopen.com, milesschofield@aopen.com
References: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
 <1525748846-7767-3-git-send-email-william.wu@rock-chips.com>
 <CAD=FV=X3f9tHLY+5NJTBxegsc1PYz5MhomC7MNNSjL-vA8DCWg@mail.gmail.com>
From: wlf <wulf@rock-chips.com>
Message-ID: <feaaa29d-8dfa-4233-2cd9-b89a191e5a57@rock-chips.com>
Date: Tue, 8 May 2018 15:01:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=X3f9tHLY+5NJTBxegsc1PYz5MhomC7MNNSjL-vA8DCWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599863716477292963?=
X-GMAIL-MSGID: =?utf-8?q?1599878378075143827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Doug,

在 2018年05月08日 13:13, Doug Anderson 写道:
> Hi,
>
> On Mon, May 7, 2018 at 8:07 PM, William Wu <william.wu@rock-chips.com> wrote:
>> If isoc split in transfer with no data (the length of DATA0
>> packet is zero), we can't simply return immediately. Because
>> the DATA0 can be the first transaction or the second transaction
>> for the isoc split in transaction. If the DATA0 packet with no
>> data is in the first transaction, we can return immediately.
>> But if the DATA0 packet with no data is in the second transaction
>> of isoc split in transaction sequence, we need to increase the
>> qtd->isoc_frame_index and giveback urb to device driver if needed,
>> otherwise, the MDATA packet will be lost.
>>
>> A typical test case is that connect the dwc2 controller with an
>> usb hs Hub (GL852G-12), and plug an usb fs audio device (Plantronics
>> headset) into the downstream port of Hub. Then use the usb mic
>> to record, we can find noise when playback.
>>
>> In the case, the isoc split in transaction sequence like this:
>>
>> - SSPLIT IN transaction
>> - CSPLIT IN transaction
>>    - MDATA packet (176 bytes)
>> - CSPLIT IN transaction
>>    - DATA0 packet (0 byte)
>>
>> This patch use both the length of DATA0 and qtd->isoc_split_offset
>> to check if the DATA0 is in the second transaction.
>>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> ---
>> Changes in v3:
>> - Remove "qtd->isoc_split_offset = 0" in the if test
>>
>> Changes in v2:
>> - Modify the commit message
>>
>>   drivers/usb/dwc2/hcd_intr.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
>> index ba6fd852..3003594 100644
>> --- a/drivers/usb/dwc2/hcd_intr.c
>> +++ b/drivers/usb/dwc2/hcd_intr.c
>> @@ -930,9 +930,8 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
>>          frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index];
>>          len = dwc2_get_actual_xfer_length(hsotg, chan, chnum, qtd,
>>                                            DWC2_HC_XFER_COMPLETE, NULL);
>> -       if (!len) {
>> +       if (!len && !qtd->isoc_split_offset) {
>>                  qtd->complete_split = 0;
>> -               qtd->isoc_split_offset = 0;
>>                  return 0;
>>          }
> This looks fine to me now, but as per my comments on the previous
> version I don't think I've dug through this problem enough to add my
> Reviewed-by tag.  I'll assume that John or someone with more knowledge
> of the USB protocol than I have will Review / Ack.
Thanks very much for your review. Let's wait for other experts' suggestion.
>
> -Doug
>
>
>
