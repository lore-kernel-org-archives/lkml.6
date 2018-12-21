Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A763C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ADA21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxKh+3YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbeLUKHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:07:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35235 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbeLUKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:07:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so4619670wrb.2;
        Fri, 21 Dec 2018 02:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpmFPgcL/oiwT+yjMmeKyzPtBfee/1LoUJpUeh24xR8=;
        b=GxKh+3YGG680fOdMY9fiUAcedv5yLCZLtTQLsKosFd1FxA8jhmzfjpwl78/5IwKjzy
         BqX1jbkmIEgz1IvjRXOfF9k/2J6qTtbGlQ2lwfmDktM6SjBbdVKuEi4M2zo54EJzY2O3
         Mo1Lna/2JuYiSVpVHv0/3ZTeHRKKZhOVVo819qSW7Ehg42P66oMjWd1HKhORxxvWDP5a
         0oq1rYRJyRRGwFHA3NkATCScIiLIoCVa12/Gg9VqijeFppkO8/Xv2FmrIMgXkzIQwMFX
         fxpSTlRENN4+VsnRKP24011a+zyJzeDNP8vtJZ+UDxNFEdIdzdLrWGt9qiTNgRBsDAZs
         7w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpmFPgcL/oiwT+yjMmeKyzPtBfee/1LoUJpUeh24xR8=;
        b=F0iYqEOBR30iLe/1UJxiv6Tsz+Mf8Fu2vHy8uoPO8HJdkqfkfSM7j4VG9kelaU/IQa
         yGuXt7RadGzTA0aSVP4HpAYFMN970XBPNhIaFvIc7Y5PX3S7JL+cxV9wHkEDWERki7X6
         egz3C0rhICwN5UY0BtmWh4sukjvzRPVIsxX05okksr4zkKx8LCh55X+/ODU1nBczm7IT
         7CcgMYnI0edMwx2W2hZtO+6Ea6nGSdd7T8SAKdKDqOztbCBYUt1G6kJs/2GXZP1QEenY
         hTwCy7N/zXVaNwL6jxDQqCeg3TtioHCk0u7gpw0mwClgpY9d55b9G0QDjGjVQecQdC4l
         dT4g==
X-Gm-Message-State: AJcUukedlZQqc7L64NlemUJezsXXVELtkovZOSlDAUHVKt3jIMbh1QTb
        18YgN3y/0aN7bPVXhR+dmGWgb6MW3bn3BPHAolw=
X-Google-Smtp-Source: ALg8bN4j8Y2ID+uOxrIBUKrDNP8XEM3Y7XB/6z0GlWxTclYG/J7WSzSMeLiUZcbaX9EJuJEcAfTZMWwXkj20Eg+Ar68=
X-Received: by 2002:adf:ed46:: with SMTP id u6mr1942195wro.262.1545386817572;
 Fri, 21 Dec 2018 02:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20181219071420.GC2628@infradead.org> <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu> <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu> <20181221070447.GA21687@infradead.org>
In-Reply-To: <20181221070447.GA21687@infradead.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 21 Dec 2018 11:06:45 +0100
Message-ID: <CAFLxGvxKPNDBQfBnx0obRrriCq9S3U_JsE4bwDwM8QxE+En9=w@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 9:58 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Dec 20, 2018 at 05:01:58PM -0500, Theodore Y. Ts'o wrote:
> > That's simply not true.  Number one, fsverity is not mandatory for all
> > file systems to implement.  If XFS doesn't want to implement fscrypt
> > or fsverity, it doesn't have to.  Number two, we're not *making* any
> > changes to the kernel code; nothing in mm/filemap.c, et. al.  So
> > saying that we are making changes that are impacted by /everyone/ just
> > doesn't make any sense.
>
> Ted, I think you know yourself this isn't true.  Whenever we added
> useful interface to one of the major file systems we had other pick
> it up, and that is a good thing because the last thing we need is
> fragmentation of interfaces.  And even if that wasn't the case I don't
> think we should take short cuts, because even if an interface was just
> for a file system or two it still needs to be properly desgined.
>
> There is no reason to rush interfacs in, because everytime we have done
> that it has turned out to be a very bad idea in retrospective.

Speaking of interfaces, one thing that needs IMHO more thought is the
user facing interface. Not only in the fsverity case, in all cases.

Linux has currently many different ways to implement and check
(cryptographic)-integrity.
Just to name a few, fsverity, UBIFS' auth feature, BTRFS csum,
EVM/IMA, dm-integrity,
dm-verity, ...

At least for filesystems it would be good to have a common interface
to query the
integrity status of a file.
So far we have mixture of different return codes (EPERM, EUCLEAN, EINVAL),
audit events plus cryptic kernel logs.

In UBIFS we return EPERM in case of an auth failure, we followed EVM/IMA.
fsverity goes the EUCLEAN route, just like BTRFS for check sum failures.

Before everything is set in stone, let's try to consolidate at least this.

Along with that, what about the statx() interface?
We have already STATX_ATTR_ENCRYPTED, why no STATX_ATTR_AUTHENTICATED?

-- 
Thanks,
//richard
