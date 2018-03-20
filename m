Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1351689-1521548614-2-5543124635190417361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521548613; b=ZiTUBigQcIQMxZHcAzupcrXGB813ujRqfcjSGGxVe6Lb8EI
    UoK5jTZHf6Fb+TR+VPuzF6/+yWayVOkwphKJHPuPGdBTb3M/LaChtzyPrBch8JFW
    mZk4qIZu7CimUKJrZUvgbDI9o1zgLhaK+s1BxZC13DmAu81TQ3fy7UY3uhduuCL+
    Kh0DP4BHloc06Guqf4vp4YzjufHe01TdZNWQElvDn/WWHjoIccHPs8irx3qpTsoJ
    fKbEjPZ+9QujarMSfAImGO5zEtkdsv2P6zEAvJTHlJBs/oryYLr+2cvzG/QYYG4H
    qxT7Q7GPwcduXtu8DdpguTN6783wYsJe8V502ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521548613; bh=8luXvbZp6F9SWwd5r7B4oCGfxuw7xWnLv50zEt6GZFE=; b=r
    XpOckHXiPUAD/6+7+LUYYwjyBaQ6wqRUZLbhTsZLZSoNI6mGTw4f3dTOTqeAMnGq
    s7Qrsaq87eiBnLlnVE6n0XWL5c7kRPsuW/iGsBEFfnB1CkxfudKbhia4P1374914
    ipWce4c4YpI2EDIYkyjAEO0Z3rweO/D6CsZq2ztbxEWTumlrud7cvQzp8VNjlIaq
    GXJ7LCqqdEhXZQg2KOBmJSaenpenqAeKyHC2+ejlQcUf+ReVFgFPy9tSXcnol2zC
    GIzHi3UEo9aw64RUp5AXnNZkzmCRvGAfqL4h3whv+8HxpxdX6TJ0coxNpvsaqVt2
    6e4vs5E1XHHlwXj+JIK/g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JltGZCwm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JltGZCwm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbeCTMWB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 08:22:01 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40603 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeCTMWA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Mar 2018 08:22:00 -0400
X-Google-Smtp-Source: AG47ELvCM2KnJANzycthIwMQJ7yueH1WBBoTxOVjjmEl8nVEAkiivSiWYnXCXCf5Q3u8c/aOQmJJYw==
Subject: Re: [PATCH v8 01/12] drivers: base: Unified device connection lookup
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
 <20180314131215.70833-2-heikki.krogerus@linux.intel.com>
 <20180320092004.GA21081@kroah.com> <20180320100412.GI11689@kuha.fi.intel.com>
 <20180320103259.GJ11689@kuha.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <eb9950fe-54fd-eda8-e678-f2216204f62f@redhat.com>
Date: Tue, 20 Mar 2018 13:21:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320103259.GJ11689@kuha.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 20-03-18 11:32, Heikki Krogerus wrote:
> On Tue, Mar 20, 2018 at 12:04:12PM +0200, Heikki Krogerus wrote:
>>>> +void device_connection_remove(struct device_connection *con)
>>>> +{
>>>> +	mutex_lock(&devcon_lock);
>>>> +	list_del_rcu(&con->list);
>>>
>>> See, rcu?
>>
>> True. I'll send one more version.
> 
> Before I do that, Hans, can you quickly check this and see that I
> have not made any more mistakes? I don't trust myself anymore with
> these.

This looks good to me (note I did not test only reviewed).

Regards,

Hans
