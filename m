Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A923C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC9C21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo8mb7Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfAWRke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:40:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44760 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:40:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so2678188lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 09:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9/S//bsRrBeO3lP8Y0yjHyxV2Cqd+9MdiWa2iKSttA=;
        b=Fo8mb7Bv7syH3Fy6CwtJ76OnhNA22FeKkr1zCi7mgV3XURaixSIXpAAdKc9gZzNuwr
         gbAVMYSdxXu7AKNB2IhBbjkM1PRW5ha/r7iEg9KwoJLZ5vLuDQbPlSvusxzqTB81jV1E
         /Iuoul9nk0q9EDz9j1k/AF+nah5FqNiqRde7UvFKrijCOg9wrfoaHtJif6QiqmNjtGwS
         Bpo6+ZmGODoowL+7/IG7+WNi/UfojK79cayVuZIBVHiO/uQm6+C6aSs/pzqOevAiq1/S
         ERVf7/IACcUWEGCpxP3vSLFQgZVbORkZpIN9OIn8a+cyxFo+vSEZX8L73E6TS3YiRVZw
         804g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9/S//bsRrBeO3lP8Y0yjHyxV2Cqd+9MdiWa2iKSttA=;
        b=pj2vcqDQqs5zZ5PrnSMVTdz8cgNRcWjrG4qjX9bssDaiNBYHDQZ0gnWu9vqeALaSok
         y2jGwpe4meyrA/ufIEtbUA1xa6/rOdPGJHfJJBfblESx6wCJbUO8ZRJM4Va2KJeExAlg
         QMMysu49wU46bXYe/v6t2wV0bMTSqz9Lv9JOua/fJZpqeNvRuq/ogwjO0YAcMK5ipvgT
         aUKceFuAVHXuQ1pfMHsIapSzpFaYhigY71fle5QMrHGBoHX/hh/ouht55KR2vID/cnRg
         qjK7/mduJA5wkjGV/iLxHaj3kP5wxsRi7O181Ni9a6Yjb9EkDAfqt10JQ1/W8PnPCj8X
         w4Ig==
X-Gm-Message-State: AJcUukdpFNQdTyjOsBAUr6hO2TtBFMYqh+3V48ALTZr62iyuHk3o6Qa6
        u9I/G9n05ZL1HvMi+S4/D8wR/T4GnSiJsfDcmZg=
X-Google-Smtp-Source: ALg8bN6By4nMLLqQ0rJzFFtPfE/VmOOHZwDQyI9wxWhfx4l+W+brMZL6z/xm2nSpjUjoenzY9NllZu6qgb1+ADj8HbA=
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr2859313ljd.45.1548265231879;
 Wed, 23 Jan 2019 09:40:31 -0800 (PST)
MIME-Version: 1.0
References: <90cb9f5e-c0b5-dfa5-c6bd-4808dc47c799@redhat.com> <CANiq72nwuD8FWRD7eSbofqvQu2=dCH8sovjFip5OncQwoWqdog@mail.gmail.com>
In-Reply-To: <CANiq72nwuD8FWRD7eSbofqvQu2=dCH8sovjFip5OncQwoWqdog@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 23 Jan 2019 18:40:21 +0100
Message-ID: <CANiq72nnVXPQafBjEXgi_wXh6zpaiBP3-68gG+SnJa3sz08rVA@mail.gmail.com>
Subject: Re: New warnings with gcc9
To:     Laura Abbott <labbott@redhat.com>, Martin Sebor <msebor@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 6:17 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Laura,
>
> On Wed, Jan 23, 2019 at 4:27 PM Laura Abbott <labbott@redhat.com> wrote:
> >
> > There's also some missing attribute warnings. The majority are caused by a
> > missing attribute in module_init/module_exit
> >
> > BUILDSTDERR: In file included from drivers/scsi/hptiop.c:18:
> > BUILDSTDERR: ./include/linux/module.h:132:6: warning: 'init_module' specifies less restrictive attribute than its target 'hptiop_module_init': 'cold' [-Wmissing-attributes]
> > BUILDSTDERR:   132 |  int init_module(void) __attribute__((alias(#initfn)));
> > BUILDSTDERR:       |      ^~~~~~~~~~~
> > BUILDSTDERR: drivers/scsi/hptiop.c:1704:1: note: in expansion of macro 'module_init'
> > BUILDSTDERR:  1704 | module_init(hptiop_module_init);
> > BUILDSTDERR:       | ^~~~~~~~~~~
> > BUILDSTDERR: drivers/scsi/hptiop.c:1692:19: note: 'init_module' target declared here
> > BUILDSTDERR:  1692 | static int __init hptiop_module_init(void)
> > BUILDSTDERR:       |
>
> I have been discussing these new -Wmissing-attributes warnings with
> the author, Martin Sebor. There is a new copy() attribute that we may
> take advantage of, but I will send the patch I have since you already
> found this :-)

[Cc'ing Martin, I forgot!]

Cheers,
Miguel
