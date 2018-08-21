Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C9EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26082170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBG0WjMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26082170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeHUL4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:56:15 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35427 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeHUL4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:56:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so30730062oic.2;
        Tue, 21 Aug 2018 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a3WaZcRam9iIMyF+ldBVgCEeHesE5nOu51pqZOj7i/0=;
        b=GBG0WjMOb/pq9map1MgsJSSRj+b3hO9Ydk7d4pgAy/LS6pDDZiWMzAER/Spv9F9qCi
         g40aIn23pL5zEktzG8OW9F2VzDVWx1gyG/1/yEX9sGnhyQRBLoInm5bOq81mxwn3Hn0Y
         2Q6C3HX8RyIeQlN+cmqyXHQSFGfLxEGClT7J++8lb9cjXwYdE75R0pQmzXTiefj1idXP
         BbPiUQOjliBiOJWJuGlyozSTia7ZUugFxh8foiHrJTswOZ5eHisUy+E7sC3khv2za5e5
         C2fmKQntMhE32ilvKzcqTic/ARBBXowiGOvBEUYul8yE5PyqV+F692//DuG0/qu3fs12
         9lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a3WaZcRam9iIMyF+ldBVgCEeHesE5nOu51pqZOj7i/0=;
        b=RLYq3lYVP564l+KW6HM9aHkB/Yrk7Aq7JnfxDXtjl0upuWOeC0iMM3fJCStbCyALbs
         5r8JL5k3p4EPi96AZjmZSmgDgsJ9MNHG9lDF8cUakDG/LeEqKYc25u1bERc+imwwKxa4
         nSCdttzSY8ge5fbe0FrOHuCXzPcNkmKUP2PvR4yk9vfI3BjzR0io66jFoNadX8Yspljx
         tdr6mMAWliiBvonn3fetpbHPm82pM9DK4tLeXRKRbv58BCAqXYRWsgk4Q95Q8QF5raJT
         6+gXIcosR8n1UER2DAni2immO80pjDPedYsbNJs/hbrQezWEPkHX4jSM01HNDjupdnHC
         kjXQ==
X-Gm-Message-State: AOUpUlEq9+wm42UJIDc4MFPQusIi+EFklgGzdbnmolpsY0sl3wPdoqmw
        JVuJUwsKEZWdvbox5J4mobBF09KEL+1/j7V3g40=
X-Google-Smtp-Source: AA+uWPyipTQRFwDyTIdO0S4UTWlnL+xYH4IIFtne25cFWqgH1Unj2pzdzHov5exj1E8GJdfx7rUiSmTFWIf09tVlZzE=
X-Received: by 2002:aca:3507:: with SMTP id c7-v6mr19182536oia.46.1534840620984;
 Tue, 21 Aug 2018 01:37:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3209:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 01:36:40
 -0700 (PDT)
In-Reply-To: <CAJs94EYH2BrHseveJV_xqYs5zK0NxrdQ8NhjrCp7tytK=KsF0g@mail.gmail.com>
References: <66694963.VB7x4V86dC@avalon> <Pine.LNX.4.44L0.1808101019550.1425-100000@iolanthe.rowland.org>
 <CAJs94EYH2BrHseveJV_xqYs5zK0NxrdQ8NhjrCp7tytK=KsF0g@mail.gmail.com>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Tue, 21 Aug 2018 11:36:40 +0300
Message-ID: <CAJs94EY3ipwLA4w=aH8TfwTVRLRhxHwyh3H+NUE_n4Ee4CgtEg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-17 20:44 GMT+03:00 Matwey V. Kornilov <matwey.kornilov@gmail.com>:
> =D0=BF=D1=82, 10 =D0=B0=D0=B2=D0=B3. 2018 =D0=B3. =D0=B2 17:27, Alan Ster=
n <stern@rowland.harvard.edu>:
>>
>> On Fri, 10 Aug 2018, Laurent Pinchart wrote:
>>
>> > > > Aren't you're missing a dma_sync_single_for_device() call before
>> > > > submitting the URB ? IIRC that's required for correct operation of=
 the DMA
>> > > > mapping API on some platforms, depending on the cache architecture=
. The
>> > > > additional sync can affect performances, so it would be useful to =
re-run
>> > > > the perf test.
>> > >
>> > > This was already discussed:
>> > >
>> > > https://lkml.org/lkml/2018/7/23/1051
>> > >
>> > > I rely on Alan's reply:
>> > >
>> > > > According to Documentation/DMA-API-HOWTO.txt, the CPU should not w=
rite
>> > > > to a DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() =
is
>> > > > not needed.
>> >
>> > I fully agree that the CPU should not write to the buffer. However, I =
think
>> > the sync call is still needed. It's been a long time since I touched t=
his
>> > area, but IIRC, some cache architectures (VIVT ?) require both cache c=
lean
>> > before the transfer and cache invalidation after the transfer. On plat=
forms
>> > where no cache management operation is needed before the transfer in t=
he
>> > DMA_FROM_DEVICE direction, the dma_sync_*_for_device() calls should be=
 no-ops
>> > (and if they're not, it's a bug of the DMA mapping implementation).
>>
>> In general, I agree that the cache has to be clean before a transfer
>> starts.  This means some sort of mapping operation (like
>> dma_sync_*_for-device) is indeed required at some point between the
>> allocation and the first transfer.
>>
>> For subsequent transfers, however, the cache is already clean and it
>> will remain clean because the CPU will not do any writes to the buffer.
>> (Note: clean !=3D empty.  Rather, clean =3D=3D !dirty.)  Therefore trans=
fers
>> following the first should not need any dma_sync_*_for_device.
>>
>> If you don't accept this reasoning then you should ask the people who
>> wrote DMA-API-HOWTO.txt.  They certainly will know more about this
>> issue than I do.
>
> Laurent,
>
> I have not seen any data corruption or glitches without
> dma_sync_single_for_device() on ARM and x86.
> It takes additional ~20usec for dma_sync_single_for_device() to run on
> ARM. So It would be great to ensure that we can reliable save another
> 15% running time.

DMA-API-HOWTO.txt has and example with my_card_interrupt_handler()
function where it says that "CPU should not write to
DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() is not
needed here."

I've found that, for instance, drivers/crypto/caam/caamrng.c follows
DMA-API-HOWTO.txt and don't use dma_sync_single_for_device() in the
same case as we have in pwc.

>
>>
>> Alan Stern
>>
>
>
> --
> With best regards,
> Matwey V. Kornilov



--=20
With best regards,
Matwey V. Kornilov
