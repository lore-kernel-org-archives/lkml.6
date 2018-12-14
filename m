Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6855BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA602206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vpoEVzHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbeLNTFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:05:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39797 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbeLNTFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:05:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so3098605pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 11:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HFArEsQ2wlNMkLl7FTUDdsS9lVVr/sQTHQJLquuhJvY=;
        b=vpoEVzHjXHvBKzsS9jtjtYLnnVL+eyVhHI+0fFNuEcqkgb70CYHN+rwkfuhHyJ6Vos
         onJNTJYI/nC8EOOW1PWp5VmwvIEATvDZW+8qzhnWa4oESE6+UFIX8JYYFf67PRlkFmUh
         tltUtWuJhcN8Edzgr2xVsvo9Z4w+JdE/Ml0P/GaAz0aZoVyNLFv4yJ6MvuTMXXHt320u
         otxVHGcLYaOi83gcrEE1DR/ybvI7FC6ElP3LUMPb9Kjhm0JoSRgAP5rcpa/WqhvVNBKa
         j9F1MFwFw3aYyjwUCOcTq1O4TTdjA+YFPJSLmP9TG11WIuUw2IDk5mToL09NCrtboqtW
         bLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HFArEsQ2wlNMkLl7FTUDdsS9lVVr/sQTHQJLquuhJvY=;
        b=aYYruvfKYs9byf0tkjyGwvLrG0/VYl7gwxaGez6nEC1PQRnrROhlUf4bYPiCpRhT87
         ZrPTFsozLnQSwY75q6QWWYX7TmGnyh8Msx/sK8OYGdqnrvVUmf9sm6aTEG15zioPXRTm
         qP1OEoFSanFBeCwqan/+ay1Ayhx/eBrFq4AUi2OBk26uhcGEOm4wCqOZm7QLmb9Ph17O
         yqvbmD4L5gBZNZeXi1CYQT9JzGrFz/wsQOOXDQLX5X0uWvRFQgajSh4SFB6D7bHH1Lwk
         U/UEfgV55lgpu6f75jB5kL+zsoABQEE+4QYJYUdVN5cowEIL5H/FsYN+Z4HBdZA/ggt3
         Azgg==
X-Gm-Message-State: AA+aEWYmuMZbJsmSi0FCs6ca0wKLi2k8basrnrVmDGIVDfg2TK2N80iL
        R2AbdDaymEaKzRJs+KjpakKRwQ==
X-Google-Smtp-Source: AFSGD/W5mWi3GpXpxXmZoI6m4GOgJbUnT2LR9T9er8SNGCdDwm4bGsdbgCjPtS0VcUu+t1JL2n64Nw==
X-Received: by 2002:a63:6cc:: with SMTP id 195mr3706718pgg.401.1544813887394;
        Fri, 14 Dec 2018 10:58:07 -0800 (PST)
Received: from ?IPv6:2600:1010:b040:6acb:bdde:f4f9:c60e:340a? ([2600:1010:b040:6acb:bdde:f4f9:c60e:340a])
        by smtp.gmail.com with ESMTPSA id x2sm7742349pfx.78.2018.12.14.10.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 10:58:05 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Can we drop upstream Linux x32 support?
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181214165535.GZ23599@brightrain.aerifal.cx>
Date:   Fri, 14 Dec 2018 10:58:04 -0800
Cc:     Florian Weimer <fweimer@redhat.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC1F028D-4382-41D6-B539-A9662FD53820@amacapital.net>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com> <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de> <20181213160242.GV23599@brightrain.aerifal.cx> <c8987b31-ed79-acef-a300-31ebf2c29d2e@petrovitsch.priv.at> <20181214161732.GY23599@brightrain.aerifal.cx> <87mup8gj1y.fsf@oldenburg2.str.redhat.com> <20181214165535.GZ23599@brightrain.aerifal.cx>
To:     Rich Felker <dalias@libc.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 14, 2018, at 8:55 AM, Rich Felker <dalias@libc.org> wrote:
>=20
>> On Fri, Dec 14, 2018 at 05:38:33PM +0100, Florian Weimer wrote:
>> * Rich Felker:
>>=20
>>> This is all useless (and wrong since tv_nsec is required to have type
>>> long as part of C and POSIX, regardless of ILP32-vs-LP64; that's a bug
>>> in glibc's x32).
>>=20
>> We should be able to fix standards if they prove unworkable in practice.
>> In my opinion, if standards require complex solutions where an obvious
>> and simple solution exists, then standards are wrong.
>=20
> The requirement doesn't mandate complex solutions. There's nothing
> complex about tv_nsec being long. long is the smallest type that C
> guarantees to be large enough to store the range of values, which is
> forever fixed and can't grow (because the definition of "nano" prefix
> is fixed :). The type has been long ever since the structure was
> introduced, and its being long means that there's lots of (correct!)
> code using %ld (e.g. ".%.9ld" to format results as a decimal without
> using floating point approximations) to print it. There might also be
> code taking pointers to it to pass to functions, etc.
>=20
> The only reason a "complex" need arises is that Linux did something
> horribly wrong here, ignoring the specified type, when introducing an
> obscure subarch that almost nobody uses. This kind of mistake is
> becoming a theme in Linux (see also: msghdr). Application authors
> should not have to pay the price for fixing this by retrofitting yet
> another silly type like "snseconds_t" or something into programs to
> accommodate the mistakes of x32.
>=20
>=20

Does anyone know *why* Linux=E2=80=99s x32 has __kernel_long_t defined as lo=
ng long?  I assume that this is where this bug, and most of the other bugs, c=
ame from.

This may be silly, but the kernel could plausibly add a x32v2 where long is g=
enuinely 32-bit, and then maybe we could drop the old x32 at some point.  =46rom=
 all the discussion so far, it seems like there really is some demand for IL=
P32, but it=E2=80=99s still not really clear that preserving compatibility w=
ith existing x32 binaries in the long run is critical.=
