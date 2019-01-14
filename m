Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51019C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2026F208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj7K/HWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfANPAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:00:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46323 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfANPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:00:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so19270740ljh.13;
        Mon, 14 Jan 2019 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pir6iph9qC+UhZ1RQ/u/pJbvExoSf4+Ae9K48RYuXUc=;
        b=Nj7K/HWA5hJw3J8CnijeZdHjrhsBe9EaWr1dm/L9v4SCFRcQ5ZTCglucuObRFOlKce
         mcC0K/e75XhpJq7bg/jV+fpEpWoAv2zOeOEkbFxElZCf9QoX2VWZXrrXsfnVVQIqV7ux
         /LGE35VcMesYKY2t9sDy3bDxgWAKzMxVX4VvE3GdGy5YgB3uAtOhcXGRTRESawxJH+SI
         mg4evIKm0mk5pTEsfB932GRgqAC9OYORPILF1al1x6e17mj+GaM/azGB3gt2bBxTfXDs
         5gc5gebJC2hE+BGLkK79dKWwF1uKJ3+eYzy+QIrbE5JM84Wz+TrlOM+q35kQBf5j34aV
         RiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pir6iph9qC+UhZ1RQ/u/pJbvExoSf4+Ae9K48RYuXUc=;
        b=o5XCgf4ngdJHGqpeyVKTZzE1v0ky02hfP9R0q9x0Fjs9Z7Uc34fZkUn6yzrtkUb9T6
         Yuz9cMwVq9m+msA9UtSk3RrCiml1/3OIaw37aJ7nlNvoJ+2KejzBa8u2mhj3LD+uH2iT
         eXsq2ogsvB4uMhVGTn7LJrQGJLJ62F78uelXDp0Wp+e7YtORYzUt/1P5jjpSLKlCoyQP
         IDkYMJVqrgRrtVaTNG1YEK3hmAGAhJVSaX2rQ5dBaKJNHkWybOmvs5e8Y46rEMLgM+t+
         19QyE63VX+w5jlREENExcFuWmLS16ca9q+fDWa7HeZIdOtXeqBMmDo8J26NfQg9uX4zx
         YurQ==
X-Gm-Message-State: AJcUukekqzUzRx8sPRqJ4UOTZwS8sIsbgwLoTsfhHsu5KDdHbbPvNoYm
        v2JXNuToo2fOPdjsqaAJWgj2yM+t8+H+2osrJuc=
X-Google-Smtp-Source: ALg8bN69YafmdrIEuFyK+nIFfDam4WyDSsSRZiOMXHk+LbFpL9ZX0UejuFc5pAhl9EJxd6LRqPWI3V15dlygd00niMI=
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr12550681ljb.104.1547478012019;
 Mon, 14 Jan 2019 07:00:12 -0800 (PST)
MIME-Version: 1.0
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
 <20190113230946.GA18710@amd> <CAE5jQCd+HBh3hCkQW4SR4QOHAGRS3wEuZfT4q1N6V8g9rrpBuA@mail.gmail.com>
 <CAO-hwJKxRBdctUf59TJLW0G81gKXLiEoueheUxgtPO4x_=YieQ@mail.gmail.com>
In-Reply-To: <CAO-hwJKxRBdctUf59TJLW0G81gKXLiEoueheUxgtPO4x_=YieQ@mail.gmail.com>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Mon, 14 Jan 2019 18:00:01 +0300
Message-ID: <CAE5jQCfQqTD8_xmOcnR5KOdL-sA_hjfykWT2US7LmV0K-fm7JA@mail.gmail.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Roderick Colenbrander <thunderbird2k@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the explanation!

Best regards
Anatoly

=D0=BF=D0=BD, 14 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 17:55, Benjamin Ti=
ssoires <benjamin.tissoires@redhat.com>:
>
> On Mon, Jan 14, 2019 at 3:23 PM Anatoly Trosinenko
> <anatoly.trosinenko@gmail.com> wrote:
> >
> > > fuzzed data is hard to discriminate from valid data.
> >
> > Just in case it can be helpful... If it is about manually "parsing"
> > descriptors to understand what is wrong by hands, then maybe Kaitai
> > Struct parser generator can help. I understand it is probably not
> > suited well for in-kernel binary parsing, but given a text-form
> > description of a format, it can visualize parsed binary data as a
> > hierarchical structure.
>
> Well, the data and parsing is pretty straightforward (see
> http://who-t.blogspot.com/2018/12/understanding-hid-report-descriptors.ht=
ml
> if you want to have an entertaining understanding, instead of reading
> the specs). The problem is the fuzzed data looks like a correct one,
> but there is garbage in the middle.
>
> And we can not simply rely on some global CRC that would prevent
> fuzzing because there is none. And the report descriptor is in the
> device, so we can't upgrade all of them.
>
> So in the end, sending a fuzz HID report descriptor is like sending a
> language grammar that doesn't mean anything. The parser says, "well,
> yes, why not", but sometime the rest of the drivers expect a little
> bit more, and this is where it gets hard to see.
>
> Cheers,
> Benjamin
>
> >
> > Best regards
> > Anatoly
> >
> > =D0=BF=D0=BD, 14 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 02:09, Pavel M=
achek <pavel@ucw.cz>:
> >
> > >
> > > Hi!
> > >
> > > I just want to note that while these may not be high-priority, they
> > > are still security holes to be fixed.
> > >
> > > > > When writing the attached file to /dev/uhid, a NULL dereference o=
ccurs
> > > > > in kernel. As I understand, the problem is not UHID-specific, but=
 is
> > > > > related to HID subsystem.
> > > >
> > > > Thanks for the report.
> > > > I wanted to tell you that I started investigating the other private
> > > > report you sent us, but couldn't find the time to properly come wit=
h a
> > > > fix as the fuzzed data is hard to discriminate from valid data.
> > > >
> > > > A couple of notes though:
> > > > - writing to uhid needs to be done by root. Any distribution that
> > > > doesn't enforce that is doomed to have several security issues
> > >
> > > We want to protect kernel from root, too.
> > >
> > > > - we could somehow reproduce those fuzzed data on a USB or Bluetoot=
h
> > > > connection, but that would require physical access to the device, s=
o
> > > > you are doomed also
> > >
> > > Not neccessarily. Imagine a kiosk where PC is protected but keyboard
> > > uses USB connection. If our USB stack is buggy, you are doomed... but
> > > you should not be ;-).
> > >                                                                      =
   Pavel
> > > --
> > > (english) http://www.livejournal.com/~pavelmachek
> > > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
