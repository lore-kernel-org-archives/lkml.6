Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3408C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E69214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOgALlCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeLSQyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:54:25 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34886 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbeLSQyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:54:21 -0500
Received: by mail-io1-f67.google.com with SMTP id o13so69445ioh.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7LGwrmK0luiJrlGQV7YS0Iqs5flwfQSvDyxasNQ+wU=;
        b=cOgALlCKBap4r8ae62S1E9H1fXa8Qrslsy+GmZxmVIJdNNAuPxAyqC29kxdfHkF4Kx
         hK6B02gRL++OriP5HBItUO3vcSCqYI7BAdgyfH8xDsZr0wquSBxPP6to3LLwf8MSaJg4
         rg90Ro8ctoKzb1dRl1u7ia9HGsPm6/xwucIkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7LGwrmK0luiJrlGQV7YS0Iqs5flwfQSvDyxasNQ+wU=;
        b=U/JOMWTqF9t/bqFrXGWAdgFIJe2wu0k/unp5LgP/U+HssfyDK/w8cS+cuCKpQc2eND
         2CfhgGJKmjDajCEOcIFf4KivhhjHoDHtTor+jT493tGiWN/EMVvN1O6hYUeJErBJEreX
         0N8oBGhgUDxPhLsjOUn3bJvPphc8CiJxQvQT6xzM/VLTxQTPR88eU7KfQdtGCrPkJNBk
         uMehpsb++TyenJW2xhnLyhA660oSEVVNJvmHVt0F3p3FJU9+rjM/hmTQsN5bDZpRnlqk
         pnWBXEPaw0FQPdnbFpB8zZ02uBHj1MUauN2Et7KAkOZt+hi7hpiiqw7hVmCHH8Jj+9pF
         rlyg==
X-Gm-Message-State: AJcUukcxeRWNCk400yaXidW/jEASBiOLjkylb8ZILe163S4MfhI2SxLJ
        qHF754D/zMVJAeO//bQU9sMJUkl9PDPjM6QWymMEWg==
X-Google-Smtp-Source: ALg8bN6KhcimKjhPL7b71bROEYVaZfiv6dzVaenUWzBUgpUR9R2W+ghoCg/m+b8JXTleFJUd8g8sKifd7UcL9BteqVg=
X-Received: by 2002:a6b:6b01:: with SMTP id g1mr338614ioc.18.1545238460297;
 Wed, 19 Dec 2018 08:54:20 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
 <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com> <CAKfTPtCJBGtmx7pQJCwhcMaxyXWoh04o_C+pR6z+YVykXwvv5Q@mail.gmail.com>
 <07400c1b-d9d7-7619-57fb-b09276d7da92@arm.com> <CAKfTPtA0HQL9xsMbAH-2u63XaEJ-4mwzdBzNzvVSA8_3XyQ89g@mail.gmail.com>
 <9b008c93-c78c-0761-5ac9-cc1c3806f24b@arm.com> <CAKfTPtDqtoUOnYMPhiAoG1Utc4YY+4Xm0=NgfzC7STWJDxiuYg@mail.gmail.com>
 <7a1aaf61-c352-69fc-b990-861bc2aef85b@arm.com> <CAKfTPtDk8z_aBapA3FM5Af1benOyqYYcTpMVWZ9KsjDP7wSJ4Q@mail.gmail.com>
 <6afedeb0-62bc-27ec-56f0-107be22d2494@arm.com>
In-Reply-To: <6afedeb0-62bc-27ec-56f0-107be22d2494@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 17:54:09 +0100
Message-ID: <CAKfTPtAtf4WMu-eLALfqn3-sKru58=uH-yo2SFygaDfmVoP0Hg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/fair: fix unnecessary increase of balance interval
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 16:54, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/12/2018 13:29, Vincent Guittot wrote:
> [...]
> >> My point is that AFAICT the LBF_ALL_PINNED flag would cover all the cases
> >> we care about, although the one you're mentioning is the only one I can
> >> think of. In that case LBF_ALL_PINNED would never be cleared, so when we do
> >> the active balance we'd know it's because all other tasks were pinned so
> >> we should probably increase the interval (see last snippet I sent).
> >
> > There are probably several other UC than the one mentioned below as
> > tasks can be discarded for several reasons.
> > So instead of changing for all UC by default, i would prefer only
> > change for those for which we know it's safe
>
> I get your point. Thing is, I've stared at the code for a while and
> couldn't find any other usecase where checking LBF_ALL_PINNED wouldn't
> suffice.

The point is that LBF_ALL_PINNED flag is not set otherwise we would
have jump to out_*_pinned
But conditions are similar

>
> It would be nice convince ourselves it is indeed enough (or not, but then
> we should be sure of it rather than base ourselves on assumptions), because
> then we can have just a simple condition rather than something that
> introduces active balance categories.

this can be part of the larger rework that Peter asked few days ago
