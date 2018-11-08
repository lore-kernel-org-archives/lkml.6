Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135B7ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6972081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgjzYi78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6972081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeKIAYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:24:03 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54296 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbeKIAYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:24:02 -0500
Received: by mail-it1-f193.google.com with SMTP id d6so1873534itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UT2LNLgTHTkAKpTXl4DqZJH7JJqcSLLb7Ngoy3nD7IY=;
        b=DgjzYi78G7HfWfbIMYpQpW/YmlvU4aWzlH//oD5cqPFf0HEQ1Ff674iUdBEmkPEQFd
         H0RSFkVg6ZBJ7jVMEiXdnBOBLTF9zV5wDiIlwImEScnQ73lVmb+R3GTakfk/uDPlg85x
         8rgULTX+5erC9B04Fkfd1tgOy00WDbBLwKmfayRQDIwkSpcCUXAS1ccagbrg0cebcLUz
         Nrc2wCyQKGeR6COkeS4oBeGR+TrMQzV8WRv6Pz3ppPniftBkWsqZz/tbmHaIvdS+TuHw
         7RIwu4pevidwkzsJxSDYSvWV4wE8K1+M8fHjZ3v+gAkVbS8psklrSd0OxMtKG2b1aL7n
         CBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UT2LNLgTHTkAKpTXl4DqZJH7JJqcSLLb7Ngoy3nD7IY=;
        b=ofn0aGSDCEm56VIYyMvLymviHGNOOpVqjH4ngWCg22SD8XM05xltraRjgqHJGh1Oy9
         7eaIo2DgGm361pFsYm5uJfakkle6B8mlIvAcjsnq0aCASABiBoRwonObJYuPBZIMDxyQ
         lwyignVp5xFw7RsHvYgiVP984oRXZeCmJYgcTF/ER2BZrnU8b86/Efl16p9JngrAzTSg
         3/u7Umdp2YfJrrc30bOeavOdLtPF8Y5MQ09wFY3DQ27exX3MbrzSSu5RcqvvtEfppXhi
         vtfyGjcbLBRq47xM67EDDT5r9+0bFmPpkPX5XhvotDllXyLwZfoSz47BpnF555nPEdlK
         tFlw==
X-Gm-Message-State: AGRZ1gJ4Z3jPaiSZVDr9cqh5h1nykR8umS11QxZc+jbzqlnaydtadKKn
        jeAOkxMU78tO/ueQajj7L9qK/IqdSOjz0HJ456+OWA==
X-Google-Smtp-Source: AJdET5e4Ri0qVbkbhxxVyH/nwORS8569rkWM8UCdfSxsWcrmbYX2HFdYVvkuKvsqGgZF73ovhwCo9t0TwEGI/joAh/A=
X-Received: by 2002:a24:16cb:: with SMTP id a194-v6mr1189806ita.40.1541688491836;
 Thu, 08 Nov 2018 06:48:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:1846:0:0:0:0:0 with HTTP; Thu, 8 Nov 2018 06:48:10 -0800 (PST)
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 8 Nov 2018 15:48:10 +0100
Message-ID: <CAAeHK+w1Qv6owkdWfjbXMFqOA8BURDN5gviw8vpgi3eon1dWmA@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 3:36 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

[...]

> Changes in v8:
> - Rebased onto 65102238 (4.20-rc1).
> - Added a note to the cover letter on why syscall wrappers/shims that untag
>   user pointers won't work.
> - Added a note to the cover letter that this patchset has been merged into
>   the Pixel 2 kernel tree.
> - Documentation fixes, in particular added a list of syscalls that don't
>   support tagged user pointers.

Hi Catalin,

I've changed the documentation to be more specific, please take a look.

I haven't done anything about adding a way for the user to find out
that the kernel supports this ABI extension. I don't know what would
the the preferred way to do this, and we haven't received any comments
on that from anybody else. Probing "on some innocuous syscall
currently returning -EFAULT on tagged pointer arguments" works though,
as you mentioned.

As mentioned in the cover letter, this patchset has been merged into
the Pixel 2 kernel tree.

Thanks!
