Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-120844-1520458940-2-14663821265713985361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520458940; b=sCuAbl4vp5s3UTPQoXgZ+AcubbmrcCd141iKdfjAXDBUB9H
    EorDWtOUU2W3CVB6peqlxwrgM2rX1p5RyZol/Mz7o977LEyj8S6j18+Q7fbWPYiQ
    EhU2I9RvbWUBBimIbNFMq45AkRx/lhUuxIqxwNw3m6VsUd0ySg3M2Y2u+g9kWyNr
    q9VeFRowBzfxP8wU6l99RLB1cbk4SxRfOpWlH9wIK8SNAs0RvG1yVBW1S8VzpOuf
    hWKt4lR1JjvzAg1p+9b8cLMDhzZDF2a8jS5Xt4Q4F5kq2+goFRgx4GFRALK7Piaa
    YY4B7V0Of/hQdIo2M/EWGIecgv0Ob2Yv7/J/uQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:to:cc:references:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520458940; bh=F8un6KR2CsEZ5duSIVCkivfOex5ji8d3dCXaqqIJUbI=; b=Y
    pASIsL0NyEE9CGc8E0BebF/9uAq4e2x2eQI5M9s3qPOZ/0yw5hSvH+snqZ+/nSNM
    1zFHE0UvXtpFUkKmgKjc4SBVdP3J1LQamPw2Gy+qR58ZLZtz3cYoDpsBDwZQ1cmn
    sXsYQwOReiJB8CpFw1FztJRuorLNUhQ/Z0jf4dueUJtYy5KNpchLMeg8ZsWmbOmL
    8YmqUFwl5qCWajTBCitePVOZT052oqJ0dLrnaKp1iDY+anVc6xj0D/ADSpgTsdIQ
    VdIgQeC3SxWpFzCZbwGiSNuS2Gbrv1DPDGKsUr5oN3QMVO6zvimeB+0JCliu8wYN
    vYb0o2vUFrIN4TCFmGmKA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754745AbeCGVmF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 16:42:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:38278 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754547AbeCGVmF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Mar 2018 16:42:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="22840671"
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] USB: serial: Add boundry check for read_urbs array
 access
To: Greg KH <gregkh@linuxfoundation.org>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f48feae7582a5669422066b4821a9e310eebc9ba.1520454192.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20180307205840.GA6242@kroah.com>
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <0055f93b-8497-5dfc-4233-9cc72bf690fc@linux.intel.com>
Date: Wed, 7 Mar 2018 13:41:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307205840.GA6242@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/07/2018 12:58 PM, Greg KH wrote:
> On Wed, Mar 07, 2018 at 12:23:56PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> In usb_serial_generic_submit_read_urb() function we are accessing the
>> port->read_urbs array without any boundry checks. This might lead to
>> kernel panic when index value goes above array length.
>>
>> One posible call path for this issue is,
>>
>> usb_serial_generic_read_bulk_callback()
>> {
>>   ...
>>   if (!port->throttled) {
>> 	usb_serial_generic_submit_read_urb(port, i, GFP_ATOMIC);
>>   ...
>> }
> How does i ever get to be greater than the array size here in this
> function?  It directly came from looking in that array in the first
> place :)
>
> So I don't see why your check is needed, what other code path would ever
> call this function in a way that the bounds check would be needed?
void usb_serial_generic_read_bulk_callback(struct urb *urb)

385         for (i = 0; i < ARRAY_SIZE(port->read_urbs); ++i) {
386                 if (urb == port->read_urbs[i])
387                         break;
388         }

In here, after this for loop is done (without any matching urb), i value 
will be equal to ARRAY_SIZE(port->read_urbs). So there is a possibility 
of usb_serial_generic_submit_read_urb() getting called with this invalid 
index.

>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

