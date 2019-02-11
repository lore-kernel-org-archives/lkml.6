Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16468C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55F2222B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbfBKPnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:43:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34873 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfBKPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:42:58 -0500
Received: by mail-ed1-f65.google.com with SMTP id b17so9288097eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Djkk03g3gyqD6ibiYiRRwhavxGTO6/ZJgmblPxXV/Vk=;
        b=JaKHItjhJ8KmGhrcpo+Zq6LLavXjRaWUvYH+qn01jl3URbfdm42Xmw8vzbqaHGxTup
         NLkfvnE2Vv+hgJjloJ/k6pL3Adcwavqr8vw8WUlegpGwUebVlRp5Fc/73M4DOfN4xJg3
         qYxbul97hxJkcJBOtmKoOvbAc5iwh5YMjgo3iwKIuqsRhBEmOu+M5RWELYVrf+5YUXaB
         cSi0mmkWLCtWmemSQASW9ByBZI8fKNwxPVrK//F1h/eMNTuU+1MBhhkpzRd5jqcJZuR3
         bddTRXO5mcwAh9v85uR0sJ3hwSwq35NvlmsoovM6MVwOubDh1i0b1dhrFQB6Z9PaepFd
         u2dQ==
X-Gm-Message-State: AHQUAuZMmSVi0orngbPbo20ZKyHeX+IVN9CbWnfyTr2/PUPFCODtXnKi
        jHxzEZM9oMv1Kj9zK+DxzGZndA==
X-Google-Smtp-Source: AHgI3IamWlVw2rnSuwYSL7eGN1mU9knVUrL2GjSAXiNp1Xsvd6uWq5MKa3R9/PxNEEr4N5/tMY8/Ww==
X-Received: by 2002:a17:906:5e52:: with SMTP id b18mr26832177eju.2.1549899777059;
        Mon, 11 Feb 2019 07:42:57 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b13sm2381140eja.74.2019.02.11.07.42.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:42:56 -0800 (PST)
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to
 platform_get_irq()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Granata <egranata@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190207185917.167829-1-egranata@google.com>
 <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
 <CAPR809vnpuh8nOjU3QMCh6YJUKmtX92+bnHSUKGiAXAp6NwCHQ@mail.gmail.com>
 <CAHp75Ve5Q0d0PCmQ6KZdcyuLd-XFfVjYqyujjM9SSbyBG+Hrmg@mail.gmail.com>
 <CAE_wzQ_RLC7N=jzj693d42T4K-CtSA-ckavt1FNDFZmLcXkB6w@mail.gmail.com>
 <20190211103024.GY7875@lahna.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <daea3a4e-8cfb-8878-70ab-679da8432d12@redhat.com>
Date:   Mon, 11 Feb 2019 16:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211103024.GY7875@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-02-19 11:30, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Feb 07, 2019 at 12:29:17PM -0800, Dmitry Torokhov wrote:
>>>
>>>> Do you have a suggestion as to how to write ACPI tables to avoid the issue?
>>>
>>> 1. Allocate new ID and use it (perhaps not the best path).
>>> 2. Use GPE(s).
>>>
>>
>> Or just solve the issue of intermixing Interrupt() with GpioInt(). We
>> have similar issue with i2c and spi, but we sidestep that there as we
>> only parse the first interrupt and do not give option of fetching 2nd,
>> 3rd, etc. Maybe we should only GpioInt parsing for the first interrupt
>> in platform_get_irq() as well for the first iteration and then see if
>> we need to improve it if we see devices with multiple interrupts.
> 
> I think it should be fine to intermix them or do what you suggest and
> start supporting index 0 for now and then maybe extend it in the future
> to cover more.

I think only support fallback to GpioInt for index 0 for now is probably
the best solution. A device could have both Interrupt and GpioInt resources,
as soon as that is the case then the meaning of index becomes ambiguous.

We are already seeing something similar with mixed use of GpioInt + Gpio
resources on some devices, where we need the GpioInt for the IRQ and
the Gpio resource to toggle something else and the ACPI tables on
different devices have them in a different order, see:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=4d1f7a6eabd45639d9de22a8a004f3c208d13c1a

I suspect that on Windows device drivers specifically specify if they want a
Gpio or a GpioInt; or in this case if they want an Interrupt or a GpioInt.

Regards,

Hans
