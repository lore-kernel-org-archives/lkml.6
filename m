Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C36ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0357620854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CvGN44tZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0357620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeGXAVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:21:04 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34984 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbeGXAVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:21:04 -0400
Received: by mail-io0-f196.google.com with SMTP id w11-v6so1982865iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzkaX2CqSXKZMZfTzAEYA6lnWjcAl9XM/L6ewZiNrgY=;
        b=CvGN44tZWJiWBjrWH8jm8/7bnacgx9CB/LQlExtwleuoQcoWmJ4pnFWfSsNgDYHgwe
         nLXryeNLzZKLmI31dipUof0Al78hVb12szZiFNSg/30Zo6QVF1G0LbRx1iiekZy6B6F9
         t8YEtZ+nj8k8HS0enyl5gb26AU1TL97y+YcNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzkaX2CqSXKZMZfTzAEYA6lnWjcAl9XM/L6ewZiNrgY=;
        b=Bkf+kuav81YPsaSKIdDRKGcaP59vnp9ce7QBAKfg99Tt4UbmyaPn9RzgSnzYWxKo0+
         dObJcUqOXVJfVGsuFjycb6NyhA5gwy6/QceqmklWDESUrNje6tSBh7b29YiiiucQJzOW
         brLAjtUZk5U2PmVRWKvx5xeNWaT7YLuL4pCQ7rT9mrdMAzjkk2Tr9NRp/Yf9HRR51mCu
         0G4lRdudQkUbxwqbffOdCqC/YM7L6pLo2BuUpvYbafw+Wi/PjszCQyANHN9x5BTn6KPe
         e4DI3r955JPKL5529BrTuocxMXg9q1MbxFOvf18CRaDoOHCIeLO5SV8OnilxMiqYQhjt
         iOBQ==
X-Gm-Message-State: AOUpUlFsiQHHgkM1xA1UxZ1tVlEGylzwFsRHA1xhMPJ9SUx102dFInws
        8SQ1tuSdYBo7Zfmn6cv166OPDcFc2sHop86B0jM=
X-Google-Smtp-Source: AAOMgpejC8LJecZa6mCz5UToA0yk7jliVtwxuLGixCxd5T4JxkAvBn3AWcXkfo80oWwP2HbMtqR/RBEGBfxU3ZxFYz0=
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr12251719ioh.259.1532387853214;
 Mon, 23 Jul 2018 16:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
 <20180723204617.GA14487@roeck-us.net> <CA+55aFyuaEGGksOxv3aAp0THYkAapap-JY65A0A81S0qUE0S+g@mail.gmail.com>
 <20180723212330.GA7441@roeck-us.net>
In-Reply-To: <20180723212330.GA7441@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Jul 2018 16:17:22 -0700
Message-ID: <CA+55aFw3tRe70mUgV70oi6xBwSLx0h_supRGoNUHgrcSGxUgeg@mail.gmail.com>
Subject: Re: Linux 4.18-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 2:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> >
> > Martin - can we just remove the
> >
> >          select HAVE_GCC_PLUGINS
> >
> > from the s390 Kconfig file (or perhaps add "if BROKEN" or something to
> > disable it).
> >
> > Because if it's not getting fixed, it shouldn't be exposed.
> >
> The problem only affects 4.18 - the code has been rearranged in -next.
> Only, in my builders, I can't disable a flag for individual releases,
> so I just disabled it completely for s390.

Well, I'm not going to release a 4.18 with a known problem, so in 4.18
this *will* be disabled if it's not fixed.

The fact that it might be fixed in linux-next is entirely immaterial
to the release of 4.18.

                   Linus
