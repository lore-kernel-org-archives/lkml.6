Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F21C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6411206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uBbng7OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbeLNROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:14:31 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:33159 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbeLNROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:14:31 -0500
Received: by mail-lj1-f177.google.com with SMTP id v1-v6so5554035ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWS1bl8UOdf0X/EUTkl39G4qxSuN42uBWNgdvIEDUpI=;
        b=uBbng7OX7Rgsmxo3aDhV9TkE2IWQpQ0SEhxqhYJCa+QivQ/7DSTWVj8YhIHx7fbSsj
         dKr0CPtOR5MD6F+EajESqmm6PRAR9m4duAo/Fn3yFkiko2DVCXxMkTMBCgrJi494Ww3Q
         Yvxntw2VmAOaPFfFpUqmZZvcHpdpRasHM9hZ2UB7qfQHD9XizH4ALqP4COBxKMdayASC
         kBArrlNeMZGNbw30SsBgR7lotOvwq5PPsOU3dHZkPoZi8Ph2rUVut8v+C7cQ+R/F5LaC
         aUaEkfZy86ouqHsQs/vxbbWyRxsyJpa25pEcFlv7L/S6t1xs9uUvq2JCebL8Krz6BljS
         8ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWS1bl8UOdf0X/EUTkl39G4qxSuN42uBWNgdvIEDUpI=;
        b=fxYL4i2zsBQUaHfZyFfGSzCzAAKaTM8VBrZEjoMKnYuxpnKdGbA47ltnfYbwwO/XPy
         wYHKve1aNyBPm5T2yGAMHIspuB6QTd900Viuwh8bXMn1NNjJx6ZNLYFhqMEKHaCDbzIO
         wqCSJPQFakJ1G8jP3a0HyiAGkrgx0I8AodmMUAbGnbiM6m5cQ6UWMdpQP5V+CoNKfDTx
         x1I8kBuy2MCyENsmRtweu5c4raQk32cVaTqd4datTWHHsqpfS5wxeALe0XnmlH/rnzGQ
         817Be38zneKy4ZbuTQoAJJWpCC9t+LQXbsLEETet5S7RLanKEBk9O/dFM5CAmpCN9PCc
         rryg==
X-Gm-Message-State: AA+aEWaRuvx6xgTZfBVda2pINIOHp5QUnm9RguZau3JTxVjgydtygFMC
        6rgensEUYq7cwGOrCpDvnAdqbLIj60T3UUZYWb7J
X-Google-Smtp-Source: AFSGD/XlPKCfRUv0O2fTebtrgcnmrvbOxmw8ZBfjw2x9ZTSa/11X0m3E0cRORjI7wOr88OFGwMUcX0vRwR4c5inbDOg=
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr2588909ljj.18.1544807669123;
 Fri, 14 Dec 2018 09:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20181209062502.16308-1-yuehaibing@huawei.com> <CAHC9VhSCnZ4HfqA5ZR3xEzrofGZobLhbHr_N2OftkzW=Z6Q_YQ@mail.gmail.com>
 <fbe38a4d-9922-e2c2-76bb-0e110d4e678f@huawei.com>
In-Reply-To: <fbe38a4d-9922-e2c2-76bb-0e110d4e678f@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 14 Dec 2018 12:14:17 -0500
Message-ID: <CAHC9VhRXK0vDTKDeVYc4n5nP32Sx1=+c6eFp+_d_csT1eBvFGw@mail.gmail.com>
Subject: Re: [PATCH -next] audit: remove duplicated include from audit.c
To:     yuehaibing@huawei.com
Cc:     Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 8:33 PM YueHaibing <yuehaibing@huawei.com> wrote:
> On 2018/12/14 7:42, Paul Moore wrote:
> > On Sun, Dec 9, 2018 at 1:25 AM YueHaibing <yuehaibing@huawei.com> wrote:
> >> Remove duplicated include.
> >>
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  kernel/audit.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/kernel/audit.c b/kernel/audit.c
> >> index a0a4544..632d360 100644
> >> --- a/kernel/audit.c
> >> +++ b/kernel/audit.c
> >> @@ -60,7 +60,6 @@
> >>  #include <linux/mutex.h>
> >>  #include <linux/gfp.h>
> >>  #include <linux/pid.h>
> >> -#include <linux/slab.h>
> >
> > As discussed previously, I don't want to remove header files whose
> > declarations are used in the source file.  While it may be true that
> > slab.h is included in one of the previously included header files, I
> > like leaving it as an explicit include to help document the dependency
> > and protect us from changes in the other header files.
>
> The slab.h is included twice in audit.c , It like this:

Yes, you're right - my apologies.  I mistakenly thought this was a
patch similar to the ones you sent earlier and were rejected; I should
have looked closer at this patch.

Normally I wouldn't merge non-critical stuff at this stage of the
development window, but since this is such a trivial patch, and easily
verified, I'm going to go ahead and merge this into audit/next.

Thank you.

-- 
paul moore
www.paul-moore.com
