Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4112161-1518780087-2-5716037414703545393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518780086; b=FSOnfnhM9qz/jv2+LlDvu+XFUcqEbMy7GLKffg1OPAK41Si
    t0ie+5NtvYMG+o8WMgCukL4eLkmyeLHF75pp4HMSOgIFBLfrmEw9957M530dbp0w
    KFF/G1K7XlkmK/wTL9qwYZfeTwMdcEXk12Y9EGx4dqxHZS6InXbsJxA5sFZiSPqN
    ZFwKRkWDq3LwGvEM0zx5RtXTSyyxSiHO7JEy5o05ibMgqZdU9AGbugELddIslidc
    A1eTzLAAhr0kDSX04reoFYr82zFiaVvz2BNB5zrTxIE0S3VWhJ9ZmQ97ZKTimCg6
    6eV04+y3jmmJIgLUrO2DSMKiz42p+OOa0OGxWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518780086; bh=rUe8etomaRaAw/k7FNhaaVvlmm4n3cIa+KNsFrujV7g=; b=S
    0rB/Gz/GsMesXLqOtKr8+KsBv9/9sacGCOhY3qIiRziFk+oSS+nzcvFOLet9NVZo
    b4Sc21qmkPhNaj7Fxt0ZZMaxkcWqEkJsalk1EIG5q3MUT+u6ORcLMdZz7a/qCNW7
    ZYCiWTBLMEjnlzlNVYfOJAeXoqVlfPxbURqa4Gt6CiWK+gJq+Y326LWs78twH4id
    U2RYD2E7NSsHR66HOAiKqy+J72vfwTGM/5xxk0v+d+C1MzbpCyh63APyn66MCdvf
    SWtUEEBdlrOzdpzzdKd8y8e5m+x93DraAV9VTNOxKmF2dq4HGejYoDi5Ewc1Qu4L
    tBW/g/oRxAnH29tSE1qrQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bIslCWcy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bIslCWcy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935472AbeBPLVV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 06:21:21 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44102 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935467AbeBPLVT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 06:21:19 -0500
X-Google-Smtp-Source: AH8x227YqFioM9a7N3tZ1Ik2lzLMFR5WO0Y0klOnk41EfFNWagtnMyBxk7sOIyt1r7r/3las8FlxvA==
Subject: Re: [PATCH 01/12] drivers: base: Unified device connection lookup
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-2-hdegoede@redhat.com>
 <CAHp75VcyrUvPzojY1J2cUheuYz6mRCP_VppSx740ELanNaQ+Hw@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ee0d4723-ab1c-85d8-e6b7-a66e1a045b02@redhat.com>
Date: Fri, 16 Feb 2018 12:21:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcyrUvPzojY1J2cUheuYz6mRCP_VppSx740ELanNaQ+Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 12:00, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> Several frameworks - clk, gpio, phy, pmw, etc. - maintain
>> lookup tables for describing connections and provide custom
>> API for handling them. This introduces a single generic
>> lookup table and API for the connections.
>>
>> The motivation for this commit is centralizing the
>> connection lookup, but the goal is to ultimately extract the
>> connection descriptions also from firmware by using the
>> fwnode_graph_* functions and other mechanisms that are
>> available.
> 
>> +void *__device_find_connection(struct device *dev, const char *con_id,
> 
>> +                              void *data,
>> +                              void *(*match)(struct devcon *con, int ep,
>> +                                             void *data))
> 
> Perhaps swap them, since data is dependent parameter to match.

The pattern of having the data before the callback function is not
unheard of in the kernel. Changing this now feels like needless
churn, but if there is a strong preference for this then we can
fix this for v2.

Heikki, do you want me to take care of minor changes like this for v2?

> And put match function on one line disregard 80 character limit?

I think that breaking the 80 chars limit here would make sense, yes.
Any other opinions on this?

> 
>> +/**
>> + * struct devcon - Device Connection Descriptor
>> + * @endpoint: The names of the two devices connected together
>> + * @id: Unique identifier for the connection
>> + */
>> +struct devcon {
>> +       const char              *endpoint[2];
>> +       const char              *id;
>> +       struct list_head        list;
>> +};
>> +
> 
>> +void *__device_find_connection(struct device *dev, const char *con_id,
>> +                              void *data,
>> +                              void *(*match)(struct devcon *con, int ep,
>> +                                             void *data));
> 
> Ditto.
> 
>> +
>> +struct device *device_find_connection(struct device *dev, const char *con_id);
>> +
>> +#define DEVCON(_ep0, _ep1, _id)                { { _ep0, _ep1 }, _id, }
> 
> Please use (struct devcon) here to make it possible to do like
> 
> struct devcon foo;
>  > foo = DEVCON(...);

Good idea, will fix for v2.

Regards,

Hans
