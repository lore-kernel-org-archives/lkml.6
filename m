Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 402C8C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE27F208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hsLfYCSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE27F208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933962AbeFLOPd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:15:33 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35293 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933295AbeFLOPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:15:32 -0400
Received: by mail-lf0-f48.google.com with SMTP id i15-v6so25979828lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JSFG8yD5kjT9HDNSL661XXjT0cMZJeaSmSaRrp9d+1g=;
        b=hsLfYCSL9iYk83xylWAn9UoJXn6gNyqH/gQ0DRJ7+f3nuYcN+5Jsr9P77GuuCgtUCi
         ScFD6niyH9SfGgkuzJLvMJiHRFmro8IH4k2aAwt6sQ2utsO4vWrJqzJr6UCWTGQKKJyf
         a5JxEvWU5JcBmntmyJHNMJFfbXbwlbmwCHynWA0WgCKglAiaNQ/4e8FL1DHZtgeciSPE
         ryG+cmGVDYuDYKg2HnRiIvBDl8CngOcHbM916f/9TFTStSf5/IEVDLj9XAsPQoTClviI
         5sdaPBMiygGbkhuJjwxHML3JD4tPcESM0YpZe8Mh+D5tNOKweixGBF+TXJavdWCGo7Bp
         0IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JSFG8yD5kjT9HDNSL661XXjT0cMZJeaSmSaRrp9d+1g=;
        b=PIY/5u9eFykB7+Gga/lLFvrhwONyQ1djA26qvdZLgB/Bho1OmtV+Aa57MUEkLGdfrZ
         XKDb/C5UGeG/CLtsA6vYiAD3EZxXexBQs1m6miqL9HXZJOT/YVU+zORBVxjLiZpZr4IF
         q2hQA2td1ZAVX23jHb9+vBsRNJPCUC/5E2US/3C6UE9JHGcBQeZcks81aD1osHWDcBTi
         3eE3A9Ie3tXU2Onn57wrKZThW/N+WvyDRE/PcGvBmlQn+TzxfSobS0FCwbS41ez5cl5F
         EFJvZANT7cRbaRTs3gKpkkE0UJ1PP2lXJq7DXVDg53YiuSJhfHoyJ1g7juxvr+n2j8/W
         g3gw==
X-Gm-Message-State: APt69E35KlicHB39n8p/GzMqiLHqWAqxfxxqtP51Vi9pPUTOFub3zjTq
        5GnWXLhGNCxZpC8j6kJnHVhzhjsS7CR00rquVdtWYQ==
X-Google-Smtp-Source: ADUXVKLfIHBjGMB37MpCCSQsqbbChoHa06an86zEWPJ9tUXB1s8pAUw4fRwjvvVOKccMOIddFQ68LXbk0hLLEn1kLiw=
X-Received: by 2002:a19:1f51:: with SMTP id f78-v6mr380017lff.42.1528812931112;
 Tue, 12 Jun 2018 07:15:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ef02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 07:15:29
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::5:e725]
In-Reply-To: <1628804.nlB6U0QxHY@phil>
References: <20180612000142.28883-1-olof@lixom.net> <20180612000142.28883-3-olof@lixom.net>
 <CA+55aFy2sOHqcO-6LaKOZ5omyAow15gq+=Z7aOTZisrDihoecw@mail.gmail.com> <1628804.nlB6U0QxHY@phil>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 12 Jun 2018 07:15:29 -0700
Message-ID: <CAOesGMghTquZgS2=M=wLNWNJrkWKBPdj-L=p6cY6n4kaqUmP_A@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] ARM: Device-tree updates
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ARM SoC <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 6:04 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Dienstag, 12. Juni 2018, 03:04:34 CEST schrieb Linus Torvalds:
>> On Mon, Jun 11, 2018 at 5:02 PM Olof Johansson <olof@lixom.net> wrote:
>> >
>> > - Qualcomm:
>> > + SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
>> > (Cortex-A75/A55 derivative) SoC that's one of the current high-end
>> > mobile SoCs.
>> >
>> > It's great to see mainline support for it. So far, you
>> > can't do much with it, since a lot of peripherals are not yet in the
>> > DTs but driver support for USB, GPU and other pieces are starting to
>> > trickle in. This might end up being a well-supported SoC upstream if
>> > the momentum keeps up.
>>
>> Isn't the Qualcomm 845 also the SoC in some of the new WARM laptops?
>>
>> I asked one person that had an older one (ASUS NovaGo - Qualcomm 835),
>> and apparently you can actually disable secure boot on that thing and
>> boot from USB.
>>
>> In other words, it might _actually_ act like a normal laptop.
>>
>> I'd love to have something that is actually a real honest-to-goodness
>> ARM laptop finally. Are we getting at all close to that?
>
> I guess the Samsung Chromebook Plus (Rockchip RK3399-based [branded
> OP1 though]) also is somewhat close to that target - even with a nice
> high-res display and everything except the 32kb BootRom being replaceable.
>
> Of course Qualcomm-based devices have the Adreno/Freedreno bonus,
> but even in that area we're seeing some progress for Mali (Midgard)
> this year [0].

Yeah, I think the benefit of the Qualcomm platform is the graphics
situation upstream, and they also come with a (native) bootloader that
makes more sense for those not used to the embedded ways of booting.
Sigh, I really wish ARM would come to the table and start working with
upstream on their Mali drivers.

About 845; it looks like there's mostly announced products and none
are shipping yet, so most people with knowledge probably still need to
be tight-lipped about details. I do look forward to seeing some of
these products coming out and what people will do with them. The fact
that secure boot can be turned off on them through regular settings is
promising.


-Olof
