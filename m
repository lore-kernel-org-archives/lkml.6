Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7278520671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqCdzvzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7278520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeI2ECN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:02:13 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43252 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeI2ECM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:02:12 -0400
Received: by mail-yb1-f193.google.com with SMTP id w80-v6so3266827ybe.10;
        Fri, 28 Sep 2018 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jhbdEF+gsaxOdiMIDcR8L/VpF3hXS9g6CTNKCQwg7TU=;
        b=tqCdzvzWLU5QuGGAry+ZBN9rmQ6tPHbEQLDkeWAh8d/FtYKVxkS7ze186KeliN27uH
         C0+Y3jd9fM2SnGH/Poi9pz8rUGhAAHg+4nlS5HTLEWPp31T0hP6IQPAylffsxuIUPCx0
         NgV9lGtTCtCaE42VsgtFk5WOZimty2KLg3wrNux2oxTRggnzJKM7s2bWpDs8pwanr9o+
         nT502iE9rdG3JTwqisXWdiUFaw67CsB+mNJHAX1E+n8N0BFx9Xd5x+9M7mBRO0A30Jle
         3wbBOV3UtTfnGu/bDsVTbd1ptU59namgTD2Rbg1wnAXWfryTcd/Pedb8/STOZTTCVh8G
         wqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jhbdEF+gsaxOdiMIDcR8L/VpF3hXS9g6CTNKCQwg7TU=;
        b=jCGsQT/zmMrbXAKWZYRPRmQr57c4fZCzE4nSeCrLIwKTk45ZFAMNTuf+5izaCkWAET
         cAzKhRD4zKjZlGNrzTKyYL32NY+oe7gsyg7fA3UjmtYOGqN4ZIVhJh1NPz8hda6lAYM4
         yLnzdGa/8F1qDm/yQK00vYZpEEBHacqI5uzDguHaIVIa+TDa8E7/14lwtV54JLFX/82b
         9zyCoNEFKioZGE3Sm+12wsMg4Z3yLRyLtnsyqvpwyOHde1n1zLFbKuRHs6OS2jFuGqHv
         h17Z62S6dhwynyVP/GkKBAb6s3aw2P6XUZaSg6Y4yqDOIbSqhR+5/Pu1w9I01Ycuqqd/
         VSkw==
X-Gm-Message-State: ABuFfoip9mPz+JN8HSc8zqL8jV5jTHPQLB9z4zupLIPUG7Oiug+nnyFC
        sq1TkL6oWpAxU0vP6Xa8LXdUDjRo0klnyzkq1Y5vSg==
X-Google-Smtp-Source: ACcGV62mwCj5AAM+4FggloObo8VyHP/zQcJ4Jfo0Ricmb5UrZQbakRR05IX4RMgJ8o4bKKQPIOH+NzI4kbGu0A1MNBA=
X-Received: by 2002:a25:bcce:: with SMTP id l14-v6mr299513ybm.452.1538170594222;
 Fri, 28 Sep 2018 14:36:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:505:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 14:36:33 -0700 (PDT)
In-Reply-To: <A3EEA386-DC02-432B-8B53-F1ECD035F431@amacapital.net>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
 <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
 <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
 <20180928103726.07761672@mschwideX1> <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de>
 <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1>
 <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com>
 <CAMo8BfJ7t-qPWzGPb6JzqEhPm9JBzvAX0a2paBXeQt-RCeHe_w@mail.gmail.com>
 <alpine.DEB.2.21.1809282224090.1432@nanos.tec.linutronix.de> <A3EEA386-DC02-432B-8B53-F1ECD035F431@amacapital.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 28 Sep 2018 14:36:33 -0700
Message-ID: <CAMo8Bf+mfK72DPehvphfJnvLc=ne-0bn52drOnMawp1oKjYsig@mail.gmail.com>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        fthain@telegraphics.com.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 2:08 PM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
>
>
>> On Sep 28, 2018, at 1:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>> On Fri, 28 Sep 2018, Max Filippov wrote:
>>>
>>>> On Fri, Sep 28, 2018 at 11:02 AM, Andy Lutomirski <luto@amacapital.net=
> wrote:
>>>> There may be a much nicer solution.  Unless I missed something, only
>>>> mips and xtensa even have the possibility of cmpxchg being missing.
>>>> We could just make those arches supply a futex-detecting helper.
>>>
>>> In case of xtensa availability of cmpxchg is known at build time.
>>
>> That makes it even simpler. Could you provide a patch which selects
>> CONFIG_HAVE_FUTEX_CMPXCHG for the right set of CPUs please?
>>
>>
>
> I think that=E2=80=99s the wrong approach, since it won=E2=80=99t cover m=
ips. How about adding this to mips and xtensa only:
>
> static inline void arch_have_futex_cmpxchg(void) {...};
> #define arch_have_futex_cmpxchg arch_have_futex_cmpxchg
>
> And getting rid of the config option.

I'd rather do that, given that defining Kconfig entries that describe
parts of xtensa configuration is somewhat awkward and redundant.

--=20
Thanks.
-- Max
