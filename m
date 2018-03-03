Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3941094-1520068488-2-9897207677853856087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520068488; b=jlqOfiFKltQ61wz/oMDcbwGXzljRPmZnIJWfZoxKch/Zv2N
    HcLKpqvSJyvjcECiuhZuveDIWFBh21EsQYe5pX2TMCfOmUsRafnOrI4Fr7aFtXnh
    X95VGXQrHvKaNY+1IzzH3p8Cxr281nQfU38GLu2Ze8X45Wuy0gen64y2/Vi/A1Sy
    OYWTesHjytSzm1QWAaIOcrTXHHpEjvSzuwJV+D0hsrwimZ0MJXCycCYp+DY58Nj4
    ydU89hW4jKTzXZilTjm9X4/JA8XJ2+X7D6WXaOD7KzqZ9O7teT3gW5OLf7K3Braq
    D5aMTDUjC0tAYkBn0mqFqkmgf4xRk3R11wEIDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520068488; bh=GByzKZk2HF+E3QjlACTvBgwpBgv4BY5/iB0CzLxWo7k=; b=F
    nIo0A1WEqy75OMtAyn3H2jk7I5ww63MYRz/SvgXEYmdonvCL3ZMWaHvGU8nKK7xG
    A5drOelpT7NO7IyofPdeEboBN/GfP74RLIyYnc1qEyf6isyrJkk5Li9xYAL2MQ33
    KGUeCAGeMXg9w/x4hbHUMOR3u4XfdaEomy+RxTYHOR3u43ZzW5A5QcKHn7Bt0GQW
    fbqMItztnYLBL7TqQlByoAQGLXIS7pHD2ewdRtlWSHxH5iuWAK9WRAFQcBRgoRWi
    2MDnsUWsn4pp5T7iLzWDriF13D5arFcrxJ2DVWJXL/YrNtbk80OI2pdCHAxuuHMd
    Qt9ESHrRhlL7JOc7FFO+g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rXdLNn3+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rXdLNn3+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeCCJOp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 04:14:45 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34747 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeCCJOo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Mar 2018 04:14:44 -0500
X-Google-Smtp-Source: AG47ELu9pBZ3VllMDsMaSi5ubjbBBJOwYSNoJ3A5YYhz2WxMFOcsplOK4OoGCYlqbFFEYlVc7gLo0Q==
Subject: Re: [PATCH 4.4 64/67] usb: uas: unconditionally bring back host after
 reset
To: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Oliver Neukum <oneukum@suse.com>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180202140815.091718203@linuxfoundation.org>
 <20180202140822.268335379@linuxfoundation.org>
 <1520036364.2786.39.camel@codethink.co.uk>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5ed38173-5fd6-eaa2-b838-632829471aec@redhat.com>
Date: Sat, 3 Mar 2018 10:14:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520036364.2786.39.camel@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 03-03-18 01:19, Ben Hutchings wrote:
> On Fri, 2018-02-02 at 17:58 +0100, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Oliver Neukum <oneukum@suse.com>
>>
>> commit cbeef22fd611c4f47c494b821b2b105b8af970bb upstream.
> [...]
>> --- a/drivers/usb/storage/uas.c
>> +++ b/drivers/usb/storage/uas.c
>> @@ -1052,20 +1052,19 @@ static int uas_post_reset(struct usb_int
>>   		return 0;
>>   
>>   	err = uas_configure_endpoints(devinfo);
>> -	if (err) {
>> +	if (err && err != ENODEV)
>>   		shost_printk(KERN_ERR, shost,
>>   			     "%s: alloc streams error %d after reset",
>>   			     __func__, err);
> [...]
> 
> This should be checking for -ENODEV, shouldn't it?

Yes you're right, the check should be != -ENODEV.

Oliver can you do a follow-up patch fixing this please?

Regards,

Hans
