Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE2AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2301E2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpUQ33QI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2301E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeLNIPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:15:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33616 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNIPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:15:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so2482969pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 00:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kFNHkzE+Cd59LXOUI8TvhyFzGW3k2qdyX3qiosOpMM=;
        b=dpUQ33QIQO8bW0z+lTF4DUnrncUytOxJuquVnuIsnB0yyQeCIzQWJ5YJ0sUnD5fgjo
         6EA4hP0aC2pbenyrrbbWP66ZWm11CFqbVlwFxKQKolrxuKrqQp8efPHzr2IFiQaZZavq
         hPdoOGiw4ZxFn2zl5ElHoxE/sPo8850b5w1IMr1/8WklOsMXuPgEytMo0zNK0MTdVJ42
         U5yFIjsINCdAvdbhqafuFeeaWWX1n/JFsPIWJiz8RNkVMXOK+WdAC/IliF8hYsYyWcs5
         z/F618etO8rvM6deBN2IGijhlFVdXrriaUn9XPfthaCeeqzjZO2r836Tj8FHvN4IuEkw
         PtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kFNHkzE+Cd59LXOUI8TvhyFzGW3k2qdyX3qiosOpMM=;
        b=Zd+jusJ6OzIn1Dg+TQihWAsOoWGuZ/GAVa23S7617Q1urGWnxpQUWKe5rXeKxmZTYL
         xfkmRMB2kzwB5TVHsc5BXdyONfNLwFYgs3sjfANRei9+qsCOf5YHZhM1WPR5w2WG1XbZ
         56ytSCfQE+GzaoOXI5EEfe/zhb4buHruu315nsRDtcmJiQ1jZR9G4NjGO8LzkdXiiGJ/
         ifH/xsTWqTum9jqyYSBqTojPPRgXgG2/0Xm/WffpgHFSSRiLFurLltDQEvepL17Hssf9
         1ZkxfqRXqTh6ADL3+C30mt851GR6e9wxOtREG2ZUOncFe14bjjlG8+eagD1NDt999VLh
         K3uA==
X-Gm-Message-State: AA+aEWYKFggzAJJIlLKcpRNOimzDlXDaLefa0cCGiLyEdaLqH6jGoJ8h
        p5Bx3RsPue4R+Ui1/HzrUNkom+K/JVQDmSwGNq2SW9anEsM=
X-Google-Smtp-Source: AFSGD/XJ0wCo3BtTAJWBpwPoyZrL2DUN2b0k9263hk7mCMPlsJy2QL4vPmEj1pQh/DxPUBWdlUsnUBwEkZu64rNIY6w=
X-Received: by 2002:a63:4342:: with SMTP id q63mr1869217pga.63.1544775308971;
 Fri, 14 Dec 2018 00:15:08 -0800 (PST)
MIME-Version: 1.0
References: <1544470917-6443-1-git-send-email-carmeli.tamir@gmail.com>
 <1544470917-6443-3-git-send-email-carmeli.tamir@gmail.com>
 <906167f7ca975d437ff9868333d8bf1e86b934a7.camel@perches.com> <87sgz0dci0.fsf@mail.parknet.co.jp>
In-Reply-To: <87sgz0dci0.fsf@mail.parknet.co.jp>
From:   Tamir Carmeli <carmeli.tamir@gmail.com>
Date:   Fri, 14 Dec 2018 10:14:35 +0200
Message-ID: <CAKxm1-G7WpJV0_3=TLyY_JMN=Wz1GkM2w6buc6ez+WUZ_tyEhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fat: New macros to determine the FAT variant (32, 16
 or 12)
To:     hirofumi@mail.parknet.co.jp
Cc:     joe@perches.com, jthumshirn@suse.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        akpm@linux-foundation.org, axboe@kernel.dk,
        martin.petersen@oracle.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for the comments, I'll work on V2 to fix them.
I just want to make sure, is there a reason why I shouldn't delete
FAT_FIRST_ENT, as Joe Perches commented?

On Fri, Dec 14, 2018 at 5:16 AM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Joe Perches <joe@perches.com> writes:
>
> >>
> >> -#define FAT_FIRST_ENT(s, x)     ((MSDOS_SB(s)->fat_bits == 32 ? 0x0FFFFF00 : \
> >> -    MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
> >> +#define IS_FAT12(sbi) (sbi->fat_bits == 12)
> >> +#define IS_FAT16(sbi) (sbi->fat_bits == 16)
> >> +#define IS_FAT32(sbi) (sbi->fat_bits == 32)
> >
> > sbi should be parenthesized or perhaps better these should be
> > static inline bool functions
>
> Right, rather this is the bug (not hit yet though) that should be fixed.
>
> Thanks.
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
