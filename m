Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5068C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8076A222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP8Y0WMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502043AbfBNPXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:23:24 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33692 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404698AbfBNPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:23:24 -0500
Received: by mail-ot1-f45.google.com with SMTP id i20so11134799otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 07:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nqvRe+zrm5fIjF/fWIXWwavfVKCfBlXl7VecBMIHoA=;
        b=YP8Y0WMBbl5Ir8rnHiP08cmDcKigZ+OljEX/hfK3ZeHLj8GZ/jrXlgtSZsarIPJVY2
         3POT4hyAyEvOALTyghKWZjubbh+VbOsfXkJewcbECxBvHqHi2FVAZS1htSJJWo0M2QDv
         gAoQ5gw0lHzxSvjNZX2RlfV5Qk5l0dTU2B1n80dpeRDGWzTTwnDQo3ayJK1sbyvtwYTX
         kca2wcFm559KUxRN2f4+Ufpzsm/s65pz23rP+Pobljw5RIr7vpQDN3yO6HCr+1QqFoRh
         kQsuKlzzJyIMS8EV0Wq1v/UtaKfku5GTPRa+SAR8vz3xNuidJWy7/E9pgsSlgjZtYYpU
         7fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nqvRe+zrm5fIjF/fWIXWwavfVKCfBlXl7VecBMIHoA=;
        b=SRap/6nwjTm41i8L6XjZn+8XhpcK6+UaM6msDwdIZdNEz61Acylp7QmQmNEEzhm9ds
         E4ZUKxdgRnTu9ikBg1aU1csIgPoUKuJ3uZWGf4rVpCr6I5h3+9muzo01asa/cGxHYjE/
         MvqqZLj/VZWuG7ba8dev2BW/4vRMT4X6QN+sl/jm6Spn4XeSULVP4RESLqleT2hpd5mu
         /sIB7Ubv9yl6G1MsjHgMx3f/ltFc7XO5hB16f6qXImvObZ5vybqMvC54f3kgl4mxG2wN
         y42dNYZTD+DARPg6+wP1rYGvkKnVmHWx4Np5C/wvJx4/rlNxLTolK+RuKJr/oB7PtsGp
         h61A==
X-Gm-Message-State: AHQUAuZkutjmm/nedGN7Uz9aBKAvPewQIsKvSNGVO8EUr9ERJVG2ajhR
        fs9MOgoFCLhJL01v1ujrDXzgzQJ9Mk6wtCHCdjWetA==
X-Google-Smtp-Source: AHgI3IbuJHg+saypEeiE4uCZHu+MxiQLki9QdN7HJ+9hiLks7WJ8Tql3dEnkJcDdyH7BK64EG9+RPHkasUV1eXA9ic8=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr2574266oib.169.1550157803437;
 Thu, 14 Feb 2019 07:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com>
 <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com>
 <CAGngYiWBdXc0VzpjBQmVyKi+E2rVaO2WsoiPLho0bxHnrdiDKw@mail.gmail.com>
 <CANiq72kw1=XhGhy8Ac2R9y3ws_jjo0YogoQ5D=tO+7oat=8swA@mail.gmail.com>
 <CAGngYiUwaWPp7=TTAN3tqPz+D+1GsPDM7uFNYY1XSTYMMm+=aA@mail.gmail.com> <CANiq72=1f7NtehzbzL0G-qHSvORAfeyYXYHjzfBkBQX46VBxsQ@mail.gmail.com>
In-Reply-To: <CANiq72=1f7NtehzbzL0G-qHSvORAfeyYXYHjzfBkBQX46VBxsQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 14 Feb 2019 10:23:12 -0500
Message-ID: <CAGngYiUTBQ7Xqm8e-w=fn=8t8grLifsBcRzKEC4prW_+yOAK7w@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Wed, Feb 13, 2019 at 8:11 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Indeed! Note that I didn't mean to say they are trivial issues or that
> the solution is simply to replace cancel_delayed_work() with the
> _sync() version in all cases -- only that it might be a good idea to
> suggest its existence (instead of only suggesting devm_, because in
> cases like drivers/auxdisplay/ht16k33.c it may be the simplest fix).
>

I will try to get your suggestion in, as I move forward with this
Coccinelle script.

Cheers,
Sven
