Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E150C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC312082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zX82UHJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC312082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeKCGgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:36:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39676 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeKCGgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:36:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id a28-v6so2934973ljd.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5E7BtxCLiFl5MyJ8FGVNz32Q+n/eWWvNnPYa7Z8dqs=;
        b=zX82UHJtRDmIzvHOFhMETwpRbeuF8lHC1gvWt8ZVx0b16hw2A5F3kQY0NsFuVE7cgl
         Kru+7Sc3cB+naovJwtAH+6UI+deFo03z/y9am4sfe26omAZ3VJefEIDu4gQMa8cswdNv
         Rj232x+j7SGMJBbEqLC0VMTbW60O+JDAnUKHWrH0cgm8XO2dGPg0tib3cUfDZZVY6XSM
         zao91QL7RMoY6KRjCegRM9fQ2/BiYMbSJN2gznJVNqs/LO5Zixm8rPFLQOPOwaK6X8Ji
         YhMxYB/3n82SwxGUN/7YJc/+Lof5TaiJ9s9pHKXZ0+yzlE8/qKQbM0gN1C9XhtEkNVWW
         OBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5E7BtxCLiFl5MyJ8FGVNz32Q+n/eWWvNnPYa7Z8dqs=;
        b=ZRZRHw/p8OOJ6ApVEm2z0rYi8umDwNoS429yURm6yjaGmqtJVFxKAQr2sjAs6gCqA/
         MKjyWSZOFT7Zn4HiPHEmZS4NoZQED/yN6f5jlJ+JM8MHMdq3SJT3+bdpTrEqL9fKasO4
         SlKTgh4QFU3fntMtjCYoWdGi/f51IsWgjyL/Zsl34stI3dB8n4gdrnzK2Aa+hKTXgxsJ
         jGqfI9t0qmMqmnwZ5Yu219MIAk5HeLlTHdeaj7mRQ1LhXDciMv4ZOgVMSN//lnNYCM1p
         Df8eKoVqvVwUiE4vjA6apRGC7bgrKxS+VKvBQGBIe6HiV/tJQJ6Qwl6Tv5JjouXCteIH
         mhig==
X-Gm-Message-State: AGRZ1gIRAaH1B+6E5F4Tt1+aTgrmRhcmxDM/Wi/unNNC0xJoyR7Fnu12
        yFjNFKl764fsSu65GmgvwdYjiDPQLy+5tqtSJqMuFw==
X-Google-Smtp-Source: AJdET5f0F5C3NkqnkUUdBWDlZO4dQZ3tbeDjLke4DNxOGMtAtyvW9s01B7kk+VpE4WCQRTI972oE48qOpfUAX0J3gP8=
X-Received: by 2002:a2e:9bd4:: with SMTP id w20-v6mr761818ljj.59.1541194075029;
 Fri, 02 Nov 2018 14:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180202154813.1625742-1-arnd@arndb.de> <d77f9a8a-0bb2-50a3-68e3-b4f4173645bc@virtuozzo.com>
 <CAK8P3a124Jdza9YbgOHECC2owpx_HmOuDMWtotxuC2-F9L9Cgg@mail.gmail.com> <00813389-daf0-a97f-8642-cb4e7a62fa27@virtuozzo.com>
In-Reply-To: <00813389-daf0-a97f-8642-cb4e7a62fa27@virtuozzo.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 2 Nov 2018 14:27:42 -0700
Message-ID: <CAOesGMi-vkYPDrL2drJ70zf3_xTMWrsfPoW68TkiRJCj8uWBLg@mail.gmail.com>
Subject: Re: [PATCH] ubsan: don't mark __ubsan_handle_builtin_unreachable as noreturn
To:     aryabinin@virtuozzo.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:31 AM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
> On 02/05/2018 01:15 PM, Arnd Bergmann wrote:
> > On Mon, Feb 5, 2018 at 10:02 AM, Andrey Ryabinin
> > <aryabinin@virtuozzo.com> wrote:
> >>
> >>
> >> On 02/02/2018 06:47 PM, Arnd Bergmann wrote:
> >>> gcc-8 complains about the prototype for this function:
> >>>
> >>> lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]
> >>>
> >>
> >> That's actually a bug in GCC. In GCC __ubsan_handle_builtin_unreachable declared
> >> with 'noreturn' and 'const' attributes:
> >>
> >> DEF_SANITIZER_BUILTIN(BUILT_IN_UBSAN_HANDLE_BUILTIN_UNREACHABLE,
> >>                       "__ubsan_handle_builtin_unreachable",
> >>                       BT_FN_VOID_PTR,
> >>                       ATTR_COLD_CONST_NORETURN_NOTHROW_LEAF_LIST)
> >>
> >>
> >> But const attribute doesn't make any sense for function that returns void or doesn't return at all.
> >> Given that gcc-8 has not released yet, it would be better to fix this bug there.
> >
> > Ok. Should I open a gcc bug, or will you take care of it?
> >
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84210

8.2.0 still shows this, and there's been no movement on that bug. How
about we pick up this patch until it's been resolved?


-Olof
