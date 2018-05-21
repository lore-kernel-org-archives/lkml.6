Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-202972-1526886374-2-3769194575861927766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526886373; b=GVC19rAATIG2BYqaksDng3k4QnIJSq7q0qn6Kn7a+NQ88ODYSr
    U9JsLKIcq62Ru8Vr9c3SxQMd1tm09ByHe3Y+GYMupJUurjG99Vh6v1CIxXmcDssn
    UZrOus7l66uOvexk7yF0aQvxIW0R/kPzL47wXC+8T/XAJErmtt8L5UGPjI+uoiQ5
    5rumaN1ldpByeQS+2wnPZgv5C2HOaAGh+kSv9zyNHNKXEZT/f9/oBlkJKgc+Bawk
    lKrS9NjMi/LORi3jOB3sEJod+twBFAr5JIjrkVObZdfmzvh57qUnG+UEWBpApM3j
    kisYFnMPzT+yAxRzSPLC1PL10giyVHGjetfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526886373; bh=PK1TT6ZbjoZS0KeIXNyqQXmXBGTE4oOzWtOMqzT5px
    M=; b=Ld5dB8QNUyiX7hQieG7YQrwFOQ2ta2JO9mf6LifZ7eQsdDzkoeuD4+kJY8
    tDZk6w7hP+lCU8r5omq4NcWn/kfSLATpzbqvde6DkB4id6lOLtGHEeaeThCg4XMT
    vLnMoKR4LqNMfuzoY4r35clSScCFNOxM/NOLiOMa5Q9uPLNJCYvCRfG+HL3+hllX
    NMvaWFOJm6S7YO4v9NC+6Nowd7TvHtObldMpwt1QNcMQymq+k46iy/LCbTqRDnAx
    9+qQeOgP5Ts9zPTH0twtK/LOVU6/M6VnqZlWOZCoS/UkuBExyWTn+NDlyZo4FhAg
    CrGFN1W98aSnyr2PJMcpBrMiCLxQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=endlessm-com.20150623.gappssmtp.com
    header.i=@endlessm-com.20150623.gappssmtp.com header.b=brpTBa3k
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=lf/63Xci;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=endlessm.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=endlessm-com.20150623.gappssmtp.com
      header.i=@endlessm-com.20150623.gappssmtp.com header.b=brpTBa3k
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=lf/63Xci;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=endlessm.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIC7aCQwqSBHU28QXoi9m8ldejzgapX5tSEGpD64BltDLDz0nMvkpL19iQ7+/1DpAK9czLjscsoVFVDyGTIsnScf3GuZi4DTsWle/nb/kQesqlttVT/S
    BrAyeqAchC+sDYvUZ7b1v/iiDGVgM1sEXxpj8Sn79/WY6Wfq4yXKI15oCM3D9uhXithCyCnrmJfBqmQ9OfvmX9iDzoODWpCDM17V+iRLG+wsgRl2m18H3kfV
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=EqdPLkY1AAAA:8 a=78_i3PCYYbFZGGsL8_sA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=dfeKg4RqpEhWThG6bP4-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeEUHGK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 03:06:10 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39996 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeEUHGI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 May 2018 03:06:08 -0400
X-Google-Smtp-Source: AB8JxZpSBAY5WdaII2fnz/ixA8J97TW46xx9pCWZ8VgI9O8D7Qi4BkOnO7AOzpy15FVVp0Ph108ZECZIbwv9xtj0gd8=
MIME-Version: 1.0
In-Reply-To: <20180518104638.GF15419@lahna.fi.intel.com>
References: <20180518083827.20626-1-jarkko.nikula@linux.intel.com> <20180518104638.GF15419@lahna.fi.intel.com>
From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Mon, 21 May 2018 15:06:07 +0800
Message-ID: <CAPpJ_eenULHGQOSG7xOpdTh8gCuVpFW8V3u=gp1OfnXQY8Yw=A@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input clock
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jarkko,

We have tried this patch on the two laptops we have now:

ASUS X580GD

dev@endless:~$ lscpu | grep "Model name"
Model name:          Intel(R) Core(TM) i5-8300H CPU @ 2.30GHz
dev@endless:~$ lspci | grep -E '(a36[89ab]|97c[56])'
00:15.0 Serial bus controller [0c80]: Intel Corporation Device a368 (rev 10)
00:15.1 Serial bus controller [0c80]: Intel Corporation Device a369 (rev 10)
dev@endless:~$ dmesg | grep -E 'lpss|i2c'
[    9.692511] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    9.697702] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    9.920034] input: ELAN1200:00 04F3:303E Touchpad as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-ELAN1200:00/0018:04F3:303E.0001/input/input18
[    9.920204] hid-multitouch 0018:04F3:303E.0001: input,hidraw0: I2C
HID v1.00 Mouse [ELAN1200:00 04F3:303E] on i2c-ELAN1200:00
[    9.923873] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
[    9.924806] intel-lpss 0000:00:1e.2: enabling device (0000 -> 0002)

ASUS UX550GE

dev@endless:~$ lscpu | grep "Model name"
Model name:          Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
dev@endless:~$ lspci | grep -E '(a36[89ab]|97c[56])'
00:15.0 Serial bus controller [0c80]: Intel Corporation Device a368 (rev 10)
00:15.1 Serial bus controller [0c80]: Intel Corporation Device a369 (rev 10)
dev@endless:~$ dmesg | grep -E 'lpss|i2c'
[    6.926801] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    6.940907] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    6.971915] input: FTE1200:00 0B05:0201 Touchpad as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-FTE1200:00/0018:0B05:0201.0002/input/input21
[    6.971961] hid-multitouch 0018:0B05:0201.0002: input,hidraw1: I2C
HID v1.00 Mouse [FTE1200:00 0B05:0201] on i2c-FTE1200:00
[    6.973930] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
[    6.974700] intel-lpss 0000:00:1e.2: enabling device (0000 -> 0002)

The patch works on both of the laptops with the touchpads.

2018-05-18 18:46 GMT+08:00 Mika Westerberg <mika.westerberg@linux.intel.com>:
> On Fri, May 18, 2018 at 11:38:27AM +0300, Jarkko Nikula wrote:
>> Intel Cannon Lake PCH has much higher 216 MHz input clock to LPSS I2C
>> than Sunrisepoint which uses 120 MHz. Preliminary information was that
>> both share the same clock rate but actual silicon implements elevated
>> rate for better support for 3.4 MHz high-speed I2C.
>>
>> This incorrect input clock rate results too high I2C bus clock in case
>> ACPI doesn't provide tuned I2C timing parameters since I2C host
>> controller driver calculates them from input clock rate.
>>
>> Fix this by using the correct rate. We still share the same 230 ns SDA
>> hold time value than Sunrisepoint.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: b418bbff36dd ("mfd: intel-lpss: Add Intel Cannonlake PCI IDs")
>> Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
>> Reported-by: Chris Chiu <chiu@endlessm.com>
>> Reported-by: Daniel Drake <drake@endlessm.com>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Tested-by: Jian-Hong Pan <jian-hong@endlessm.com>
