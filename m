Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF7C21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="DF5alnf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF7C21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbeIUKjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:39:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37031 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIUKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:39:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so5405738pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 21:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oIRi/r05WlA2ZKhZzXLapQz26LC9owmURuqsMLwmbE4=;
        b=DF5alnf5zgfwF0kWJVvb3oLhqKCLLqyQY6RseJj1JjRBwus6dPg8FGKNMyKhpZKbo3
         5AkxMmQpYSAYyu8kLwhQ5oqnqr9Qjrxns359bB1NnMSlj1L8eKYCwQnP5mDowxxLCnPt
         nJ8Lea4nlHhPJEV799SCkpo+Qc0ojYvKTbjC7y70c4CSgSO6I7xWi2nzTRQXM6lquKOX
         MJDQNxvCztxxPDxuGCPBI+So1VcKXFJKQJBfbgrdpCrvF6FBTQQiH1O5S955U7tAG/Ey
         cchg0+rFM6ZrU8eI50KQ8qc4xn5WiiBQU+M7hYyDqjn0fK1Bu6FO+yUYxrVEVjenn3Y7
         MlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oIRi/r05WlA2ZKhZzXLapQz26LC9owmURuqsMLwmbE4=;
        b=dho7gnSRe/WQRiOSNWwQuA/maiQeyrRz6B6pJh5N7zw2LERb2NYpPX8bY37itYQfRD
         uArharhn/NvFbc1c4JOUs0ZiYTn20Kc3Jr58ZmiAenK/2sKlc8NUdA14xqYY/+guXPji
         zFPUK0uU6j2e8jMqLhaWyCD4jgC/pHXA7owA4oKTSfnPgvDw5TQye7bEixYO1Y7Y73QU
         YOzqEQBsfVTsbB7iQBADRYnnDKw88N0QpwGPRxatI0AztR4O8Btza1kp2dHViP60yKhj
         OvxeRqMJ49WrKv643RtSyiyLU8lzFKvcDW8+nQUVJ1LY4NbNyp0hkVxtZCK3Q8QSjpck
         adMg==
X-Gm-Message-State: APzg51CjINpC/3RuSn3vvriqaJzHtxvuk3QMgOQG51EBq2K+V5xwYok9
        BEElNNLOeKf+cFmDthkKl+Tt7A==
X-Google-Smtp-Source: ANB0VdaPvpll5R/ePuC97A2zq2Ghq/PAGO0dJ9nhfvyEpkcnoznn5wrQGsZgYWkbhS9fy6k2n3FYnA==
X-Received: by 2002:a63:9f19:: with SMTP id g25-v6mr40690994pge.39.1537505526286;
        Thu, 20 Sep 2018 21:52:06 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:413c:2b8f:d2ea:80b3? ([2601:646:c200:7429:413c:2b8f:d2ea:80b3])
        by smtp.gmail.com with ESMTPSA id z19-v6sm33715385pgi.33.2018.09.20.21.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 21:52:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAKv+Gu-sciHeWVij8hWGF78HV_CLddMv7Xdf1GRSY+6B2yt48A@mail.gmail.com>
Date:   Thu, 20 Sep 2018 21:52:04 -0700
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
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
Message-Id: <AA5D5BE5-79EC-4149-BD54-2C4286CFA291@amacapital.net>
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com> <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com> <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com> <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com> <20180921031255.GB11109@lunn.ch> <8FA361E3-FBCB-469E-88DC-F4085BD91175@amacapital.net> <CAHmME9rF=FfOf-_EOB-BeT-BM=B9Q9YzFAoUimaPiM2RKb5sGA@mail.gmail.com> <CAKv+Gu-sciHeWVij8hWGF78HV_CLddMv7Xdf1GRSY+6B2yt48A@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 20, 2018, at 9:30 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
>> On 20 September 2018 at 21:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote=
:
>> Hi Andy,
>>=20
>>> On Fri, Sep 21, 2018 at 5:23 AM Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>> At the risk on suggesting something awful: on x86_64, since we turn pree=
mption off for simd, it wouldn=E2=80=99t be *completely* insane to do the cr=
ypto on the irq stack. It would look like:
>>>=20
>>> kernel_fpu_call(func, arg);
>>>=20
>>> And this helper would disable preemption, enable FPU, switch to the irq s=
tack, call func(arg), disable FPU, enable preemption, and return. And we can=
 have large IRQ stacks.
>>>=20
>>> I refuse to touch this with a ten-foot pole until the lazy FPU restore p=
atches land.
>>=20
>> Haha. That's fun, and maybe we'll do that at some point, but I have
>> some other reasons too for being on a workqueue now.
>>=20
>=20
> Kernel mode crypto is callable from any context, and SIMD can be used
> in softirq context on arm64 (and on x86, even from hardirq context
> IIRC if the interrupt is taken from userland), in which case we'd
> already be on the irq stack.

The x86_64 irq stack handles nesting already.
