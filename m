Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A01C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088DD218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rj6yIH+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBGAkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:40:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43532 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfBGAkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:40:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so3937559pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 16:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgcJZkUh0YIGv0Z7LvtuEKCvSPK3FTC+e0Utb9tNKjk=;
        b=rj6yIH+d0bydBgX3dE2oDdbUQCxoTjDMJLA9GebZCheYTnsV4Vsd85azePcEN5KPDD
         GlADREe7Cuqgw0JyXVEpxfLu8ylpyHF2e/pyjFbKDY3cMeVKdIcbK/RTpof8pK6Q85OS
         +7WWT8S8anqYkVbwkUO6ss0w7JPN5U4ic5LjVF7VoeDVNfTJEAZSwogcBMxkpOY0hleG
         k2qH+EPPI9lKQ/NEBueFpte2FoJjJm57pBg9/g4A6XP1GgkkiwlOrYTxvubT0ezr3/JO
         uS85N6pW/9vfWMJrXnx6vSCJWnWFn3FyKub1TW0YS+wAroRzbqi4K5BQ1q0HuzlAiYwg
         q+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgcJZkUh0YIGv0Z7LvtuEKCvSPK3FTC+e0Utb9tNKjk=;
        b=gLURWSCBb3DaMODb1uoyhX7df6Rx389Vb5jqjSdy0CScAqfEJAu7XZeQNKAdjhecrs
         CscRAWR9gvHEWGCirQqXKvHTlDqw10pq7zg0hLLa9FBq89FHi8ZSGrQZq0OyM0SPnxhN
         UP1aw/RkBc8xbINdCYYFMv1zpdb+dnoyr3GJ/mtpzY/Q/LueJbgxrzsU9t8ESHtlaZQG
         sAJsDn1LE6+cjl5RjFwocrxE53AQgBkfU5VC54Gy/BsugOcESoW3g1MrSUlgiZD7z5sZ
         3El2drZZPACzosd9Zd8fX8TOEQR3gB+1Fotae7O/1cs5A3RfqTy5hkxtwq5YQF15DTd9
         utig==
X-Gm-Message-State: AHQUAuZF0u0vIaRqs0dh72z1JzVjmSw4pT2xAwMPzY0rLGg+tRuWrhey
        AdhQnRmvxuxlHty7zY1NUl+KdaFLCLTX+v53bTnWfQ==
X-Google-Smtp-Source: AHgI3IYMAu7+h/e9nGmWcrOPxzOtpgk6HcsC+0SFalMR/hxOKgiUs3il3X0WSX0RCuXIo/sFg1KPWKk7FJBJJjydWJU=
X-Received: by 2002:a63:e156:: with SMTP id h22mr12289862pgk.255.1549500015154;
 Wed, 06 Feb 2019 16:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20190201210853.244043-1-jflat@chromium.org> <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
 <20190206164528.GA8925@archlinux-ryzen> <CACJJ=pyLqhrxka2jXtby9CUqsAr=-_oQUraH5ua3PZpgXHgdOQ@mail.gmail.com>
 <CAKwvOdm=dqScCDVTgQ71i0wtBSqezEzLr69Pxp3bZJFs+_mXsQ@mail.gmail.com>
 <20190206174339.GA19743@archlinux-ryzen> <CAK7LNAQ97h3RjKNy8f2abb7fnCaQS3TOoF2LFeGgNxeoCy0GwA@mail.gmail.com>
 <CAK7LNATAdXh4d39VfNqmLX-V-46sLwVXK+YhE1AiMCDutvUr0w@mail.gmail.com>
 <CAKwvOdk4cT=Ay2Xk4hYo4-x8=4ng9gF5rF=5RsV-Rp=q5UFNtg@mail.gmail.com> <20190207003712.GA10692@archlinux-ryzen>
In-Reply-To: <20190207003712.GA10692@archlinux-ryzen>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Feb 2019 16:40:03 -0800
Message-ID: <CAKwvOd=MfBvhn=naQLcZ33gzTYC+Tf4-dx+Y+09zbx9diRK01A@mail.gmail.com>
Subject: Re: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jon Flatley <jflat@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 4:37 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Feb 06, 2019 at 04:30:21PM -0800, Nick Desaulniers wrote:
> > On Wed, Feb 6, 2019 at 4:28 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > > BTW, it would be nice if kbuild test robot
> > > could test building with clang ...
> >
> > Is "kbuild test robot" different than 0day, kernelCI, or ClangBuiltLinux's CI?
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> kbuild test robot is 0day (that's the name the emails come under when
> reporting issues).

Ah, ok, I've email the 0day team about a year ago.  Once we land the
asm goto patches and get everything working again on x86_64, then I'll
contact them again.
-- 
Thanks,
~Nick Desaulniers
