Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9ADC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB3121729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8cyHtGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB3121729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeHHMUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:20:21 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46279 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeHHMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:20:21 -0400
Received: by mail-ua0-f196.google.com with SMTP id u11-v6so1667286uan.13;
        Wed, 08 Aug 2018 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IzmNrZ93nK5BPKakPluyD1BZFrzByvhqK+/1bc9EPiY=;
        b=h8cyHtGRgpONChphMytZycWg/UnB8OwWaeA68i4EyfGrKOe7uJu835gyL/Vtu4JBk0
         AKt4E+lb2WCOBZOLj3PXfhTDpmv5aFxcLJZXwlWKGQmUa8wNdbDFBJqo5c7WRTAJGtja
         2EpyAb7xHnEYt9hGuYK2A7RdrYBztHLAIGOR89URQNsBRm0VB0F4RjGjSKMD8dlFWIcb
         8Ye0M1w8XPgbYfeMWM5jzI1uX8lwyO3StV/IyK7WHEV/zjmLXoMFuBvwGFGaFFhQka8k
         QmI4NeV9TlhqgXd3wwSlDUucbOqLxxM7x9MVxCs00F0/6drOriaDlliMoSHdX6/mhePu
         qUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IzmNrZ93nK5BPKakPluyD1BZFrzByvhqK+/1bc9EPiY=;
        b=TJnyZt7V7/opGkLTFklhkPOBwW3JY2wr5NjhtYc37GoccplXgO/PGeyLaeAHn04rzu
         +AHHJCmOIe+9Kuwztpg614milkIiHazyHXKcB0Df27tuSOvRfUCfRaCRS/m3cc42V2Gv
         1XIHmTY+PqSmkVeAvwxCi4W7xTT03NA18/ehORkRXMaA3WjmOCRRNbrUzHd3ZDZzXlmZ
         8kyLujGbG2AwCoQ9JamCNut53sHphix0tOMM76BzdkQ05vt04FyIAW42eD3Bz6IU8XmV
         Oi9CNb3yAof6DxC6KM+Ir5ftBqVWRpoTgzOUvmjUXhXZX2SbdVzf4K50qoqRiII0JcY3
         hXVg==
X-Gm-Message-State: AOUpUlGksSiDMl54iD0ZLjftMyvwbBv7n3Ci1rQBPxJ7b1n9yVFHWCfS
        q5JHEp9Hd4xFcOIGOE80weNsvhcK6esP53ISO4g=
X-Google-Smtp-Source: AA+uWPzuGP294L9svZVoFe2nQlOaOngg2gMkPtPA11xMk3X02Nlu5rLTXLm/49B/fSAT/icwe3Ue3ltbg964KrD6vVI=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr1453089uai.122.1533722482486;
 Wed, 08 Aug 2018 03:01:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 03:01:21 -0700 (PDT)
In-Reply-To: <69e355c2-89ea-16bc-3d52-4ef9d0eb953b@axentia.se>
References: <20180808083006.31919-1-hdegoede@redhat.com> <20180808083006.31919-5-hdegoede@redhat.com>
 <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com> <69e355c2-89ea-16bc-3d52-4ef9d0eb953b@axentia.se>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 13:01:21 +0300
Message-ID: <CAHp75VdyEannOhudrqMvFqEMR3hZkJ+RG_cGojkte2EfXVmZ8w@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
To:     Peter Rosin <peda@axentia.se>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 12:47 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-08-08 11:08, Andy Shevchenko wrote:
>> On Wed, Aug 8, 2018 at 11:30 AM, Hans de Goede <hdegoede@redhat.com> wrote:

>>> +       /* Count number of clients to instantiate */
>>> +       for (i = 0; inst_data[i].type; i++) {}
>>> +
>>> +       multi = devm_kmalloc(dev,
>>> +                       offsetof(struct i2c_multi_inst_data, clients[i]),
>>> +                       GFP_KERNEL);
>>> +       if (!multi)
>>> +               return -ENOMEM;
>>
>> Here I see the following:
>>  - it's kinda unusual use of offsetof(), perhaps i*sizeof() + sizeof()
>> would be more understandable
>>  - there is no guard against i == 0
>
> I don't see why a guard is needed?

Because there is no point to have a module loaded when there is none
client to serve.

> *Your* code below needs it, but that
> issue is not a concern for the original code.

I can admit that's not a big deal, just making logic slightly more robust.

> It might however be a
> good idea to fail the probe if there are no clients to instantiate, but
> that's a different issue...

That's what I have in mind.

>> multi = devm_kmalloc(sizeof(*multi), GFP_KERNEL);
>> if (!multi)
>>  return -ENOMEM;
>>
>> multi->clients = devm_kcalloc(i, sizeof(*multi->clients), GFP_KERNEL);
>> if (ZERO_PTR_OR_NULL(multi->clients))
>>  return -ENOMEM;
>>
>> But I would like to hear your (other's) opinion(s).
>
> I think using two allocations is a waste in this case.

On the other hand it makes code more readable. With offsetof() it is a
bit hard to get it on the first glance.

>>> +               if (inst_data[i].irq_idx != -1) {
>>
>>> = 0 sounds more robust
>
> But not as flexible/future-proof. Why should 0 be the only valid IRQ index?

Ah, because > is used usually is a quoting character in email you
missed the point.
It was written as >= 0.

-- 
With Best Regards,
Andy Shevchenko
