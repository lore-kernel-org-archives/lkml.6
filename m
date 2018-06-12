Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2D521C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D760F208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5bcPoKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D760F208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934985AbeFLQwD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:52:03 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39530 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933983AbeFLQv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:51:57 -0400
Received: by mail-ot0-f194.google.com with SMTP id l15-v6so27855330oth.6;
        Tue, 12 Jun 2018 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7VMNrzAjKDc64qlsbblULFGY6ZOX0+yF8AB/zjQjF4w=;
        b=r5bcPoKqPybYyuookIFv6aza1+MAA4exq0fYyNwIhHUsx0VaRHYEm4u4AlKY12TbS+
         owXlm3jUJ8Y7pG6plClGnNwR00nJhNFAq/AnmJADQKTLqXzMItF8FgEuqg9Jgt2X5DQF
         iZye0UtRPC1g4sYlTQlz/Lv8ppoEDMF5kkEisjSjV5YGI/wzaWcBRlBTGa6K8SrbhXWk
         MplZAE57lkCnvTEq6J+6mWzcnAzKcUhZiOBDm69EnDwOxObZKxjReRq6VItpycx2So5p
         LqSgjcwq8m7cJCoQ1PfV6ZjNBgRT9RllgOaWLh/f9mptCsb5gGgGjGO0ayb0EjlQBg1f
         TmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7VMNrzAjKDc64qlsbblULFGY6ZOX0+yF8AB/zjQjF4w=;
        b=fxBjZ6614lVCnYjRlGfX3FLiXB1m12RWX8WlB5g5yeTKgY2OIMeuI43WFag/LAxDNm
         9U+bxwJSY/D68/dZPK33WCLCgWCb0tF6CNE962X7xbMX0hEdOj+4VeovObY7jqMh9aku
         aR2y4kZeZ9j8RQ3JrlH9txL///j2+GeL06SNaosYN667030glEm9ZCjnSIth9K5uFVSs
         i1VS/QiF/N9qnhGVDhTSN+d9vSQGDzyc4ksmIDHSX7QHZkxaQQZazBi1+rP5ES2AaqAz
         iOzLKce3uEzZ92crwusROk+9o1cbE7NggmhU0Ju/qMvasOCAgkeIjOfGuei/+RTwzWxe
         Obfg==
X-Gm-Message-State: APt69E3td/MIWWoc0rt2aLmP4AFOPvcPJW7uBEh1+yOleRs1DJNDfi6w
        3az3hEqF9uWakRdcUcbETqvQvohjD7WWSdR7iEc=
X-Google-Smtp-Source: ADUXVKIDeyZXgBOrS3sx2HFO6pnfdGJj2UPcGssp7ImPhgTz9UJtPOz2LffjPJTJ9H7asFtHGk67gx8sKXsybCqHkUg=
X-Received: by 2002:a9d:2ed3:: with SMTP id w77-v6mr858645ota.123.1528822316023;
 Tue, 12 Jun 2018 09:51:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 09:51:55
 -0700 (PDT)
In-Reply-To: <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
 <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com> <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 12 Jun 2018 09:51:55 -0700
Message-ID: <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
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

On Tue, Jun 12, 2018 at 9:34 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Tue, Jun 12, 2018 at 9:05 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>> On Tue, Jun 12, 2018 at 9:01 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> > On Tue, Jun 12, 2018 at 4:43 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>> >>
>> >> On Tue, Jun 12, 2018 at 3:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> > On Thu, 7 Jun 2018, H.J. Lu wrote:
>> >> >> On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> >> >> > Why is the lockout necessary?  If user code enables CET and tries to
>> >> >> > run code that doesn't support CET, it will crash.  I don't see why we
>> >> >> > need special code in the kernel to prevent a user program from calling
>> >> >> > arch_prctl() and crashing itself.  There are already plenty of ways to
>> >> >> > do that :)
>> >> >>
>> >> >> On CET enabled machine, not all programs nor shared libraries are
>> >> >> CET enabled.  But since ld.so is CET enabled, all programs start
>> >> >> as CET enabled.  ld.so will disable CET if a program or any of its shared
>> >> >> libraries aren't CET enabled.  ld.so will lock up CET once it is done CET
>> >> >> checking so that CET can't no longer be disabled afterwards.
>> >> >
>> >> > That works for stuff which loads all libraries at start time, but what
>> >> > happens if the program uses dlopen() later on? If CET is force locked and
>> >> > the library is not CET enabled, it will fail.
>> >>
>> >> That is to prevent disabling CET by dlopening a legacy shared library.
>> >>
>> >> > I don't see the point of trying to support CET by magic. It adds complexity
>> >> > and you'll never be able to handle all corner cases correctly. dlopen() is
>> >> > not even a corner case.
>> >>
>> >> That is a price we pay for security.  To enable CET, especially shadow
>> >> shack, the program and all of shared libraries it uses should be CET
>> >> enabled.  Most of programs can be enabled with CET by compiling them
>> >> with -fcf-protection.
>> >
>> > If you charge too high a price for security, people may turn it off.
>> > I think we're going to need a mode where a program says "I want to use
>> > the CET, but turn it off if I dlopen an unsupported library".  There
>> > are programs that load binary-only plugins.
>>
>> You can do
>>
>> # export GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK
>>
>> which turns off shadow stack.
>>
>
> Which exactly illustrates my point.  By making your security story too
> absolute, you'll force people to turn it off when they don't need to.
> If I'm using a fully CET-ified distro and I'm using a CET-aware
> program that loads binary plugins, and I may or may not have an old
> (binary-only, perhaps) plugin that doesn't support CET, then the
> behavior I want is for CET to be on until I dlopen() a program that
> doesn't support it.  Unless there's some ABI reason why that can't be
> done, but I don't think there is.

We can make it opt-in via GLIBC_TUNABLES.  But by default, the legacy
shared object is disallowed when CET is enabled.

> I'm concerned that the entire concept of locking CET is there to solve
> a security problem that doesn't actually exist.

We don't know that.


-- 
H.J.
