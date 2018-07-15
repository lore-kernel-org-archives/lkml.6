Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58547ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC5921473
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv/HJxbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC5921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbeGOPbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 11:31:50 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34800 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbeGOPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 11:31:50 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so70369725ois.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GbGD6dICMVOLkZcfAZiQD1V7K+TI1KHGPhQeJUZnzt8=;
        b=Vv/HJxbK30WV7mIngWTuQZmheMDo/bkJlq9ewnx94rZmcy5xWzxA/4WaE84ovM4ST0
         8qW/JpoHRi4eDsKpFr6JI2Pe3UoDfFHig5bvIP2xHIf0Hk/m7GfrpEGrGBz4H+c4gIUk
         pxlDcZHUbJWXWmqtReWA4kLOgT1I26SP9gMwjez8+6eBGywrU+jQjeoDyjPeDAyZw9IP
         Inrc7dndax8Y7B0e9XU5p0GHsGsuWd0MRtbyFK6VAjoZCrJ6EaGt3tXsAP43SB5dBzXR
         lPeFszhotu65w8GC/7ajpV0Ii3XCTdREoF4S19TYZ0tYdFHWFWDOcY5tKw/bBhOI8OS4
         chbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GbGD6dICMVOLkZcfAZiQD1V7K+TI1KHGPhQeJUZnzt8=;
        b=FtZbKhlRdLmLlusvuB4i+2Xw4rR7LKVsawYz/KK0yE8j74d7RpCmnChFT0KkqutOkM
         ewz7gC0UU0E6W4Gkd1T+QbCPSjgoA8fCvECiKKDAHKIg/Ps3t4GL83nYcV5EbW2G58Bz
         QRxoUjlEXrV3R5V/H7Y3LGcnNJO/Uu0ZdaItV0fA3Scg1XuNgI5ss5E3yAbNKN7O7oov
         2NezEUQ+y0tIzD/MxY/KirvxZVEPwIzze5ugyiRsJfG7f0MgcmZny0ryW9nIxYEeclXP
         K5V5bhIvR7exZEIbfSHp0Ncvs/bTq1rT2aRx0UHYwiZbeyAUwNiYE9LjOUHmBVmd1pCD
         pszA==
X-Gm-Message-State: AOUpUlGjnVUwC6CR13E9wa3g/28i95/VvvViagQmPJkJ0N3Qo8hwj8mM
        jA89bmaPt/G2NM9Gd5Ww/Mudfz6AxM7CCa4BJSxRvvFpLNM=
X-Google-Smtp-Source: AAOMgpfPKNh51rVKdsXvipn0I4g2IQ4PxyqgwKqHYBJboFn8cxXYsu8dskN2U7kYVEBObWTP0ag7K00ShHKtgi+5PPI=
X-Received: by 2002:aca:3546:: with SMTP id c67-v6mr15405882oia.249.1531667314330;
 Sun, 15 Jul 2018 08:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCe4nX8m1f5jPL57GeU32CftNv+NvgNmZxufH85nun1o7w@mail.gmail.com>
 <878t6c7f8p.fsf@mail.parknet.co.jp> <20180715143043.GM30522@ZenIV.linux.org.uk>
In-Reply-To: <20180715143043.GM30522@ZenIV.linux.org.uk>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Sun, 15 Jul 2018 18:08:23 +0300
Message-ID: <CAE5jQCcs2x4myTHUhNmHPZvhMuPsrkzLmiqqeF5wzZ-Hf5druQ@mail.gmail.com>
Subject: Re: FAT: Operating on broken FAT FS causes the write syscall to
 return negative number not equal to -1
To:     viro@zeniv.linux.org.uk
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!

> This patch returns better error (-EIO) for me.

This works for me likewise.

> (But note, the corrupted FS image doesn't guarantee POSIX behavior.)

Oops, I was just doing some testing and thought that correct behavior
for crafted FS is to return arbitrary valid error code (like -EIO) or
some arbitrary data, say, not larger than FS (not disclosing the
kernel memory, of course). Please excuse me if I was wrong. If fixing
this would slow down some hot code path, then I am not insisting on
returning valid errno. :)

Meanwhile, how should be considered such discrepancies with man pages
for invalid FS images: should it be considered low priority bug,
not-a-bug or feature request (diagnostics)?


Thanks
Anatoly

=D0=B2=D1=81, 15 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 17:30, Al Viro <vi=
ro@zeniv.linux.org.uk>:
>
> On Sun, Jul 15, 2018 at 11:20:06PM +0900, OGAWA Hirofumi wrote:
> > +static inline bool fat_valid_entry(struct msdos_sb_info *sbi, int entr=
y)
> > +{
> > +     if (entry < FAT_START_ENT || sbi->max_cluster <=3D entry)
> > +             return false;
> > +     return true;
> > +}
>
> Pet peeve: if (...) return false; return true; instead of return !....;
>
> In this case,
>         return entry >=3D FAT_START_ENT && entry < sb->max_cluster;
