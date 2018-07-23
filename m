Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12B8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DF220846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="neCpsCVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DF220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbeGWIkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:40:51 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:41351 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387828AbeGWIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:40:50 -0400
Received: by mail-pl0-f42.google.com with SMTP id w8-v6so7908016ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YrlB2SA8G/ic/ZeUfHVpH8mz5CVEbE1BKUKpwp92+jg=;
        b=neCpsCVskTYqtpVirI/4urxrNtQzQq2xFKDQKR/+wrFkh8S+WaxjeWN7ME5WsD/jVf
         3m1WkVyFhOECO1EKHgaa19oE9IOCWnIE5GsfvlIL5C1PkN2nDYMc2fSB9ayishspwLEg
         FwNBLDxlkDpuXIgNVNFlCmZCimSV4NtzTr42Nlz+igTAhHT7/Ne0t/BgqSXc8VEyNHSj
         wg+WGMISG1ePcmZNCzqBi82mKRlqbcXAQ2C4KSHYxhS6Q6l/X4p+3Gw/duLBkEJ3eRtK
         OCIBhQq9T/VTHuREh9j8A92mHKu8ShixwmOR073bCpAUAIKDRAppU94rqRlDyLxmCpo7
         dvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YrlB2SA8G/ic/ZeUfHVpH8mz5CVEbE1BKUKpwp92+jg=;
        b=rj3wScKOuIRzRbs0j84vOie9NxlAbiBnt5mxvBSAGOOBFMvfsso/sn6fy1seQCFaLW
         ljo4k2oovUM3Z5QOsuPeKup5ONBSJbDGrxLD4Ulsav79V2xzwLcezO0Ai8a6qLTrWkkB
         cytJSHUa0UwK+J2p1w0jveoKNB2vFCy7r68Fon+PoQexNrZB0yKyZpRgWq6iP2TSlh1R
         MYSyzz+eLRRTWrAk6DyI8aLXqaPRGtWbP8sxsXoAZ5SwGce2/GWIDjrtpUm7eLhiVcKn
         wpRc4/pAq/Ouvq/V571RuQZBuvb9bN/OlfoNi+c6Tu8dx7F9q43ob0+3wBFzQmH03rez
         kTHA==
X-Gm-Message-State: AOUpUlHYwgjSWtg8Qs07Ipa3eFPte+yjif5mtKBuhLaV3VIHtJRPKrwc
        wS6fTyhIKJO6jdgGfsan4WxRy7ioAVD+Ty07KAQtRw==
X-Google-Smtp-Source: AAOMgpfyZ+KwymbdYxK5anO0Xry3R2HkAauDlP5HDajgIbnGJaq8TnszOdGjU5l+L2sW+/rdvv5rF/lJA3GgHz3tUhk=
X-Received: by 2002:a17:902:8c88:: with SMTP id t8-v6mr11787224plo.117.1532331657602;
 Mon, 23 Jul 2018 00:40:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:8e82:0:0:0:0 with HTTP; Mon, 23 Jul 2018 00:40:36
 -0700 (PDT)
In-Reply-To: <CALCETrW4F33LWWA=cWYZ2N9=veCmVfjhCCLnSv2qh=32fOAf-w@mail.gmail.com>
References: <CALCETrW4F33LWWA=cWYZ2N9=veCmVfjhCCLnSv2qh=32fOAf-w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Jul 2018 09:40:36 +0200
Message-ID: <CACT4Y+aP4QSGBiLWt0iNHVJ4nMc_phthK9P+gTMd4d=exaAKwA@mail.gmail.com>
Subject: Re: Making KASAN compatible with VMAP_STACK
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 7:52 PM, Andy Lutomirski <luto@kernel.org> wrote:
> Hi all-
>
> It would be really nice to make KASAN compatible with VMAP_STACK.
> Both are valuable memory debugging features, and the fact that you
> can't use both is disappointing.
>
> As far as I know, there are only two problems:
>
> 1. The KASAN shadow population code is a mess, and adding *anything*
> to the KASAN shadow requires magical, fragile incantations.  It should
> be cleaned up so that ranges can be easily populated without needing
> to very carefully align things, call helpers in the right order, etc.
> The core KASAN code should figure it out by itself.
>
> 2. The vmalloc area is potentially extremely large.  It might be
> necessary to have a way to *depopulate* shadow space when stacks get
> freed or, more generally, when vmap areas are freed.  Ideally KASAN
> would integrate with the core vmalloc/vmap code and it would Just Work
> (tm).  And, as a bonus, we'd get proper KASAN protection of vmalloced
> memory.
>
> Any volunteers to fix this?

Hi Andy,

I understand that having most configs as orthogonal settings that can
be enabled independently is generally good in intself, but I would
like to understand what does VMAP_STACK add on top of KASAN in terms
of debugging capabilities?
