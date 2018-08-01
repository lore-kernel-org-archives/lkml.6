Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F42C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDF420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxPysqg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDF420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbeHARXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:23:36 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37402 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389729AbeHARXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:23:35 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so9914083itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYJunNEVWlmzNNDtapRgMnjsKoYuiuXI8lWxs+kk20E=;
        b=jxPysqg36iwmptkMEqeHklYxd+Jsg58smCvOJlJhaM2Rxvcpbz33A8haYs5Ot0dnZ6
         TphrQCMIeI7jI4o6vpcYRwjF887dvLclodjEEPvvjIvG4muc/x3Ov8uiEbcsV8lHpeam
         /HZJIlB2oM2fdyuqBFXu2PiaKy5T2/tUaGiPSHkPbvHS0UngtuhdWD3n+T80Eqqwy0Fd
         UInhEwdYqGZVOkxrezhXWd+g1W6sdhHVrRD2X5K/puKkkiLdM8wJMKbPN7qw1GuzMe3E
         GKs6mn1FnKu+uF8lCJPUEzUCtqgUYwsCCOtg8q2HiUMDSclTMFGqanzd+eZAbgeUkVfF
         dS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYJunNEVWlmzNNDtapRgMnjsKoYuiuXI8lWxs+kk20E=;
        b=MHlSS82c6eEAHubvIJ0a9xC6qeEavSfmD2IgqoJnnT4pHO2uCgDlSv3D/cDVjWA4Ro
         nxgIaN3VSc8pjoglRBsh9SlXyxSsfvaaFDeN7llhWp0sbatzcQ9ot2ZG5VM46LCqsy1D
         GnbAlcSqUoeMNHTUAfmCRkNHvPxANa+k7MJt40JKsGWUbzGUYAB2LLayfbgQT0gloSU/
         YrPlhT6rXRkOkUC6bwRXNeyibgSQNSf6G7D6fW47O2g4mPyTQXSOWyFmdNZ0tWj6vh9r
         aC2tIjy9tGB3n3BfmKhwaRCLP7Gfx0G7cwEMf2nfNHJj4Z5/na7o6Zg4s7Az/3srz5sB
         Yb5w==
X-Gm-Message-State: AOUpUlFuFKalaLGfygJ+WA7qbfi5dsmfTOnLDF0oyHFsroysuQtL9F/O
        lLF2rfztGr+z16iZjg7UZZaetcnUIA9cmJEBwU0a5w==
X-Google-Smtp-Source: AAOMgpeaAUnTgHRtAIBvsjKpV+Wf3wus7Kb5t7NbFNNTyXDBf5VigUyjPb+Vhf8bDM3Vg9+S56Ee3uZhQF76iPfGMHU=
X-Received: by 2002:a02:b687:: with SMTP id i7-v6mr24993805jam.55.1533137838525;
 Wed, 01 Aug 2018 08:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com> <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
 <CACT4Y+bLbDunoz+0qB=atbQXJ9Gu3N6+UXPwNnqMbq5RyZu1mQ@mail.gmail.com>
 <cf751136-c459-853a-0210-abf16f54ad17@gmail.com> <CACT4Y+b6aCHMTQD21fSf2AMZoH5g8p-FuCVHviMLF00uFV+zGg@mail.gmail.com>
 <01000164f60f3f12-b1253c6e-ee57-49fc-aed8-0944ab4fd7a2-000000@email.amazonses.com>
In-Reply-To: <01000164f60f3f12-b1253c6e-ee57-49fc-aed8-0944ab4fd7a2-000000@email.amazonses.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 1 Aug 2018 08:37:07 -0700
Message-ID: <CANn89i+KtwtLvSw1c=Ux8okKP+XyMxzYbuKhYb2qhYeMw=NTzg@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Christoph Lameter <cl@linux.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, jack@suse.com,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 8:15 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Wed, 1 Aug 2018, Dmitry Vyukov wrote:
>
> > But we are trading 1 indirect call for comparable overhead removed
> > from much more common path. The path that does ctors is also calling
> > into page alloc, which is much more expensive.
> > So ctor should be a net win on performance front, no?
>
> ctor would make it esier to review the flow and guarantee that the object
> always has certain fields set as required before any use by the subsystem.
>
> ctors are run once on allocation of the slab page for all objects in it.
>
> ctors are not called duiring allocation and freeing of objects from the
> slab page. So we could avoid the intialization of the spinlock on each
> object allocation which actually should be faster.


This strategy might have been a win 30 years ago when cpu had no
caches (or too small anyway)

What probability is that the 60 bytes around the spinlock are not
touched after the object is freshly allocated ?

-> None

Writing 60 bytes  in one cache line instead of 64 has really the same
cost. The cache line miss is the real killer.

Feel free to write the patches, test them,  but I doubt you will have any gain.

Remember btw that TCP sockets can be either completely fresh
(socket() call, using memset() to clear the whole object),
or clones (accept() thus copying the parent socket)

The idea of having a ctor() would only be a win if all the fields that
can be initialized in the ctor are contiguous and fill an integral
number of cache lines.
