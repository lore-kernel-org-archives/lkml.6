Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02008C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A1522404
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4i8WGMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A1522404
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeGGDI3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:08:29 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41216 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932590AbeGGDI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:08:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so26883250oiw.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 20:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=335Vtcki0khHV6xlURXG85TUuYVyziwauhUlpur6dKM=;
        b=g4i8WGMCjiH48jI0wz46JU6e+OFUNPKz5JjRtxf8RMyhKb0cYH3gHmAD7zvSpf5akE
         fhi0q+mtwq3LWwAqqGA9uKe7PP0SJgf12JAefwdF5lSgYOrJaUU+8rrUV6xRJR3guYor
         JKV8KGH9hNUAJWvVp852NoBHB8Ybh+LqXNc/nTc0p7+fD5zkqpqIX6P0X9yT046vp/1a
         SEdMLP4B4BT1fw/wsuFAEddJrY42IB7b010aJm8BDv037TvZvXDi8QTl/YLpj4jHlKPZ
         mxngVckjcZvoZWjWqoNcPnSKpPaQUY2q64rdN6t8YLZu2eGmruHksoDcrmQWp6WNjzSO
         2rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=335Vtcki0khHV6xlURXG85TUuYVyziwauhUlpur6dKM=;
        b=PePzkMOUBEzZbBXeN8SezXpZ+pkorKY9gkQDn/gBZD3H3neawGnjcEjZ8qv2DdedX3
         I1HWCkJnNwL6GpL9BhSBILvUZtebm6fGmlhS7MV/YixcTODpswpFypIDAticTAff/42v
         pNKZuiovf9ZGTG8CkTz9BLRvjV7wD/D4reFZPJKMusF9dKi8rdHvxtvcpUOUvRXZ8bQi
         vxCLiCXOvY8FsRdZe4jMaxDFTZMnzHeXB058CqqYJ6rW/nKUhzhk+dwMFX312dU08V0I
         1xWjQ44jAhRfxKIB7+wWRa2XumWZSnSBp9+n8d80CrM3SzFURCOmHwQwZFt3aHXiuvR4
         sZeQ==
X-Gm-Message-State: APt69E2tE82XoiRGA+BTUNoAT9uQJPOQvziXEOGfLs/wDP+oy7MbNCrY
        VMNfVdqmhDBzAd344yFUrAkEW2AtBHhTmlwQvcfY8w==
X-Google-Smtp-Source: AAOMgpf8NdHIR1xJwDeEXIdIlzt3WCJ4Z8AEH56L8TmQMWZZjT5irIxgMR9JUDqpTWlUd2qE5+4kSC50BvwN/7VVSs8=
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr14934488oib.91.1530932907298;
 Fri, 06 Jul 2018 20:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com> <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
In-Reply-To: <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 7 Jul 2018 05:08:01 +0200
Message-ID: <CAG48ez1rkG=R82eeuYA7s9S6z7+iRfJpVb__PmYaecjZAZETaw@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 4:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jul 6, 2018 at 7:31 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Who actually does direct read/write to /dev/sg? Could we perhaps just
> > add a config option to disable it entirely?
>
> On the IB side, the argument was that there was some crazy binary-only
> vendor management code that really wanted to use this completely crazy
> interface.
>
> I also think that the warnings are dubious. I'd rather add a
> deprecation warning to the whole "read/write to /dev/sg" itself, and
> then do what we did for ib_safe_file_access(), which was to just have
> the permission checks.

I guess we could try that...
Douglas Gilbert said that the read/write interface was the original
one, so there might be some users left... but the two hits I just
looked at on Debian codesearch seem to have switched to the SG_IO
ioctl already, using the read/write API as fallback only.

> It's not like a normal person should have access to /dev/sg to begin
> with. So it's not like you can open /dev/sg0 and then try to fool a
> suid program into doing the actual IO.
>
> I'd hope.
>
> Maybe I'm wrong, and there's some crazy "let's make /dev/sg available
> to normal users" setup out there somewhere. At least for me, /dev/sg
> isn't accessible to normal people:
>
>   [torvalds@i7 linux]$ cat /dev/sg0
>   cat: /dev/sg0: Permission denied
>
> but maybe some distro decided that everybody should have direct device access..

Al Viro pointed out that some distros grant access to CD devices to
non-root. I've checked in a Debian VM and a Ubuntu VM, and there,
/dev/sg0 is mode 0660, group "cdrom". That's not "everybody", but it's
not just root. At least in the Ubuntu VM, the user account that the
system installer created has access to "cdrom", but accounts that I
create afterwards using the settings UI don't get access to that
group. Unless other distros are more lax, it's probably not a big
issue?
