Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B0AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF95621B31
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEk6Ic/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF95621B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbeHIBYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:24:33 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37059 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbeHIBYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:24:32 -0400
Received: by mail-ua0-f195.google.com with SMTP id y10-v6so4276611uao.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 16:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkNmsLhRlos1SBwsBAZ5DzdPrXJuslpk9MRcdMhtJcM=;
        b=vEk6Ic/R12pZNFyhXGGn2ZQyPJsvE5VrXI5ZtjawoSwtoWZtS4KuIkRBkjkQzb1WXs
         IrZSzwcWH+xQjS+0O0z7/vCVFDWf+on8QlenPGrOwejcdkWZmPtn6AeSSh4rHun2LZ23
         fxOsOf7IopGdrqFvicOXYXl7K9+WZNRB3LK4a4bm8nD47bJUrmxK0NEXEQuKayBTNDBL
         EpRd4OCVxcl9mMzYRY0JKsh7dWE+/iYa/E0OPorrbkmW3lvhHMX/jmch4AsLP2aDFR9g
         +S6yLz2UvaDD6BOfIDiVhDTJII50zH4FvnPO0NUQuzf9zIAgJScxl5/qdsKG/s2N7ZhT
         AgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkNmsLhRlos1SBwsBAZ5DzdPrXJuslpk9MRcdMhtJcM=;
        b=BQ+Mzrv4iLtcuNXnPuEoCbat7+keUUMBpkUx5KAGCuTqySab28QRNRjKOwJuDi2+Rb
         rg7rbcM8NqT0eEVC8o2jHkrtTauXvb3n43X+UrXhRdtINH7Jzc+3tetP/5Tqa9w+49MT
         WnEvCpbOTvNzviGZtS3rHAksFYNjuypzfEBvpkqeNJNzJsHHkKnzwfgkb6ncnTSvpx+k
         tQjRYGZnDiYP9fQ8XQyanqQyhfvqedw2Ch71iEmL4ncf2MgWTWJGbw0g/BtTX+prAKrr
         NU+UbSVI10HmSScy2f8tYeIOK9Rh0EvyK193xGW5VtCqydjYpu9HXbFGGkJHfxtPh1xM
         lsSw==
X-Gm-Message-State: AOUpUlFwc8AwZ1S1MvMCa5ht/LyTsV1cOe4ahqtCV9idjWXJ1lvkvrA4
        CwCnYVLIc3bfSPZ9xQ6vJ0faLvuSqyPdUnryUdWvQg==
X-Google-Smtp-Source: AA+uWPwFxhzMHAtDxeWmCHKBhgC7kUGMjEID15PGzazBs4xvlCkG8+BnuMrxcmGa6qCr3o4wddEK9HW3o0Bh5w1x60g=
X-Received: by 2002:a1f:b9ca:: with SMTP id j193-v6mr3290041vkf.139.1533769360789;
 Wed, 08 Aug 2018 16:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
 <20180808072040.GC27972@dhcp22.suse.cz> <d17e65bb-c114-55de-fb4e-e2f538779b92@virtuozzo.com>
 <20180808161330.GA22863@localhost> <f32ab99a-de28-b140-a7d0-027073055728@virtuozzo.com>
 <b4b58edd-b317-6319-1306-7345aa0062b8@virtuozzo.com> <20180808180152.GA2480@localhost>
In-Reply-To: <20180808180152.GA2480@localhost>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 8 Aug 2018 16:02:29 -0700
Message-ID: <CALvZod7C_jcNc=J0wg_wnCa2fkCjHhjoV1G8oKAmivRbvgQWxg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
To:     josh@joshtriplett.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Hugh Dickins <hughd@google.com>, shuah@kernel.org,
        robh@kernel.org, ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>, jbacik@fb.com,
        Ingo Molnar <mingo@kernel.org>, mhiramat@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 11:02 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Wed, Aug 08, 2018 at 07:30:13PM +0300, Kirill Tkhai wrote:
> > On 08.08.2018 19:23, Kirill Tkhai wrote:
> > > On 08.08.2018 19:13, Josh Triplett wrote:
> > >> On Wed, Aug 08, 2018 at 01:17:44PM +0300, Kirill Tkhai wrote:
> > >>> On 08.08.2018 10:20, Michal Hocko wrote:
> > >>>> On Tue 07-08-18 18:37:36, Kirill Tkhai wrote:
> > >>>>> This patch kills all CONFIG_SRCU defines and
> > >>>>> the code under !CONFIG_SRCU.
> > >>>>
> > >>>> The last time somebody tried to do this there was a pushback due to
> > >>>> kernel tinyfication. So this should really give some numbers about the
> > >>>> code size increase. Also why can't we make this depend on MMU. Is
> > >>>> anybody else than the reclaim asking for unconditional SRCU usage?
> > >>>
> > >>> I don't know one. The size numbers (sparc64) are:
> > >>>
> > >>> $ size image.srcu.disabled
> > >>>    text      data     bss     dec     hex filename
> > >>> 5117546   8030506 1968104 15116156         e6a77c image.srcu.disabled
> > >>> $ size image.srcu.enabled
> > >>>    text      data     bss     dec     hex filename
> > >>> 5126175   8064346 1968104 15158625         e74d61 image.srcu.enabled
> > >>> The difference is: 15158625-15116156 = 42469 ~41Kb
> > >>
> > >> 41k is a *substantial* size increase. However, can you compare
> > >> tinyconfig with and without this patch? That may have a smaller change.
> > >
> > > $ size image.srcu.disabled
> > >    text        data     bss     dec     hex filename
> > > 1105900      195456   63232 1364588  14d26c image.srcu.disabled
> > >
> > > $ size image.srcu.enabled
> > >    text        data     bss     dec     hex filename
> > > 1106960      195528   63232 1365720  14d6d8 image.srcu.enabled
> > >
> > > 1365720-1364588 = 1132 ~ 1Kb
> >
> > 1Kb is not huge size. It looks as not a big price for writing generic code
> > for only case (now some places have CONFIG_SRCU and !CONFIG_SRCU variants,
> > e.g. drivers/base/core.c). What do you think?
>
> That's a little more reasonable than 41k, likely because of
> CONFIG_TINY_SRCU. That's still not ideal, though. And as far as I can
> tell, the *only* two pieces of core code that use SRCU are
> drivers/base/core.c and kernel/notifier.c, and the latter is exclusively
> code to use notifiers with SRCU, not notifiers wanting to use SRCU
> themselves. So, as far as I can tell, this would really just save a
> couple of small #ifdef sections in drivers/base/core.c, and I think
> those #ifdef sections could be simplified even further. That doesn't
> seem worth it at all.

Hi Josh, the motivation behind enabling SRCU is not to simplify the
code in drivers/base/core.c but rather not to introduce similar ifdefs
in mm/vmscan.c for shrinker traversals.

Shakeel
