Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2141624-1524728947-2-6476029837758305002
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524728946; b=WER29nw0ICVn1tXuGDL2Z5u7dqcjZc7FmPCicX0FMoFiYc6lOf
    Ee9CBYMKorefbHysOyaAYpH8+IwIiNLe2oKgBe1EnikmWWgLGNzJVWVT/ZcvWSei
    1hcfz4YZNHD+Rqmpj9Pz1n73QxbvBzsCLNL9UWlRZOFWmQIlXgDszs4i5WxyoD2o
    JPcCea4ZH7BS0eCWesI7r3wecyBiyervnSGOCJ7ELSGU++SN46EOCpvAiPP16MmH
    k78Vrf57+ymYxzXiz2cY/vp2WCDJ/EnvJu/7SBACifiIM1KcQq168g6IJPE/yrE1
    oHhrz9ZkoYLmqaFpS+Q8S1qJZ7DJqpTA/x+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524728946;
    bh=PxdS8lPzUQQEPIzI39GNym5s3Gb1lkv6BNYb0XhsnAU=; b=NBGiYTzDhC30
    3L4nDuaNLgNQU4mGkEq6igIKu91Z5X2cjAD29ykdw8T7P3r5dXxNScSsfrU4jVoM
    O+DbHLwwdIJvwqMdGOYp/KL2iIQwOMUT5shchkRlSX7D2BczvrdjmSxIRd7PUg9Y
    AsrAEsLexZd230RWbyTbdIvtRxnAiNKx6+9lEjqxGOl5y0dBBw1JiNdrIRKpRciV
    MBoNZ47j2eeHfPwoz+Ow8hWIujBL96rxXwKVvm8vBqHJ+uBhSeN9tGilSRxYwAP1
    gwE0lQgz/45eL082f6VJZV2yhRnOPjAMc0FqhRTIAqJQwPs8mxra3ItRhguvO+P0
    QO5eaCjMtQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UY751OfP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GWuazn69;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UY751OfP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GWuazn69;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBOtN6L/6uYILpaMdAOVGlyrmZV9GANN2UjHZkPaee5O6PoQ7BD7IwKsiLGIuczS/yQsrrCaBx31MHf9CRHIKnwLCN7tkN7RbOyA0NclKm9etul9LPwI
    30QGbw8ujXBCnXaOiWq9w6b4kgD8IIehwb2uE9m7Xz2R2QNeTObULucQopIxiB9yZKZgXUAWLqe4kgIOkIbQrCgVBzVYxky7x9fRDU3sXnXeOgHzu1x58t8e
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=CjaL-clQNZYA:10 a=Kd1tUaAdevIA:10 a=dZ7Af3Q_AAAA:8 a=VwQbUJbxAAAA:8
    a=PeUCudeUK7nmzZRlsKUA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=xnyMoErWsJe9py2mg6Iw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeDZHtB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 03:49:01 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:38588 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeDZHs7 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 26 Apr 2018 03:48:59 -0400
X-Google-Smtp-Source: AB8JxZrFYQFjJRyd4HTs8Qgf74iqAacU63ZLRjgcy77wAs3uk8DiFl+Cx3zitvG2mo7GZGJXEdt/ew==
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
To: Johan Hovold <johan@kernel.org>,
        =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
Cc: stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180426062831.320-1-sz.lin@moxa.com>
 <20180426070927.GT4615@localhost>
From: Lars Melin <larsm17@gmail.com>
Message-ID: <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
Date: Thu, 26 Apr 2018 14:48:54 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426070927.GT4615@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/26/2018 14:09, Johan Hovold wrote:
> On Thu, Apr 26, 2018 at 02:28:31PM +0800, SZ Lin (林上智) wrote:
>> This patch adds support for ublox R410M PID 0x90b2 USB modem to option
>> driver, this module supports LTE Cat M1 / NB1.
>>
>> Interface layout:
>> 0: QCDM/DIAG
>> 1: ADB
>> 2: AT
>> 3: RMNET
>>
>> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
>> Cc: stable <stable@vger.kernel.org>
> 
> Applied, thanks.
> 
> Johan

With a Qualcomm Device Management interface, shouldn't this modem be 
driven by qcserial?

/Lars
