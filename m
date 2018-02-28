Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832570-2-6310777001794011634
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
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832570; b=cGPKvtT6XNzqUa8m52sL4LN+MG1twTE7S7mm5RD6V1RNzgx
    LLqV/ru1pvEJqwxOBJgDs2lgZgJFuly5x/IZszTKlCHxNpo2SoOyPZEA17V08lWc
    E7FN82eUCoe3nNcp5FaKLBvfKHE7xjiiI4uloTY3N1BLe0Yby9+kiHEVfwUhWwfY
    QgKXzkpMJcBFLBC1aeSqC9FWzUEzFRC9pAcB2jEaU4zm2zMuCX3CUs3saPBkn+LD
    swn2VGdwRt6GWWvOU+nbBUgHgKzXUK9uWVDdg6kIEwiyqIJIRkn8W1zlCsdwg4nI
    6YAITpWfYAe01VI9/a4PrML94RZuWMb/AlhemoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519832570; bh=GMxx5JEXq3uBc5lQZaWd6ppLwsH3aiCo2EzgUSgix+4=; b=Z
    KbBN9FzeJ8ux8gWrJYQnmfar3HmNrt8Rs6IT79tT6f0AMR4TuiMP6dTgGtDtx0Xd
    thXWZrvj4n5T48o77MdvFMXb7dEo5BtIIYDgaf1owOCmPIk227dh+iOzwAqmY6p7
    w1n/wqIzQbKCZt8+3QBI3gz0ztQYG6yY2ampi2Lyc+FrajOxoX71ypCAQkBeeAEn
    bdFN6l89R0t0+4JS5ONDp2C2L9o66cJhZWy3ZVuVhqPeFwvaE8qw+DTzSSUUGyFu
    V8pen6N3xcbWCS1bKJIRhlWUsI98VrZpsCqm95vgoIXOBjaOV77M8jCpxBD6L9O8
    h3sPF1ZYzQZAgiQbs1Z1A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=M2+4No8W;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=M2+4No8W;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932358AbeB1Pmh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:42:37 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33955 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeB1Pmf (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 28 Feb 2018 10:42:35 -0500
X-Google-Smtp-Source: AG47ELtJ4dZ6kQsLQq08HfV/Tfscuikp9PPBjmTs2Wbc5XSBAX9Ni3mlcq9mMRt/Z4kKOlptUoS+fw==
Subject: Re: [PATCH v5 08/12] xhci: Add Intel extended cap / otg phy mux
 handling
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180228150749.26831-1-hdegoede@redhat.com>
 <20180228150749.26831-9-hdegoede@redhat.com>
 <20180228151552.GA5335@kuha.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <070f5ccd-dfeb-1e47-681a-8e116472ef9f@redhat.com>
Date: Wed, 28 Feb 2018 16:42:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228151552.GA5335@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 28-02-18 16:15, Heikki Krogerus wrote:
> On Wed, Feb 28, 2018 at 04:07:45PM +0100, Hans de Goede wrote:
>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> index 96099a245c69..5917e3095e2a 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1825,6 +1825,7 @@ struct xhci_hcd {
>>   /* Reserved. It was XHCI_U2_DISABLE_WAKE */
>>   #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
>>   #define XHCI_HW_LPM_DISABLE	(1 << 29)
>> +#define XHCI_INTEL_USB_ROLE_SW	(1 << 30)
> 
> Did you rebased these on tope of the latest usb-next?

No I did not expect that to be necessary, but I see now that it is.
I've just done a rebase locally, any other remarks before I send
out a v6?

> This does not
> apply cleanly on top of linux-next.

Regards,

Hans
