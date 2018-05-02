Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1076443-1525281406-2-2572819945215014830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525281406; b=mPqMcptxvGkbROjH4eYLLa9H3OvHKigTrU7s1ISXd/PDadqKA+
    rLqdMdoUYEikEnvtNi9Y1CLRTFpx5hOnpQIkUpWzeKyAs1ruCvetdF75QwJ4iFKc
    jIQanD53iH0lzRxGtuDiWetZlzXj16EZ9v+dfvzFcMFVObqK3sffMXI5kuNHL/hx
    Z7sCieU47HfKf6MeIc0pdS3FJs130Z8TfJ5cevXHg5xfCbp+6Eyh25971ZVV8hD/
    JSbIdj6qQt+9cURRPjgR0KNZ/J++NrokY+KcJvszApFPgHmmeA8oRXNuqSc4fg1N
    iRaQtUwsE+iemRruTBcR/6aMuqxxYLhAdSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525281406;
    bh=IsQ5adFKEmh+u2OZWRA6W14o2rT/RaLigu0cwonh500=; b=gjm6v+mZOGNm
    zz15/KYYl1PrYM8Y9hJY2Y/rbP/rRUBsusACdKIYXUO4A16aA/+Ey66xJJsI3tmw
    3a6DIzJz8+xgNKIfGr2rfK6y4tw3qQUVySl5G+4fIStwNS2/C1bFFn7PyhXotZ6r
    yeMpgmDvdNlFaqUqJowXBUaC4MuLzFui5Tk8E0WVnWF9DMiuswcpOdhgGQSt9awF
    doq0/I+meyFiRQs1/3pb82yWw4nqn3uFv2P6SAZD+DiJQCJKl7r72aXVVon3MxuC
    W1TsA5YjZc6IARvRYvm8La/uGbAEuCGivowlWvjUZFiR77Dv9QiZ9Rc6pq5daKrA
    +a5HpHDk3A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNCkMzBHcQXzXWDbW7yRvtuARZ/TACQS8kMLMp8JChm8Fy9oG7kQExkk5O7c1obtQSSt8ZqFlmQblS5+ZBXymAv3HhVpv78b7b3kdUQD27NfGaTcZxIt
    jQCfTCeTFsyBFnPwM2v8kzqNC8JYm8RT62QvHAoqX1qFn1NNp2WFWz8ql4UnfjPf9IJlshH5z1/rZ/SsrFI6J42F2A3XUDqauIlFrlLEo3hSuQjr1KBxpshe
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=4_-BN3WEXhEA:10
    a=VUJBJC2UJ8kA:10 a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=CPysfF9r7JwwzmaOoEsA:9
    a=X4Um7eoHEUNr9z_C:21 a=LuPEUeTM8f8QoplZ:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeEBRQd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 13:16:33 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:51357 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeEBRQc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 13:16:32 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: wulf@rock-chips.com
X-FST-TO: vpalatin@chromium.org
X-SENDER-IP: 111.146.46.34
X-LOGIN-NAME: wulf@rock-chips.com
X-UNIQUE-TAG: <555ee9ead0c36a46bb7da8e59bca7027>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 2/2] usb: dwc2: fix isoc split in transfer with no data
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
        zsq@rock-chips.com, Allen.Hsu@quantatw.com, StanTsui@aopen.com,
        Vincent Palatin <vpalatin@chromium.org>
References: <1525230288-6014-1-git-send-email-william.wu@rock-chips.com>
 <1525230288-6014-3-git-send-email-william.wu@rock-chips.com>
 <CAD=FV=XWzKZOF8+=z07UC3FBGRFifBvk9Oda7HRipqGy9Rxcnw@mail.gmail.com>
From: wlf <wulf@rock-chips.com>
Message-ID: <abdf9cc8-c065-109f-82eb-0de61c3d976e@rock-chips.com>
Date: Thu, 3 May 2018 01:16:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XWzKZOF8+=z07UC3FBGRFifBvk9Oda7HRipqGy9Rxcnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Doug,


在 2018年05月02日 13:02, Doug Anderson 写道:
> Hi,
>
> On Tue, May 1, 2018 at 8:04 PM, William Wu <william.wu@rock-chips.com> wrote:
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
>> Changes in v2:
>> - Modify the commit message
>>
>>   drivers/usb/dwc2/hcd_intr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
>> index 5e2378f..479f628 100644
>> --- a/drivers/usb/dwc2/hcd_intr.c
>> +++ b/drivers/usb/dwc2/hcd_intr.c
>> @@ -930,7 +930,7 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
>>          frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index];
>>          len = dwc2_get_actual_xfer_length(hsotg, chan, chnum, qtd,
>>                                            DWC2_HC_XFER_COMPLETE, NULL);
>> -       if (!len) {
>> +       if (!len && !qtd->isoc_split_offset) {
>>                  qtd->complete_split = 0;
>>                  qtd->isoc_split_offset = 0;
>>                  return 0;
> I don't think my USB-fu is strong enough to do a real review of this
> patch, but one small nitpick is that you can remove
> "qtd->isoc_split_offset = 0" in the if test now.  AKA:
>
> if (!len && !qtd->isoc_split_offset) {
>    qtd->complete_split = 0;
>    return 0;
> }
Yes, good idea! I will fix it in next patch. Thank you!
>
> ...since you only enter the "if" test now when isoc_split_offset is
> already 0...  Hopefully John Youn will have some time to comment on
> this patch with more real USB knowledge...
>
>
> -Doug
>
Best regards,
      wulf
>


