Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEBFECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F6620936
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwv6PCnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F6620936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeGOP7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 11:59:12 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:44173 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeGOP7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 11:59:12 -0400
Received: by mail-oi0-f49.google.com with SMTP id s198-v6so70422716oih.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ggljRTRq/t94V/WKcL/itgrdSyj1Z4L7YrX189WNs90=;
        b=Qwv6PCnrHwsh+qeRgw+ooyga9A6sbq2tY6vGw/LUtBnmbfoSeFcQaJ/Kgwj8bJakwY
         uto0cIQrYqAAG1iga64gMoqNNpoG44eGwTFbkjelyIOvYtJ+9Cardr2/J0e+4/pZWSrw
         YpnmpOpwVXQKXJBfQfblzaD/ZwXRpEGwneoo27I405rdW14lt54CFUGmZRQLYD3QfaFW
         7BrfRGWtzF2fSJUX3qLGXoDzKqdrczB9IKo0/7JArqNvt2ysRmYQ+6XGoLaeZEm+9IbC
         ymkniSzfSXUI0DkyJ/+/aUKMlC3oDm8bodi2BdW8w10uFsm95roXmzm/oQ1fEtSjlBUV
         sphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ggljRTRq/t94V/WKcL/itgrdSyj1Z4L7YrX189WNs90=;
        b=RfkZBRQFbSEXjerwE3af/fz4FxT8TWwqIQ4L3SO5IEAiDusQPNp5pyjxYANbju5n5Y
         0fGkvACdakO8fdlei82n2uWC79BH1n12OqIChYOyakxLuJavvgDjd1xnDkScquWuuMz2
         ba930x37+odAp8zBPXZE+ojmorkZxhKDw8o/QYlXFEZH9Tmc/k6pPUkbiicnn+mF+Z1l
         ONdQBRaBrOiHj4P4H7TIwXDLwxjVd4zSPICOv8WsfSmCRp8xZnhv1DZ7cnSZqda9zz0n
         qbhRmg2Tmgx9kgRDaNESZ8ZZrXoazWp/sKkti7jpI/ww59Xik5Y48h78vTei2tQhkuoz
         Q+ag==
X-Gm-Message-State: AOUpUlEjCA6Ip9qbTRSLlRm3ZGMWxz1uM2h93WY0iK9H7q1q5fxjeuF2
        kB/tDrKvPFaYKeMgm5RKxnJv4c/d3wH7Yrl/Lw8=
X-Google-Smtp-Source: AAOMgpcN3wkV6NJEnRe9t/l7n3sWapWJdLeOKIUTwr0gEjTxxL4p/mFrUki0l4U2gKj30+rg9pXhS8jX/kUfxqPW+ls=
X-Received: by 2002:aca:d5d3:: with SMTP id m202-v6mr14060054oig.93.1531668952214;
 Sun, 15 Jul 2018 08:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCe4nX8m1f5jPL57GeU32CftNv+NvgNmZxufH85nun1o7w@mail.gmail.com>
 <878t6c7f8p.fsf@mail.parknet.co.jp> <20180715143043.GM30522@ZenIV.linux.org.uk>
 <CAE5jQCcs2x4myTHUhNmHPZvhMuPsrkzLmiqqeF5wzZ-Hf5druQ@mail.gmail.com> <87h8l0y0z8.fsf@mail.parknet.co.jp>
In-Reply-To: <87h8l0y0z8.fsf@mail.parknet.co.jp>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Sun, 15 Jul 2018 18:35:40 +0300
Message-ID: <CAE5jQCevucqTnYOwKVYV8viz69A2q3o93=VE7zDGdCN_mgpYTA@mail.gmail.com>
Subject: Re: FAT: Operating on broken FAT FS causes the write syscall to
 return negative number not equal to -1
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for explanation!

Best regards,
Anatoly

=D0=B2=D1=81, 15 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 18:26, OGAWA Hirof=
umi <hirofumi@mail.parknet.co.jp>:
>
> Anatoly Trosinenko <anatoly.trosinenko@gmail.com> writes:
>
> >> This patch returns better error (-EIO) for me.
> >
> > This works for me likewise.
>
> Thanks for testing.
>
> >> (But note, the corrupted FS image doesn't guarantee POSIX behavior.)
> >
> > Oops, I was just doing some testing and thought that correct behavior
> > for crafted FS is to return arbitrary valid error code (like -EIO) or
> > some arbitrary data, say, not larger than FS (not disclosing the
> > kernel memory, of course). Please excuse me if I was wrong. If fixing
> > this would slow down some hot code path, then I am not insisting on
> > returning valid errno. :)
> >
> > Meanwhile, how should be considered such discrepancies with man pages
> > for invalid FS images: should it be considered low priority bug,
> > not-a-bug or feature request (diagnostics)?
>
> To handle the corrupted image _perfectly_, finally we will have to have
> online fsck or similar.
>
> For example, if the data block was shared between the regular file and
> directory, user can mmap the directory data via (corrupted) regular
> file.
>
> Then locking of directory handler doesn't work, and handler has to have
> directory data as volatile data (and validate data for each memory
> load). And to verify this invalid shared data blocks, we will have to
> read all inodes (i.e. almost fsck).
>
> So, I may change the code if data verification is easy and lightweight
> like in this case. But like said above, it will not be guaranteed.
>
> Thanks.
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
