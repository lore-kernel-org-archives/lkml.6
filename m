Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312E7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2EC20877
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="t3UBEDFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2EC20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeGPPBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:01:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41591 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeGPPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:01:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so25364792ljy.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IFphJYXKeJx951UEdEgRlj759+EmGd4AL1FdfKdQ3Yw=;
        b=t3UBEDFx3R14pwwn+MsOSwqzR0vcZTuUZVmRxl9agbTG3s9bcl4bUHX2aSiPSAaeBv
         BM1B0ihUIKdcVLoXtiWg01dQhCN3kiTTKeq6bf/R6SSRHYz5g8a8CD70Hk6gmww0rLVv
         bL275pr8rmJsk14G3voh4TxtzkQFQSPzNF3nh8JNLahlKvgtlHos6Km6mnCn7xL1sIO5
         JHNbvhYotggjxfXFtsXvX6XTJS1147jAGN3LajSHOfPjfbJARTM4CrF/kPPL/nFhw7Z4
         dp+yTx3q3ut5zHpvqez1Q/P4XIQD1fnIJisPT6F6jnpo2jAJFI48tOLfVO/746WeT4Y1
         kwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IFphJYXKeJx951UEdEgRlj759+EmGd4AL1FdfKdQ3Yw=;
        b=JQHeM4NOoLx4qaB/OKwJayusHFnotzW7D5rvEHnq3dpQy7FXOlm/LTEX91Ir9gQLch
         +SYx0lBOJE68De5opZ3xUmi0s5STlG+ZvNJNpg0JZFj+0u/3cbeECf1t90JKS/O8v+nq
         2gNK7cVnEiNGYb5Bflkap8qkjMLxEZAkt5j2ZePtBUmltNVdgoTsv1sZLaVptAPI3dNw
         MMV8+GubpZ35D0x+aUn/QwEvs/EjBU3SitcXG5N8OdL1gv0uT1q2jpxWBZY2nPPqyWOe
         i/V0g/7tCiYp1586QVCygaSxUhUGx4fryjeyhy85na9S84HVcz2rFvGYjVCU+2Lr9b/w
         iDuQ==
X-Gm-Message-State: AOUpUlHU5e9+eOWbQMMO3q3XUE4K8bddvDVJ2ootluROP3I9f0iAEkwm
        TRoW9lF3Ot+ONYiVsIaQmsycMLtojjeE+Khl+1vHJg==
X-Google-Smtp-Source: AAOMgpfdL+oM6NaspadrJ9stW+7P/k/oGUqWbSd8ihMcJf9j+KZ4noqWWepkXt4yMrI4rw5XSnlgiHnyKh32Aj1Z0Is=
X-Received: by 2002:a2e:740f:: with SMTP id p15-v6mr10152907ljc.130.1531751646361;
 Mon, 16 Jul 2018 07:34:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 07:34:05
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::6:90ed]
In-Reply-To: <f619f0e9-b8b4-29fb-5ad6-7f5ebc3a4da8@arm.com>
References: <20180715035342.11371-1-olof@lixom.net> <f619f0e9-b8b4-29fb-5ad6-7f5ebc3a4da8@arm.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 16 Jul 2018 07:34:05 -0700
Message-ID: <CAOesGMjq=d3ZPLTq5qudx+EE+XC2-zSsA1ViheTwM7fnTtJh2Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: cpuinfo: Include cleartext implementer and part strings
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 2:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Olof,
>
> On 15/07/18 04:53, Olof Johansson wrote:
>> There's some use in printing out what the implementer and part numbers
>> decode to for cases where they're known.
>>
>> I filled in the table based on public information; mostly from ARM TRMs
>> and other tools (and some of the SSBD tables in the kernel, etc).
>>
>> Apple IDs came from
>> https://github.com/apple/darwin-xnu/blob/master/osfmk/arm/cpuid.h
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>  arch/arm64/kernel/cpuinfo.c | 79 +++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 76 insertions(+), 3 deletions(-)
>
> [...]
>
> The same thing pops up every so often. And the answer is the same each time:

Ever thought about why it pops up?

> - it breaks an existing userspace ABI by changing the format of cpuinfo

Most tools likely rely on a per-line format, and in this case they're
likely interpreting the contents after the ':' as an integer. Adding
something to the line might or might not break them, agreed.

How about introducing a "CPU model" line similar to x86's cleartext one?

> - it is unmaintainable in the long run

False. Chances are you already need details more fine-grained than
this for errata and quirks, we already do for SSBD. And if it lacks an
entry it's not the end of the world.

> - userspace already has this information by simply running "lscpu"
>
> What has changed?

What has changed is that ARM(64) is moving from a
custom-kernel-custom-userspace world to one where you might be
upreving kernels and userspace separately, and you might be using an
older userspace with a newer machine and a newer kernel. Having to
update lscpu is an extra step and extra friction to making it behave
nicely.

There's also a growing expectation of the system to behave more like
x86, especially when it comes to trivial ways of detecting what kind
of machine you are running on. On x86 it's been trivial to look at
/proc/cpuinfo since it is provided by the platform there. Nobody wants
to change their implementation from having to read a file to exec a
program, dealing with errors, and parsing its output (sure, easier
from scripts, but more awkward from real source).

Having the information exported from the kernel is a reasonable way to
do it. The other extreme is that the kernel should just ever have
exported the raw MIDR value.


-Olof
