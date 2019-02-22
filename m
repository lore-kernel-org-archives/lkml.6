Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28302070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ftSjNtmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfBVTwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:52:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40896 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfBVTwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:52:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id u9so1577469pgo.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 11:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sWjx7TiMPEfGbZSAb5kdSEfmJJCZRoY7ZYxqwwXxGcg=;
        b=ftSjNtmPcx7WC466JmBway+T4V6DT1UvefC+zlgzWGwFVyIwZh0rDU6vRU9apyHEFp
         V2Ja9uak+DX6YqG7BCiqCLSppre9N+NprLbQZirT5nEGHkoSWfNVH2KqTQPa4Q0Xd2OD
         I5OGCo2ygaBMgvLmX6dfYP3LzyZ0sbWeZ9rwMDR7Gj8XgTQ/nwZYGUVdwjeWsrVITHZO
         pVgJ8LGGukAvEPT93wFdKP41cxzwrnPsJNH5Swyx80fjout9pjTBxie3Rbw+cWBE+Iw0
         3AWQRrMZ5sgJox0qhtVvPCve3GJqC5uSBq6oZtQ/sr5RfZIwtHNhalPUgIDWeyyPuXOz
         44xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sWjx7TiMPEfGbZSAb5kdSEfmJJCZRoY7ZYxqwwXxGcg=;
        b=gAXk57T3OLnZsvEl02t1IvCjQQ5ysKPo7D+Xzju66i7Y3U7EFdWHwi4tfJSliJznMh
         v+fTr/kzIfzzBX5ozX+h817ouVKOoIrovAvCqWtVWAmZj/vmiB8sydTFoBSd+m1ejjJf
         bELPhEeSjdpcx5PPfQ+FQunmasCpP3hbtxO41xWNx88oAQcwLa0Mdb6hWb3xp0/hOM1x
         K7+U+WKXWMLjT9aD2liBVSgjbRKNAxOkIqPaYwmH7D4PgDvb1R+wZeTqfMcP1I56cPed
         22QGQOXM6jTGqgMT45mbHmOCObhdgvsyDYeiJYVbigoaUpRwiNRniv8HFYAZFpP4SMCn
         Jreg==
X-Gm-Message-State: AHQUAuYTy4omoEkhUygjzrZbJTTtTBtDLLwPpPcZUa7dr4KRHOlyJzoO
        exD63u2YslJkbaHWdP6LVU2ZENr3jVih1w==
X-Google-Smtp-Source: AHgI3IYskkIe3SGKwY03X0Aq/BNs3SVl337NWh/GGM0MFWeaO/slx8R3y5owUFET9gmuOsQgY32ffg==
X-Received: by 2002:a63:575d:: with SMTP id h29mr5585788pgm.442.1550865157877;
        Fri, 22 Feb 2019 11:52:37 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:6592:abd7:9236:4c2f? ([2601:646:c200:7429:6592:abd7:9236:4c2f])
        by smtp.gmail.com with ESMTPSA id k1sm2943066pgq.45.2019.02.22.11.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:52:36 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access kernel memory that can fault
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <CAHk-=whX6LLVn_q2DC0K37iQgZ4S0LX6mR46+O2TNufJuR-K6Q@mail.gmail.com>
Date:   Fri, 22 Feb 2019 11:52:36 -0800
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2561D633-DE6C-4E74-8EBD-B743D0141054@amacapital.net>
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org> <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com> <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net> <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com> <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com> <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com> <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org> <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org> <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com> <AD9148E4-00CC-4711-82D3-957D28497057@amacapital.net> <CAHk-=whX6LLVn_q2DC0K37iQgZ4S0LX6mR46+O2TNufJuR-K6Q@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 22, 2019, at 10:28 AM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=20
>> On Fri, Feb 22, 2019 at 9:48 AM Andy Lutomirski <luto@amacapital.net> wro=
te:
>>=20
>>> On Feb 22, 2019, at 9:43 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>>>=20
>>> Then we should still probably fix up "__probe_kernel_read()" to not
>>> allow user accesses. The easiest way to do that is actually likely to
>>> use the "unsafe_get_user()" functions *without* doing a
>>> uaccess_begin(), which will mean that modern CPU's will simply fault
>>> on a kernel access to user space.
>>>=20
>>> The nice thing about that is that usually developers will have access
>>> to exactly those modern boxes, so the people who notice that it
>>> doesn't work are the right people.
>>=20
>> We use probe_kernel_read() from oops code. I=E2=80=99d rather it return -=
EFAULT than oops harder and kill the first oops.
>=20
> It would still do that.
>=20
> Using the unsafe_get_user() macros doesn't remove the exception
> handling, and we wouldn't remove the whole "pagefault_disable()"
> either. So it would work exactly the same way it does now, except on a
> modern CPU it would return -EFAULT for a user space access due to AC
> not being set.
>=20
>=20

Hmm. I misunderstood you. I thought you wanted the oops.

We=E2=80=99d have to check that we don=E2=80=99t trip the =E2=80=9CSMAP viol=
ation, egads!=E2=80=9D check.=20=
