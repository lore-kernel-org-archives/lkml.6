Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70EAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B20F20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nINlQ++D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B20F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeLFKUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:20:10 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35846 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbeLFKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:20:09 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so558474itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMLX7TZgGimHpOPxJ6kf9Gyqt7YLykVCggBq8z/2DPk=;
        b=nINlQ++D+/shIxgOMKvy2sqsuA0UcM6LgdCMXam3mX6f0qNCRtICzkK+cD0qDRUeym
         N4HQKf1ua05IzqSRb84TTyGK0f1aotpGruvCow11Ol+K/FmWe5zemmwA2VtpcfoXMVUV
         ShmC8TZkEaMMBdrtFzPFVzzqFb2MjpP6XaUZGv3ToA8pcl3CF9ogyiFDvKehemJ6e+tU
         GoquIWdl92+ABFOSi6naZEgd615nk8U2HbElPG3A5Qw3hcBGFKVG6hepUAyzzajue+LK
         3it+GfnQaKjGwSpLlZQQiI1iuLUs890rUiM8qQnzymv4zRrFWl8+T6RW3wn9c+iDtieo
         7kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMLX7TZgGimHpOPxJ6kf9Gyqt7YLykVCggBq8z/2DPk=;
        b=GjUUU/Fcs4y60TjqnaKHFcnsiJ6RQpKK4CZaGVGvcqoqDYELUQWX1YqEz2n6DA7BDQ
         ZZVXApSmntYJO1G3Ikb33iZAs2zhi+DFdYuWAwE1OJ1nFvCIyZscAFiWhtFSWUochPKd
         Sx2Nn3iRDyK9LrjHfa+cRXoG8PacTkJccNWPLDRKobb/e4yg5cfW3vXCvDbpIo0MTkps
         5XSQejZJyrTY1JgOXgPFT3LIvZKTO67bgWjysVKWnwrCWv1ykvPM/HYVnfcnFCkDoGMJ
         4TM8cCaxZnu6w+EJZMduVwcj74XDSbZDJ17wyM7aKTruei/11FzdlfOGJMClZSs92RkC
         lCWg==
X-Gm-Message-State: AA+aEWbWJh/sei71DSwl827acXXNkDjpzC5upVrJJyc4vrvkrytEyZQb
        NYeVgF2UGHhMfERwrUYkvthavXqAu+ds0lhUgyu4Vw==
X-Google-Smtp-Source: AFSGD/V0S/VS0r8YYqUJXBp2ufBpxX2HkEz6m2+mhQ1R0QsMnoWizbVgluEHuL+4DwwDPGClzxOCNIoxDwAepSixwt8=
X-Received: by 2002:a24:cb02:: with SMTP id u2mr16244774itg.87.1544091608562;
 Thu, 06 Dec 2018 02:20:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543337629.git.andreyknvl@google.com> <996c9b3898bb3c5de977d00215ddc4bf8cf154c1.1543337629.git.andreyknvl@google.com>
 <20181129180134.GA4318@arm.com>
In-Reply-To: <20181129180134.GA4318@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Dec 2018 11:19:57 +0100
Message-ID: <CAAeHK+yN6Jrk6G6OjbkMHwCxkuQHfrz8PXtPTUdrfsHaru_eKA@mail.gmail.com>
Subject: Re: [PATCH v12 23/25] kasan, arm64: select HAVE_ARCH_KASAN_SW_TAGS
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:01 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Nov 27, 2018 at 05:55:41PM +0100, Andrey Konovalov wrote:
> > Now, that all the necessary infrastructure code has been introduced,
> > select HAVE_ARCH_KASAN_SW_TAGS for arm64 to enable software tag-based
> > KASAN mode.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 787d7850e064..8b331dcfb48e 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -111,6 +111,7 @@ config ARM64
> >       select HAVE_ARCH_JUMP_LABEL
> >       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >       select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> > +     select HAVE_ARCH_KASAN_SW_TAGS if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>
> Can you do if HAVE_ARCH_KASAN instead?

Will do in v13, thanks!

>
> Will
