Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFFEECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169E02147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0bUCWyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169E02147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeGMGCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:02:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35290 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeGMGCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:02:48 -0400
Received: by mail-it0-f66.google.com with SMTP id l16-v6so10000633ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=7rGxqXGZ2L3dMnrl/2X+em7CfbAVbVuRUvDJ+yN3vBQ=;
        b=S0bUCWyFMJoFZri3KHsHAQFcG1iz2PT0cc0bJNuqGTjuDY24p8Htql/AdGS0G1tzin
         38O16xNr5WDCXLTg/jDPgqnssaRxiHmf5kzVU9dn618dLvCfsaQqxELXOKO5DTaUb4kZ
         /lSxQ6AmXp2g/u5HbXZiUYcMP2K4stCyXjqM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=7rGxqXGZ2L3dMnrl/2X+em7CfbAVbVuRUvDJ+yN3vBQ=;
        b=nOdcEu5qWWA0+SQWuc1bSZN0ViMMKMUg72Z+xz5FGEFTQSO1FJWaWFVogaN35Dw46J
         KMDf+5NTc6WKPNyQ3lav6pcLOGeS8+RfvRJhXxoloAbE/y1hDWIKGhrPctbntGFKZYxe
         czd2T11bSbaxPA4wB+mfcuqp9vjFcPeNL5XADIaHRHONeAwfKvt0kL47MKWqWyssTmfL
         2hAl7R7X99ALlQ3Z7nu0xWUbz5RUpUTcr8dnBYW85DJyLP2dSkXKBI+zp+v3OuFWW7Lp
         52qxcc2NJrdb6UljdAb02DDdAP/FFQnaWsCv8yn74m2Uu/9MKbptGBMLkO7bRnXGdSO4
         7WNA==
X-Gm-Message-State: AOUpUlHQIS8tUEtvNvsZKBtaz6D0TmjtUUm13nGqKrEWSC3+r4AWBTSQ
        9IYI6wYwCo84P/9nrWXuLdGLwdBz3JThwNE+dGg/oA==
X-Google-Smtp-Source: AAOMgpePjXJbGQJPqmYSvdY3yrg8rGTWT66OtcslBNrgK11cqj3K6yfmJfI0/3a6+dXp9K7eFUT2KS3B9DiRXk7KOXw=
X-Received: by 2002:a02:6001:: with SMTP id i1-v6mr4178972jac.5.1531460985854;
 Thu, 12 Jul 2018 22:49:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 22:49:45
 -0700 (PDT)
In-Reply-To: <20180713003434.GZ28220@linaro.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180712164918.GA26935@arm.com> <20180713003434.GZ28220@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Jul 2018 07:49:45 +0200
Message-ID: <CAKv+Gu9PT75XTXGsh1jc5roRO_d2QYKEamq42mfbsXzmerAUzA@mail.gmail.com>
Subject: Re: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on
 acpi-only system
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
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

On 13 July 2018 at 02:34, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> On Thu, Jul 12, 2018 at 05:49:19PM +0100, Will Deacon wrote:
>> Hi Akashi,
>>
>> On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
>> > This patch series is a set of bug fixes to address kexec/kdump
>> > failures which are sometimes observed on ACPI-only system and reported
>> > in LAK-ML before.
>>
>> I tried picking this up, along with Ard's fixup, but I'm seeing a build
>> failure for allmodconfig:
>>
>> arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
>> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'
>>
>> I didn't investigate further. Please can you fix this?
>
> Because CONFIG_ACPI is on and CONFIG_EFI is off.
>
> This can happen in allmodconfig as CONFIG_EFI depends on
> !CONFIG_CPU_BIG_ENDIAN, which is actually on in this case.
>

Allowing both CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN to be configured
makes no sense at all. Things will surely break if you start using BE
memory accesses while parsing ACPI tables.

Allowing CONFIG_ACPI without CONFIG_EFI makes no sense either, since
on arm64, the only way to find the ACPI tables is through a UEFI
configuration table.

> Looking at __acpi_get_mem_attributes(), since there is no information
> available on memory attributes, what we can do at best is
>   * return PAGE_KERNEL (= cacheable) for mapped memory,
>   * return DEVICE_nGnRnE (= non-cacheable) otherwise
> (See a hunk to be applied on top of my patch#4.)
>
> I think that, after applying, acpi_os_ioremap() would work almost
> in the same way as the original before my patchset given that
> MAP memblock attribute is used only under CONFIG_EFI for now.
>
> Make sense?
>

Let's keep your code as is but fix the Kconfig dependencies instead.
