Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D276C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF54D2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0rkUeJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfBFRtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:49:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41951 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfBFRte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:49:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so13373687otk.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rRMVWcIepJ780DiGU65IJUJ+FeBxKihEfR1/RuIkls=;
        b=c0rkUeJXHWQAog5OCqvrgIB4oKC94nuDCiTyHdVBmx/Vv7Oi4UVLorFPf1idqeCbbu
         YeIg0K+LRZLk+1jxWsElcb5WTobQaIKlQTYYXbV3qf3PGIskRCXELaJkRTtiiPT4Vn6T
         5Rx+Gtt9VGDA0Em8QY3qRV1E1sUDL0amdLR5QDg1FV1IKxYzq8gdEyFYEsUMDdv8D50m
         oTdSnK2hpWMBAqMvaQZtXm4cAYGwFvSD6vG45euieSw2ByH8tsYDyvMLWHTjJIaW7p/O
         fw1wDBXpa5svPIbbd6lI84kcOi9KA6fZFvFSR6PgJZN4t4BmdlGA8K0W37FqjFlZCkP8
         VeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rRMVWcIepJ780DiGU65IJUJ+FeBxKihEfR1/RuIkls=;
        b=EnYfQ5zGOabPJhCcS4vTvRULUXmGUFwaanJJ/GLrgkAWwPt0ntDzmNBpSQCCJqyUde
         SUHBQ/SFjoz5K7KPEzewJyw498wZu9ZKUD4E08FEAlirbBDtr/V6tNXYACXf4cKN5rw7
         i73IHTTYXAvfGCJJxKpSBtHyvbJ+ucMaLSJ0sZVQFPAPn0ramXzIKUNj2xgca+Fu2zgy
         5RJ0Gg6inoEpLuQKdFA3Upoj0ioajU3iWalwmH0u2q14xEqtlsf08hRujJXSxzeGiz3e
         UCt+Tp7I0WsIyyXBStEmVwTz9CxG3r7Pnpqhxi0f0HZlUUyYJfO2EB93vddlsWABrX+X
         lgPA==
X-Gm-Message-State: AHQUAubEwRkngceYAPnQEodnJSQpyCQZYj768K1Nn0hgPy7XucFWyfgw
        ThDGMR8aVftQmXm4WPHWAdvoUAqNs52air6LOOQ=
X-Google-Smtp-Source: AHgI3IZHXRbqo5Mh6CNOpZe1WXwSlub/z2BlsbFrnHgiDvJU/XoIJTLwPDD8z+BG4T7ImsImPqIlQ9MAJ+hir7keyfM=
X-Received: by 2002:a9d:61c8:: with SMTP id h8mr5959942otk.279.1549475373118;
 Wed, 06 Feb 2019 09:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUsq55EUKa0rYCeQ62VanhwNUxs-pfkJxUwqd4HO3m-Lg@mail.gmail.com>
 <20190205184355.GC22198@kroah.com> <CAGngYiUMuM_ZxHKVWRihDHZcMncvTwR6Sz1zGNJLrGpyhhT1uQ@mail.gmail.com>
 <20190206164657.GC8466@kroah.com> <CAKdAkRQbCj59_Cw2RqpyDEU2zzn4ajOjXF44NE2LJ7QB8-DLtw@mail.gmail.com>
In-Reply-To: <CAKdAkRQbCj59_Cw2RqpyDEU2zzn4ajOjXF44NE2LJ7QB8-DLtw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 6 Feb 2019 12:49:22 -0500
Message-ID: <CAGngYiUh1o8yMjDAO5VFPJ-Jw-fF3q-2NHnz-+DNaEpt7SmwZw@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 12:30 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Yeah. But devm irq gave most trouble because we did not have enough
> devm APIs so we often ended up with mixed devm/non-devm usage and that
> is what was causing most of the issues. If we can switch everything to
> devm then devm irq is not that troublesome.
>

It sounds to me like _incomplete_ devm_ is worse than no devm at all.

Imagine a devm_ resource depends on a non-devm one:

int acme_probe(struct device *dev)
{
  ...
  r = create_something();
  d = devm_create_thing(dev, r);
}

Then remove could get us into some serious trouble:

void acme_remove(struct device *dev)
{
  /* r _must_ be released here, we have no other place to do it */
  destroy_something(r);
  /* here, d is still alive because it's devm
   * which is cleaned up _after_ remove().
  * Now we have a live resource using a released resource.
  * use-after-free anyone?
  */
}

This is a more generalized version of the issue I originally
observed, where r => struct work_struct.

I'm sure there must be plenty of these around the codebase.

I wish we had a Coccinelle script to catch these, because it's
one thing to fix them today. More will be added tomorrow.
devm_ is so elegant that people frequently use it without
thinking it through.

I certainly would have, before yesterday :)
