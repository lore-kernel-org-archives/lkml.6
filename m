Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F4BC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E294620868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDSHcY9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E294620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeJLXPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:15:20 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43052 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbeJLXPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:15:19 -0400
Received: by mail-ot1-f43.google.com with SMTP id k9so12763316otl.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TGKNdRiAqsJ+9vv05Ju7TZ00qhmWcvpBHNFs7xhl1cA=;
        b=TDSHcY9+usFj9Lg6fBVkeBPBqHzT6L5PlJk9Ilc3Y4gFExb+XQVPOKr6UwRbfZeGGr
         CnOHT3sZzjpaVCeHWvPPHc0XsgGxVZUI8C4vTB2wH+MvpZKfJT0/+v5fhU0MPlqn532s
         vkfcBVwsL8e1DeEB7T1mJD4JMapXBL3G5Rbx0p52OwGTzdPCBZYMjqG4yLAKCxCpiUuP
         Tos9HVlJ+VLVsVE1x6wV6uDYbU+tyTpjiOcYT0/O/bCWdp7XS5Znf3+N7LMTY9UZ0xcE
         C0Wq5z7dC/wlM7G06Vl7r+t7rzn8yks6Y3axC3NoTtnaRoljKzuzYN8vQKwzejAkJR7x
         DIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TGKNdRiAqsJ+9vv05Ju7TZ00qhmWcvpBHNFs7xhl1cA=;
        b=EbYUyFdrhtK/pD6mHLR4VONIUegi2aeDWDUbnaCi2GV2sE0VLY+uOCBdp96EUxcS5d
         n0mzWY8fTkumh07XyZoUuxXq0VSure1mtSJdXifxt5owp51wTs9QVJpiyTjaT1IucDNC
         AeUrr/L4/ADNbQIQaYdG9nwkGYBeAN/PGnqzN4fdFv8ioQfcoRlB5SLAP2A08hssUotv
         Kn23Qd0nfgYReyRjQE0x0v5oH6cZgEK73Ab75C4dyhdGjXU9ZaEndBANkH/PJl1mzcbE
         Pt04Wg1+S2GcXLS3bGWBW33NcmsuoA3UrA0eAp5jLXfJJ5dhGG1PqpHV6PSrdT2k2p2y
         ihmw==
X-Gm-Message-State: ABuFfoj0ulBc5kfrZU8706OhoqBtr7WUK2g7iFqoOaROmXT6ugErCxE+
        BLHNRFcQbIfRVEmTo/4ktynuQZ1v3ZWwT0U2D7tyXg==
X-Google-Smtp-Source: ACcGV61cjUt8V8FxMstasCIxlwtkFTZbPan+26squLWCdASYJMXaZTFoJxrrQ4ij5X9rlgcwuVWIGtmeKc0CTlXBs9E=
X-Received: by 2002:a9d:2f23:: with SMTP id h32-v6mr4393271otb.255.1539358936091;
 Fri, 12 Oct 2018 08:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
 <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>
 <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
 <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com>
 <20181012152515.1d816906@alans-desktop> <77F59E25-5244-4CBC-A3CB-DCF863803CD2@amacapital.net>
 <20181012160219.7d16ef59@alans-desktop>
In-Reply-To: <20181012160219.7d16ef59@alans-desktop>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 17:41:49 +0200
Message-ID: <CAG48ez0r7UL675rxW-EypnfR+tF4LWT_GQkCevg7bTj9TkBM0Q@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>, kristen@linux.intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 5:03 PM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote=
:
>
> > My understanding is that the standard =E2=80=9Cbreadcrumb=E2=80=9D is t=
hat a cache line is fetched into L1D, and that the cacheline in question wi=
ll go into L1D even if it was previously not cached at all. So flushing L1D=
 will cause the timing from a probe to be different, but the breadcrumb is =
still there, and the attack will still work.
>
> Flush not write back. The L1D is empty (or full of other stuff the way
> the prototype I tested did it as x86 lacked a true L1 flushing primitive)

What about the TLB? Once KPTI is unnecessary, are you going to need an
extra TLB flush here to prevent PRIME+PROBE on the TLB?

Also: Are you assuming that the attacker would only be able to do
PRIME+PROBE, not FLUSH+RELOAD or other attacks that rely on shared
memory (like FLUSH+FLUSH, or the MESI-based stuff that detects when a
line stops being in modified state on another core)?

> > > At best you have a microscopic window to attack it on the SMT pair.
> >
> > So only the extra clever attackers will pull it off. This isn=E2=80=99t=
 all that reassuring.
>
> It's going to be very hard for them to do that. You don't really have the
> timing control in userspace to do that sort of thing easily.
>
> At the end of the day it's an additional hardenening not a fix. It's
> designed to provide extra protection for the cases we don't know about
> until we find them and lfence them. All of this (and all sidechannel of
> any kind) is merely about reducing the bandwidth an attacker can achieve.
>
> The idea is that it's cheap enough that it's worth doing.
>
> > Or I would get a fancy new CPU and use UMONITOR and, unless UMONITOR is=
 much cleverer than I suspect it is, the gig is up.  The time window for th=
e attack could be as small as you want, and UMONITOR will catch it.
>
> That would be an interesting line of attack. You would still have to
> navigate a fair bit of noise.
>
> Alan
