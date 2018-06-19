Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683EFC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083972083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DI11X+hW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cDrVhlYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083972083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeFSXsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:48:24 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35317 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeFSXsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:48:19 -0400
Received: by mail-yw0-f194.google.com with SMTP id v131-v6so542150ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QvTgeUtMZUrhyxxA/IeInTAuE0XOAQekEQKiTa4yBHQ=;
        b=DI11X+hWZWDspJvMfHXNP8Qo0SC96BGQgZHXQjIt49wuDlqNCwIIrgYZTf8E9KgNIS
         2tVK00ohz/0w4f/1hu1RAB8y6RM2erxdwGtMnqrRLXLa7X/OlfBPOxvKzaQ9HDjIqvtp
         1/PR/IhHxbA6cc8xy3HdxY2WzmJtx1vMpY6JxIxSmCqvprv6cdZdHkQOAL4UOb859c8k
         Aq/qaSVuGWzbRQHUR3SNhWLEQIyR8kXh63LHBbMb0/gPCzojgjyx1aqs/RdyBb9bJX5a
         y8nNkOR1YYXFcv+I2mo3OtcSFnAlahZUjCzo5tC0Hdy4pvpsdCbcxe2YwCPGcyXuVGX9
         wSVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QvTgeUtMZUrhyxxA/IeInTAuE0XOAQekEQKiTa4yBHQ=;
        b=cDrVhlYeBE06VJ0OWdmJOzbamdKLP0potg7sUxrJs96xl6CiT7iZh2ntSM+AwA+XMZ
         HebnErmJqo5Shg+TiM/PSTXmb65wxw/GgFjifcWqPQLBJBV/hon6OLUeFbU37K4gteXq
         QhaWOfoWHUSBBkh+gKdvVxI89sFGDBEORKaMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QvTgeUtMZUrhyxxA/IeInTAuE0XOAQekEQKiTa4yBHQ=;
        b=XOyRAhCg79nOx4/GSkWDbkixnPQb5AeLu/Ooz3lvNp7QTRuEbfTT77OIUS88nyBePw
         AtwNO1wFKab6YSe6z6vRR31RmE24BekKt5aJV+Mw7v+BOJr1oRZCgG3EL9ciFke0pFFP
         M08Hi1oHO9O/9A3ilxtcoifERvtQc52ax88WLgenEXMV10DprlvsVHMbsiE0Vqrbl2eH
         WRDEwGr3Br7i9KClx/dam0aaOpOcRzO+UpCh6utrbMsbve6S9U/VwgAWGxOeewEuMmzC
         oY0JaqbwiGTrSnkikmaAJMPBNcR0HRZzP97LaF0TdwLGDBGurj6WcVWddG1PuC8cuk7K
         pOZw==
X-Gm-Message-State: APt69E2LtcXcE9MRWkeXNRVnhVWLw+7XOoyXauKGkZf2dZph2XDF4wXi
        zYJyYOtE8R301EV+YFBFO7JrzH5YlJDL+ckTlj1irQ==
X-Google-Smtp-Source: ADUXVKIYZlX79G9czGvknan/sWGjGWIL5+NYzz58Cm/80eaiWWIjCdAkY4vQqCVlBy9exzkLu16KbqwZpAYVw/aeTF8=
X-Received: by 2002:a0d:d105:: with SMTP id t5-v6mr9397482ywd.53.1529452098411;
 Tue, 19 Jun 2018 16:48:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 16:48:17
 -0700 (PDT)
In-Reply-To: <20180601110921.GC4695@parrot.com>
References: <20180531184525.GA11068@beast> <20180601110921.GC4695@parrot.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 19 Jun 2018 16:48:17 -0700
X-Google-Sender-Auth: TcKai8UVlIQX8d_3AWI83Cw8oUU
Message-ID: <CAGXu5jJVX5tk3w5etreTPJpoEzXfF9bFD4GNNW69yRHZTEBYiA@mail.gmail.com>
Subject: Re: [PATCH v3] lib/bch: Remove VLA usage
To:     Ivan Djelic <ivan.djelic@parrot.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 4:09 AM, Ivan Djelic <ivan.djelic@parrot.com> wrote:
> On Thu, May 31, 2018 at 11:45:25AM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> allocates a fixed size stack array to cover the range needed for
>> bch. This was done instead of a preallocation on the SLAB due to
>> performance reasons, shown by Ivan Djelic:
>>
>>  little-endian, type sizes: int=3D4 long=3D8 longlong=3D8
>>  cpu: Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
>>  calibration: iter=3D4.9143=C2=B5s niter=3D2034 nsamples=3D200 m=3D13 t=
=3D4
>>
>>    Buffer allocation |  Encoding throughput (Mbit/s)
>>  ---------------------------------------------------
>>   on-stack, VLA      |   3988
>>   on-stack, fixed    |   4494
>>   kmalloc            |   1967
>>
>> So this change actually improves performance too, it seems.
>>
>> The resulting stack allocation can get rather large; without
>> CONFIG_BCH_CONST_PARAMS, it will allocate 4096 bytes, which
>> trips the stack size checking:
>>
>> lib/bch.c: In function =E2=80=98encode_bch=E2=80=99:
>> lib/bch.c:261:1: warning: the frame size of 4432 bytes is larger than 20=
48 bytes [-Wframe-larger-than=3D]
>>
>> Even the default case for "allmodconfig" (with CONFIG_BCH_CONST_M=3D14 a=
nd
>> CONFIG_BCH_CONST_T=3D4) would have started throwing a warning:
>>
>> lib/bch.c: In function =E2=80=98encode_bch=E2=80=99:
>> lib/bch.c:261:1: warning: the frame size of 2288 bytes is larger than 20=
48 bytes [-Wframe-larger-than=3D]
>>
>> But this is how large it's always been; it was just hidden from
>> the checker because it was a VLA. So the Makefile has been adjusted to
>> silence this warning for anything smaller than 4500 bytes, which should
>> provide room for normal cases, but still low enough to catch any future
>> pathological situations.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXy=
dAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> v3: fix r_bytes to whole-word size
>> v2: switch to fixed-size stack array
>> ---
>>  lib/Makefile |  1 +
>>  lib/bch.c    | 23 +++++++++++++++--------
>>  2 files changed, 16 insertions(+), 8 deletions(-)
>
>
> The patch looks good to me. It also passed my regression tests.
>
> Reviewed-by: Ivan Djelic <ivan.djelic@parrot.com>
> Tested-by: Ivan Djelic <ivan.djelic@parrot.com>

Thanks for the review and testing!

Who's the best person to carry this patch?

-Kees

--=20
Kees Cook
Pixel Security
