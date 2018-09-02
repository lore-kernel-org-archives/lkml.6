Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF68EC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 11:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AD520837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 11:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOqGZd2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AD520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeIBQAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 12:00:16 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34806 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 12:00:15 -0400
Received: by mail-wr1-f46.google.com with SMTP id g33-v6so15142079wrd.1;
        Sun, 02 Sep 2018 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aXzL6dVHhRMYiKGcnBKoQLXtOtEa75BiJs5pR99uo0=;
        b=jOqGZd2yCltGbq8RafdJuLBj3ihjyTIkSjTl3atBXV7p9NyO/8d5O1YadMElhkhYJf
         gBr6qaocQYAQ9jrmQRbJFui1VvOCRsPqTQldW6JR8TBF9T3X92dIDmfZPrT9NDHLzj0c
         FPqx9GUdaLFnVuyLynLh+Fof3PRuimEk9oEASSinR2Xj9+jnSt1hDnJwUe7sEXczdF+d
         dXXJwlIabWaLC4EnuAVKim9IqvMF2BagTyBcFLW08zIfpSIh2je5YZUxsnWhE2mWE/cO
         xUOGgtqwRXADJ2wLrQyaDj5dG/EtV2B6c1Agz2pjweSt8jUP20wPMz/fm9mSYcMZSV1K
         Pj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aXzL6dVHhRMYiKGcnBKoQLXtOtEa75BiJs5pR99uo0=;
        b=K1otySofKUgpuMldoJmEtKlOZY5SGgJ5uaJTNFIiCnWW59w/N1k27ACygeToPY6TtN
         7HWH4Umks73QjySAqigp0EUTpNKXGRz3+JhlvCm70s0LuXWCJUA5MVY9/49AcKBu90le
         OE1CNVuKd0G6JN7f6TBhXLQzWWg1LdR/TCUSmC1Iu7ik1xct/jvc1oThUkWHoYnqSI6i
         heYRIB7lwQsAqqfA6FukweLbUNTf1xv2kRtc/78oca/spGBfIc8jPGPo2lHL24DyWuod
         W4jxA3Eksulew9PWLOlOs5Npt+9LyXD6AQlTb2uDUUKpMhf86EfxdQNBQpiO4AFKg1eS
         ztsw==
X-Gm-Message-State: APzg51DMgKl4jHsQ++MKxvho5Bvhjrw1uF1zVGdoHUY3r2MvsPo1sgLU
        fuf1sAWxdg93NIXbgpsxDnQ0pzUAeAaZv7YUZz4=
X-Google-Smtp-Source: ANB0VdZZ0nXobp+0m60WZQAXgxG5w3MnAhHYUxJACal6kqRIF2j6CzHMkVRoZ/LlOrFZnyHnDL4L1B259i2v8pW96JU=
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr16188609wrc.88.1535888684185;
 Sun, 02 Sep 2018 04:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuWhkaGjX8Q_xghkFVTqzZkDrUv-sdH=VbS7hvnqFWrT+3eOQ@mail.gmail.com>
In-Reply-To: <CAOuWhkaGjX8Q_xghkFVTqzZkDrUv-sdH=VbS7hvnqFWrT+3eOQ@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 2 Sep 2018 13:44:31 +0200
Message-ID: <CAFLxGvxX8QW4wUJKommXVMpGBj7G_H3=SOwQGjGuyPZZrhCzKw@mail.gmail.com>
Subject: Re: Recent removal of bsg read/write support
To:     drorl@infinidat.com
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing relevant people. Otherwise your mail might get lost.

On Sun, Sep 2, 2018 at 1:37 PM Dror Levin <drorl@infinidat.com> wrote:
>
> Note: I am not subscribed to LKML so please CC replies to this email.
>
> Hi,
>
> We have an internal tool that uses the bsg read/write interface to
> issue SCSI commands as part of a test suite for a storage device.
>
> After recently reading on LWN that this interface is to be removed we
> tried porting our code to use sg instead. However, that raises new
> issues - mainly getting ENOMEM over iSCSI for unknown reasons.
>
> Because of this we would like to continue using the bsg interface,
> even if some changes are required to meet security concerns.
>
> Is there any chance for this removal to be reverted? I saw it was
> already included in 4.19-rc1.
>
> Regards,
> Dror



-- 
Thanks,
//richard
