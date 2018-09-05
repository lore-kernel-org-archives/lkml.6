Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EAEC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03F7206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM1GDpk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03F7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeIEMyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:54:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38731 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIEMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:54:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so12046638oix.5;
        Wed, 05 Sep 2018 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O03UbD0U3+fa2lSz96RDGfleYjrnYsDunk0/9oS3Buo=;
        b=FM1GDpk+7YhauUdXyAn8wr0aSqQTm/XvqUl+HiAoH8IQcdUWG1qBQNY6rgqXQvt826
         paeR39sHdRCqJ3Vz6LAzi+MtFQBuucxXONnOoi43UteZCMVMjcisb4SAGIUN77lvuoVF
         kvpI06VT7/FxsxDQ5HI9PHyqwvCN4ehDoa1n4X7vaxy9Axg/Q619zkEnoWx2A51jp45g
         chE3sxa1sXcocRuctYuvBJuA5FD95oot2YkOrTi/BRuDfqeAdf7nk3KaSTR10eFm4Fvw
         QPAvwUCP2KgMrb2eJuv7rbcw4C2DEzlmAdO97b/GY8ZryzoZXRiKuFfnthmNR13z14IE
         7w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O03UbD0U3+fa2lSz96RDGfleYjrnYsDunk0/9oS3Buo=;
        b=HEG/rbdMBtlEH4L5rUIs/xVXu8+LuUFTDMDr3LV6HzNUG63YWVjRqOERthk1+elkrX
         yVT6mN6LWt2grEIhU4xIsB2+zbe3j6wa4JGFYn3LQ9ZLbXnmqpchIddeCu4PEms+BFhT
         zd1no706ikW4lnrqx6Z7zC9YVjXgxcF4fYZjFDrsKSqz8XW+Kz0QOVKkFMfE9PfNgKSq
         ZttrYySZ0Gw8o/SCiyJ6DTaf9qaPz5vIobVRIIGkZgi1+K7yKrq36UHRbcdKulVI2toT
         LlgHwxKf9F25TDW6Qh7kFDpJKcucOlN57wJup5el4hhu8iQtar62D4Z9x2tLM1wZLgEv
         YPvg==
X-Gm-Message-State: APzg51AIn/3w8/zbwQvRzLMxePX9O0wlSqyf9iikE1x8XK7varQl/5bM
        uXT1/IVIMYUQgfkAmtAf2dwBoykYcXYFoZE8yR8p7pCHW5pQ5w==
X-Google-Smtp-Source: ANB0VdZaygXUu190WHafc8Yw0KQIG4oV13/GWXSfF1tCWrsvGOJIq600BQ+MuwKfbxZH83ujGylzKSLhQKh+jqj3evk=
X-Received: by 2002:aca:5e42:: with SMTP id s63-v6mr26898044oib.134.1536135908920;
 Wed, 05 Sep 2018 01:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl> <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180904161203.GD17478@fieldses.org> <20180904162348.GN17123@BitWizard.nl>
 <20180904185411.GA22166@fieldses.org> <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
In-Reply-To: <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Wed, 5 Sep 2018 16:24:57 +0800
Message-ID: <CAJDTihxE07BuXMBmShXuj=TbJCK1mq3ZMFMxP1-T=xjhPF5ySw@mail.gmail.com>
Subject: Re: POSIX violation by writeback error
To:     jlayton@redhat.com
Cc:     bfields@fieldses.org, R.E.Wolff@bitwizard.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 4:18 AM Jeff Layton <jlayton@redhat.com> wrote:
>
> On Tue, 2018-09-04 at 14:54 -0400, J. Bruce Fields wrote:
> > On Tue, Sep 04, 2018 at 06:23:48PM +0200, Rogier Wolff wrote:
> > > On Tue, Sep 04, 2018 at 12:12:03PM -0400, J. Bruce Fields wrote:
> > > > Well, I think the point was that in the above examples you'd prefer=
 that
> > > > the read just fail--no need to keep the data.  A bit marking the fi=
le
> > > > (or even the entire filesystem) unreadable would satisfy posix, I g=
uess.
> > > > Whether that's practical, I don't know.
> > >
> > > When you would do it like that (mark the whole filesystem as "in
> > > error") things go from bad to worse even faster. The Linux kernel
> > > tries to keep the system up even in the face of errors.
> > >
> > > With that suggestion, having one application run into a writeback
> > > error would effectively crash the whole system because the filesystem
> > > may be the root filesystem and stuff like "sshd" that you need to
> > > diagnose the problem needs to be read from the disk....
> >
> > Well, the absolutist position on posix compliance here would be that a
> > crash is still preferable to returning the wrong data.  And for the
> > cases =E7=84=A6=E6=99=93=E5=86=AC gives, that sounds right?  Maybe it's=
 the wrong balance in
> > general, I don't know.  And we do already have filesystems with
> > panic-on-error options, so if they aren't used maybe then maybe users
> > have already voted against that level of strictness.
> >
>
> Yeah, idk. The problem here is that this is squarely in the domain of
> implementation defined behavior. I do think that the current "policy"
> (if you call it that) of what to do after a wb error is weird and wrong.
> What we probably ought to do is start considering how we'd like it to
> behave.
>
> How about something like this?
>
> Mark the pages as "uncleanable" after a writeback error. We'll satisfy
> reads from the cached data until someone calls fsync, at which point
> we'd return the error and invalidate the uncleanable pages.

Totally agree with you.

>
> If no one calls fsync and scrapes the error, we'll hold on to it for as
> long as we can (or up to some predefined limit) and then after that
> we'll invalidate the uncleanable pages and start returning errors on
> reads. If someone eventually calls fsync afterward, we can return to
> normal operation.

Agree with you except that using fsync() as `clear_error_mark()` seems
weird and counter-intuitive.

>
> As always though...what about mmap? Would we need to SIGBUS at the point
> where we'd start returning errors on read()?

I think SIGBUS to mmap() is the same thing as EIO to read().

>
> Would that approximate the current behavior enough and make sense?
> Implementing it all sounds non-trivial though...

No.
No problem is reported because nowadays we are relying on the
underlying disk drives. They transparently redirect bad sectors and
use S.M.A.R.T to waning us long before a real EIO could be seen.
As to network filesystems, if I'm not wrong, close() op calls fsync()
inside the implementation. So there is also no problem.

>
> --
> Jeff Layton <jlayton@redhat.com>
>
