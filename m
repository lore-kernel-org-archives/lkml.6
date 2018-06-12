Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 84E9EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283932089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFRbXM+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283932089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbeFLTei (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:34:38 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36476 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbeFLTeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:34:36 -0400
Received: by mail-ot0-f196.google.com with SMTP id c15-v6so175353otl.3;
        Tue, 12 Jun 2018 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W+28d3Sr/9L9yJao9RPdfThx+qD77ejVW9EN5e4mgt4=;
        b=RFRbXM+C9r56bzdKYHB7ELVfTaEhMAk3GqJpS5CZlaoZm2GWvknbgESI9K6zJRxwym
         UClpaZjiUNLhgySSW3QQnD2BkAMNPH8qN/6ZC//2zVtB46jYKIqLiLV1KEYfzh4sy3LM
         5cw2NF9zVCyWYnymoizg1/hQpz7ONakWryCOukx05QVi2bVH9qAHqfqz0wqYPt3z2HzK
         N86H+3HC1W8APVtNTlDSalw2+9UGFc5wqfSfrOkUTqwLvj3sTCT70g1xw2QMR9igXfsw
         exh4c64P0uLGweU2sSJOywr/aN+HvaR9MyhqFTXOAdCu5CCFay91+k9YZWJwsS3z/Z09
         vHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W+28d3Sr/9L9yJao9RPdfThx+qD77ejVW9EN5e4mgt4=;
        b=MlhnctIoKdSbTcp6v6Bj9Hx6eVQrNzWbtvI8qN7+PG4QtiFfWTLUUB5QAASAcuXt6j
         Qte3RLXiOdfo1/nRc/usDenUKt8zmAiyGuFTaiK2NdHdU751i47/Eu++gM9eZbseoD3+
         XwR8mcwB9X1J6YUWNTdqLuMnTnWcseV152A0o5U55NYOeSb0aGm7/RQROC3m8Os/s3Nc
         h2DCpCxjaNrG+OqcjuD3t80nibEbXz6KuYkKwQiTi3fB2QhdfAQv2+rAol1IqdEitWKr
         CftIOOItIIyIAIxuhQogqWjFiZjhjHg8alnHD3omL9zud1TweQDLlfHkfQ3DcX37zd+B
         NHQQ==
X-Gm-Message-State: APt69E3ZbinuIOrUWmAwjqxgyu/GjMuVAmhbEfCOzTXrvenRv/OKqbXZ
        TNot+sxfAkWNA8gkIF5I3qMN8lRB5v98SF/MsYM=
X-Google-Smtp-Source: ADUXVKIybqCMpSQWFgLDDTTQVy2phEamWokOgX9urRnuG9eru53IE9YLbgRA/hhQ5IVktvPEXV666vAQd5mnW+YkdsI=
X-Received: by 2002:a9d:2ed3:: with SMTP id w77-v6mr1243664ota.123.1528832075346;
 Tue, 12 Jun 2018 12:34:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 12:34:34
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
 <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com>
 <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
 <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com> <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 12 Jun 2018 12:34:34 -0700
Message-ID: <CAMe9rOrGjJf0aMnUjAP38MqvOiW3=iXGQjcUT3O=f9pE85hXaw@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:59 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 12 Jun 2018, H.J. Lu wrote:
>> On Tue, Jun 12, 2018 at 9:34 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> > On Tue, Jun 12, 2018 at 9:05 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>> >> On Tue, Jun 12, 2018 at 9:01 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> >> > On Tue, Jun 12, 2018 at 4:43 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>> >> >> On Tue, Jun 12, 2018 at 3:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> >> > That works for stuff which loads all libraries at start time, but what
>> >> >> > happens if the program uses dlopen() later on? If CET is force locked and
>> >> >> > the library is not CET enabled, it will fail.
>> >> >>
>> >> >> That is to prevent disabling CET by dlopening a legacy shared library.
>> >> >>
>> >> >> > I don't see the point of trying to support CET by magic. It adds complexity
>> >> >> > and you'll never be able to handle all corner cases correctly. dlopen() is
>> >> >> > not even a corner case.
>> >> >>
>> >> >> That is a price we pay for security.  To enable CET, especially shadow
>> >> >> shack, the program and all of shared libraries it uses should be CET
>> >> >> enabled.  Most of programs can be enabled with CET by compiling them
>> >> >> with -fcf-protection.
>> >> >
>> >> > If you charge too high a price for security, people may turn it off.
>> >> > I think we're going to need a mode where a program says "I want to use
>> >> > the CET, but turn it off if I dlopen an unsupported library".  There
>> >> > are programs that load binary-only plugins.
>> >>
>> >> You can do
>> >>
>> >> # export GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK
>> >>
>> >> which turns off shadow stack.
>> >>
>> >
>> > Which exactly illustrates my point.  By making your security story too
>> > absolute, you'll force people to turn it off when they don't need to.
>> > If I'm using a fully CET-ified distro and I'm using a CET-aware
>> > program that loads binary plugins, and I may or may not have an old
>> > (binary-only, perhaps) plugin that doesn't support CET, then the
>> > behavior I want is for CET to be on until I dlopen() a program that
>> > doesn't support it.  Unless there's some ABI reason why that can't be
>> > done, but I don't think there is.
>>
>> We can make it opt-in via GLIBC_TUNABLES.  But by default, the legacy
>> shared object is disallowed when CET is enabled.
>
> That's a bad idea. Stuff has launchers which people might not be able to
> change. So they will simply turn of CET completely or it makes them hack
> horrible crap into init, e.g. the above export.
>
> Give them sane kernel options:
>
>      cet = off, relaxed, forced
>
> where relaxed allows to run binary plugins. Then let dlopen() call into the
> kernel with the filepath of the library to check for CET and that will tell
> you whether its ok or or not and do the necessary magic in the kernel when
> CET has to be disabled due to a !CET library/application.
>
> That's also making the whole thing independent of magic glibc environment
> options and allows it to be used all over the place in the same way.

This is very similar to our ARCH_CET_EXEC proposal which controls how
CET should be enforced.   But Andy thinks it is a bad idea.


-- 
H.J.
