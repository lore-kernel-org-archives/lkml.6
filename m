Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D170C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC920892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0lv78Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAC920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbeLFMop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:45 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45940 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbeLFMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:36 -0500
Received: by mail-io1-f66.google.com with SMTP id o5so202146iop.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXfEeer8lXiTzxdO568lQH0i3J/k1WTWOP8z/E4CgAE=;
        b=a0lv78WzuNp7XEpWonO8wUhrSSI6l/F7CXDT6FsiSZHZqcgxpH55mW9Tktanmms4bd
         5WCvksPkUVVuWKdYjbtNl5XPuUAi+CEshOgTxF28JKtHNyMf2rozq8k7gTIZd0tjGte/
         0Jm76bCRRLJ50ynvAsj54vvoHRYBD97InWazLHNBTVgwH+KtFbEOXEGnx6EoC5r92IOS
         3af+Ope8V3NZ1nVOlPbh2VisJkNtrEaB8vhSDm8+o9ojvgiLA5qm7ffdoOhR37ULhPEN
         /kzgOF3bW19VejcLSpCAWdn00qf6I5rktWTvGGB69uEdC/RPKj44A8fS9K7EQ/9shASB
         99Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXfEeer8lXiTzxdO568lQH0i3J/k1WTWOP8z/E4CgAE=;
        b=DsF5Og1viEfafCbYAfK2JIiEIhAEIG0lE7hJ6Ugbt5TO4grCQ83sUHhldVWQ2Qxykp
         p4uHxTiLOh0BfAUun/GB3M5qFmoSx27CefNiU4akO4r3Isx4dhSSYvbS2Mjo15i33axf
         qeqnqRPQVxwHyu+70oMRLTNv7lMCsnM/IAGX+L0NdgGfROowKUVTFPp4WkL8xHEYVLU2
         99RtfP8DAl+fTaHb+lWN0CqJDop1sjPu6p7RetXtCgmp93gs3QD16dVJbx0GXSfN4Z9f
         iItxXQAnEdo4S8cm96gGRhJkOd9uuHu2G9Kt0fEo5nmfGnqLaDmazLnVOLkTGI5nDGRm
         F+9g==
X-Gm-Message-State: AA+aEWbO03dDjTru9FedROzWGd6ivgnBtOjnhT3EU7A0GmhcbpbL7I5n
        yRZG/8jAQim7j1ODKH7vjbbfoYtUo3/3G8O9PspFQA==
X-Google-Smtp-Source: AFSGD/ULBxYF7T4c0NJD5O2DilLikv+Y2xbpu6RXWu/u1zlwiz0r4xTAJbdjlGtLEshBsqDhgSfLqaIzXSLUBXDHZCg=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr8810806ioc.119.1544100275528;
 Thu, 06 Dec 2018 04:44:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541687720.git.andreyknvl@google.com> <CAAeHK+w1Qv6owkdWfjbXMFqOA8BURDN5gviw8vpgi3eon1dWmA@mail.gmail.com>
 <20181129181650.GG22027@arrakis.emea.arm.com>
In-Reply-To: <20181129181650.GG22027@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Dec 2018 13:44:24 +0100
Message-ID: <CAAeHK+x9CuqqgvP6pZEV1Gz5cFHNpwsuUDbWQFHFzTy8GBMPKA@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Andrey,
>
> On Thu, Nov 08, 2018 at 03:48:10PM +0100, Andrey Konovalov wrote:
> > On Thu, Nov 8, 2018 at 3:36 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > > Changes in v8:
> > > - Rebased onto 65102238 (4.20-rc1).
> > > - Added a note to the cover letter on why syscall wrappers/shims that untag
> > >   user pointers won't work.
> > > - Added a note to the cover letter that this patchset has been merged into
> > >   the Pixel 2 kernel tree.
> > > - Documentation fixes, in particular added a list of syscalls that don't
> > >   support tagged user pointers.
> >
> > I've changed the documentation to be more specific, please take a look.
> >
> > I haven't done anything about adding a way for the user to find out
> > that the kernel supports this ABI extension. I don't know what would
> > the the preferred way to do this, and we haven't received any comments
> > on that from anybody else. Probing "on some innocuous syscall
> > currently returning -EFAULT on tagged pointer arguments" works though,
> > as you mentioned.
>
> We've had some internal discussions and also talked to some people at
> Plumbers. I think the best option is to introduce an AT_FLAGS bit to
> describe the ABI relaxation on tagged pointers. Vincenzo is going to
> propose a patch on top of this series.

So should I wait for a patch from Vincenzo before posting v9 or post
it as is? Or try to develop this patch myself?

>
> > As mentioned in the cover letter, this patchset has been merged into
> > the Pixel 2 kernel tree.
>
> I just hope it's not enabled on production kernels, it would introduce
> a user ABI that may differ from what ends up upstream.
>
> --
> Catalin
