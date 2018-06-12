Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 07BF2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57E3208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WExk16/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57E3208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934478AbeFLQF2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:05:28 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40681 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933137AbeFLQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:05:25 -0400
Received: by mail-ot0-f195.google.com with SMTP id w9-v6so23194474otj.7;
        Tue, 12 Jun 2018 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TFQQIbLGTzW2bFSoSf10vd13MEIKws0HjwYno/jdX2U=;
        b=WExk16/D049ZstxhL3eG61ZP9GiPS09La9q2FWsOuZvyqTv7GKHeXu7ZcTJ7TOJoQ0
         4n/FDzfGWNnHp6jrGOXNZoSw8yZX5zmGpJGZKhPzPqfoRxGos7LcG3BCupz9iDVsOwUG
         lenjtqqUMAH1n/2+rNRlQZkoAd/tTpoOkxXD5Gz0mQwM1i6wom5UyFW2RQxUa2F0XzuP
         +rlQQZUgDsf24o3pJjM2DydCwK0c9IKtJ4kCi77LUUZocyteBqU1kjF8wdDVz2wcAckv
         4ifmIMo+ANCHWjBkHFomXole2WglSyNb2D6I1QqjrHZWrNYbQ0VyLVFTWNtSm/Hw1gOd
         nKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TFQQIbLGTzW2bFSoSf10vd13MEIKws0HjwYno/jdX2U=;
        b=ZkNwk0b8aEW95CLvjFPoNafmOXp2xV9WjEPx0s4N8/6/tN62RifYbqqhzmlPDCXuRX
         f92wkVkHUhXk5ZOgKG7pe7sG8ZwfqBpJYB+bcHtD4cPP2ndRIRdsq2z30FgiypnPFY/M
         OBTPbCqVPavvlP0W/j0JuhY/UMG5kyUfXtZWezhCxMwSav9SSGJFOzYGOCMg0lYXVgEt
         IsKy5d8k5WK3GacSN4dxD19RXg7RRW4wOCvmxyg5hqK6VYM+xyy/h43PZwowOAnlkN7C
         uEB64I8m5NZjeW9VSD9LhodJfqNxw8tCbR4VHmFKDVxE2/sJGZRfCv+adZFsfR8eA+Ar
         IE1Q==
X-Gm-Message-State: APt69E3kAI9EJtIVsENpfPPaX9IZzeCnbBNYoO57Y1X4sNiwJaltUcr3
        0QBCE912yys9Y3z5wDnG8BOZ9bDMTC7+V3PkIGM=
X-Google-Smtp-Source: ADUXVKIzk7gZNO373f+KJSaMOTTTByIuRYieGVywQyIrNXKCWkIsUK4TjMzcd44rFeCJrZHrJoyMrcS7msxJGFJ1HTk=
X-Received: by 2002:a9d:62d3:: with SMTP id z19-v6mr651115otk.159.1528819525168;
 Tue, 12 Jun 2018 09:05:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 09:05:24
 -0700 (PDT)
In-Reply-To: <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com> <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 12 Jun 2018 09:05:24 -0700
Message-ID: <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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

On Tue, Jun 12, 2018 at 9:01 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Tue, Jun 12, 2018 at 4:43 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>> On Tue, Jun 12, 2018 at 3:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Thu, 7 Jun 2018, H.J. Lu wrote:
>> >> On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> >> > Why is the lockout necessary?  If user code enables CET and tries to
>> >> > run code that doesn't support CET, it will crash.  I don't see why we
>> >> > need special code in the kernel to prevent a user program from calling
>> >> > arch_prctl() and crashing itself.  There are already plenty of ways to
>> >> > do that :)
>> >>
>> >> On CET enabled machine, not all programs nor shared libraries are
>> >> CET enabled.  But since ld.so is CET enabled, all programs start
>> >> as CET enabled.  ld.so will disable CET if a program or any of its shared
>> >> libraries aren't CET enabled.  ld.so will lock up CET once it is done CET
>> >> checking so that CET can't no longer be disabled afterwards.
>> >
>> > That works for stuff which loads all libraries at start time, but what
>> > happens if the program uses dlopen() later on? If CET is force locked and
>> > the library is not CET enabled, it will fail.
>>
>> That is to prevent disabling CET by dlopening a legacy shared library.
>>
>> > I don't see the point of trying to support CET by magic. It adds complexity
>> > and you'll never be able to handle all corner cases correctly. dlopen() is
>> > not even a corner case.
>>
>> That is a price we pay for security.  To enable CET, especially shadow
>> shack, the program and all of shared libraries it uses should be CET
>> enabled.  Most of programs can be enabled with CET by compiling them
>> with -fcf-protection.
>
> If you charge too high a price for security, people may turn it off.
> I think we're going to need a mode where a program says "I want to use
> the CET, but turn it off if I dlopen an unsupported library".  There
> are programs that load binary-only plugins.

You can do

# export GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK

which turns off shadow stack.


-- 
H.J.
