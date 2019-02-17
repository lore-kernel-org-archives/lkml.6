Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B11C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 02:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B9F21A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 02:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0KNvUXDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfBQCg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 21:36:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36580 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfBQCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 21:36:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so6789246pfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 18:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CxnZx9xjxIgLZ1xag5Fp9cF44ziT0g64seYfvpN2DbE=;
        b=0KNvUXDnXnID/X8ZRp/6Z6PdHlcQ4HNePWnzsF5eCKqlK+IrX+gguZuG547VVi3BI+
         FyCqC4DudDs5aUAjW0efGEkl2iMu8Xg0h2/fv5iMg82pVQxloLW6fmLIeUH8EGLMMzGq
         9Zklezlz3QDJab9ZDnZMi5tnA+WMdzO2WVLyDWOArI9ACTBreXeuoT2BM903zikyu39q
         nTsou8i7G1V48w8TqyLTjpfD0r6CqRj6HFtVxwkUZCBpjk/eSrqqhpuPZGkB9xieLy9s
         pJ76OUW0IV/z5eyHk3i7Dsg3P0ZgkVcL1Bk6Hw8uwVk8VWL0aQl3Vjs57rTOt+k0gNcK
         NGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CxnZx9xjxIgLZ1xag5Fp9cF44ziT0g64seYfvpN2DbE=;
        b=WgHKsMrqH9Umm1sJx8ledd0s28SMDnYqOvw5hd2OlE2DUPtjspYqry8Bz9vXdOt4lK
         hJvNn/20T95AUBJxq4H4fHhD12+otqd/XEpK6xONeOeP/sXPj1QaVvmDM3uKk8i1ZtwK
         eJvejFqbca4sA6sGvkun1bo9VaLwnFpw3gVpKv89v72T5d3QB++0RFM/wSiYQGPRvL5U
         OTHnLtZNf5+yzH7Y0aZBPKWZhRmgFhSf0X5JgO3qkJd7C76galOdhQLV5Bog8xOq+YbP
         mqt7vNwBb3OSXjwlQv6V64kflp581HNtgfa49T5RZqA6Zh0Qv49WcPFlXwUWv2FFcoWN
         A3pg==
X-Gm-Message-State: AHQUAuarKvVE2Xg7M/8cvak0oHThe+RUGcCKveRugT7MNckN2a+sZp/8
        0GxMvEyLgY7MzwYARWHGmmS8ow==
X-Google-Smtp-Source: AHgI3IYV7xk0wqKNGout3H8gWPo+gsRwWlyvFrKlU/jp0V52EoaUNxc7hY2I4Tbcg2EQl3nQfwKnAw==
X-Received: by 2002:a63:5518:: with SMTP id j24mr12351626pgb.208.1550371015557;
        Sat, 16 Feb 2019 18:36:55 -0800 (PST)
Received: from ?IPv6:2600:1010:b04d:2030:49e7:7136:e1e6:66fa? ([2600:1010:b04d:2030:49e7:7136:e1e6:66fa])
        by smtp.gmail.com with ESMTPSA id k74sm1951376pfb.172.2019.02.16.18.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 18:36:53 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190216234702.GP2217@ZenIV.linux.org.uk>
Date:   Sat, 16 Feb 2019 18:36:52 -0800
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        baloo@gandi.net, the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FBED20DC-1F47-4038-81CC-8F5119785F8E@amacapital.net>
References: <20190215235901.23541-1-baloo@gandi.net> <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com> <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de> <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net> <20190216234702.GP2217@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 16, 2019, at 3:47 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
>> On Sat, Feb 16, 2019 at 02:50:15PM -0800, Andy Lutomirski wrote:
>>=20
>> What is the actual problem?  We=E2=80=99re not actually demand-faulting t=
his data, are we?  Are we just overrunning the buffer because the from_user h=
elpers are too clever?  Can we fix it for real by having the fancy helpers d=
o *aligned* loads so that they don=E2=80=99t overrun the buffer?  Heck, this=
 might be faster, too.
>=20
> Unaligned _stores_ are not any cheaper, and you'd get one hell of
> extra arithmetics from trying to avoid both.  Check something
> like e.g. memcpy() on alpha, where you really have to keep all
> accesses aligned, both on load and on store side.

I think we should avoid unaligned loads and do unaligned stores instead.

I would general expect that unaligned stores are a bit cheaper since they do=
n=E2=80=99t need to complete for the comparisons to happen.

But I maintain my claim that this code should not be overrunning its input b=
uffer into the next page, since it could have observable side effects.

>=20
> Can't we just pad the buffers a bit?  Making sure that name_buf
> and symlink_buf are _not_ followed by unmapped pages shouldn't
> be hard.  Both are allocated by kmalloc(), so...
>=20
> What am I missing here?
