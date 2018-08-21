Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF0AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090EA216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJg+VFba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090EA216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeHUQ7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:59:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53467 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeHUQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:59:16 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so4136114itw.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FS+N45EMI6S5platJWC6hB8JY8ElJv6/uwIx9m4wVJ4=;
        b=GJg+VFba+GzT4It0f3CZEf6b7MJ+HhkFLNLUPHpFVErtncyyzpcgeJy/eFd9zzIyEq
         uD7ynNYiIQW1/PgIQx4iyAyzePvsDcbuXzcbZHeb3PFzbomjEBbcgKs6BYkuZrjxtuZW
         oRDr8KbG7pZgvhWMyg3guX1qDO1A/NUY5XPvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FS+N45EMI6S5platJWC6hB8JY8ElJv6/uwIx9m4wVJ4=;
        b=Nl8+SWi4iJ8tVNX25zFLx9xCSx/AfNd1lZbbU+HQcuYZGEca1f/Xod05dcmegY45Z6
         YhmMQEhKXpa/euDhPxWysKit8ukhbV/mTt84xn1J4OkMhYMAO/Vzia00x0vO9GClPNaV
         nCnWcPC6SF1NtOrOhIhc27YhnwZ9Q5Cr+TXdU3WgPmvQB3tOqogJWaOs9uWofEBzkW1U
         pzqemOlFmv3s8/sNsOXJB9HFzTLw9OcGpaNjd+5mLMmbddNdQI240wSRNCyNa2igwDM+
         VNkMDvKg+kB5AzGM07p6Gz7kBmn0DFVbWQJ2x2PlDf5XiM0FWq/mikvKSpvMYuOh25TM
         qPRQ==
X-Gm-Message-State: AOUpUlH4ihfb0+jSAtjOHpUqtTTLF5dcYHifaJZlOX/N8oPGn4AgdQwD
        YRFzEYEPG8yjmKnU3WAqQWLsKuVpg7zthOvNsY9KVQ==
X-Google-Smtp-Source: AA+uWPxQNLi52WiUBC+xQoiS/942KaXKVlnZWqUVuFJ1jIie5Ep1IqYTMxWEhPz1/+lG0rcX3Dj1jTLa8Cq/XxDvkcQ=
X-Received: by 2002:a24:4c0b:: with SMTP id a11-v6mr37133772itb.123.1534858744641;
 Tue, 21 Aug 2018 06:39:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 06:39:04
 -0700 (PDT)
In-Reply-To: <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de> <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
 <1533800010.5087.71.camel@gmx.de> <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 21 Aug 2018 15:39:04 +0200
Message-ID: <CAKv+Gu8KKwNkUdx7tSxEosRvydxmQ2yaasHRJn_LcHPs7p2UYQ@mail.gmail.com>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
To:     Dave Young <dyoung@redhat.com>
Cc:     Mike Galbraith <efault@gmx.de>, Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 August 2018 at 11:13, Dave Young <dyoung@redhat.com> wrote:
> On 08/09/18 at 09:33am, Mike Galbraith wrote:
>> On Thu, 2018-08-09 at 12:21 +0800, Dave Young wrote:
>> > Hi Mike,
>> >
>> > Thanks for the patch!
>> > On 08/08/18 at 04:03pm, Mike Galbraith wrote:
>> > > When booting with efi=noruntime, we call efi_runtime_map_copy() while
>> > > loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
>> > > that and a useless allocation when the only mapping we can use (1:1)
>> > > is not available.
>> >
>> > At first glance, efi_get_runtime_map_size should return 0 in case
>> > noruntime.
>>
>> What efi does internally at unmap time is to leave everything except
>> efi.mmap.map untouched, setting it to NULL and turning off EFI_MEMMAP,
>> rendering efi.mmap.map accessors useless/unsafe without first checking
>> EFI_MEMMAP.
>
> Probably the x86 efi_init should reset nr_map to zero in case runtime is
> disabled.  But let's see how Ard thinks about this and cc linux-efi.
>
> As for efi_get_runtime_map_size, it was introduced for x86 kexec use.
> for copying runtime maps,  so I think it is reasonable this function
> return zero in case no runtime.
>

I don't see the patch in the context so I cannot comment in great detail.

In any case, it is better to decouple EFI_MEMMAP from EFI_RUNTIME
dependencies. On x86, one may imply the other, but this is not
generally the case.

That means that efi_get_runtime_map_size() should probably check the
EFI_RUNTIME flag, and return 0 if it is cleared. Perhaps there are
other places where EFI_MEMMAP flag checks are missing, but I consider
that a separate issue.
