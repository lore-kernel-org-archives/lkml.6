Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1311000-1517926252-2-1130249490630612794
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517926251; b=e3DS5SV4IkXpfkhZoFYWyNhXW7JAuSxKmYLDPKcK1XSQ9KI
    FVNTnY/YAdX0kb3vbo/JgKVeL+feumlt4h7g/M04CNUrfcIXe5ck1M84f0gkU4ji
    WNslgkSy+2YcDxjBigGzFJnAlOWQ0eXw+zDjHL1T8eg260uMAreWPs6Q97w2yXmk
    7y/1lQ9C5ZEV5iNCyU1gXu3bN2D3PbvhDAXNeSyuSvEfVj7iIDBg6aUAIIK7KiHk
    JRVAC6bERfSPYx8HC0tQlilGATVtEY8XqE4Y5BySItfGIk1b40Cqg/4TBwjXZlQB
    KJ848xWsUsszHjtYN4fs4THho6QFt6QgIUJNmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517926251; bh=9VurqlV1Of2Ra1TKbSElg9GhqhmYFkdzPwMbqONaQ6U=; b=Z
    vefffDGfQq9DTLkIZy8AdF8khE8Vwcb2edirje0+bYd89ebI7XQiHo7KsIjkvAFD
    cJ2FLRgECjjolc3Ul1V4AAlFZPG6dD59ypDFe/IzYl3Ew/85UxdZAyohZb6A54GZ
    JrmBFeokeabQiNFXMkqR7VuzalMGPh5k8eKwSTwmqkbgjS7oz6g/uUN5QOJ+ncoB
    zPW+ke1l6c2b15qARxNcXPXZtDwYyAQTvrMwMgq5CW1ArA9TG+CBlrclBiiKsHEb
    eLXNDbuY/4PGg7ZMjQSXeP2oonwgVS9q6i6udaPfKxxHhUpubyTPqbsKNMU/9mZT
    WD55qWIgv3ReZoH/dO6ag==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeBFOKq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 09:10:46 -0500
Received: from regular1.263xmail.com ([211.150.99.134]:48675 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeBFOKp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 09:10:45 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: wulf@rock-chips.com
X-FST-TO: fml@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: wulf@rock-chips.com
X-UNIQUE-TAG: <a0e6db9f820c214f35276e2a106a452f>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH] usb: gadget: f_fs: get the correct address of comp_desc
To: Jack Pham <jackp@codeaurora.org>,
        William Wu <william.wu@rock-chips.com>
Cc: gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
        huangtao@rock-chips.com, daniel.meng@rock-chips.com,
        fml@rock-chips.com
References: <1517830418-2648-1-git-send-email-william.wu@rock-chips.com>
 <20180205181758.GA22738@usblab-sd-06.qualcomm.com>
From: wlf <wulf@rock-chips.com>
Message-ID: <9d809068-1100-0ffc-6508-43e029543949@rock-chips.com>
Date: Tue, 6 Feb 2018 22:10:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205181758.GA22738@usblab-sd-06.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jack,

在 2018年02月06日 02:17, Jack Pham 写道:
> Hi William,
>
> On Mon, Feb 05, 2018 at 07:33:38PM +0800, William Wu wrote:
>> Refer to the USB 3.0 spec '9.6.7 SuperSpeed Endpoint Companion',
>> the companion descriptor follows the standard endpoint descriptor.
>> This descriptor is only defined for SuperSpeed endpoints. The
>> f_fs driver gets the address of the companion descriptor via
>> 'ds + USB_DT_ENDPOINT_SIZE', and actually, the ds variable is
>> a pointer to the struct usb_endpoint_descriptor, so the offset
>> of the companion descriptor which we get is USB_DT_ENDPOINT_SIZE *
>> sizeof(struct usb_endpoint_descriptor), the wrong offset is 63
>> bytes. This cause out-of-bound with the following error log if
>> CONFIG_KASAN and CONFIG_SLUB_DEBUG is enabled on Rockchip RK3399
>> Evaluation Board.
>>
>> android_work: sent uevent USB_STATE=CONNECTED
>> configfs-gadget gadget: super-speed config #1: b
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in ffs_func_set_alt+0x230/0x398
>> Read of size 1 at addr ffffffc0ce2d0b10 by task irq/224-dwc3/364
>> Memory state around the buggy address:
>>   ffffffc0ce2d0a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   ffffffc0ce2d0a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   >ffffffc0ce2d0b00: 00 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>                           ^
>>   ffffffc0ce2d0b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffffffc0ce2d0c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ==================================================================
>> Disabling lock debugging due to kernel taint
>> android_work: sent uevent USB_STATE=CONFIGURED
>>
>> This patch adds struct usb_endpoint_descriptor * -> u8 * type conversion
>> for ds variable, then we can get the correct address of comp_desc
>> with offset USB_DT_ENDPOINT_SIZE bytes.
>>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> ---
>>   drivers/usb/gadget/function/f_fs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
>> index 6756472..f13ead0 100644
>> --- a/drivers/usb/gadget/function/f_fs.c
>> +++ b/drivers/usb/gadget/function/f_fs.c
>> @@ -1882,8 +1882,8 @@ static int ffs_func_eps_enable(struct ffs_function *func)
>>   		ep->ep->desc = ds;
>>   
>>   		if (needs_comp_desc) {
>> -			comp_desc = (struct usb_ss_ep_comp_descriptor *)(ds +
>> -					USB_DT_ENDPOINT_SIZE);
>> +			comp_desc = (struct usb_ss_ep_comp_descriptor *)
>> +				     ((u8 *)ds + USB_DT_ENDPOINT_SIZE);
>>   			ep->ep->maxburst = comp_desc->bMaxBurst + 1;
>>   			ep->ep->comp_desc = comp_desc;
>>   		}
> Please see my alternative fix for this. I proposed changing this
> function to use config_ep_by_speed() instead.
>
> https://www.spinics.net/lists/linux-usb/msg165149.html
Thanks for your great job!
  Your patch seems good, I will test your patch on my RK3399-EVB board.

William

>
> Jack


