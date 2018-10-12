Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA7C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CC22098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wHzSYHtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CC22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeJLWP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:15:58 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41974 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbeJLWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:15:58 -0400
Received: by mail-pf1-f180.google.com with SMTP id m77-v6so6305606pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MVIhcoy2987S0IkbqRssZBMMuTl+ECmSYs1VE8q++Qo=;
        b=wHzSYHtWI1FWvpqWMoI29Nv0pD5eMm4aUHRjMemE3tiMkwzlord9gz9x6kxJT4NbPK
         R/J6X44TXQJ+TUfrx3zf4CdymfRfmvl84sfwrfYGQzyh+9obG3MtzaAlSEiMRZOiYoc0
         A5StWg7VIC6oJRs5dTXIqI4zeew51SYzbbqGI/VHBheEgTVl6Lqj09pk7BzrW0a/Bpvn
         Ah7D+HwjFOsXs44OyMarnTQPX14piq4cGVcua6j4WT450V3/9fzXLguBlTWpmPAGn/p6
         +M4EMcihWCqcYocKEZ17AcwoyqyC5MWkWIQlE0FeTV0ZkXCd5vj0KYYnREvFyEPwfin7
         3ijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MVIhcoy2987S0IkbqRssZBMMuTl+ECmSYs1VE8q++Qo=;
        b=eObQD4du7fh4fuxxnLP9465qjFeqL3zl6FmYnP/Ric5o1TeAOmka3W2rx0QqEuVPJJ
         +uv5zC9HX9Zv33FaMTmEHWO+G5l07BstlnD8aOBl8LZmgTbitAiOax5M5ytioUhsHZJ3
         VSDpvrzuSq6Hg0GHB9+i04ENHcPjWZGj2K8ePD9lxZsC8Yrsl5Ft97+CiPZjg2GGzf9H
         iDi0vSfEyxvz0OfihY62KJyaXeFyZLzKAjndrMBHTlh59VrqLH3R8k2qVPWWuH+6NKDT
         YDFJlmbN9bh7k1ZgI1CZYi0n6xhlejHKhgLdiKQI4EysSCFxVDH/LsBk7VdOxvYkuYgZ
         5wSA==
X-Gm-Message-State: ABuFfoiEDvqFlft3bCAAnNGyHPXUvDoUHYFs3xIYk2RsiazU4UQ7h+Rb
        1Hhdr2r4bA/gCdnAtzO3tcda8w==
X-Google-Smtp-Source: ACcGV62HSFR6NkxnI9xd0Zu8SKiOaJE2mhOz346FyPov/sz6BPJ1H+zH5OSvphZX76jeJCOdJ2Ckqg==
X-Received: by 2002:a63:3285:: with SMTP id y127-v6mr5940351pgy.104.1539355391686;
        Fri, 12 Oct 2018 07:43:11 -0700 (PDT)
Received: from ?IPv6:2600:1010:b023:6e7d:49f6:3296:7822:7f09? ([2600:1010:b023:6e7d:49f6:3296:7822:7f09])
        by smtp.gmail.com with ESMTPSA id z25-v6sm3015392pfl.58.2018.10.12.07.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:43:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181012152515.1d816906@alans-desktop>
Date:   Fri, 12 Oct 2018 07:43:09 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <77F59E25-5244-4CBC-A3CB-DCF863803CD2@amacapital.net>
References: <20181011185458.10186-1-kristen@linux.intel.com> <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com> <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com> <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com> <20181012152515.1d816906@alans-desktop>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Oct 12, 2018, at 7:25 AM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:

>> But this really needs to be clarified.  Alan said that a bunch of the
>> "yet another Spectre variant" attacks would have been mitigated by
>> this patch.  An explanation of *how* would be in order.
>=20
> Today you have the situation where something creates a speculative
> disclosure gadget. So we run around and we try and guess where to fix
> them all with lfence. If you miss one then it leaves a trace in the L1D
> cache, which is what you measure.
>=20
> In almost every case we have looked at when you leave a footprint in the
> L1D you resolve to an error path so the syscall errors.
>=20
> In other words every time we fail to find a
>=20
>                if (foo < limit) {
>                        gadget(array[foo]);
>        } else
>            return -EINVAL;
>=20
> we turn that from being an easy to use gadget into something really
> tricky because by the time the code flow has gotten back to the caller
> the breadcrumbs have been eaten by the L1D flush.

My understanding is that the standard =E2=80=9Cbreadcrumb=E2=80=9D is that a=
 cache line is fetched into L1D, and that the cacheline in question will go i=
nto L1D even if it was previously not cached at all. So flushing L1D will ca=
use the timing from a probe to be different, but the breadcrumb is still the=
re, and the attack will still work.

Am I wrong?

>=20
>=20
> At best you have a microscopic window to attack it on the SMT pair.

So only the extra clever attackers will pull it off. This isn=E2=80=99t all t=
hat reassuring.

If I had the time to try to break this, I would set it up so that the cache l=
ines that get probed are cached remotely, and I=E2=80=99d spin, waiting unti=
l one of them gets stolen. The spin loop would be much faster this way.

Or I would get a fancy new CPU and use UMONITOR and, unless UMONITOR is much=
 cleverer than I suspect it is, the gig is up.  The time window for the atta=
ck could be as small as you want, and UMONITOR will catch it.

(Have I mentioned that I think that Intel needs to remove UMONITOR, PCOMMIT-=
style?  That instruction is simply the wrong solution to whatever problem it=
=E2=80=99s trying to solve.)

>=20
> Alan
