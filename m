Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03954C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39F7207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jD7VFDPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfBUWwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:52:39 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33302 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUWwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:52:38 -0500
Received: by mail-ua1-f65.google.com with SMTP id q17so294592uam.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TgJXk/D5mOtgeFgN3EpBvq8DnHwpIuqAB8mkg89XBFw=;
        b=jD7VFDPWG05dn+qrVooRe7QFkZhfu99WGtNyjigLM4YED+dlhJ2+bl/36w5lWv5RHE
         gFdIdiMvdNLC7MYt64EJBFkfeZRc4407ogVjvFKx6toOEXjUDHuR+LSn6GjgDvZMJNv2
         IxH9MYxyxuMJAnrYZ+iZr1HAjaAE1nnmpXlXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgJXk/D5mOtgeFgN3EpBvq8DnHwpIuqAB8mkg89XBFw=;
        b=sSCmBiM2r1tJUz2gx1sEgCRxWie7jdp/6aFm0wE1i1tRis6ui61PICoGmHSgyHH6r1
         DwJdq0yx9hK5AON0S1Np2G4eiHDnTUb+jEKKqwp7MBCarCBqdhOzToL0SsApyBozQpxN
         niXA0DSIQfmXOuA0gx9Q/wlu4zXyIv4hJJh/9/3eYrm9OlHBavxkPgbcdpk0wcIktGxK
         y7YEigJJ8NahzziXhn2ut5vOUnXbW1NqQD2T1sfI1me9uifd01ZqBqHzz4Jpc8mEc77Y
         lhweq0Be3zeqXE+DEH0AT/xRFHKUpoHgAzghwmbsItu0AprfLPDQvvhB45/wVof81UMx
         daUg==
X-Gm-Message-State: AHQUAuYZ+YP5LisHNuhQGGMSWPSflhpO+BwOejSaonTbbJFilR6BT+EX
        qpNMopmrWB7ZFi8D7c4AcppgqgalOaU=
X-Google-Smtp-Source: AHgI3IaDKTSYzS9mMIPZZVIusUDlOsC7QGpp5pipQoe2bi8fh0/cu7DQZ/Ewunf/TOkKm8YV3Po5Ww==
X-Received: by 2002:a67:ecc4:: with SMTP id i4mr559646vsp.218.1550789556964;
        Thu, 21 Feb 2019 14:52:36 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id c45sm16662uae.17.2019.02.21.14.52.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 14:52:34 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id e16so224971uam.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:52:33 -0800 (PST)
X-Received: by 2002:ab0:645:: with SMTP id f63mr597992uaf.106.1550789553487;
 Thu, 21 Feb 2019 14:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
 <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com> <CAG48ez34MMBfTzQFxj2o5brYDrUS89_gvX9=SnpWZ+TjMUV-BQ@mail.gmail.com>
In-Reply-To: <CAG48ez34MMBfTzQFxj2o5brYDrUS89_gvX9=SnpWZ+TjMUV-BQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 14:52:22 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+da7frEM62vV+WZUTDSuNnUQCxEc7FCL01=jtqDAUb9Q@mail.gmail.com>
Message-ID: <CAGXu5j+da7frEM62vV+WZUTDSuNnUQCxEc7FCL01=jtqDAUb9Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     Jann Horn <jannh@google.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 6:28 AM Jann Horn <jannh@google.com> wrote:
> On Thu, Feb 21, 2019 at 2:05 AM Kees Cook <keescook@chromium.org> wrote:
> > On Mon, Feb 18, 2019 at 4:52 PM Jann Horn <jannh@google.com> wrote:
> > > AFAICS the byte_at_a_time loop exits when max==0 is reached, and then
> > > if `res >= count` (in other words, if we've copied as many bytes as
> > > requested, haven't encountered a null byte so far, and haven't reached
> > > the end of the address space), we return `res`, which is the same as
> > > `count`. Are you sure?
> >
> > Oh, whew, there is only 1 arch-specific implementation of this. I
> > thought you meant there was multiple implementations.
>
> Not sure what you're talking about. Are you talking about
> implementations of strncpy_from_user()?

Ah, I used a bad match. But it seems it's only about half (and not
x86, arm, powerpc).

-- 
Kees Cook
