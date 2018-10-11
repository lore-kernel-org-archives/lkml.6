Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06A3C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4335B2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="CwSj5mWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4335B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeJKXsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:48:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39899 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeJKXsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:48:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so4468874plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8YgZF3nM28BReU0c6f/QqyOk3H86PJZeln6QJBbxNb8=;
        b=CwSj5mWpYyNwiuEbE1zI/ExFWQ1Efndx1501FyHYDObLBk3iyUjCjR+/IsGoGP2AmN
         F6m4DSyWebus2xyUuUl9fmPQUhKuNegBMobq4n4VIm6YonPeEbKwm8N1758Vy2dSBaYV
         zEZeR4brGUyzYR3ktAs7HoPKlJ4rH2tHi4Ne+xuq4LctVew+oeuLoCzHzeHyBbaminaJ
         FjSY2LgEWzEe595ImfnPkPU1nQI7L0+LsA0lfA2tKQjDx4T0wdJBwaA4n+KWvZO2Tofq
         hn3kLofCD1dILJPKj08gVlpCbY1SQvNbCsUWnBZVCDJVBIlDtsN7rO6lf9L0isDZccxL
         /olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8YgZF3nM28BReU0c6f/QqyOk3H86PJZeln6QJBbxNb8=;
        b=LE2zFcc01H5hBBZCEFwcdQHgXv3AmGhO6xQMEa7q7EW7jl4Lfi3u/gcZSwrTh/AF2t
         dFYi5ROGvkhsWphEvyr4A+rwilL23L6l8dfpnon544zxWBUjFfan8mltuYnjahPDx8Ic
         I7ECKtl2Ma8qPniQMMAxQh549IWuo2CTBCRQOq1qxheqNrhAENn0MY4rKZNw39A09ZXG
         zYBFCMYdD3Vu/zgU5vx7cBj4ol0fkrn4gr+mIj/qot7NZPBcRGHXemwUF405hmCZXFJq
         k4zaYbu8y7PyaqVIzkvatlC9G3gWYvm1FrGu9ZBwpxIMsOR5wRN9GY+JcTJxQtRk5yyT
         EqTA==
X-Gm-Message-State: ABuFfohD/e94QycdDQlOyVNVVJK0YKItt2rPNhwYQQlXicElgASgvWuN
        rQ6FYrsOdsdE8ilSvNn7+VVhRA==
X-Google-Smtp-Source: ACcGV61DA6VQkxayGhtLpAod1QK/Gh2Lp5EldIi/EFRpZ6qvQVy02E/sVE5NEN6vF948ZKq8CM9ORw==
X-Received: by 2002:a17:902:124:: with SMTP id 33-v6mr2223430plb.205.1539274842280;
        Thu, 11 Oct 2018 09:20:42 -0700 (PDT)
Received: from [192.168.0.178] (c-71-202-137-17.hsd1.ca.comcast.net. [71.202.137.17])
        by smtp.gmail.com with ESMTPSA id o85-v6sm59037184pfk.94.2018.10.11.09.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 09:20:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181011125258.ihsdmonepaoc5xtb@treble>
Date:   Thu, 11 Oct 2018 09:20:40 -0700
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7EBEF5D-443E-4764-8589-DE470F93422D@amacapital.net>
References: <20181008155757.GC5663@hirez.programming.kicks-ass.net> <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net> <20181009021710.qwt5hpntyeps44h3@treble> <20181008235750.59da83ae@gandalf.local.home> <20181010175237.e7m3sldcu2maoqcq@treble> <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com> <20181010181605.arsyjxwdztztrjih@treble> <20181010181741.lc4l7kjvcmoxrw5b@treble> <CALCETrUZMmTDOh5-Mzyj1rk7Q82DgdQLinOfbzF4Sb7OC2aYMQ@mail.gmail.com> <20181011030738.wwy6grnss67txd2l@treble> <20181011125258.ihsdmonepaoc5xtb@treble>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 11, 2018, at 5:52 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>=20
>> On Wed, Oct 10, 2018 at 10:07:38PM -0500, Josh Poimboeuf wrote:
>>> On Wed, Oct 10, 2018 at 02:13:22PM -0700, Andy Lutomirski wrote:
>>>> On Wed, Oct 10, 2018 at 11:17 AM Josh Poimboeuf <jpoimboe@redhat.com> w=
rote:
>>>>=20
>>>>> On Wed, Oct 10, 2018 at 01:16:05PM -0500, Josh Poimboeuf wrote:
>>>>> On Wed, Oct 10, 2018 at 11:03:43AM -0700, Andy Lutomirski wrote:
>>>>>>> +#define DECLARE_STATIC_CALL(tramp, func)                           =
    \
>>>>>>> +       extern typeof(func) tramp;                                  =
    \
>>>>>>> +       static void __used __section(.discard.static_call_tramps)   =
    \
>>>>>>> +               *__static_call_tramp_##tramp =3D tramp
>>>>>>> +
>>>>>>=20
>>>>>> Confused.  What's the __static_call_tramp_##tramp variable for?  And
>>>>>> why is a DECLARE_ macro defining a variable?
>>>>>=20
>>>>> This is the magic needed for objtool to find all the call sites.
>>>>>=20
>>>>> The variable itself isn't needed, but the .discard.static_call_tramps
>>>>> entry is.  Objtool reads that section to find out which function call
>>>>> sites are targeted to a static call trampoline.
>>>>=20
>>>> To clarify: objtool reads that section to find out which functions are
>>>> really static call trampolines.  Then it annotates all the instructions=

>>>> which call/jmp to those trampolines.  Those annotations are then read b=
y
>>>> the kernel.
>>>>=20
>>>=20
>>> Ah, right, and objtool runs on a per-object basis so it has no other
>>> way to know what symbols are actually static calls.
>>>=20
>>> There's another way to skin this cat, though:
>>>=20
>>> extern typeof(func) __static_call_trampoline_##tramp;
>>> #define tramp __static_call_trampoline_##tramp
>>>=20
>>> And objtool could recognize it by name.  But, of course, you can't put
>>> a #define in a macro.  But maybe there's a way to hack it up with a
>>> static inline?
>=20
> I went with something similar in the latest version.  It's less
> surprising in a couple of ways:
>=20
> - DECLARE_STATIC_CALL doesn't have the magic objtool definition.
>=20
> - Call sites use the static_call() wrapper, which makes static calls
>  clearly visible.

Seems reasonable. Also, for a real patch, it should be straightforward to ha=
ve a fallback implementation in include/linux/static_call.h that just derefe=
rences the pointer.
