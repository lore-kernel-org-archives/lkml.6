Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34121C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBB821742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Zfkduaa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBB821742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbeHNFeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:34:44 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:48752 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbeHNFeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:34:44 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7E2nYKW030051;
        Tue, 14 Aug 2018 11:49:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7E2nYKW030051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534214975;
        bh=S8Fex/Otcwuwi84noS7XevgUTTcMtKAC2KfLWubCzQ0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Zfkduaa1NZXmOG67mlFBj4rvJFZg3J6gomRtp3h+I5Lg6R9IPTrICSybwMLT+z42U
         AKHnayObD9mPWvempleGMlBTubUin4gtOG2L2+YVpuXJaga6bOE4eqI0BjxZ17XydP
         Lavk84m5R9fVu0IXXxrP7eg8QtstfILg1XMv3K7jBo5ap0WmK311yF+iWrFH532Zdc
         DJsdCCuFo9SOplt3XgMSJMV5825J0VKPNfcVYXx/A6Xn3aDJ4j+BiG5fyGohwi4bxD
         ISy+yG/WHOzgRx1B4a++NScBhGQv8e+W6JS+BF1t4hj7n3pIP95p8XYU9bIVhCgr6R
         y2UJN8ugRNrRA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id w7-v6so11547750uan.9;
        Mon, 13 Aug 2018 19:49:35 -0700 (PDT)
X-Gm-Message-State: AOUpUlF4FPkDjCtmyNRJOivMxhRwaE0kQQQarIqB51lWexDplxTnXt99
        MlBf5cIjMdFAV/TvXwuqJy5gq+Y78S6rMM2CzJg=
X-Google-Smtp-Source: AA+uWPyzI7qGdur2uOcCsavR/xeR/y57q3rWI1iGva7PHQL6XkgLq5MOz0a6ZGcJMVZRBTEdMKwBpEbgb1XcS3lv7kI=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr12129070vks.106.1534214974220;
 Mon, 13 Aug 2018 19:49:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 19:48:53
 -0700 (PDT)
In-Reply-To: <20180813172003.GA20519@ravnborg.org>
References: <1534178919-8375-1-git-send-email-yamada.masahiro@socionext.com> <20180813172003.GA20519@ravnborg.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 Aug 2018 11:48:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+xe56yVs=R1MjWX71Bw+kwjSeGpRP-kD0TY3oEmy4+Q@mail.gmail.com>
Message-ID: <CAK7LNAQ+xe56yVs=R1MjWX71Bw+kwjSeGpRP-kD0TY3oEmy4+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove unused sym_get_env_prop() function
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-14 2:20 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
> On Tue, Aug 14, 2018 at 01:48:38AM +0900, Masahiro Yamada wrote:
>> This function is unused since commit 104daea149c4 ("kconfig: reference
>> environment variables directly and remove 'option env='").
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Both patches are obviously correct.
> Feel free to add:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>
> and apply to kbuild so we  can get them in this cycle.
>
>         Sam


Applied to linux-kbuild/kconfig with Sam's Ack.



-- 
Best Regards
Masahiro Yamada
