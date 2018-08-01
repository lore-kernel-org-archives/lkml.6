Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867DBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAE5208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuhlVkbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAE5208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390441AbeHATiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:38:17 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42460 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390345AbeHATiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:38:16 -0400
Received: by mail-ua0-f194.google.com with SMTP id w7-v6so13262371uan.9;
        Wed, 01 Aug 2018 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/RrV+1Bdv4HVo7QpoDxltrBcoZ/NJ9c0G/+/GGBxP8s=;
        b=SuhlVkbOMAsacUXLQCcItt2TCH2RqGgKbp0mYBJ2/ZeUfipDPCZNTvJpK4Q0rV0x7/
         g7MlA8apIRYKnyFvvFy0Gg/HOkPLPja5j13un+S2CAAZm2XpQBKwFvcYHh5rGwn/erHQ
         hs2aMGZIJmK9ytx4qHMxbO/5WcN9j0SWLVPdBDMjeK1DUGgR76kuDiq6bsJ6/vmehDed
         rixNyBZaCKN9JbynHIHiesCYf+PFneDw/D2eQ+75ppcJub1ehZ27ZOV1Tm0LoezgbS05
         DEzfWRZrmqwC3V+2RNUPJuL0Y96VQInM/v953gqu6JIS/DA/JstYLUvb9mNwnHlxwq0w
         90dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/RrV+1Bdv4HVo7QpoDxltrBcoZ/NJ9c0G/+/GGBxP8s=;
        b=eZ+PkSsmY0VS5P5y6y4XTLHyXR8ZuecSELyR/p2wSw6zIB3I3jH4Brr6ONbbtQ9I5J
         7fD/WqNWDNUf9ypXkXsQqmGNeE7oJjEdlHTIqd0INdwb2MFeMHzjkj9QJ0NbZEc87v40
         F1i0OSYs4B1s6HKVC3528JRoG1gcnORPu7L1s/t2yup1ZZXl/MZtIFDozSfTREw21iGO
         4mxrqMpas5bU78nMIrssihHQvDQ5Nxjxbcoreb6yp8ZnbM6UFl9/CLLRxtb/cJYGq3bY
         5y1KoQBpx7cOF2n1uLB6l382l1ein7aeaLNzkgqMafJ8aESecuvcobIY9xrRA+dD9SH7
         8B7A==
X-Gm-Message-State: AOUpUlFb8tCgQaRcoLisuFKfesHMMu9pUqSuLpdFpU7JZuzFJ86eJIWf
        70YdD7SRc8/cLy65x+U0y6nPcPRgo09j8neT14Q=
X-Google-Smtp-Source: AAOMgpexBzv4HdSXIuu9TVAx5uFw982xcJKJqUSA1UT1r79Pi73rM9iE2C4P35IPPyVdMUR1wJlSmUH/sQZse+QDgXg=
X-Received: by 2002:ab0:60ae:: with SMTP id f14-v6mr19112445uam.153.1533145885865;
 Wed, 01 Aug 2018 10:51:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9f:26e1:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 10:51:25 -0700 (PDT)
In-Reply-To: <20180801172549.GA16774@roeck-us.net>
References: <CABXF_AAVhadw=+rtcD-L06-zBTMb3v7C2QqvN-6vcx5w2T0sYg@mail.gmail.com>
 <8ab731b4-2929-e92e-6536-35096ee66baa@roeck-us.net> <CABXF_ACKZXe+3J76bfyr4V1qdyhJ--cTekSXSVPksKOTxCBfTQ@mail.gmail.com>
 <20180801172549.GA16774@roeck-us.net>
From:   Ivid Suvarna <ivid.suvarna@gmail.com>
Date:   Wed, 1 Aug 2018 23:21:25 +0530
Message-ID: <CABXF_ADirjLD-3DdVoJ4NKRNRcib8nDC2PCxif9ZXvtDZbFUEg@mail.gmail.com>
Subject: Re: arm64: pstore: printk causing hang during boot in __memcpy_toio
 with pstore enabled
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 10:55 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Aug 01, 2018 at 10:46:06PM +0530, Ivid Suvarna wrote:
>> On Wed, Aug 1, 2018 at 6:49 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On 08/01/2018 05:35 AM, Ivid Suvarna wrote:
>> >>
>> >> Hi,
>> >>
>> >> When pstore is enabled and a *pr_info(any printk) in
>> >> __memcpy_toio(arch/arm64/kernel/io.c)* is added, kernel wont boot and
>> >> just hangs.
>> >>
>> >> The path where __memcpy_toio is called is below:
>> >>
>> >> ->persistent_ram_update
>> >>    -> memcpy_toio
>> >>      -> __memcpy_toio
>> >>
>> >> I tried with trace_printk and kernel boots fine. I understand that
>> >> printk has overhead, but is this expected when we use some printk
>> >> statement in __memcpy_toio?
>> >>
>> >
>> > I think the problem may be that the printk() output is copied to pstore.
>> > Since pstore calls memcpy_toio(), you get a nice recursion if you add a
>> > printk() call to it.
>> >
>>
>> Is there any solution to this other than not adding printk :p
>
> Well, disabling pstore would help. You could also use a trace function,
> as you already found out, or you could use gdb for debugging. Since
> this is obviously a debug image, you should be willing to accept some
> limitations/restrictions.
>

Ok. But trace_printk output is available only after boot, so to debug
any boot issues,
it may not be helpful. And gdb for kernel debugging? Maybe u meant kgdb?

Let me check if this issue is only for pstore path or not.
