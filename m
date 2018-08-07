Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD2C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039462159F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="QAQ+GwHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039462159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeHHAox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:44:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37120 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeHHAox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:44:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so107293pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3AYaBXyIGCsJXUfcXqERbFYbtttGmx+ac68jEKqIERQ=;
        b=QAQ+GwHoDm8hXE3s+gMvyk9i1itjTF5IN5XgmImHtvmjF/dm1G63Y6PDZON5MrPdRA
         tgP27FKVD4ktbwAXNxKaQ4MuEK7X+dKBgBafMKB9/A59vlkRC/9cNnIywqpgH+ggfe6i
         Jc7nC/CfgdytN9bArueYGhnyHXU/tcY4Le/HAAsMtJKEIVChw7RHJS2/pye8L4q33Cen
         OQaHzZWCKPFW0Y9zgwDhOhbMG/QKd22erMYLK+qqv0ca5/mxXJsH4tcOcnwsiKCDJ7Rz
         437juLNP/Er4QdiXA59iiDL6yEFC/dokhg+XAVYxtc8UQiLVEZMt3+c6OMudfjaZp3GK
         KtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3AYaBXyIGCsJXUfcXqERbFYbtttGmx+ac68jEKqIERQ=;
        b=fZn+b+zThjQS9axhCDntfRKIQbo6P3ZfzmauoPghdqC7Gra5rAU5TPVbTw4NvCmd2q
         AR8WPhQrSm0RARfevDiznNhezCRNgIbFnnVj4YwXvitNJMNnrU7lZwz3t06x4C8XTJiS
         E9WIUJmSbLXpXuo919DNt1Vxn/InoHAs6ndbBG3Wx1Sdi1EAPu1L8zeiYcL5DYXP8JYJ
         QJZbvWmPPxC9CtBsW5VXaf2GR6xNppLdvK/ZtnecNfSVaWEbdvndehL/VT5NSuTwnQ2s
         Ai7RvNnRVSL0i9K3KS//NsskWXSVtbuAmNMiYFH5rDK2Ssi3PjaH+0599VpJXL6orFro
         y4MA==
X-Gm-Message-State: AOUpUlFctp5xjj9OhORcH+mfr7iGH9HvcH5vZy8YelB0xwJBg/Gltl8N
        tJyXck/6pQ0Ra+pZWF6x621whO8CGvQ=
X-Google-Smtp-Source: AA+uWPyYeZ7/+qjJ1uY3SmumMrNJwiflV6JaW/UwMa7krKr+qPiEaCPF4dGutYa4TGIrVd2jkzrppQ==
X-Received: by 2002:a62:b0c:: with SMTP id t12-v6mr259907pfi.36.1533680900448;
        Tue, 07 Aug 2018 15:28:20 -0700 (PDT)
Received: from ?IPv6:2600:1010:b016:7102:f59d:5c2c:ab3c:d9ca? ([2600:1010:b016:7102:f59d:5c2c:ab3c:d9ca])
        by smtp.gmail.com with ESMTPSA id 1-v6sm6655301pfk.134.2018.08.07.15.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 15:28:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/2] x86: WARN() when uaccess helpers fault on kernel addresses
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAG48ez3nEszuPN9SZ9vV2=ubzv348bMpJjT9b5Q_wx6uxV2zXg@mail.gmail.com>
Date:   Tue, 7 Aug 2018 15:28:17 -0700
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <126BF909-1BB3-45EF-944E-C0AAD239F752@amacapital.net>
References: <20180807012257.20157-1-jannh@google.com> <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net> <CAG48ez3nEszuPN9SZ9vV2=ubzv348bMpJjT9b5Q_wx6uxV2zXg@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Aug 7, 2018, at 2:17 PM, Jann Horn <jannh@google.com> wrote:
>=20
> On Tue, Aug 7, 2018 at 4:55 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
>>> On Aug 6, 2018, at 6:22 PM, Jann Horn <jannh@google.com> wrote:
>>>=20
>>> There have been multiple kernel vulnerabilities that permitted userspace=
 to
>>> pass completely unchecked pointers through to userspace accessors:
>>>=20
>>> - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
>>> access_ok() checks")
>>> - the sg/bsg read/write APIs
>>> - the infiniband read/write APIs
>>>=20
>>> These don't happen all that often, but when they do happen, it is hard t=
o
>>> test for them properly; and it is probably also hard to discover them wi=
th
>>> fuzzing. Even when an unmapped kernel address is supplied to such buggy
>>> code, it just returns -EFAULT instead of doing a proper BUG() or at leas=
t
>>> WARN().
>>>=20
>>> This patch attempts to make such misbehaving code a bit more visible by
>>> WARN()ing in the pagefault handler code when a userspace accessor causes=

>>> #PF on a kernel address and the current context isn't whitelisted.
>>=20
>> I like this a lot, and, in fact, I once wrote a patch to do something sim=
ilar. It was before the fancy extable code, though, so it was a mess.  Here a=
re some thoughts:
>>=20
>> - It should be three patches. One patch to add the _UA annotations, one t=
o improve the info passes to the handlers, and one to change behavior.
>>=20
>> - You should pass the vector, the error code, and the address to the hand=
ler.
>>=20
>> - The uaccess handler should IMO WARN if the vector is anything other tha=
n #PF (which mainly means warning if it=E2=80=99s #GP). I think it should pr=
_emerg() and return false if the vector is #PF and the address is too high.
>=20
> What about #MC? do_machine_check() sometimes invokes fixup handlers.
> It looks like fixup_exception() is basically reached for anything that
> can't be restarted (either MCG_STATUS_RIPV isn't set or the worst
> severity is MCE_AR_SEVERITY), but doesn't reach MCE_PANIC_SEVERITY? In
> particular for "Action required: data load in error recoverable area
> of kernel", if I'm reading the code correctly. It seems like the code
> is intentionally preventing memory errors during user access from
> being treated as kernel memory errors? So perhaps #MC in user access
> should not WARN()?

Agreed.=20

>=20
>> - Arguably most non-uaccess fixups should at least warn for anything othe=
r than #GP and #UD.
