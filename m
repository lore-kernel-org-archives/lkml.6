Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A54C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918DF21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ge6DD5TB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918DF21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbeIUJKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:10:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45830 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:10:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so566984pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 20:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sPXEnSMsJF0hE/7Deb/Um3IRE2hU9wTxaBBmexcE3lo=;
        b=ge6DD5TBbkTwq4rjJsjmIONrD+6B8yvutKeuZvLsLAb9zUzL4YusTNLlGgYYZibRHK
         Fo/Qzp/CuaDW/vzkH7hT7rIGa5nyYDps+IjGgjebmlQkYHYaw9ZJuVEe4KBL0avJcqwF
         akabVsKbuUkDNw6WPvorGutdBc9LO58xcUHwyfV83vEE/cUvDd1UovT6QIxNYBpVORgg
         FVehpPWPSKThGsmw4O5zWJIHp4aNO+GdTinHpNxuJ6MvtsUqLf9Zk/Hx0FUcP/DBkwsf
         8NOYu7YEbH9jpFTskuMohOJCQKWdXALvafq1xua9Kj3iqRVfHIOhVW3wIUxv7Q0m1vZc
         CWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sPXEnSMsJF0hE/7Deb/Um3IRE2hU9wTxaBBmexcE3lo=;
        b=LJee/Ogg1n/lW0q6ztjizaCZsmU+fcaE1orEwmkYavIi+tsZscBEBn29JxBGvj11nc
         5wFpMlhZXf9A0OjABdG4D6W4/ZUEIicxWgOhqbVb8eixM2po8mdKi5YhI89CUjJvPy4Q
         0JylQrW5FLSqsqQ+En2ufXpjPA45wfbomg5egtIQcPANN7dsL7UwX6fKdn5lHxMZJMu9
         ABaNpD9ZjRsWNJJ04baLHI8mc3by2umFNrq7h/cDqgj+VqfAg96e6pO9k71rDxuNMDCa
         wbGH/zyWcMtNeAhHtdeEaZWu/haE3/DBoc2R/++r6phXlJvcSkpIR1pIpIDq4KZ1CVs+
         2XFQ==
X-Gm-Message-State: APzg51DE2t+Ehq+Bt01e8vkbb+x4oyi6F8jObZOSrYouh0V2h9ZQzCjt
        yblJMy4IYBf+7D55jhO7rV+Cqg==
X-Google-Smtp-Source: ANB0VdbGtM7dfJUqWAU9vQ4lO7kuZZye+BfYysrFX8pIPWmAZ+jGIjirL+PIynUAYQaql/nOZsPrdw==
X-Received: by 2002:a63:3089:: with SMTP id w131-v6mr38634658pgw.79.1537500226634;
        Thu, 20 Sep 2018 20:23:46 -0700 (PDT)
Received: from ?IPv6:2600:1010:b04c:ca1a:74fd:3271:641b:80d8? ([2600:1010:b04c:ca1a:74fd:3271:641b:80d8])
        by smtp.gmail.com with ESMTPSA id k64-v6sm7837099pge.85.2018.09.20.20.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 20:23:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180921031255.GB11109@lunn.ch>
Date:   Thu, 20 Sep 2018 20:23:43 -0700
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FA361E3-FBCB-469E-88DC-F4085BD91175@amacapital.net>
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com> <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com> <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com> <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com> <20180921031255.GB11109@lunn.ch>
To:     Andrew Lunn <andrew@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 20, 2018, at 8:12 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
>> On Fri, Sep 21, 2018 at 02:11:43AM +0200, Jason A. Donenfeld wrote:
>> Hey Arnd,
>>=20
>>> On Thu, Sep 20, 2018 at 6:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>> Right, if you hit a stack requirement like this, it's usually the compil=
er
>>> doing something bad, not just using too much stack but also generating
>>> rather slow object code in the process. It's better to fix the bug by
>>> optimizing the code to not spill registers to the stack.
>>>=20
>>> In the long run, I'd like to reduce the stack frame size further, so
>>> best assume that anything over 1024 bytes (on 32-bit) or 1280 bytes
>>> (on 64-bit) is a bug in the code, and stay below that.
>>>=20
>>> For prototyping, you can just mark the broken functions individually
>>> by setting the warning limit for a specific function that is known to
>>> be misoptimized by the compiler (with a comment about which compiler
>>> and architectures are affected), but not override the limit for the
>>> entire file.
>>=20
>> Thanks for the explanation. Fortunately in my case, the issues were
>> trivially fixable to get it under 1024/1280. (By the way, why does
>> 64-bit have a slightly larger stack frame? To account for 32 pointers
>> taking double the space or something?) That will be rectified in v6.
>=20
> Hi Jason
>=20
> Do you any stack usage information?
>=20
> A VPN can be at the bottom of some deep stack calls. Swap on NFS over
> the VPN? If you have one frame of 1K, you might be O.K. But if you
> have a few of these, i can see there might be issues of overflowing
> the stack.
>=20
> =20

At the risk on suggesting something awful: on x86_64, since we turn preempti=
on off for simd, it wouldn=E2=80=99t be *completely* insane to do the crypto=
 on the irq stack. It would look like:

kernel_fpu_call(func, arg);

And this helper would disable preemption, enable FPU, switch to the irq stac=
k, call func(arg), disable FPU, enable preemption, and return. And we can ha=
ve large IRQ stacks.

I refuse to touch this with a ten-foot pole until the lazy FPU restore patch=
es land.

All that being said, why are these frames so large?  It sounds like somethin=
g may be spilling that ought not to.=
