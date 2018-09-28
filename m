Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8233EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCB121566
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Vv3A3+3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCB121566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbeI1NSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:18:46 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:59305 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1NSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:18:46 -0400
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w8S6uCHf029636;
        Fri, 28 Sep 2018 15:56:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w8S6uCHf029636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538117773;
        bh=SX0KulU0KjKm7pTn45PqphOge/zr/+2SOu59bgjuc1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vv3A3+3wqJmoqAeEysIfAdGVV+5b/+vH2kxpguGeTYMH83P9zavuCVdFy2qz8deZS
         M/O7Kfdq/XDqZ4lFNP156OxjvhXRNZerrytwU067u7OjvrpVS5Wwb+Rxp/Y/PmQhnJ
         1Rmd296hn5VGENWqwdZ6NRPwlsqGU8FYUn9u2E2u5fCXiDeUIgoZSlnWc8Ti7OjxfM
         WOMu5nojAx8OVBJPyv9JvjupWq3J0Q5Dp2xuhNvTtSVx+JBlRX6MtPH2tTMKf1H7gq
         SMH3t1L1emTfG2AThnIb3SETphy1hMAm9OMv8h7slCYl0V6SmzeuNttPa8e70Xd97Y
         SCpp5JDfmB8rw==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id x140-v6so1183779vkd.6;
        Thu, 27 Sep 2018 23:56:12 -0700 (PDT)
X-Gm-Message-State: ABuFfohU2Ry3usISJqU+QXmbYrbtm16y6QIkxkgyFK/c6pUD1MQIbXGM
        tDf5UHoNJZnCSy4X1BGOVX3/GJriYzheIZJonQE=
X-Google-Smtp-Source: ACcGV61YjB5N1SGqInWv07Ss+IujV4RQuAyRvLZcFSioXsEoKRakTzeC4uuw6dXbMQdlQssHU/Sg2PoIMVB+kOjmxW4=
X-Received: by 2002:a1f:8b84:: with SMTP id n126-v6mr5045247vkd.74.1538117771626;
 Thu, 27 Sep 2018 23:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
 <2024081.XhWFmWp6tJ@blindfold> <CAK7LNAQrOhJpkUf=zxvwcbf8oWTAhKiWxemweHz8QPT55H+R-g@mail.gmail.com>
In-Reply-To: <CAK7LNAQrOhJpkUf=zxvwcbf8oWTAhKiWxemweHz8QPT55H+R-g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 28 Sep 2018 15:55:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ87H72iMEyrTin=CPRWiyfuiU_sEpxmCT-qCovjREHtw@mail.gmail.com>
Message-ID: <CAK7LNAQ87H72iMEyrTin=CPRWiyfuiU_sEpxmCT-qCovjREHtw@mail.gmail.com>
Subject: Re: [PATCH] samples: disable CONFIG_SAMPLES for UML
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=E5=B9=B49=E6=9C=8819=E6=97=A5(=E6=B0=B4) 15:58 Masahiro Yamada <yamada=
.masahiro@socionext.com>:
>
> Hi.
>
> 2018-09-18 17:21 GMT+09:00 Richard Weinberger <richard@nod.at>:
> > Am Dienstag, 18. September 2018, 05:58:33 CEST schrieb Masahiro Yamada:
> >> Some samples require headers installation, so commit 3fca1700c4c3
> >> ("kbuild: make samples really depend on headers_install") added
> >> such dependency in the top Makefile.  However, UML fails to build
> >> with CONFIG_SAMPLES=3Dy because UML does not support headers_install.
> >>
> >> Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_in=
stall")
> >> Reported-by: Kees Cook <keescook@chromium.org>
> >> Cc: David Howells <dhowells@redhat.com>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > Is there anything UML can do better?
> > Not sure whether an arch like is supposed to install headers at all,
> > I guess no. :)
>
> I just thought suppressing CONFIG_SAMPLES was a big hammer.
>
> We could install host-arch headers for UML if we like,
> but I am not sure whether is is sensible...
>
> Wait for comments in case somebody has a better solution.
>


I started to think this is a wrong hack.


I posted a different solution:
https://patchwork.kernel.org/patch/10619043/



--=20
Best Regards
Masahiro Yamada
