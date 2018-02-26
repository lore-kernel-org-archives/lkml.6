Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252317-1519632480-2-13133703665960281887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519632479; b=lAdorBdJNEh05WFHqTfacs+asCNNwg1kOIrxvTISv/QruuZ
    zN8hrSilpoa7UbPqx/KbMEAT15MN10er13m1WOKGdngMjk0CMxGg25gVI9hd3AhF
    TTcmfVzr9m8kISXf9m4jfqSfROVq28C2m87Wjh+LQkR0R0oDAGImAbAQAothCrzm
    vMYc86rr+bPlWqTZR/hj2jkQADtUfyUYkqR/3olm/PWozh2ohZfrTb+cI9/boYbk
    D0DCx9gQHtv6c+jP0MAagKKl5a5q2SDs3dnnnMdU+SbGFD8ERkKgW4TUIkYlT7kR
    xsJ0bPizApc3F8NnJLIYjmovj1oINT+VNijTRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519632479; bh=F7dhP9fpZtTcVE8FTFpFcITuDkvUbRF/t8BCFsY9WtU=; b=h
    upctWqjO8Y3sNZ3BTng5FJXhIUvoCJXXqM5ALF7n3bpDRTcCLP6nniPfqEJQM+oh
    MxMOsdjqZFO6CsrwDdEkZzSH/+rms0vO7SJsfc2AFpnbdX/wFo4mIFq9AW/PXLtk
    RtmvWPphn6FAlZ6UyAF+xb4+UD3SxIakyh5CC+lYEgkgGKm6AhskG7rZ3GOHgn+8
    5S7BteXzeoI2PHceHCaiU5Up4uzAl6XO0mxU56BNHpNCQlGMHwcn+7BL5f7Z9Mxk
    WEq/yhzNVSH9ewBfIn++xid6N0EjB6fYkLVpHAcjZW+TdeTF6J2g6f/ikEwFp9iH
    D4CcyDh1Tgtcc3BSZEMWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YFdeAbgd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YFdeAbgd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeBZIHq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:07:46 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33583 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeBZIHp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 03:07:45 -0500
X-Google-Smtp-Source: AH8x226fFr47GKKtYJK87+DwDFfCsZUdmKmkum4xxgINjm8otVANVSGxKKCllDK7CbPQPvaP0k/RNA==
Subject: Re: [PATCH v2 12/12] extcon: axp288: Set USB role where necessary
To: Randy Dunlap <rdunlap@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180225152510.10159-1-hdegoede@redhat.com>
 <20180225152510.10159-13-hdegoede@redhat.com>
 <2e3c62b0-0d9b-4d30-654b-750055e6f515@infradead.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <478db279-c9c6-7fd2-b275-88789631cbda@redhat.com>
Date: Mon, 26 Feb 2018 09:07:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2e3c62b0-0d9b-4d30-654b-750055e6f515@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 25-02-18 19:51, Randy Dunlap wrote:
> Hi,
> 
> On 02/25/2018 07:25 AM, Hans de Goede wrote:
>   
>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>> index a7bca4207f44..de15bf55895b 100644
>> --- a/drivers/extcon/Kconfig
>> +++ b/drivers/extcon/Kconfig
>> @@ -30,7 +30,8 @@ config EXTCON_ARIZONA
>>   
>>   config EXTCON_AXP288
>>   	tristate "X-Power AXP288 EXTCON support"
>> -	depends on MFD_AXP20X && USB_PHY
>> +	depends on MFD_AXP20X && USB_SUPPORT && X86
> 
> Could that be:
> 	depends on MFD_AXP20X && USB_SUPPORT && (X86 || COMPILE_TEST)
> 
> or is there some reason that it won't even build on other $ARCH?

It uses:

#include <asm/cpu_device_id.h>
#include <asm/intel-family.h>

So it really should only be build on X86, it always was an X86 only
driver, but it now it really depends on X86.

Thank you for all the reviews. I will prepare a v3 with all your
proposed fixes soon(ish).
Regards,

Hans


>> +	select USB_ROLE_SWITCH
>>   	help
>>   	  Say Y here to enable support for USB peripheral detection
>>   	  and USB MUX switching by X-Power AXP288 PMIC.
> 
> thanks,
> 
