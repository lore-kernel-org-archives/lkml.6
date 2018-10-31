Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505F920657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPd36ric"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505F920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeJaWFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:05:05 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:38215 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbeJaWFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:05:04 -0400
Received: by mail-lj1-f169.google.com with SMTP id q186-v6so1395173ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7keqIWl7XBA+JCqfRs4mrTzOXx/vyc9F8lZHhh5bo0I=;
        b=YPd36ric6cmpwLKt+Bk+0/XvfdNYbg4ueUF9K+7VckuloZ96N/iFFtCxoG99lieIhU
         di50Vg6oTde5MnFWizZf2jgnr9/PueZZj8Uqt43UKjHbjHZS5G/16oAHvt28mTWi2R9P
         eRWJOb6BFjru8xBMIVEy0uCfu5wKVVTnSdflvjbONar+On4VoazA+xOn3MzrX9WPn6Qt
         LcBf3r55FHz+jqXUveTZSlJDPKWjbfburfgE9bLLLWmKypvQ5iFR59zDixm3gyTgzIJ1
         1yU7f40/qOeoP2ccdRdctdMiSvvOTfIIbTMy1TbmGLFsf8MoHGDPOUCPFaraslswbxIg
         I/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7keqIWl7XBA+JCqfRs4mrTzOXx/vyc9F8lZHhh5bo0I=;
        b=MGUVP+Ub66m9X7lAm6BtrhXwVAt4nyvkgDpMgJdPvDymCzxZdRMAEDYo/a0fG+T9cP
         /h/G7Lx1s2A4RcNmL+78kqArXVxvIVXaw1rs68jo5Aa0PZvkoBHBzsebeLoALuuy/NXG
         VV3oB03x53Y9+Zmk+35i0Zu4ikAL+FJxToDez63s1pB3zjjVCeH2z2Bssyp78wvV9QRj
         EUid1yKp3vvAo3xGYA29sLoKUfk5UEtbnub9mmN+UJ4hcDmmB897Jiy0nZKRov4gsLSP
         WgZWeQlE1AUfU48eOC+elr/TsQBFi++0FwK6h2N4NUaEvQ0tXsvCh07j9IjJW7QvJV/F
         cX9Q==
X-Gm-Message-State: AGRZ1gIAmYc7ZZR1QQ1DL2zcCr0EI30K85wCcgUrj2/KR+1+CJlrdnQB
        PfNCh3s0UoaFR/p7N36HK9pSoar6vaA9cXpBLIk=
X-Google-Smtp-Source: AJdET5cMZnnPYI3FloUeMiqcGhCXGxs8W/oxpza0uJHZGYpWxkA/BWA14sSdv5iRWh9qfMPVb0Uo/EhkZWr+ErOwax0=
X-Received: by 2002:a2e:8989:: with SMTP id c9-v6mr2040918lji.124.1540991225153;
 Wed, 31 Oct 2018 06:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCdhWVVqf8en9S-3mbDBwuxk481S+hi-uvQSw6Gf6jKujQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1810282336440.1498@knanqh.ubzr> <CAE5jQCeN6xsyUsi0RhyDobGqMXO5JA-LtFEV=E=gVZLXSo4Akw@mail.gmail.com>
 <nycvar.YSQ.7.76.1810291150231.1498@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1810291150231.1498@knanqh.ubzr>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Wed, 31 Oct 2018 16:06:53 +0300
Message-ID: <CAE5jQCc+LjJOSxAvTLaf1Fh_pRKgTgeS0=kZKgBjBPg1n2B7_w@mail.gmail.com>
Subject: Re: Cramfs: "unable to handle kernel paging request" when reading a
 file from a fuzzed FS image
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested in fresh torvalds/master branch. Thank you!

Best regards
Anatoly
=D0=BF=D0=BD, 29 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 19:03, Nicolas Pit=
re <nicolas.pitre@linaro.org>:
>
> On Mon, 29 Oct 2018, Anatoly Trosinenko wrote:
>
> > > How do I populate /vtmp? Mine is empty at this point. I imagine I
> > > should put the cramfs image somewhere on the host, but I'm not that
> > > familiar withkvm.
> >
> > Oops, forgot to say, it is the /tmp/kvm-xfstests-$USER directory on
> > the host (it will be created when you first launch kvm-xfstests and it
> > is "live", i.e. like NFS, not like "pack to ext4 image then boot and
> > mount").
>
> OK, I reproduced it. The fix is as follows:
>
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index f408994fc6..6e000392e4 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -202,7 +202,8 @@ static void *cramfs_blkdev_read(struct super_block *s=
b, unsigned int offset,
>                         continue;
>                 blk_offset =3D (blocknr - buffer_blocknr[i]) << PAGE_SHIF=
T;
>                 blk_offset +=3D offset;
> -               if (blk_offset + len > BUFFER_SIZE)
> +               if (blk_offset > BUFFER_SIZE ||
> +                   blk_offset + len > BUFFER_SIZE)
>                         continue;
>                 return read_buffers[i] + blk_offset;
>         }
>
> User space will get a bunch of zeroes rather than an explicit error in
> this case. There is just so many ways to corrupt a cramfs image without
> detecting it afterwards that I don't think it is worth doing more than
> making sure the system won't be compromized.
>
> > > Hmmm... It doesn't show up on my test system.
> >
> > Mounted it on my host Ubuntu 18.10 amd64, executed `cat /mnt/xyz` and
> > it was "Killed". Maybe it is something freshly added or
> > arch-dependent...
>
> It actually depends on whether there is something mapped immediately
> next to the cramfs cache buffer.
>
> In any case, this is a nice catch. Thank you for reporting it.
>
>
> Nicolas
