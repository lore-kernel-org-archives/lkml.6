Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5245C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFC720883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="SQgyPuvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFC720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeKIKXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:23:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42947 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 05:23:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so125626wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 16:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdhTRWSUVEcWBscAsLhgTjRfmWQlTGz+ikL0XCjUXZA=;
        b=SQgyPuvlFn/v52UaPq733+x1QveHknP5PUo2HaPfIecqcPf+VPCamW3qR4YBLxdR6Z
         ykFO57bwa5kLPlH8rFYOT4Pz+ABEcmzQGmK2ZDjNXSJmMCDIFHEhmnFP7tqvY202S1UK
         AYCfX7DIBXRSytZjK71k6yMBc8r3RqwJwZ12E53Hjq4SCQbQ5WnsAdkF5vBXO9NcrE+t
         ktODzQ4IAIHABS1CJvoEoSeRkWCjalwK4mg84eOWIzdmKzvqDWMLZPvKSRXHBMxkWBm5
         gEtDFyEed9LbjcZZqhPwq1QKVCTfPq3b+1E6ClsdUg3tTiO3keHgbUTMaU9RPIrZgxMY
         sd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdhTRWSUVEcWBscAsLhgTjRfmWQlTGz+ikL0XCjUXZA=;
        b=joAcDE63DB5eHGd7qDSFmBmWvcGsmxvjt2NgEy0zPFhWYmwZCZBPT7MgqnsRyHp+Zr
         pLjsfxaofHSXVM/+nfDCwFdkENyxEFeRxKdv9YlKJZqGhriyT9cAB4ZxD2LijZZd6hfU
         CuvYNJayovj3UgPEC5fSwMnThjT0vTrPUpOPpLb4KlSfkBY8bDJozfmyl1ywShrBw+up
         TSJQfCgRHyOBKv4i/1qLotBQaGzALfd3TyCHqfLaXhEMCtCe7/9p//y3neS57Y+rR/61
         m1MXCZxFMkpC+nyNK1zgdwsyVkv4A2ayMnKOTLD9CCUcQXwF3757lbU2SRKk+d+MUN/M
         jUTA==
X-Gm-Message-State: AGRZ1gKXTsnZdV+E8aJ+mWnV9ytDJV4F9uIGM1FIgsia5GDCgTw+JFzs
        pqz3mNCMwnJnUkM6QbxGaqlzgiPH17ghZT+8EcqBqg==
X-Google-Smtp-Source: AJdET5cYxU7/HdcJI6HzaCJqKjhQjRlWchMCbOoRJoXvvvobrFzj2a/Ez6JxT+gZ/a5Dq/uus+FdBMYiByviDgLFMmk=
X-Received: by 2002:a5d:4450:: with SMTP id x16-v6mr5986222wrr.308.1541724338245;
 Thu, 08 Nov 2018 16:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20181011151523.27101-1-yu-cheng.yu@intel.com> <20181011151523.27101-5-yu-cheng.yu@intel.com>
 <CALCETrVAe8R=crVHoD5QmbN-gAW+V-Rwkwe4kQP7V7zQm9TM=Q@mail.gmail.com>
 <4295b8f786c10c469870a6d9725749ce75dcdaa2.camel@intel.com>
 <CALCETrUKzXYzRrWRdi8Z7AdAF0uZW5Gs7J4s=55dszoyzc29rw@mail.gmail.com>
 <043a17ef-dc9f-56d2-5fba-1a58b7b0fd4d@intel.com> <20181108220054.GP3074@bombadil.infradead.org>
 <ead230ab-a904-50d6-c4cf-46d5804f6151@intel.com> <20181109003225.GQ3074@bombadil.infradead.org>
In-Reply-To: <20181109003225.GQ3074@bombadil.infradead.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 8 Nov 2018 16:45:26 -0800
Message-ID: <CALCETrWbYwxDtkp7jjf=L7xFubEOP3+DuCQFHdf7bVy0MqqvXQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 4:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 08, 2018 at 03:35:02PM -0800, Dave Hansen wrote:
> > On 11/8/18 2:00 PM, Matthew Wilcox wrote:
> > > struct a {
> > >     char c;
> > >     struct b b;
> > > };
> > >
> > > we want struct b to start at offset 8, but with __packed, it will start
> > > at offset 1.
> >
> > You're talking about how we want the struct laid out in memory if we
> > have control over the layout.  I'm talking about what happens if
> > something *else* tells us the layout, like a hardware specification
> > which is what is in play with the XSAVE instruction dictated layout
> > that's in question here.
> >
> > What I'm concerned about is a structure like this:
> >
> > struct foo {
> >         u32 i1;
> >         u64 i2;
> > };
> >
> > If we leave that to natural alignment, we end up with a 16-byte
> > structure laid out like this:
> >
> >       0-3     i1
> >       3-8     alignment gap
> >       8-15    i2
>
> I know you actually meant:
>
>         0-3     i1
>         4-7     pad
>         8-15    i2
>
> > Which isn't what we want.  We want a 12-byte structure, laid out like this:
> >
> >       0-3     i1
> >       4-11    i2
> >
> > Which we get with:
> >
> > struct foo {
> >         u32 i1;
> >         u64 i2;
> > } __packed;
>
> But we _also_ get pessimised accesses to i1 and i2.  Because gcc can't
> rely on struct foo being aligned to a 4 or even 8 byte boundary (it
> might be embedded in "struct a" from above).
>

In the event we end up with a hardware structure that has
not-really-aligned elements, I suspect we can ask gcc for a new
extension to help.  Or maybe some hack like:

struct foo {
  u32 i1;
  struct {
    u64 i2;
  } __attribute__((packed));
};

would do the trick.
