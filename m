Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B167FC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F447213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wY2dZyAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F447213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeK3FHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:07:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46549 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeK3FHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:07:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so1397927ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5mKf2Q04oVfYHYFYMyN5JHkOgZmjDhCPWYQJGQDFG34=;
        b=wY2dZyAafyXh0fKCgYTRsAdBimTcaqaVXLxmgRe/2a0rFSYPG+ksUkoKjpWJTfBfPs
         +F1XQ3NO6UJ7Qwm/hqEigcOcGPKAB42fAQGMVzNTMvRjFwfFhzUO7kcHqj/weTWlOiIu
         wWodTHQG2TQg08dQrE1AobEz0gyuDB/C5/n72RpvsXSKpGM1zbuJv1a2v3DICGMLblaS
         owvQwfUpBNXXtudcwgi6AZDZkFKeJFBHMZnM+vi1TeyzS9wG2Ts4vjMcDQOuxK9gUrTI
         /FrXJa3WiAKAcIVPeYy6rIxFX6QpxmMVe7L2i1fHoDZtTZhUEVaZGLO1phhHMBwM1Rh8
         6o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5mKf2Q04oVfYHYFYMyN5JHkOgZmjDhCPWYQJGQDFG34=;
        b=uYxy6qI/NZiNl0Vu20ywITym1CUmRbEzPvlNfdj788YmJBluOqii9w0h31FobWU/mw
         7jr5W2tn5k9I+igmUce/AMni9hXBZdY30dGeJA32aEcAxw25SXEoetO4VFURluySF44Y
         nRoq/tiZadbHSrGrdHtnOULXOild32oCWNQnpj7Y12ZT9Zu4nC4eaZ+UixGjCk/HSxxS
         hz1UyU6lXj8iGYllXRbRIDyvQjkrTvPnz00XHVffjYDrOV3jCgCpXNp19xgrSCRrxt56
         UTMLocvi2IEQPVqXiQTuFa1mdGAtbhKm1H4fP2o6P3sqkQBntSl2cstxp6mXvbXFgWsC
         9doQ==
X-Gm-Message-State: AA+aEWbQpSjFHPwkoqppnCly3HwoH0qOvc78GsgsuGsSPEo8de3rWWpC
        KVSAUl9UAhN6ahC539kL9cF6jg==
X-Google-Smtp-Source: AFSGD/U9xNUuaMuMiopfgrxRL/XVwbeSiPT+7wAVS7NL0+CV0qiwOauNCAd7IokXH4P09mL9e8BI9w==
X-Received: by 2002:a17:902:76ca:: with SMTP id j10mr2368741plt.144.1543514451143;
        Thu, 29 Nov 2018 10:00:51 -0800 (PST)
Received: from ?IPv6:2600:1010:b054:ff26:3849:a65d:14d0:f668? ([2600:1010:b054:ff26:3849:a65d:14d0:f668])
        by smtp.gmail.com with ESMTPSA id z186sm5097064pfz.119.2018.11.29.10.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 10:00:49 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call implementation for x86-64
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
Date:   Thu, 29 Nov 2018 10:00:48 -0800
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <60A06EF9-C301-4705-A32C-5E77E2D9DA9C@amacapital.net>
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net> <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble> <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble> <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com> <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net> <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble> <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com> <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home> <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com> <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 29, 2018, at 9:50 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Thu, Nov 29, 2018 at 9:44 AM Steven Rostedt <rostedt@goodmis.org> wrot=
e:
>>=20
>> Well, the current method (as Jiri mentioned) did get the OK from at
>> least Intel (and that was with a lot of arm twisting to do so).
>=20
> Guys, when the comparison is to:
>=20
> - create a huge honking security hole by screwing up the stack frame
>=20
> or
>=20
> - corrupt random registers because we "know" they aren't in use

For C calls, we do indeed know that.  But I guess there could be asm calls.

>=20
> then it really sounds pretty safe to just say "ok, just make it
> aligned and update the instruction with an atomic cmpxchg or
> something".

And how do we do that?  With a gcc plugin and some asm magic?

>=20
> Of course, another option is to just say "we don't do the inline case,
> then", and only ever do a call to a stub that does a "jmp"
> instruction.

That=E2=80=99s not a terrible idea.

>=20
> Problem solved, at the cost of some I$. Emulating a "jmp" is trivial,
> in ways emulating a "call" is not.
>=20
>=20


