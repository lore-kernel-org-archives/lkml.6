Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D33DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166B220836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="VNBQe/r0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166B220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757240AbeFSUri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:47:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42289 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755460AbeFSUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:47:35 -0400
Received: by mail-pl0-f65.google.com with SMTP id w17-v6so471932pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hna65Qii4Y07/hwRcMlHHRl8clNAP2YSD03xwzMcGr0=;
        b=VNBQe/r0okWsKxg7Vcf0OgNXm9yHLR5IEm0SwusV58SL9lH0AINptiTMKCYVFLpk+V
         CRiPjwbQy4Hph4MJkhS+N9eH+ZhzYbH/lZbvgRFVHyTMY5iPbNHuYMSJ0AXLHfjrU9Tf
         HozJc18MqIrdt5QjWpzsAXIP/+DsC+pMATTrDPJyvdsgFF8xuWRajihBNbjjAE7Fm2LN
         OXV+fKsccm1SkDELdPwmtPqjQ8ZxO8hJDjWzEJf1+1AhpaDz7RJGq70uPvd+knT3tzLv
         xfBnK+wOTN6qisnJpKBfinRcP7mP9wu+4QsQrmbJ4xaUYYqn9QZ+Pn6VlmT8LrNUx+Lw
         Sizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hna65Qii4Y07/hwRcMlHHRl8clNAP2YSD03xwzMcGr0=;
        b=WWUJPEM5dXGUjO1g4tjm7salz+f/okZeXothF0/6K8O/Kk3owWHHg+wr+a1kA5g4Q1
         3qO/clIrcUJtuIMvxnJeMZ1/hZTknaIL+i+7Nhkmo/04qyz8vqZG8nAQ3ZiqhxoPu7Mm
         yMuJoUHb+HP9eFH99QSemFVm25XjPbIUB4ZR6I76I7bLQCqXNcKQWg9fCfKye+9e1epq
         QjtNfOrj+DGU1pIKv0wQugx4+inwm23fwfa9hs8KbKENWV15rqAeiys5Z9Lqi7meGyRX
         HXsYeKR0ZCkntL78bBWYmKhqDLZ79K5OqetBVgEMC/Za7Auc0lkEpxeqlnNl2nCUIv/j
         F7KQ==
X-Gm-Message-State: APt69E30T0BADLxRkbfWttlvl7Lfsaub3DORgsdSOSbP0rfIzbDFxDGJ
        3MijT31HWc3LVx4k+yxwdDYrg0f7wQs=
X-Google-Smtp-Source: ADUXVKJzK+AQUr7SJX2e23MfUWF76NJkZhfCynWMhtR4HdBtmszqtZqf/NelictHSl8ZhqJkVTLtpw==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7-v6mr14984009plr.215.1529441254854;
        Tue, 19 Jun 2018 13:47:34 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:d482:e0fa:500f:80eb? ([2601:646:c200:7429:d482:e0fa:500f:80eb])
        by smtp.gmail.com with ESMTPSA id j127-v6sm504773pgc.10.2018.06.19.13.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 13:47:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CAGXu5jLEMy_T_5OtXLT+pUCt=Nk53nBbuRvrUgJBhq-4RZ=yCA@mail.gmail.com>
Date:   Tue, 19 Jun 2018 13:47:32 -0700
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com, Florian Weimer <fweimer@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <446EB18D-EF06-4A04-AF62-E72C68D96A84@amacapital.net>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
 <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com>
 <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
 <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
 <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de>
 <CAMe9rOrGjJf0aMnUjAP38MqvOiW3=iXGQjcUT3O=f9pE85hXaw@mail.gmail.com>
 <CALCETrVsh5t-V1Sm88LsZE_+DS0GE_bMWbcoX3SjD6GnrB08Pw@mail.gmail.com>
 <CAGXu5jK0gospOXRpN6zYiQPXOZeE=YpVAz2qu4Zc3-32v85+EQ@mail.gmail.com>
 <569B4719-6283-4575-A16E-D0A78D280F4E@amacapital.net> <CAGXu5jJNgu4bW_Zthqjfpe9gLxK0zxG8QFEqqK+pJNebz6tUaw@mail.gmail.com>
 <1529427588.23068.7.camel@intel.com> <CAGXu5jJ4ivrvi-kG0iY=4C0mQQXBDXwPdfY36Dk+JqOpX19n0w@mail.gmail.com>
 <0AF8B71E-B6CC-42DE-B95C-93896196C3D7@amacapital.net> <CAGXu5jLEMy_T_5OtXLT+pUCt=Nk53nBbuRvrUgJBhq-4RZ=yCA@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 19, 2018, at 1:12 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
>> On Tue, Jun 19, 2018 at 10:20 AM, Andy Lutomirski <luto@amacapital.net> w=
rote:
>>=20
>>> On Jun 19, 2018, at 10:07 AM, Kees Cook <keescook@chromium.org> wrote:
>>>=20
>>> Does it provide anything beyond what PR_DUMPABLE does?
>>=20
>> What do you mean?
>=20
> I was just going by the name of it. I wasn't sure what "ptrace CET
> lock" meant, so I was trying to understand if it was another "you
> can't ptrace me" toggle, and if so, wouldn't it be redundant with
> PR_SET_DUMPABLE =3D 0, etc.
>=20

No, other way around. The valid CET states are on/unlocked, off/unlocked, on=
/locked, off/locked. arch_prctl can freely the state unless locked. ptrace c=
an change it no matter what.  The lock is to prevent the existence of a gadg=
et to disable CET (unless the gadget involves ptrace, but I don=E2=80=99t th=
ink that=E2=80=99s a real concern).=
