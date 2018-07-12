Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1463BC468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E562147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zjd7Z7p3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E562147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbeGLPGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:06:36 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:22167 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732310AbeGLPGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:06:36 -0400
Received: from mail-vk0-f47.google.com (mail-vk0-f47.google.com [209.85.213.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6CEuLKs015626;
        Thu, 12 Jul 2018 23:56:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6CEuLKs015626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531407382;
        bh=S+2u0VqXmfTDSEl59T68sWk9CThrktK8AnYJOEJjKWA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=zjd7Z7p3+qE1V9mj3NK61rzIFsfAKFnABBJ9kXZ6PnqKURmz3/C5RDOqf2POphFOQ
         8b3CARqUPTh0aMwI/4druDoehfuDch3MxDp5QFw1NlSNci9LpPFoXQgg97FY3SS9uS
         jyubUf0dQXXboZAOjhs4pQU3NyMG//FWRACpHCjQd00iHzzlNjackp/Oom/4Xlcxqm
         2tpAnpoX2escNhOu2D6R9VoLGKAHKrx+xkDvevEzZB46/qOq6gyR8q5GMnrDyqZzuU
         7YfGw0NC7Qa+p1irR8/swCHefuBMiW1Ar5j3vz0AdktaxQfRw+espfmwvPZxUpufSZ
         5x6LltJmkFjVQ==
X-Nifty-SrcIP: [209.85.213.47]
Received: by mail-vk0-f47.google.com with SMTP id j11-v6so16490102vke.8;
        Thu, 12 Jul 2018 07:56:22 -0700 (PDT)
X-Gm-Message-State: AOUpUlFeqaLKnl7x0NI7foYEfM07fs4Smey9/bC1sbu5CSWDpjNBMZtw
        Efe6q0SD0DnFqHggly/DqhTnDez5qmCyNhO9A5w=
X-Google-Smtp-Source: AAOMgpcU4c4qg8FIPKFA2stZmxUXkZud/ggAFn9PxzWk0bkkBi1O9m7qcb/rr5aj2IvcVbYHdHveN13E2iMW6GjtIDY=
X-Received: by 2002:a1f:2e89:: with SMTP id u131-v6mr1420149vku.11.1531407381218;
 Thu, 12 Jul 2018 07:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 07:55:40
 -0700 (PDT)
In-Reply-To: <20180712110806.dql44ngo4nysozj6@pengutronix.de>
References: <1531391916-24086-1-git-send-email-yamada.masahiro@socionext.com> <20180712110806.dql44ngo4nysozj6@pengutronix.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 12 Jul 2018 23:55:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjU8mGaOARzV56MuUW=4JrGdJW0gOY5PoGn8t=8rva_g@mail.gmail.com>
Message-ID: <CAK7LNATjU8mGaOARzV56MuUW=4JrGdJW0gOY5PoGn8t=8rva_g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: suppress warnings from 'getconf LFS_*'
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-12 20:08 GMT+09:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
> On Thu, Jul 12, 2018 at 07:38:36PM +0900, Masahiro Yamada wrote:
>> Suppress warnings for systems that do not recognize LFS_*.
>>
>>  getconf: no such configuration parameter `LFS_CFLAGS'
>>  getconf: no such configuration parameter `LFS_LDFLAGS'
>>  getconf: no such configuration parameter `LFS_LIBS'
>>
>> Fixes: d7f14c66c273 ("kbuild: Enable Large File Support for hostprogs")
>> Reported-by: Chen Feng <puck.chen@hisilicon.com>
>> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Which is the system that doesn't know about LFS_* and you care about?

No particular system in my mind.


Chen Feng reported this before.

I also found this:
https://stackoverflow.com/questions/47367350/how-to-recompile-torvalds-linu=
x-from-mac-osx-high-sierra



> Irrespective of that:
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards
Masahiro Yamada
