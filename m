Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6874C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7381A20684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HwjKRRkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfBYQ3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:29:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36306 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBYQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:29:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so4739476pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 08:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yuLSXS0q32QG2oFI7goBmlRqUD/wlrn62SrDBmA0m04=;
        b=HwjKRRkOv3YiyId3cJvh60Q3FGC73WmX74RVGRMDHyANhHGZ426aewz2zvT4gGZuge
         KCEcDIZrXc7n6W0lonLCqZbhCea2xGavYJogVAGrN0dVjcaoiwqv8AAKQ+eXyMSCO1mV
         +vR8b4Wji7ilX6Dl69ZaGUD0b2fVu5hz7aqtWung7byZggy/SYsUD4Lly2NJbjTIRsly
         l0vtMoinc74eOr2f3SK4RUu3T8r/wdn5IGoT2WN5UAPgcrFk9Ga8elsLwxRVuoLWmpQi
         /YqRmTCW2atrb3PJ8YhaD6cobSnz0cuwJSPNfjeyUfhj5QT09NwPMBTnrz4m3mqbTxFd
         vNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yuLSXS0q32QG2oFI7goBmlRqUD/wlrn62SrDBmA0m04=;
        b=JSwNmqqw7z7QMyH4RwwlHHMdqxe/jhBtl+dGXvl3F1dzvMEamH8Q9CjwfB3OnyijxE
         GgtDYy8kZnIWYr4KuakryFaSUl1d6muYzIKjepGlF0hlcHodfEIXDYRXz2vdXhyPtskm
         V6vx1r6LpZRH7J3I4xZ0Yod5AdGu26cQc7ZPCftD1318VvH3yeu96VkxQ2zL4Jw3RwVt
         AHht27gTc75AmdbilfpEegeysYTd5XDwWlL9WTJr/+PS+kUe6XhZRvp1mBgOY6eHOryO
         phcQdwYTQxcy4bZxLr5JCF0Xd2DSlFZ42X3Jbfufx/hgd7JA6zIPkBuG8pFel/E+cips
         DjoA==
X-Gm-Message-State: AHQUAuaObehTjqRGPzFzn6CW1IudgHyCe/P2NmJ81IIwa323nX1cpCr2
        2xa1k805YVR2dE3EJa0S3AaiEQ==
X-Google-Smtp-Source: AHgI3IYW07QORwHTBGYGyRzEEPUgSqGgDSwMHNIes/PDZdk4Q4c3Zm2QFGVTrptkfZ1b03DWE+52mg==
X-Received: by 2002:a63:d54f:: with SMTP id v15mr19799190pgi.318.1551112153932;
        Mon, 25 Feb 2019 08:29:13 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:b15f:5c41:cd64:8b39? ([2601:646:c200:7429:b15f:5c41:cd64:8b39])
        by smtp.gmail.com with ESMTPSA id r3sm22887181pgn.48.2019.02.25.08.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 08:29:13 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/6] x86/ia32: Fix ia32_restore_sigcontext AC leak
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190225161003.GL32477@hirez.programming.kicks-ass.net>
Date:   Mon, 25 Feb 2019 08:29:12 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F83AE74-3F9E-42BB-8F9C-3033F72B3EF5@amacapital.net>
References: <20190225124330.613028745@infradead.org> <20190225125231.936952143@infradead.org> <CALCETrW-p4iF-RMecyNt1JDwKh74c_tw67FCW7Yr_Fd3adtGUw@mail.gmail.com> <20190225161003.GL32477@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Feb 25, 2019, at 8:10 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Mon, Feb 25, 2019 at 07:41:50AM -0800, Andy Lutomirski wrote:
>> This is so tangled.
>>=20
>> How about changing RELOAD_SEG to replace unsigned int pre =3D
>> GET_SEG(seg); with unsigned int pre =3D (seg); to make it less magic.
>> Then do:
>>=20
>> unsigned int gs =3D GET_SEG(gs);
>>=20
>> ...
>>=20
>> RELOAD_SEG(gs);
>>=20
>> And now the code actually does what it looks like it does.
>=20
> Is this what you mean?

Yes, except:

>=20
> ---
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 321fe5f5d0e9..e04eeeddcc35 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -53,17 +53,16 @@
> #define GET_SEG(seg)        ({            \
>    unsigned short tmp;                \
>    get_user_ex(tmp, &sc->seg);            \
> -    tmp;                        \
> +    tmp | 3;                    \
> })
>=20

Drop this part.

> #define COPY_SEG_CPL3(seg)    do {            \
> -    regs->seg =3D GET_SEG(seg) | 3;            \
> +    regs->seg =3D GET_SEG(seg);            \
> } while (0)

And this.

Unfortunately, whether we want the | 3 varies by segment. For FS and GS, we d=
efinitely don=E2=80=99t want it, since 0 is a common and important value, an=
d 3 is a deeply screwed up value.  (3 is legal to *write* to GS, and it stic=
ks, but IRET silently changes it to 0, because the original 386 designers (I=
 assume) confused themselves.

>=20
> #define RELOAD_SEG(seg)        {        \
> -    unsigned int pre =3D GET_SEG(seg);    \
> +    unsigned int pre =3D (seg);        \
>    unsigned int cur =3D get_user_seg(seg);    \
> -    pre |=3D 3;                \
>    if (pre !=3D cur)                \
>        set_user_seg(seg, pre);        \
> }
> @@ -72,6 +71,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,=

>                   struct sigcontext_32 __user *sc)
> {
>    unsigned int tmpflags, err =3D 0;
> +    u16 gs, fs, es, ds;
>    void __user *buf;
>    u32 tmp;
>=20
> @@ -79,16 +79,10 @@ static int ia32_restore_sigcontext(struct pt_regs *reg=
s,
>    current->restart_block.fn =3D do_no_restart_syscall;
>=20
>    get_user_try {
> -        /*
> -         * Reload fs and gs if they have changed in the signal
> -         * handler.  This does not handle long fs/gs base changes in
> -         * the handler, but does not clobber them at least in the
> -         * normal case.
> -         */
> -        RELOAD_SEG(gs);
> -        RELOAD_SEG(fs);
> -        RELOAD_SEG(ds);
> -        RELOAD_SEG(es);
> +        gs =3D GET_SEG(gs);
> +        fs =3D GET_SEG(fs);
> +        ds =3D GET_SEG(ds);
> +        es =3D GET_SEG(es);
>=20
>        COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
>        COPY(dx); COPY(cx); COPY(ip); COPY(ax);
> @@ -106,6 +100,17 @@ static int ia32_restore_sigcontext(struct pt_regs *re=
gs,
>        buf =3D compat_ptr(tmp);
>    } get_user_catch(err);
>=20
> +    /*
> +     * Reload fs and gs if they have changed in the signal
> +     * handler.  This does not handle long fs/gs base changes in
> +     * the handler, but does not clobber them at least in the
> +     * normal case.
> +     */
> +    RELOAD_SEG(gs);
> +    RELOAD_SEG(fs);
> +    RELOAD_SEG(ds);
> +    RELOAD_SEG(es);
> +
>    err |=3D fpu__restore_sig(buf, 1);
>=20
>    force_iret();

I=
