Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62021C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091BE21776
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acOUdiED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091BE21776
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeHMXyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:54:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42646 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbeHMXyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:54:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so8080567pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vN2lx7to1HrLGzgJbzM12SwmOEIgdB18P5n95f9h6NY=;
        b=acOUdiED/U8TECCqbKsN2EVawU90gInUxN4XtmN2wbl9Zma8TzPdqu2r9x+LtKmbD1
         I05Yhou6V2nJJ4HKNAZ2BNtDS2NdfWvxwjrlpbrqZCygec/rm5vuC+T6/y+wpUYxZcup
         m2Is3sAtuy2bAMt13KRS1IOGzCyouKvXtJuCte0GoIO9f0wVCgZp8u8I46SbDbVqA/LT
         8y2s/xkry8WpELpgx57WmDw78hqY3OoTptVlaVMcqRDalc7pljiEimTCFnhT+j/gZpzy
         UPB0rRsrzLw/ivQQuv3lt//L1H1Azz1M+ajgGAzdRNeOdbF4YQ2Fwh3oRT+lSxPSJGdc
         CLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vN2lx7to1HrLGzgJbzM12SwmOEIgdB18P5n95f9h6NY=;
        b=K/bD90I28PJ7xA69QDwEpwAeDPd9L+hn0OKcgsmuVwtQAgW+jlPsHtvSlAhF4BOUk3
         J+aQWQSyhz/XtL4bd3SiHhC8mOf9u4yMi4HONLJcxDqyP8o980V6Tz7X6puLEy+joWIL
         Z2YY/6tb37qMpu56Uun1myF1coJcLVZUVJoTknvdm8vPAsubZJiYO4Oe6Er5ebGRvQXL
         JYIIW71A6tmxpIddZSFz29V5mLuQRM/DnOgj8kDd0W+p5OnTXm8M3+rMJGNjGxHQ7WiB
         lYxvAlfm9vNjQxvVN6ykZT2qwfR2XEEzeNfPu5zrkmGMKgETtVCfRAWp+pfpOV0r05NT
         a3EQ==
X-Gm-Message-State: AOUpUlHUnjxpIAmnW2oxLfFaWA3KDQfteffp6GxScEwIbjOSVhjWwY8h
        zzgYcUx2ODjhhXSktUrANU/Is0fvSOLom+ntE+JZXA==
X-Google-Smtp-Source: AA+uWPwrYRMcu6E2cXPy+qlTkxBfNZ0BzjvB+ulX0knLn/NAIZ0gYNL4VZ/tNykvq0INXPB1vsKqjYL3hcLiuN/iwYk=
X-Received: by 2002:a62:106:: with SMTP id 6-v6mr20842893pfb.168.1534194619607;
 Mon, 13 Aug 2018 14:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180801215759.103758-1-ndesaulniers@google.com>
 <20180802.144234.41564686794492805.davem@davemloft.net> <CAKwvOdnp7R094sbsyKi921ZVB8BD+d-8L37mcPv0UjMMF4QqDg@mail.gmail.com>
 <20180802.151740.166085629835691260.davem@davemloft.net>
In-Reply-To: <20180802.151740.166085629835691260.davem@davemloft.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Aug 2018 14:10:08 -0700
Message-ID: <CAKwvOdkvk7wN_iypAa09xhju2-XE60Nn16QjAKzK4mZkEBfNBw@mail.gmail.com>
Subject: Re: [PATCH] inet/connection_sock: prefer _THIS_IP_ to current_text_addr
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 3:17 PM David Miller <davem@davemloft.net> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Thu, 2 Aug 2018 15:10:00 -0700
>
> > On Thu, Aug 2, 2018 at 2:42 PM David Miller <davem@davemloft.net> wrote:
> >>
> >> From: Nick Desaulniers <ndesaulniers@google.com>
> >> Date: Wed,  1 Aug 2018 14:57:59 -0700
> >>
> >> > As part of the effort to reduce the code duplication between _THIS_IP_
> >> > and current_text_addr(), let's consolidate callers of
> >> > current_text_addr() to use _THIS_IP_.
> >> >
> >> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >>
> >> I'll ACk this for now:
> >>
> >> Acked-by: David S. Miller <davem@davemloft.net>
> >
> > Thank you David.  Should you take it into the net tree, can you please add:
> >
> > Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
> >
> > to the commit message? This will help us as Nathan stated previously
> > in this thread.
>
> Why in the world is this a stable candidate?  It doesn't fix a bug.
>
> My understanding is that you are trying to do a consolidation of code
> and clean things up so that only one interface is used.
>
> That means it should, at best, go to the net-next tree.

David,
Can you please pick this up for the net-next tree then?
-- 
Thanks,
~Nick Desaulniers
