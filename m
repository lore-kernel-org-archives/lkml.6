Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2938AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB82021104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB82021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeK1G3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:29:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44856 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeK1G3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:29:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so19998210edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 11:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tcZdSQLAG9vyb+9Wa9niQt/DsHtP4sEshVOc5hcSiAM=;
        b=r6ZiPpS+cmcXZN2LK3Fa1qoMVrznkCXTcEX4Y64FiIJGNlnRYehR/T17RxCJAC9iaV
         gJc/wKWrl8ZGz3txJsEabgRE/UJILYNX2Cy7AOM1hNrl2vIRbS6Tw24CrHoRVjMs9TxB
         PqqBxR2jJ/UF8kgQHrn7VnSm2AVpZ0oNPRck0Olx9OI9BoEt6RY6FLRPfg308HfMnocy
         ogv81Isi5WU9qchX5AkMbObbaJ+UTyfDpVZos61vQ32t1mRe1nmT87TbE+cy2dZMIMxS
         MsU6XK5rkgZXuCjMo3ziCAYD34a/5aweqQCYheo3Brx2IINVCAu+ACURy8J34rJPuFu4
         WrrA==
X-Gm-Message-State: AA+aEWbMTnSCy6C6RYqYXot0XiL7UG/LSIb1K185a3UDDaj831lA8s6G
        X+cKaa1m5I8e7lc1ORxoXmfyJgQMBz0=
X-Google-Smtp-Source: AFSGD/XtqQQlP9RSY8+fer2W45zSsqSE5uQFc61Hae02/uQzf0aABsJ16qdgV0Sch/7UD6fcvKJBAQ==
X-Received: by 2002:a50:a399:: with SMTP id s25mr28686289edb.1.1543347048118;
        Tue, 27 Nov 2018 11:30:48 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s19-v6sm718509ejz.2.2018.11.27.11.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 11:30:47 -0800 (PST)
Subject: Re: [PATCH v3 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
 <20181127153728.47866-6-andriy.shevchenko@linux.intel.com>
 <c6a0201e-d69e-7646-dcae-0b1b6fe42451@redhat.com>
 <20181127192746.GZ10650@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <81965d66-56fb-01b1-7d5f-63afd5693778@redhat.com>
Date:   Tue, 27 Nov 2018 20:30:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127192746.GZ10650@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27-11-18 20:27, Andy Shevchenko wrote:
> On Tue, Nov 27, 2018 at 05:14:06PM +0100, Hans de Goede wrote:
>> On 27-11-18 16:37, Andy Shevchenko wrote:
>>> The caller would like to know the reason why the i2c_acpi_new_device() fails.
>>> For example, if adapter is not available, it might be in the future and we
>>> would like to re-probe the clients again. But at the same time we would like to
>>> bail out if the error seems unrecoverable, such as invalid argument supplied.
>>> To achieve this, return error pointer in some cases.
> 
>>>    	acpi_dev_free_resource_list(&resource_list);
>>> -	if (ret < 0 || !info->addr)
>>> -		return NULL;
>>> +	if (!info->addr)
>>> +		return ERR_PTR(-EADDRNOTAVAIL);
>>>    	adapter = i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
>>>    	if (!adapter)
>>> -		return NULL;
>>> +		return ERR_PTR(-ENODEV);
> 
>> Why not simply return -EPROBE_DEFER here (and simplify the callers a lot).
> 
>> This is the only case where we really want to defer.
> 
>>> +	client = i2c_new_device(adapter, info);
>>> +	if (!client)
>>> +		return ERR_PTR(-ENODEV);
>>
>> If you look at i2c_new_device, it can fail because it is
>> out of memory, the i2c slave address is invalid, or
>> their already is an i2c slave with the same address,
>> iow if this were to return an ERR_PTR itself, this
>> would return -ENOMEM, -EINVAL or -EBUSY and never
>> -EPROBE_DEFER.
> 
> It would change the behaviour.

Yes it would change behaviour, for the better, all the errors
from i2c_new_device() (*) will not go away when we retry later,
so responding with probe-deferring to them is not useful.

> In any case, it's only two users and both written by you, so, just to be sure
> you aware of this change and bless it.

I'm aware and you've my ack for this change.

Regards,

Hans


*) with exception of -ENOMEM which should never happen
