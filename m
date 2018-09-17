Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E164B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="O4UGoLjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E164B2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeIQUTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:19:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33096 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbeIQUTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:19:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so7800068pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zVO0ChGdPzl3gJQigOdGLQOx7051Qh59m/s8Em3/q88=;
        b=O4UGoLjLzbYady2lVqaPJm/gZ8XirVADVWw4q66sr3oTCNoXYx/DNK2SnxlOwBEMkm
         RgUWmGNOupBzDK9NCLuFTIjnvRtwxaZeRJk2gAMVpB6ycDvkassglc0IdA8y7nH4qQAX
         lKmGm9tCrQ3UR/+JDqS7AaSgvXNigBFdESAwaKsJj6rnCUCizoGBPqaiXSS/KFA6sOsr
         h/nBAv8lCB8TOb0L95dBVIUQNRpgJaS9aopRdcJHAZx57kWs9Nu0eJq1w4tmIxPxO/Od
         ML1hz6xL/a9rYdMzJREuZQw8flHUhj4zzD7HIzE85TSWi3QsOGtlM4D46owqb+cYdqtD
         VBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zVO0ChGdPzl3gJQigOdGLQOx7051Qh59m/s8Em3/q88=;
        b=nSvZOHjnES55O027aSi3h+y3c9zTd6afh/FP672hg4Va5/W84a4ikyR3DIdexQsw/s
         pmIqOkkMRXxAyn1kpzli7OlbhQV74DYS3HDkeeWXZOKh58aWhxBWA7jpWw3AL8C+8Ro0
         Npymk/EZ5SrMqI72tTGI9EjuvX7yGly/eiBEXUauvBev26sBx6R5GPoNHRQRM3XqemMV
         G1iFp5id5MmGiUmwx1E7mYPtFBFTq9JgoAEy/VMfmCfe0MbCHkGYelX/KU97QXzadIt8
         k2FhWVEvx4zT5oGfgUPSxZ0+0MDtvYEQs7GtmvbVHsO3ehNLrcZPK+kzApLfCO68MqSn
         cbGA==
X-Gm-Message-State: APzg51Dszfm0eXKj0vIn+U2ri2lFn4QZxA++km2x7yL0Cnwk6tiVE96q
        in2uWDNp+5ZQ4FmSAk9rsk6BIg==
X-Google-Smtp-Source: ANB0VdZBX+8QrjJMeDd+EYdEDEWLIad4VyzoR4Lni9KkIYEjX+mUPB1oqgKPCV3hS2XI7AmYimNULg==
X-Received: by 2002:a63:d645:: with SMTP id d5-v6mr23905035pgj.450.1537195916593;
        Mon, 17 Sep 2018 07:51:56 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:d8c5:6393:c455:3e7? ([2601:646:c200:7429:d8c5:6393:c455:3e7])
        by smtp.gmail.com with ESMTPSA id b203-v6sm23084768pfb.174.2018.09.17.07.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 07:51:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
Date:   Mon, 17 Sep 2018 07:51:54 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net>
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com> <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net> <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com> <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 16, 2018, at 10:26 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org> w=
rote:

>=20
> As far as I can tell (i.e., as a user not a network dev), WireGuard is
> an excellent piece of code, and I would like to see it merged. I also
> think there is little disagreement about the quality of the proposed
> algorithm implementations and the usefulness of having a set of easy
> to use solid crypto primitives in addition to or complementing the
> current crypto API.
>=20
> I do have some concerns over how the code is organized though:
>=20
> * simd_relax() is currently not called by the crypto routines
> themselves. This means that the worst case scheduling latency is
> unbounded, which is unacceptable for the -rt kernel. The worst case
> scheduling latency should never be proportional to the input size.
> (Apologies for not spotting that earlier)
>=20
> * Using a cute name for the crypto library [that will end up being the
> preferred choice for casual use only] may confuse people, given that
> we have lots of code in crypto/ already. I'd much prefer using, e.g.,
> crypto/lib and crypto/api (regardless of where the arch specific
> pieces live)
>=20
> * I'd prefer the arch specific pieces to live under arch, but I can
> live with keeping them in a single place, as long as the arch
> maintainers have some kind of jurisdiction over them. I also think
> there should be some overlap between the maintainership
> responsibilities of the two generic pieces (api and lib).
>=20
> * (Nit) The GCC command line -include'd .h files contain variable and
> function definitions so they are actually .c files.

Hmm. I would suggest just getting rid of the -include magic entirely.  The r=
esulting ifdef will be more comprehensible.


> * The current organization of the code puts all available (for the
> arch) versions of all routines into a single module, which can only be
> built in once we update random.c to use Zinc's chacha20 routines. This
> bloats the core kernel (which is a huge deal for embedded systems that
> have very strict boot requirements). It also makes it impossible to
> simply blacklist a module if you, for instance, prefer to use the
> [potentially more power efficient] scalar code over the SIMD code when
> using a distro kernel.

I think the module organization needs to change. It needs to be possible to h=
ave chacha20 built in but AES or whatever as a module.

>=20
> [To summarize the 4 points above, I'd much rather see a more
> conventional organization where different parts are provided by
> different modules. I don't think the argument that inlining is needed
> for performance is actually valid, given that we have branch
> predictors and static keys, and the arch SIMD code is built as
> separate object files anyway]

I might have agreed before Spectre :(. Unfortunately, unless we do some magi=
c, I think the code would look something like:

if (static_branch_likely(have_simd)) arch_chacha20();

...where arch_chacha20 is a *pointer*. And that will generate a retpoline an=
d run very, very slowly.  (I just rewrote some of the x86 entry code to elim=
inate one retpoline. I got a 5% speedup on some tests according to the kbuil=
d bot.)

So, if we really wanted modules, we=E2=80=99d need a new dynamic patching me=
chanism.

I would suggest instead adding two boot (or debugfs) options:

simd=3Doff: disables simd_get using a static branch.

crypto_chacha20_nosimd: Does what it sounds like.
