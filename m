Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A7ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA41208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kczB4eTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA41208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIOMQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 08:16:15 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39945 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeIOMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 08:16:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id l202-v6so14765712oig.7;
        Fri, 14 Sep 2018 23:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QfDYA0yl/YE9INDs2s5RGeG32jzODQuXrSzcv9liAmc=;
        b=kczB4eTfclIBGzSAJJPlLeJNwTo4shMO8kqtVE5U4vzaZwaFocVtvOCxFGy5r1ZO4N
         ghiZ9/oUftWQeyG568Nh20jjyAYPaaPAYj+Mh37hkXoUlkyqyPa0g1DB4sIQlWnLLEJt
         GyalDdxg/Zu50+BvcA/nUDYg0UnVoTN8aBFRglZ0e2puUKNsjSkufrYVobYxBhMTkYd1
         L5HyfQCBKEsi1FpiE64O4ikxseVUH7f6f3PiLWtz4c8J6r+pcPX8Cozd1NyuiAhkHrTM
         UfLhVXkMR1VFQnuUjv96PL7xNKlsfli4VVBVj2dXX+eXKMideO7XgbOiFhVUtoxPMHei
         atyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QfDYA0yl/YE9INDs2s5RGeG32jzODQuXrSzcv9liAmc=;
        b=ocnD39AC1zpalszm3onxtmCv6bZ98t38BLODQezRiPbxQPafsw5Y05WaduxDxpyj7q
         kY7tJZLlGtiGQ8kLrYOJTHDeRZ7FyzW6eF6/5Rci7zIjwOBlyTzSIShuK3at4cbnBKu9
         ky3U6yq3oubAAN8M4+Tu6A7e9XsF+B6dJECLb4GnJvz6GTkILxyGn2tA+BQeRC8ld4jo
         XyS0iLcN1Wx4g+x7E7I7erhs3cj5hfBET6Ml3sc6DuyZsfPzxl6A2Xty0z45g0uTtS1d
         Qm0IJWBVU+yHMxJinGBerMTNtXn98QPYZV8/15ca4t1P3A5m6IQTW499pTUqJ/BBzLit
         /dcA==
X-Gm-Message-State: APzg51CEpowluMsvxZ3nyxWiML+LaHnroDqt2luvh5WL6nKRzq2YwcfP
        K7NU2L+fcq096IrjSfT8ylEQRrlWsYD/wdhSpnqHJrBkkM2G//Ua
X-Google-Smtp-Source: ANB0VdaEigS/b/SC62Woo/puJk6Ukyho5zVia+gTjEDT9z5TxPEGlTvYcE4cgEsD5a2KA3ZVoDAy/Ag6MccUP3pFgNw=
X-Received: by 2002:aca:3c02:: with SMTP id j2-v6mr11890771oia.50.1536994698825;
 Fri, 14 Sep 2018 23:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJDTihzzLV3qwg0tGH_D4xAjCrgMy+oc4H9snpnMC_RC2q7nyw@mail.gmail.com>
 <20180914222336.GD16550@dastard>
In-Reply-To: <20180914222336.GD16550@dastard>
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Sat, 15 Sep 2018 14:58:07 +0800
Message-ID: <CAJDTihx2MEpdWdp6V6AsOD35Lh_6R=uFXBGtO8fL8s0o5C_t8Q@mail.gmail.com>
Subject: Re: metadata operation reordering regards to crash
To:     david@fromorbit.com, cmumford@cmumford.com,
        linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 6:23 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Sep 14, 2018 at 05:06:44PM +0800, =E7=84=A6=E6=99=93=E5=86=AC wro=
te:
> > Hi, all,
> >
> > A probably bit of complex question:
> > Does nowadays practical filesystems, eg., extX, btfs, preserve metadata
> > operation order through a crash/power failure?
>
> Yes.
>
> Behaviour is filesystem dependent, but we have tests in fstests that
> specifically exercise order preservation across filesystem failures.
>
> > What I know is modern filesystems ensure metadata consistency
> > after crash/power failure. Journal filesystems like extX do that by
> > write-ahead logging of metadata operations into transactions. Other
> > filesystems do that in various ways as btfs do that by COW.
> >
> > What I'm not so far clear is whether these filesystems preserve
> > metadata operation order after a crash.
> >
> > For example,
> > op 1.  rename(A, B)
> > op 2.  rename(C, D)
> >
> > As mentioned above,  metadata consistency is ensured after a crash.
> > Thus, B is either the original B(or not exists) or has been replaced by=
 A.
> > The same to D.
> >
> > Is it possible that, after a crash, D has been replaced by C but B is s=
till
> > the original file(or not exists)?
>
> Not for XFS, ext4, btrfs or f2fs. Other filesystems might be
> different.

Thanks, Dave,

I found this archive:
https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg31937.html

It seems btrfs people thinks reordering could happen.

It is a relatively old reply. Has the implement changed? Or is there
some new standard that requires reordering not happen?

> Cheers,
>
> Dave,
> --
> Dave Chinner
> david@fromorbit.com
