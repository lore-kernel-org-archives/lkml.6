Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A52C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B7520878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV7kGw9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B7520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJHXOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:14:04 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:40269 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJHXOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:14:03 -0400
Received: by mail-lj1-f170.google.com with SMTP id r83-v6so18362557ljr.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXOQa01RRg7nAf2wbPNTbzF1A/p1zVjlGhfKb0EAu1c=;
        b=eV7kGw9Pso3DeAofyKGXIrvKFDEKTlGaq5LmCQU2uW4/bBA1Pxeop2ctbPsmK5lRJ9
         r6UNV+9aB07OqmkzTRDNR7R0ZwvogWbG41fJ5wxyaJVFWlIDhR35uIwztNKbFpVXfrJb
         Eb8G8w4Djj3SgimvHXHo2xIHP68zqZlu+nvWa481GUqUMPiRUTCRO7OL+BK2iZvOT34B
         VgehmFKdI+LyenHbm02j0LC+HebJUCwrNuur9InIhSc4s0UVHGsoxk/2u4P73S4zpDTc
         Z+T+5BV8TKzoZ6Xy8ujZgC2Ad6BZxVRpPeDu4KL6c1AO5plfwprDj9EUtJgWWLEpWYsv
         WSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXOQa01RRg7nAf2wbPNTbzF1A/p1zVjlGhfKb0EAu1c=;
        b=V68WagkeC6V2E1tcTX/MDHLax5PAKZ7SCjh6+YVJK3dvSBdxYQphv0E4yIGDBdzAO9
         EslDoTmrp7pHDkXAzWfT9i76TxobgoSEaYMFdq38lx35OR8Jh96hX8sDEdman6DdTucc
         LbJziKgGnEnWBBGqtXN43ICM5RaFlKvgTw0gp+/yUdvQvu/pSyFg44hOP2vabBJ8hPJf
         CG0a2ThE1c0pEiGP7Qj3WBw7zdAPPIcMsgFMlvvHtp+1uoIpmV9ipsZsYtAQ40GYv1ed
         RJsZOc2X8/ogHTw6KFw9qCim2Z2msnDKyJL8ov8ucJ7uL/z/7KJ+aKEFV8xlW7X7b7Fe
         Lz6Q==
X-Gm-Message-State: ABuFfoimSr+Bae6NOqfAUxxIx6rkFJVCbVfoUA73ELWRNMwytLRSWxZs
        4vsPIrW+UIKAfh2KLgy2Cvo8cJQJUce8N20v32E=
X-Google-Smtp-Source: ACcGV634bsL8c3gNzWM1vq10GVY1rxug13lWB1aOhJWC3kMEPF0D4exEYjuLkhJ9B+iOsvpidUacFjiwTezKVbnVpso=
X-Received: by 2002:a2e:9549:: with SMTP id t9-v6mr15163071ljh.94.1539014496387;
 Mon, 08 Oct 2018 09:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
 <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com> <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
In-Reply-To: <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 Oct 2018 18:01:25 +0200
Message-ID: <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
To:     Joe Perches <joe@perches.com>
Cc:     Jason@zx2c4.com, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 5:40 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2018-10-08 at 09:31 +0200, Miguel Ojeda wrote:
> > On Mon, Oct 8, 2018 at 4:01 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > The shiny new .clang-format file lists a number of nice iterators in
> > > the ForEachMacros category, the consequence being that there is a
> > > space between the iterator name and the opening parenthesis. This
> > > strikes me as the right thing to do.
>
> It does not strike me as the right thing to do.
>
> Keeping an exhaustive list current is a continuing
> burden and the list generally goes stale over time.

Indeed, it is not nice. It would be best if clang-format had a special
case for macros before a block (i.e. assuming those are meant to be
"for loop macros"). Alas...

>
> > > However, checkpatch.pl complains about it:
> > >
> > > WARNING: space prohibited between function name and open parenthesis '('
> > > #65: FILE: ratelimiter.c:65:
> > > +               hlist_for_each_entry_safe (entry, temp, &table_v4[i], hash) {
> > >
> > > It would seem that .clang-format is right and checkpatch.pl is wrong?
> >
> > Checking quickly, it would seem most of the kernel does not put a
> > space there (a minority does), e.g.:
> >
> >   git grep 'list_for_each[a-zA-Z0-9_]* (' | wc -l # 67
> >   git grep 'list_for_each[a-zA-Z0-9_]*(' | wc -l # 13892
> >
> > So in that sense, checkpatch.pl is right (even if it is not a function call).
>
> As a general rule, I believe any dominant coding style
> is correct. These things are just a convention.
>
> .clang-format is a work in progress and should be updated
> where possible to reflect the kernel dominant styles.

Ideally, in a handful of years we would have an almost perfect mapping
(and/or agree to dismiss the old style that cannot be easily emulated)
and simply force to pass all code through clang-format in a
(server-side) git hook. One can dream... :-)

>
> > We would probably need to implement SpaceBeforeForEachMacros (or a new
> > option for SpaceBeforeParens). I haven't had the time to look into
> > adding the missing support for the few things that the kernel style
> > requires, sadly, but it is in my TODO list.
>
> Good luck and as you are the .clang_format maintainer,
> I hope you find the time.
>

Thanks a lot! I will try for sure at some point, since coding style
stuff takes a looooot of time from everyone.

Cheers,
Miguel
