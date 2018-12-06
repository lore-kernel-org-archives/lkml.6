Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8770F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eF4lMLd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8770F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbeLFMg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:36:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34193 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbeLFMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:36:58 -0500
Received: by mail-io1-f67.google.com with SMTP id r9so245781ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WidNIP8PGlQQtkA0lmSuS7tUfoPMSknLn9VUL0IsozE=;
        b=eF4lMLd2gM5bZJkTfp6Rs2kYVm7O2ljRh8HtAeOfR/uvqp9VX9Le/TtrRT4623RIW9
         S37itEwpEmj2zoERka2diuAljUcjkjdXO182hvOyUN0whOir04e6TkSCA33JGJhc04yc
         vA0VMroGWF2XsAc9XPb2Ti576+1OhnTFlFLpuSYYU9PlebzUtOiYlNDXrS7Q3wLpNtpv
         VTEefTG7R6HvqN1nlJnEta/2ds92zk+a+UXyTze/lHXdz5XyqfUTgAu2aMkeBOT3EWdZ
         +0v4SzUCJkcJF52coaPIb3gYx+Uu7LXUvWaHF1dyFK8zP8+M/DrG8ohcEnrL4h4pDCXE
         DaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WidNIP8PGlQQtkA0lmSuS7tUfoPMSknLn9VUL0IsozE=;
        b=XFu96OvQeWvO0Fu+s2gHbl/z9jJjlO/p5k4UVvzEbb57rqx+nXyOmFWkBgdaiL1uXH
         VOFY3AwvPMGBjg9KM13Cll2M7L4RRQwRrw1T+MatqsIW5uvI4rPuOJliSRvjoXDzJZv5
         TiodXEG0nCs9WCEhLQGl9CKMEyZnziSK2o3KSIAFDt7Xr/WA2lRR4zH85h4zxW+fSWQD
         PjrfPk5PJ/HiENEGdmoM1+762cIHSvjToqKTrr629GJvQudxtmvXllyqGUv9amTUaEBA
         upOEkUcEIBk0rnQndGDsbod9CiXmENf8Vdw9rGOOIVXHwC6LTm0L1L/WxE6z1UB+uBJ4
         UYrA==
X-Gm-Message-State: AA+aEWY67PiaeYl6EBx+QHn8208iTmjiE/30Zf3LbB8jV3ENeVK/YWSw
        bE6Kop7YJw2FRPJSbtqTfNMbfVqyCWKNflXqFEpCWA==
X-Google-Smtp-Source: AFSGD/Xm9VGdnSPf1hWOUupCpcd7a1Mg3qQvtYoJwqmAMi3YOnI7fV93LEeSmCsW4kQDTIuBhjZmOXHOAFzCCUI1QE0=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr8796163ioc.119.1544099817423;
 Thu, 06 Dec 2018 04:36:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541687720.git.andreyknvl@google.com> <c9028422854fb5bfb79d798397b30d4701207062.1541687720.git.andreyknvl@google.com>
 <20181129182323.GI22027@arrakis.emea.arm.com>
In-Reply-To: <20181129182323.GI22027@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Dec 2018 13:36:46 +0100
Message-ID: <CAAeHK+y7AwdXsEgBYqLUzps2K8aGcbDsSpS+obCs11voZX55og@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] uaccess: add untagged_addr definition for other arches
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:23 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 08, 2018 at 03:36:09PM +0100, Andrey Konovalov wrote:
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index efe79c1cdd47..c045b4eff95e 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -13,6 +13,10 @@
> >
> >  #include <asm/uaccess.h>
> >
> > +#ifndef untagged_addr
> > +#define untagged_addr(addr) addr
> > +#endif
>
> Nitpick: add braces around (addr). Otherwise:

Will do in v9, thanks!

>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
