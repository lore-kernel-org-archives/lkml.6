Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2715842-1517464279-2-8432829308309409958
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517464279; b=l2YAXmdmi0zmvmqsJjcn9rzq9Nu279oaNkK6LZOtDHElAMd
    EO5pn0wEjpeYuolLPD1TeMEACo85MBUECcNVvDgQ3J7K/YazMZS7E+t2UkLXaJb2
    AdggdooS+fvdi9eH7PDN8WUlB3jQzFDzYcL5nKKAXTfi6QsAA5qeBvZdU/tgALGD
    NvUgzJxoknAxPnuQL3pwR2YdjuAxU9Cys6gG+DrobCug/TkuXXgsJOLh5eY+je+g
    aq6hHS2SF04AqMhZsso+u1r53HKUfHk1BIf8BDsdFxfzsAjpGjL6OHrsRuZdG7W4
    g54K0nrfAjPedBt0M6G8OEx+9NcqFQnM7WvzG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517464279; bh=7W1tHItgtiM/uU6DeFzG0ExKOOk0D8TnxNAuwTZxRwk=; b=F
    he7oqkADBeyvnGNFjIp6hcK+5wCEAfrtCV1x/2NTbz5IgQbZD7OXsAGV5qhvAOP5
    Z/P54zEpG/TCx5jsFnuNf+PqJzbHPtAWhpFxhsdCxGYYiLIxeKp2yoLQLcjto2nc
    bkBr5oOWlIEl0eTgDsktFaq1+nw1HbjXHAvY7lg3v/mDgNDR9fiHBMGBRjsSgKtp
    fZdIzidXTo7DCO85jiF2N+hSuGFM/tOhP+0cJWbtV320tGK0S9CQahi5kbv1vSb5
    gKSjyfpAyInye2dUsBmJ9xQJ/A4FzI4R+y1EO0mAzWU/YEMrVwXQjCuEr1uuvPHw
    2gANOYipO9shnw9STmqmQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FUvdKuCf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=c5/n23xV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FUvdKuCf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=c5/n23xV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeBAFvD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 00:51:03 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:44633 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeBAFu7 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Feb 2018 00:50:59 -0500
X-Google-Smtp-Source: AH8x226Pd1djdFIR9IHD8f8SvFJgQv8NLi6o89oN1OvzhIrjjEDl8iAe7NF3KqqmiN8pU99c4KZOmQ==
Subject: Re: [PATCH 5/5] USB: serial: f81232: fix bulk_in/out size
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <1516607927-8887-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1516607927-8887-5-git-send-email-hpeter+linux_kernel@gmail.com>
 <20180130041150.GC3434@localhost>
From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <840d55b0-9ce2-846d-9bf5-8d0e67b8739e@gmail.com>
Date: Thu, 1 Feb 2018 13:50:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180130041150.GC3434@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Johan,

Johan Hovold 於 2018/1/30 下午 12:11 寫道:
> On Mon, Jan 22, 2018 at 03:58:47PM +0800, Ji-Ze Hong (Peter Hong) wrote:
>> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
>> index a054f69446fd..f3ee537d643c 100644
>> --- a/drivers/usb/serial/f81232.c
>> +++ b/drivers/usb/serial/f81232.c
>> @@ -769,8 +769,7 @@ static struct usb_serial_driver f81232_device = {
>>   	},
>>   	.id_table =		id_table,
>>   	.num_ports =		1,
>> -	.bulk_in_size =		256,
>> -	.bulk_out_size =	256,
>> +	.bulk_out_size =	16,
> 
> So it seems you should really be setting bulk_in_size to 64 here (and
> possibly leave bulk_out_size unset) as that would appear to match your
> device buffer sizes.

Yes, we want to set the bulk_in_size as 64. The public datasheet has
some error with bulk in/out, the correct size is 64.

We had test the bulk_out_size set the same with internal TX FIFO will
make the best performance in tests, but it's ok to set 64. In my opinion
, I'll prefer to set 16.

The following information is the F81232 dump by lsusb:

Bus 002 Device 007: ID 1934:0706 Feature Integration Technology Inc. 
(Fintek)
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        16
   idVendor           0x1934 Feature Integration Technology Inc. (Fintek)
   idProduct          0x0706
   bcdDevice            0.01
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3 88635600168801
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
Device Status:     0x0000
   (Bus Powered)

Thanks
-- 
With Best Regards,
Peter Hong
