Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7515C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F7620868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="h1kPkP2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F7620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbeK3Erq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:47:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38786 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeK3Erp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:47:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so1245362pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Ns8En5M+58PyNdAEuIJfvnQ7RbVlGuieXRyTmWOxoQ=;
        b=h1kPkP2HTwABaj4CZSCXI6hxIws0Aua2vRImuMoyEpwGMXGJBbTkkO2mtf0y/DpSEL
         SebZLtK3nl8mtpjJj0fBJwuoIoqyvAqtKn3ngU/AoJEOmZDwkk6TpBnDp/2F27KaHjFG
         jRwmcTiQ3JxDDWlkNqSq+UOBqDW1x3NacVrsvPH0cjuhw6tFJJ1VmEyWqj3gK46dD1yW
         6cRqeAVuFF6m6PTFMSZtIevjAhjTostUuwHHlCdECXExAXOxV/Ji+XynnGQG5L+wL/qY
         /jydLES5SkEhK+7yhVxqmICNGLQm+N4hmeAkXWPg7n9zD44/d/pSQ8Uhv7gsAR7LhO6l
         8SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Ns8En5M+58PyNdAEuIJfvnQ7RbVlGuieXRyTmWOxoQ=;
        b=bT567bJ6uQl/Qc77YbiDgfgHNfgc70jUU10GYUv6i66/MXfg1kpIJywGpfKyHcklkX
         XdCewrPel5PxEtJoO1iWV3yxKmHzlgVwvZky9gH5rKn6C7kFQM6HuIASHirio4pB6GsG
         hPpE/fQXMIWH+mxFkyoMoXtZYDxLiuaQbMT5ZAj9qLuITaH/BnzfnGKRNVUK0D7XHj1J
         N4i98qSZlyRlGqueNZsn/KJ1QCfyCwrZAQKd/Od+OEX6g6yO8FZVdbX5IEbWJRw7P9n0
         8bucH/dS/DVuY+z4WL4gVCN3idnPtAAthaBffmiRxsRPHmlCTLSPE3/TnN9lBcI6u8Vc
         71lA==
X-Gm-Message-State: AA+aEWaMVc+9m3uwCC+yWt+/YSzIrvGFDzBkFnn4xwQWM/ecqKRV89OX
        s6gg6rE9YzorH42QAESz1zMgXQ==
X-Google-Smtp-Source: AFSGD/VYoGlezxw3NtyFhGVRskLy2FZM4ct3tqmDueWhNJMG6oDDVImBiq0yI3mKofqhFtYZ0lPN0A==
X-Received: by 2002:a62:de06:: with SMTP id h6mr2368307pfg.158.1543513296296;
        Thu, 29 Nov 2018 09:41:36 -0800 (PST)
Received: from ?IPv6:2600:1010:b054:ff26:3849:a65d:14d0:f668? ([2600:1010:b054:ff26:3849:a65d:14d0:f668])
        by smtp.gmail.com with ESMTPSA id d11sm2771801pgi.25.2018.11.29.09.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:41:35 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call implementation for x86-64
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181129122156.782e739e@gandalf.local.home>
Date:   Thu, 29 Nov 2018 09:41:33 -0800
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <666E3CE2-CD96-4271-8F9C-614F96D24F26@amacapital.net>
References: <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble> <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com> <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net> <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble> <20181129164914.GA9027@hirez.programming.kicks-ass.net> <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net> <20181129171539.GD9027@hirez.programming.kicks-ass.net> <20181129122000.7fb4fb04@gandalf.local.home> <20181129122156.782e739e@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 29, 2018, at 9:21 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Thu, 29 Nov 2018 12:20:00 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>=20
>> r8 =3D return address
>> r9 =3D function to call
>>=20
>=20
> Bad example, r8 and r9 are args, but r10 and r11 are available.
>=20
> -- Steve
>=20
>>    push r8
>>    jmp *r9
>>=20
>> Then have the regs->ip point to that trampoline.

Cute. That=E2=80=99ll need ORC annotations and some kind of retpoline to rep=
lace the indirect jump, though.

>>=20
>> -- Steve
>=20
