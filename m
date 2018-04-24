Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2543453-1524555788-2-9747613071993245424
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524555787; b=w005DF+VJGJjuD7LeN3OdkNIwTV787eIieMiQSaTtmLRaQWmRZ
    aHFA+dHE9R4Lyms+Mfr7V4iWj4oblIgggDyQWsTxbGZFm3jqgzvT3HFwTTZshnBZ
    0lmKUzfc+ug2kktEQAaMuuseoP22sl2xfYMHoTvTNV1OOfL73kvQrbPh0xXkDsCK
    ob0Z/ir+7KcULDmXinijM6Ej0Rco7fvYtBBkoSIv/88xhPCyKOjFZ8Hs/4bD7GFX
    0SlBB6xoB62mB3ttSOORzZsHZ+3sDx7OdCJ2ey1TX3VqcrpcCmuquO6is3pZLfN3
    KR+wOZ7KHsNcyleL+RzC3czwyIlQye+QDvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=fm2; t=1524555787; bh=1r0zL/dr5mHz
    Y5NDpMHjqL0aFFbqFORcSTvL1Ow8JAg=; b=cPHgi6qUwKYzSGa47EMwqiiFFxvL
    jvsQaEel4RvvjLmjNhKLlDTPswigRQtdkHW5YUM9zytCeEwjxWFBaf/c6kW5fJVs
    BE7vkDGdgiZYVf/FTyiiEOdjKFfeUSKhMqipc7+83yryvlOo2q+gDQ1jiKKaVmv1
    oBPisgwPqNNTwc4gLH9z5n5wFuD+IVw81pG7OS+ezp72jd8ATIE6PhjVnbzKuDnU
    mVygU9ixgqA5Hl4cDMDU8YOhAM1AmEN2wK4pXKQ8h+XFMO5UTsrIr/CSlraOA+cW
    REi5RYiIaMdAt8DHdpjckxFclVqk5sNyQrfV9Kn9OZo947PmqcQu6tV02A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ipe+Rk/n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ipe+Rk/n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCa0Wzu/YPl4s2Fvy83XDbuv4uMRWmSEaZjdZR7nUviDT4wnqHqwYVN6JRcu0S4FmBZfoYtofp+cJtWhbOsxwo3K+wHHI/cDUiLdAN71dcF57GJKFqPJ
    81SvGmMOojOurXcaCc7bIyyQvNmB2NYpdje3tKuO34L9s/XXHQQfJsYT+02Me2VxcYTy0XpJWJRSmRgrC8NGWC35R/Lwm4jFdrLa0KpKgUe7zrpPkI8Tm8F+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=hXhQfpdcRjNPdIuxo5MA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756042AbeDXHmx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 03:42:53 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21280 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeDXHmw (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 24 Apr 2018 03:42:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180424074250epoutp031ce8e79c00cb6345b810e87ecd68c51b~oT2VFU8w-2836628366epoutp03y
X-AuditID: b6c32a46-145ff70000001024-80-5adedff71378
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5ADEDFF6.3010902@samsung.com>
Date: Tue, 24 Apr 2018 16:42:46 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] usb: always build usb/common/ targets; fixes
 extcon-axp288 build error
In-reply-to: <9632a61d-fb15-4764-93ae-d6f4049cba82@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTURzl7r29PcPVba26KJi9PiDJtY+Wz1ArlHqlgtEfxULXQx9OdJvs
        bZHRhxWmDaylhaE1zYWZRSuL0NKsmR9ZRFnDIrVAqCxLUGkqRO3tGfXXPffcc869v8MlMUUl
        EUHmWeyczcIWUMQ8/F7nmrjYwIdhg9r9ciU96uoE9PhnL0af8HgJeqynSkI7r7fi9Ov7Fwm6
        vqEEo98fayTo74NV+OYwprV6SMbcaYxhPG2jEsb9dCfTcemGjBl/6CeY03ebADPZHJVBGrgE
        E8fmcLZozpJtzcmz5CZSqbuMyUb9BrUmVhNPx1HRFtbMJVIpaRmxW/MKgq+jovezBY4glcHy
        PLUuKcFmddi5aJOVtydSezUarUqjjlNptcFVl7lRqw9K9nEmX085XvhZcWCsvJ8oBk0LnCCM
        RHA9ejbbK3WCeaQCtgB01X9eKhwoYACgmZvGv6LGCwNA5G8B5G5IF7AcLkTTlcO4E5AkBpeh
        J/35Ao3BNejLVAUuZg4B9GjchYn6GHSzxC8RMA5XoZquM6FMIsh3fHlLCHgBXI780yMhfjHc
        g1prf8qEICW8GLzXezy0weAoQL/6vssE1SKYiUYfVYVwGExC3TODmCBCcJJAt/01EnGEFPSj
        voYQ8SL0teeuTMSR6FPTbSAaSgEqbXfPuc8B9GJgeM6tQ58uOyXidPNRWecvmTA0gnJUdlIh
        ShjUde3VXOgW5Pa0zvXVC9DkjNIFoqr/q6z6X2XV/1VWB7AmsIQr5M25HK8t1Kp41sw7LLmq
        bKu5GYQ+ZMzWFnDlRZoPQBJQ4fK6mSGDQsru54vMPoBIjFLK26OGDQp5Dlt0kLNZjTZHAcf7
        gD7Y+FksYnG2Nfi9LXajRq/V6XS0Pi5ep46nlsqL058bFDCXtXP5HFfI2f76JGRYRDHIOtC3
        t4XxSN9FxpYcqj2ajqJufKxL3hbodHSk4FjtponB1LH2WXd4r3ItlN450kBFNB9ODff3+1wP
        3qwO/E54Uhb/vPvUiqlukxTPOaZS39sdAGTFyLdUPskTucO7y+DKLh+fDe9/vLoy/2iWl3hp
        NJVmblNec7dZ0pzbJ75SOG9iNTGYjWf/APkvW7mmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t9jQd1v9+9FGcx7p2bxcsJhRov3z9cz
        WzQvXs9m8eb4dCaLrtU7WSwu75rDZrFoWSuzxe3GFWwWb+9MZ3Hg9Ng56y67x+YVWh6L97xk
        8ph3MtBj/9w17B7v911l8+jbsorR4/MmuQCOKC6blNSczLLUIn27BK6MQ8d7WQqeC1W86b3E
        1sC4ir+LkZNDQsBEYsWM64xdjFwcQgLrGCXeHl3GCJLgFRCU+DH5HksXIwcHs4C8xJFL2RCm
        usSUKbkQ5fcZJbb1X2eDKNeSWNd6lQnEZhFQlZh9tB9sDBtQfP+LG2A1/AKKEld/PGYEmSMq
        ECHRfaISZI6IwCxGiZ5ZLUwgDrPAa0aJ9z87wQYJC8RKPJjYxQ6x7QSjRFNvLwtIglPATuLY
        zzvMExiBehFunYVw6yyEWxcwMq9ilEwtKM5Nzy02KjDKSy3XK07MLS7NS9dLzs/dxAiMjG2H
        tfp3MD5eEn+IUYCDUYmHd8HPu1FCrIllxZW5hxglOJiVRHj3yt2LEuJNSaysSi3Kjy8qzUkt
        PsQozcGiJM7Ln38sUkggPbEkNTs1tSC1CCbLxMEp1cBYzXV/suDClw0P5zcrzp4mtnbiA1mW
        dX2X5l6JEHu9sC/6tYj1t8j5LBWKRxyfvZAo1X++OutQm8CDX5yfO53+T+f4fselXFb4d5yl
        to92xOK2+mZl7+ul+sqTfym8tL95iXV/H9/sHGXXvmfsXum75mqzrjxQf8as1ODtq+MPfdqe
        X1Vh/PdciaU4I9FQi7moOBEAfTQoLogCAAA=
X-CMS-MailID: 20180424074246epcas2p3d9c17356663d06a3c7a42deab184c20a
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180417090153epcas4p16fcd18a906baef77b8e87471916a6ed4
X-RootMTR: 20180417090153epcas4p16fcd18a906baef77b8e87471916a6ed4
References: <d2641585-65d8-76d4-0668-a278955967d8@infradead.org>
        <CGME20180417090153epcas4p16fcd18a906baef77b8e87471916a6ed4@epcas4p1.samsung.com>
        <9632a61d-fb15-4764-93ae-d6f4049cba82@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018년 04월 17일 18:01, Hans de Goede wrote:
> Hi,
> 
> On 17-04-18 07:14, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> The extcon-axp288 driver selects USB_ROLE_SWITCH, but the USB
>> Makefile does not currently build drivers/usb/common/ (where
>> USB_ROLE_SWITCH code is) unless USB_COMMON is set, so modify
>> the USB Makefile to always descend into drivers/usb/common/
>> to build its configured targets.
>>
>> Fixes these build errors:
>>
>> ERROR: "usb_role_switch_get" [drivers/extcon/extcon-axp288.ko] undefined!
>> ERROR: "usb_role_switch_set_role" [drivers/extcon/extcon-axp288.ko] undefined!
>> ERROR: "usb_role_switch_get_role" [drivers/extcon/extcon-axp288.ko] undefined!
>> ERROR: "usb_role_switch_put" [drivers/extcon/extcon-axp288.ko] undefined!
>>
>> An alternative patch would be to select USB_COMMON in the EXTCON_AXP288
>> driver Kconfig entry, but this would build more code in
>> drivers/usb/common/ than is necessary.
> 
> Ah, that variant of fixing this got posted yesterday and I acked that,
> but I agree that this version is better.
> 
> Greg, what is your take on this fix?
> 
> Chanwoo Choi, please wait with merging the fix from yesterday until
> we've a decision which fix to use.

OK. I'll not send pull request for fix patches until deciding them.

> 
> Regards,
> 
> Hans
> 
> 
> 
>>
>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: linux-usb@vger.kernel.org
>> ---
>>   drivers/usb/Makefile |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- lnx-417-rc1.orig/drivers/usb/Makefile
>> +++ lnx-417-rc1/drivers/usb/Makefile
>> @@ -60,7 +60,7 @@ obj-$(CONFIG_USB_CHIPIDEA)    += chipidea/
>>   obj-$(CONFIG_USB_RENESAS_USBHS)    += renesas_usbhs/
>>   obj-$(CONFIG_USB_GADGET)    += gadget/
>>   -obj-$(CONFIG_USB_COMMON)    += common/
>> +obj-y                += common/
>>     obj-$(CONFIG_USBIP_CORE)    += usbip/
>>  
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
