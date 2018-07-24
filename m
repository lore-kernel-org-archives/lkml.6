Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE65DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9DE20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9DE20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbeGXGXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:23:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45911 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeGXGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:23:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id j143-v6so2064176lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 22:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LVQu27la5jZgoJxzys3veTLUm0IGukX2fOskHBvRhJI=;
        b=RbvIm3H3YF7mE3c2VJEZAUG4G5CFhU0eoone484awfAe3wj8z2AuGBpdC7iaZ/MyHZ
         rw91dUGBpSQgcM/++7aYgE2GoUobmfzJ2JE9RJ64TfCifczzMk4JdEvFqRrB98jT8sEK
         t3X0gUkSzJ9tNw8bl76dX2MZreO8noafZ0Ple4a5uRR8z0AQqQ1LVLjYmwMh9qkmdU++
         kg2jSz+ObyLkovX0gcVb71BadjkSnopD+mpgSmdpYI+eEby5X5enPZ8rQjR9jc79PTQq
         g9CZgdWf1E5HIGUDFmSrnITTaWh9fNGbE0wdAb8uF/KGZ74OQYU/UE1vgxJIjWwuUCbZ
         jYoQ==
X-Gm-Message-State: AOUpUlECHFuSFE9C54oWNNGU32M/GeL1L7omQcRKj+FCDmJm8o2E6rAG
        3GWe9robyeTscfRZxTP5I6QOuUJGnrpDgYZJdw/GEw==
X-Google-Smtp-Source: AAOMgpcBbUok+oED/txc5RkcjwWE+L6UeqgxyGGysiPGzW0FQcpHRzDM2IXcG2MZ74KNkg06vhXPaFs45ciZ4ZZGc4k=
X-Received: by 2002:a19:1c81:: with SMTP id c123-v6mr9431890lfc.105.1532409546441;
 Mon, 23 Jul 2018 22:19:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:81a:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 22:19:05 -0700 (PDT)
In-Reply-To: <20180723133527.GA9450@arm.com>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180712164918.GA26935@arm.com> <20180713003434.GZ28220@linaro.org>
 <CAKv+Gu9PT75XTXGsh1jc5roRO_d2QYKEamq42mfbsXzmerAUzA@mail.gmail.com>
 <20180717051222.GA11258@linaro.org> <20180723133527.GA9450@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 24 Jul 2018 10:49:05 +0530
Message-ID: <CACi5LpO=ObREcWfr6Y+7+bv3c1VkOEkw80CLELHDO6QD4xbeow@mail.gmail.com>
Subject: Re: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on
 acpi-only system
To:     Will Deacon <will.deacon@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Dave Young <dyoung@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Mon, Jul 23, 2018 at 7:05 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 17, 2018 at 02:12:23PM +0900, AKASHI Takahiro wrote:
>> On Fri, Jul 13, 2018 at 07:49:45AM +0200, Ard Biesheuvel wrote:
>> > On 13 July 2018 at 02:34, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>> > > On Thu, Jul 12, 2018 at 05:49:19PM +0100, Will Deacon wrote:
>> > >> Hi Akashi,
>> > >>
>> > >> On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
>> > >> > This patch series is a set of bug fixes to address kexec/kdump
>> > >> > failures which are sometimes observed on ACPI-only system and reported
>> > >> > in LAK-ML before.
>> > >>
>> > >> I tried picking this up, along with Ard's fixup, but I'm seeing a build
>> > >> failure for allmodconfig:
>> > >>
>> > >> arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
>> > >> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'
>> > >>
>> > >> I didn't investigate further. Please can you fix this?
>> > >
>> > > Because CONFIG_ACPI is on and CONFIG_EFI is off.
>> > >
>> > > This can happen in allmodconfig as CONFIG_EFI depends on
>> > > !CONFIG_CPU_BIG_ENDIAN, which is actually on in this case.
>> > >
>> >
>> > Allowing both CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN to be configured
>> > makes no sense at all. Things will surely break if you start using BE
>> > memory accesses while parsing ACPI tables.
>> >
>> > Allowing CONFIG_ACPI without CONFIG_EFI makes no sense either, since
>> > on arm64, the only way to find the ACPI tables is through a UEFI
>> > configuration table.
>>
>>
>> Do you agree to this?
>
> Yes; please post a new series which resolves these dependencies and includes
> Ard's fixup from before.

I see that Akashi has already posted a v4 here with the suggested fixes:
https://lkml.org/lkml/2018/7/22/321

Thanks,
Bhupesh
