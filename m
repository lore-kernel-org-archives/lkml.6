Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D54C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E846C2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="AH8aHR0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E846C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeK3AnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:43:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37664 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeK3AnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:43:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so1056379plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 05:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HSFFE4InofskcPnoYlMIpt76PX9UGREOZkKdoLtdHuo=;
        b=AH8aHR0jpxYb5A7HENw7GHAofIvCf09v1jIZxVYaPigq2HRNAIh5otVC7EgJTmSBd8
         vWLi4yS8+yREKYt/yB8SyQ7G0jBdNGD54BZcIwh9foQKoGPWYJNAY+Pk31y2lMlMSt3o
         ODLKyQIMAjDaloehVpuGOK7ol+DOGIEEFYk6tR7ISOfoWz89rjvz5ixId/GmIMXRtdtX
         rne5PkdInltzzp5+EbSuP0euxbiR5zfoF9aDo11eoHkyeR63KU473+Qjjl3C2GVsGfi/
         sU5Qq6GkZIHl4UwGvY6jexeN6Kd9aQmKdWBdCHOJKC3np0I2cQhnDGkZEo1iBJsgUWhU
         Gygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HSFFE4InofskcPnoYlMIpt76PX9UGREOZkKdoLtdHuo=;
        b=YU+6YhriQ9Ol/ktok+pane7dlD0e2o8kUQXaDxPa77sBjZ9v8K15gg0rqBTJuAfEq1
         1WtqthAMQ7D/V6dfp6Z5SJX/poBb00QUGC1oo8IAQdajg0EoPrexBbhfQVuoCxJe3tJw
         6V+Xj9tp1DJWFtJ6LAmg2OR+DqpVPFJuxX8cU7HTjiie/1mObgV75TMvuy+/2UAbPQGo
         1IK8dK4orzTHNzupdowpMKMITDeQrFiQPANExUWTZEpKLcrKLPPP01VpYQyWhkoA98ZA
         8jFaHB9Ba8ErLSjDOp9YW90aA08/p3yGVioU5lRO4C9w+4Lhe8GKAkMuKVdWPgJO3JvR
         CySQ==
X-Gm-Message-State: AA+aEWb3J7B0XmcXQzUXEqvHvonwOPuVDcKBqGdxfbpSZcVUDoFZXh8P
        ENdnjmyhwjYa1MU2WKBiDMdjQw==
X-Google-Smtp-Source: AFSGD/VBsCpUJnV5aeETAGSWMNC3zgISW6Q6ZMLVrzQeSyB2FU+Y29gh7qngpvJEKfZnCnoK2JWPDg==
X-Received: by 2002:a17:902:f44:: with SMTP id 62mr1547386ply.38.1543498662404;
        Thu, 29 Nov 2018 05:37:42 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:8014:9f93:fece:fe5e? ([2601:646:c200:7429:8014:9f93:fece:fe5e])
        by smtp.gmail.com with ESMTPSA id g65sm12664459pfa.63.2018.11.29.05.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 05:37:40 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call implementation for x86-64
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181129094210.GC2131@hirez.programming.kicks-ass.net>
Date:   Thu, 29 Nov 2018 05:37:39 -0800
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
References: <cover.1543200841.git.jpoimboe@redhat.com> <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com> <20181126160217.GR2113@hirez.programming.kicks-ass.net> <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble> <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble> <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com> <20181129094210.GC2131@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2018, at 1:42 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Nov 28, 2018 at 10:05:54PM -0800, Andy Lutomirski wrote:
>=20
>>>> +static void static_call_bp_handler(struct pt_regs *regs, void *_data)
>>>> +{
>>>> +    struct static_call_bp_data *data =3D _data;
>>>> +
>>>> +    /*
>>>> +     * For inline static calls, push the return address on the stack s=
o the
>>>> +     * "called" function will return to the location immediately after=
 the
>>>> +     * call site.
>>>> +     *
>>>> +     * NOTE: This code will need to be revisited when kernel CET gets
>>>> +     *       implemented.
>>>> +     */
>>>> +    if (data->ret) {
>>>> +        regs->sp -=3D sizeof(long);
>>>> +        *(unsigned long *)regs->sp =3D data->ret;
>>>> +    }
>>=20
>> You can=E2=80=99t do this.  Depending on the alignment of the old RSP, wh=
ich
>> is not guaranteed, this overwrites regs->cs.  IRET goes boom.
>=20
> I don't get it; can you spell that out?
>=20
> The way I understand it is that we're at a location where a "E8 - Near
> CALL" instruction should be, and thus RSP should be the regular kernel
> stack, and the above simply does "PUSH ret", which is what that CALL
> would've done too.
>=20

int3 isn=E2=80=99t IST anymore, so the int3 instruction conditionally subtra=
cts 8 from RSP and then pushes SS, etc. So my email was obviously wrong wrt =E2=
=80=9Ccs=E2=80=9D, but you=E2=80=99re still potentially overwriting the int3=
 IRET frame.=
