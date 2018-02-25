Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3951089-1519560992-4-6985486979311798128
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519560991; b=Kl3t/8dOQuC4AUSrhYb05Aaf4VrxsOLTqHheoQoTle3ouZz
    HoxTJaa3LIKbRSmnYD644ARpKREWqmJ48B2CaRjSvIxqmoFyQIwDe1ASvNp3sHfF
    LIsTwtEdaosZUdcJV7+GCDecG45fPV431cziR5chaNx7QykHc64qpUTGp+lRTU4k
    1RVhxWWvkY0SFgGTULHjiuMmeA9l2B0NJORcng6Iu3bzKBLUMU/Xi6mP8T4MMsmu
    Gc2HDN5x0afKaVUuP5b4pa3q8Mh62MoKGYTUqr9UmLG2+NLCU+KFfoCCptGY0BB8
    E77R9mf3/AAZiiCEZiHBooWHKqu6hhagyF9hytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519560991; bh=sSU7TOdI/+/PCiEgGAXvny5qUoPNDonqkHBIjboU38I=; b=n
    8Thty9f05K62rLlkRp0nh408Js5iLMLf089jmiH9JAhEQ3clY5cEbEAFI8ru32Cm
    955L2LCMjAY5NZrRLTOKZYEbB69Lltylt9Dtpd+KtkQLp1B2jK0E/nfAyQ/buO6G
    B1QlKD5rPZ/LjvYNQUdmC4aN9JRehk4Ii6zI9uJAADR225PZY4U2d7m6SxCXIhTm
    7nl/K2aIqiInvHi0nazEh7ekjvv9p1y0oFszOqHQu5WPiuY+mWTebD+C135HWG/+
    JpZnklyN95GXx5zhHdwQD0WscLXk+BELUoUJPu/S8vNHJOtjZ4DpKFeUXvL29Qs3
    Z0m45fczJoXirkJHZ+04g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h288ObKf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h288ObKf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeBYMQa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 07:16:30 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43587 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeBYMQ3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 07:16:29 -0500
X-Google-Smtp-Source: AH8x227EUhcBTgtKW/TjAdYD0QFwkS6DUkTAkYnVxMytuv+vZrYUz0PBOnn2STivOEgQ/K0PzyfPCA==
Subject: Re: [PATCH 04/12] usb: common: Small class for USB role switches
To: Randy Dunlap <rdunlap@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-5-hdegoede@redhat.com>
 <90191d89-0881-3486-87f9-59b355824927@infradead.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <d3f1d350-95f6-91f2-b67f-c2823f76d898@redhat.com>
Date: Sun, 25 Feb 2018 13:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <90191d89-0881-3486-87f9-59b355824927@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 19:33, Randy Dunlap wrote:
> On 02/16/2018 02:47 AM, Hans de Goede wrote:
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
> 
>> diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
>> new file mode 100644
>> index 000000000000..923e3721d183
>> --- /dev/null
>> +++ b/drivers/usb/common/roles.c
>> @@ -0,0 +1,305 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
> 
> Just use /* since this is not kernel-doc notation.

Thank you for catching this, fixed for v2.

Regards,

Hans


> 
>> + * USB Role Switch Support
>> + *
>> + * Copyright (C) 2018 Intel Corporation
>> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> + *         Hans de Goede <hdegoede@redhat.com>
>> + */
> 
> 
