Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-353908-1527091670-2-16857144984160371369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527091669; b=J/4aZvX6he4q25PzcN7XcyAskmZk+cIp8ddx8RX6gpS0gk5MfT
    VK+8B5YJaspNDCpMgrZ7/bViTEbOUeuT4V6Sx5+Fl4qGB0U3w0B0YETwbkRDsSnG
    VH2R/O0Zvq3pDxpekMFCyAvEO7lITlyls4PxoUp/C3KIQyFFtr3WCrjXN6sv6T6R
    bHQRiO22CxR/dRKH6cl3axepsAukeIJOIMhado2jryn+1MRCmbvCNEX0lBHFsH8w
    okORP8UTFW5uWOSNp8J5hJFR1IabgHe42bgGX0/BWdQmhtSmbTI9ryx20J9PaNmu
    DnBSL7hwUvc+EkcEjnJDfFiw69/mx7NybMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527091669;
    bh=LC0xk1v639irque2CZv2KrlZOslmdkcFp9yFBcUAZ8c=; b=ntAWhA4zAueu
    uNDF9qASKEInVhLxuYczdl2nJhP0RHZ2dyp/4zgYTKCk4UuLfk71gSEWOYoThbVw
    esY6PPTXYWvR0ipWOmoocNUgCglqXaCRu7xqCV1BJlLgslLJP0ojwbRZ+3eEwcSY
    anVN6Z8Beo64KnI7P5JH66za+MetJ22kArK1BaZfajhPnAXmKxlmC3wQ6eG8Dfhg
    rfhvPIvy9tiHZIcNUXNInJ2mhobz06QAjrOqHi0BHWrhnWsTLi1dR4yNR9J07LYU
    h6oL+Da+Y1Yloupm9XHvNRMlzHtDqqdrbt23kwimP7iJswElqyt9P5l3q/neRX5P
    fEJWtn/feQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=cogentembedded-com.20150623.gappssmtp.com
    header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=ir7wXn9O
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=h879qdKa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=cogentembedded.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=cogentembedded-com.20150623.gappssmtp.com
      header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=ir7wXn9O
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=h879qdKa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=cogentembedded.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH4neQNoCyV4Wc6tlhPQjqk+ZCsXct/YuiSNKmGP8nashAfMAc+YZrBJQRf5Dtz+/duJeCXBF2ukU6yR3dnOf7YiVdbCiP4iVZ6DZ3KALQPyJTA2vLqj
    +lKlFK/qp9uNiQhYT3itf1XZQCLYOO+pQUz8ao3PKLdeXONlgigC00p//s0RCdD7aW7/EvCMkDvCwwLI6NrVQlA75RXKABDgECDegIzHQn0wX+MmBfALJbGF
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=3SToLZCV_L9zhH-NIxIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbeEWQHo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 12:07:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46910 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754676AbeEWQHm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 23 May 2018 12:07:42 -0400
X-Google-Smtp-Source: AB8JxZoExjKr6BjkHLk1Epz5a4NHjJyuYuQPnTmbBImHFEDB9HDbnngm7+s2hsmioIX5KyFTHjy4JA==
Subject: Re: [PATCH v2 3/3] usb: typec: fusb302: Fix debugfs issue
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
 <20180523143758.66348-4-heikki.krogerus@linux.intel.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0f88eb2c-9487-d1d8-7dc5-867238b117ec@cogentembedded.com>
Date: Wed, 23 May 2018 19:07:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180523143758.66348-4-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 05/23/2018 05:37 PM, Heikki Krogerus wrote:

> Removing the "fusb302" debugfs directory when unloading
> the driver. That allows the driver to be loaded more then
> ones. The directory will not get actually removed until it

   s/ones/once/?

> is empty, so only after the last instance has been removed.
> 
> This fixes an issue where the driver can't be re-loaded if
> it has been unloaded as the "fusb302" debugfs directory
> already exists.
> 
> Fixes: 76f0c53d08b9 ("usb: typec: fusb302: Move out of staging")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
[...]

MBR, Sergei

