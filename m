Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3839317-1519560715-2-3754543391063159337
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
    t=1519560714; b=nGOqeRPwCkdKUBwz4tb+at9LJGXVQzqGuDrVAYyjTsogMsS
    PiKYO+ojc3473lhqYqqzssR1vwPc6wJ8j1+HGf5PYkzVAFtMrnaV6+DpwzsVglgL
    0GjTbUaEhDuD5ukdvCrEICe5SkjWC5pB11R5j4tSGAQ7aEAAij3L2gAJvQwsrox6
    h9L9jiKDY7RRJ5HVJ8OjLVcR36/VWU/3txBQvfGxY087sEsFYMm1Px8OxjsPgHMx
    I1/6dGIoqm+wKKK6hEQExus13LPSGU88B4OygU39zHzSR+bSIj9DLMsRdau9Q9CV
    I7DVXEe7ZTF1YGwbKKlXFkEiOwR6SdsI+Vy1t7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519560714; bh=SD67quJyk2HLU6KWZEXTcsQsLkS7kjIDdcIzJN+E91o=; b=M
    dc3iOCZzUGBr9b9pFVgQL4t8avnUVJm2HDGysRGVqg6V0jyoXdarqhDP5hsSewxg
    9xV/q8fxrXsoPkrQNvYBs8iZ2aeivKUXkoh0m6+a7VqWGNAnm1vGW4wJR3oLRi4+
    s6jQxwZP0pCxjEa0V2tYZ1iOpodipFPMUPhMC1nawoPSpC+Dp7F5Aj1FBuw0ks7l
    rVkWQ8xu0iO86VuUSpNhtNEi7X1y855ongZnVF5opsjGKxxNNB9gv7xB7DxLy9zO
    pOGBGIiRmrbqJeyuooX6qJW4hFZ0dcK4yUZjfybpT1hALDcxS0cOaLhUsAE87VKW
    qFEsQk+GPIhaXgEPKsyQQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pI1qkN7b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pI1qkN7b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeBYMLo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 07:11:44 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35366 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeBYMLm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 07:11:42 -0500
X-Google-Smtp-Source: AG47ELsFaZQ+iSB1EJbGDY+FepyMnB9oL0Gg/M2I85alOEe4pri+GmRZHU4s7PyKdowQYvrAxMyW9g==
Subject: Re: [PATCH 09/12] usb: roles: Add Intel XHCI USB role switch driver
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-10-hdegoede@redhat.com>
 <20180216133850.GO1480@kuha.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5a5d758f-643d-7159-162d-50f053d99c17@redhat.com>
Date: Sun, 25 Feb 2018 13:11:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216133850.GO1480@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 14:38, Heikki Krogerus wrote:
> On Fri, Feb 16, 2018 at 11:47:48AM +0100, Hans de Goede wrote:
>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
>> index 060643a1b5c8..7d1b8c82b208 100644
>> --- a/drivers/usb/Makefile
>> +++ b/drivers/usb/Makefile
>> @@ -65,3 +65,5 @@ obj-$(CONFIG_USB_COMMON)	+= common/
>>   obj-$(CONFIG_USBIP_CORE)	+= usbip/
>>   
>>   obj-$(CONFIG_TYPEC)		+= typec/
>> +
>> +obj-$(CONFIG_USB_ROLE_SWITCH)	+= roles/
>> diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig
>> new file mode 100644
>> index 000000000000..e5c2bfaf8ba5
>> --- /dev/null
>> +++ b/drivers/usb/roles/Kconfig
>> @@ -0,0 +1,14 @@
>> +if USB_ROLE_SWITCH
>> +
>> +config USB_ROLES_INTEL_XHCI
>> +	tristate "Intel XHCI USB Role Switch"
>> +	depends on ACPI && X86 && EXTCON
> 
> Hold on... There is no dependency on extcon, or is there?

You are right, this is an old leftover, removed for v2
of this patchset which I'm preparing atm.

Regards,

Hans
