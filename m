Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15662080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnuN5iTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbeLOIqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:46:30 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39154 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeLOIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:46:29 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so13150981itl.4;
        Sat, 15 Dec 2018 00:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRdWugCzhLlThSiyV3/dOqa6S724s+hG6NOiFfLl4ZI=;
        b=hnuN5iTmhUZrAwBaZSA3JH1v+xUlSX6sA4D52Pu+GuGcXRoxIbPmtsDoP0xhlT9wM2
         AyR/zeomJydTZehpsHQviLDymQuQ2s2yfvu6gENsC5KG0rYwp3Bo8qxtel/TNDke9Ma+
         TvJ7/Sr9EaG6LxEkT6ek6jlO+t/YV1MXHibWoc3SIHEpq8wvJe1WFaVwIw1/m8PwQ+IU
         M8zmXcJbNZYMHg9WCq9kPf8l2JFzNd5Kd8yZEph+xJM+VIPN2kvdemgzryYI3OqGBsah
         /ffU2cyiQcW7f7CDNNa2xKKL/Wo8vfPLFx7oHriaLBln4es84z1JaZcCoafA4YwnRHKr
         Zajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRdWugCzhLlThSiyV3/dOqa6S724s+hG6NOiFfLl4ZI=;
        b=Pfs/U380ivIe6sBu+8mDjHvtcLT7OqpeVWoJmhDyNacQ9ZpUVRTEed5yukjHCZFnQ4
         FKpHJHgAqOm4pWi9WAeffZw1LO3FQN69BAQ7fDvwhBM0sDEVqES+1RQGP2SIa9L9uBf8
         TOi/rMABtJ7/8ZKoCvCusLPByhQdkTA4NoL5JU9Q4cZ5yjw1t82ZSqDrr6HeZwRTkbek
         movnGGjV6HHAAmEeKwMneonqwhyx+CZMBNwPSqXsUitrPq2Q6DtQ8fS0x20ivS7xPxJs
         ulfHT3oRyUjtTOLUmM3VwyG82bv2ay8rZ97ENnU5rm7Y7+zIdCte6cevjlp710M+YXEE
         guQA==
X-Gm-Message-State: AA+aEWatx2CD5KxsTc5H+GBh2JTEomcBSzX3XX0MQrX9fRkyyT7jZTAK
        H3jefh2K8daXKP/wSA4P/8ndngCit1bR/eZB0VRJxBB5
X-Google-Smtp-Source: AFSGD/VMUOiWu1w36OXEZE8kZdHqqn+R+NVO8yjr3CdUeyH0L7GLdYAOrKmHPiKoGFqm8pSK/kczbkII14ApV/xBL8A=
X-Received: by 2002:a24:7b90:: with SMTP id q138mr5717255itc.37.1544863588966;
 Sat, 15 Dec 2018 00:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20181201015154.4718-1-tiny.windzz@gmail.com> <CAJZ5v0g6R40D-OrQeZ=wAj+epPaYacLTnCVLLHfzUrpNKUv2_w@mail.gmail.com>
In-Reply-To: <CAJZ5v0g6R40D-OrQeZ=wAj+epPaYacLTnCVLLHfzUrpNKUv2_w@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 15 Dec 2018 16:46:18 +0800
Message-ID: <CAEExFWvymtA_-6GWtO5=YpgsbKshQZWs2tgUUh5ZjOoibN-kJA@mail.gmail.com>
Subject: Re: [PATCH] driver core: remove define_genpd_open_function() and define_genpd_debugfs_fops()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Dec 1, 2018 at 2:51 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define such
> > a macro,so remove define_genpd_open_function and define_genpd_debugfs_fops.
> > Also use DEFINE_SHOW_ATTRIBUTE to simplify somecode.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> It would be good at least to split the genpd changes off into a separate patch.
>
> The regmap and comonent changes appear to be independent of each other
> too, so I would put them into separate patches either for easier
> handling.
OK.

MBR,
Yangtao
