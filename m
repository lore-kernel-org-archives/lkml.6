Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A8C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 04:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E076224EE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 04:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIEnvaxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E076224EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750861AbeGGEX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 00:23:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46143 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeGGEXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 00:23:54 -0400
Received: by mail-io0-f196.google.com with SMTP id p7-v6so12561022ioh.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 21:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KXI1xllMV/IDYWe66EPXsmhjUIytZsBnSRbUcn9mOXQ=;
        b=DIEnvaxD9YD0iT/IxpkWhOy3xaFxlCUsANoM9noK8pifx7kq2dfjaztA01Nay5akeN
         RhP0VniDaDgmwQE2GqTWttC/ivr1syLm+EW0eSyd+AULgtcrQTs28qmhQwN6R01nSe9r
         WjrvavwGlQ7t49Z305qV/7wtr7Vfn5+gdNaFFooz4fMK0aD++72pkUAphMBURyW9In0F
         rcEVTMrWEAdIp80ALzfTk+QNTgGTsPanoVizs7PQ/vsq1wQAgah/8DWgDfxsnH+1HOfj
         9Zg54mPvjXhMT9ZdcLEKONTWHC1RAQXYlRV4wThwb+c3H4MxyWrKWxfURkO2M+uWKYrc
         v7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KXI1xllMV/IDYWe66EPXsmhjUIytZsBnSRbUcn9mOXQ=;
        b=Cc5gQqdZSJjoHhghWF8q/9F0xxzw/Nj7A0tITOCdcVyyJz6lvjUnWnpITXFRNS/40r
         iSchm7R69KPQsM9CjiLF5facFzf14SlwfHaiwL9lrrBKcPIVhy8FpKgLFJM6FJbl35Cb
         rVyHZNOtO8NSa8KvmuwwCvo3YIpAmKKszyAXE+CVlo9KPmwvHARWK3yH+vwCVariHGkT
         2yG3iJ0drhlS5n4MICKzEAUvI2GJeavGRGWbFMjmOFXryHAKAx5fOwJaVUrW5oNrMskr
         g+ckpzybXcHAC0m90eqGUARITnqj9Fm/8FQhn4O8JqcXOu36HSP39IadtwYtjqWd+4mr
         AKoA==
X-Gm-Message-State: AOUpUlHtycZ8giRKcVTESRPEmwXswqNVqiBilTRnEycxIcWK8th9AWjL
        gXJ9zM7RvOLeArMnsTmMDwbBbLcFT4QJhxr5QvE=
X-Google-Smtp-Source: AAOMgpfDMRPm+u2518dWMXTNhvlmoh1lcuZ3DZNTGGZ2e3oZMJ+euF99WfBN/hzzP1dzDZXB2tlrolKOU6fJKj3NoxE=
X-Received: by 2002:a6b:2c9:: with SMTP id 192-v6mr10971780ioc.123.1530937434363;
 Fri, 06 Jul 2018 21:23:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6801:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 21:23:53 -0700 (PDT)
In-Reply-To: <CAK8P3a2L9z+Ok1Wd0=5F=Xt7nvqL6be+AS++F3rZzByN+a+9QA@mail.gmail.com>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
 <20180705213604.18883-4-deepa.kernel@gmail.com> <20180705222110.GA5698@infradead.org>
 <CABeXuvoj_WwvnaqY1wao+axx1JLpPte-iXP=Ti7jsT+r6VrVUg@mail.gmail.com> <CAK8P3a2L9z+Ok1Wd0=5F=Xt7nvqL6be+AS++F3rZzByN+a+9QA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 6 Jul 2018 21:23:53 -0700
Message-ID: <CABeXuvr7LUk+eBWwv-sZOt6U+Rq7xRcer0gB+MRbgHjf=bt_pg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] riscv: Include asm-generic/compat.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 4:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jul 6, 2018 at 1:56 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> On Thu, Jul 5, 2018 at 3:21 PM, Christoph Hellwig <hch@infradead.org> wrote:
>>> On Thu, Jul 05, 2018 at 02:36:00PM -0700, Deepa Dinamani wrote:
>>>> defconfig, allmodconfig and nomodconfig.
>>>> And hence does not inlude definitions for compat data types.
>>>>
>>>> Now that time syscalls are being reused in non CONFIG_COMPAT
>>>> modes, include asm-generic definitions for riscv.
>>>>
>>>> Alternative would be to make compat_time.h to be conditional on
>>>> CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
>>>> asm/compat.h include the generic version instead.
>>>
>>> Two comments here:
>>>
>>> First I think the current riscv compat.h is completely bogus.
>>> As you mentioned riscv does not actually have a compat mode, so
>>> having a compat.h makes no sensse at all, and the COMPAT_UTS_MACHINE
>>> override which is the only thing implemented is included in that
>>> statement.
>>
>> I was leaving the decision on how to clean up compat mode to the
>> architecture maintainers.
>> I wasn't sure if they were still in the middle of implementing it.
>
> If we only need it for 32 bit time_t, we can probably just use the
> asm-generic/compat.h for now.

Ok. Will send out a v3 with asm/compat.h removed. Thanks.

-Deepa
