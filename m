Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4B3C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8F2217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8F2217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbeHDWEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 18:04:37 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:24731 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728309AbeHDWEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 18:04:37 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179])
        by mwinf5d74 with ME
        id K82n1y0053soyjV0382nra; Sat, 04 Aug 2018 22:02:48 +0200
X-ME-Helo: mail-qt0-f179.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Sat, 04 Aug 2018 22:02:48 +0200
X-ME-IP: 209.85.216.179
Received: by mail-qt0-f179.google.com with SMTP id q12-v6so9804622qtp.6;
        Sat, 04 Aug 2018 13:02:47 -0700 (PDT)
X-Gm-Message-State: AOUpUlEiu7BaDgydQJ8QDsb2jFascK8KR0oZkMRy09WuIsW1BL25u8QB
        2ztZvrEE8rpgRL7Sh1UrfYDtS88bb3TBHgADnKQ=
X-Google-Smtp-Source: AAOMgpeOmOQAxLpCwYHxy7vx4W44YRPLBdvtl3+Lx2HlmcXB6suUE+104WCTG8YZ+gSstcEQ8RVkrehmNQpQ0nKb4pE=
X-Received: by 2002:ac8:3351:: with SMTP id u17-v6mr8903318qta.126.1533412966858;
 Sat, 04 Aug 2018 13:02:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:278a:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 13:02:46 -0700 (PDT)
In-Reply-To: <CALecT5hgk+Wuh4-UWY29NNoEz-47Fx3pSjve8raCd3hRMzXE5w@mail.gmail.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-4-maxi.jourdan@wanadoo.fr> <CALecT5hgk+Wuh4-UWY29NNoEz-47Fx3pSjve8raCd3hRMzXE5w@mail.gmail.com>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Sat, 4 Aug 2018 22:02:46 +0200
X-Gmail-Original-Message-ID: <CAHStOZ5VaOiOQhi7vG0Q9R7gF+LHvZim1qsEUJanZkFoXqgwDA@mail.gmail.com>
Message-ID: <CAHStOZ5VaOiOQhi7vG0Q9R7gF+LHvZim1qsEUJanZkFoXqgwDA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
To:     Yixun Lan <yixun.lan@gmail.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +                       sysctrl_DMC: system-controller@0 {
>> +                               compatible = "amlogic,meson-gx-dmc-sysctrl", "syscon", "simple-mfd";
>
> we'd like to drop 'meson-' prefix, so better using "amlogic,gx-dmc-sysctrl",
> please take a look at the discussion here [1]
>
> [1] https://lkml.kernel.org/r/7hk1prmg4w.fsf@baylibre.com
>

On that subject, should I remove the meson keyword from dts only, or
from everything ?

e.g use amlogic_canvas_* symbols instead of meson_canvas_*, name the
source file "amlogic-canvas.c", etc. ?
