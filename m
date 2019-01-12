Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7AF206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E8Z1SSkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfALSnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:43:41 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:40487 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfALSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:43:41 -0500
Received: by mail-vs1-f41.google.com with SMTP id z3so11291314vsf.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kFYTHlNee6tfYAfOphbB8cRVrLMf3yeMjA3SSmVwiHY=;
        b=E8Z1SSkcoZqa50iPT/K42E+dymspPEubX0rDHLGYhvS6P4BbK9t8Zlb1Zq2oQuYDPu
         gUH8Qwtr8XtE0SVVWKlXovGNdZhwrQB6aKqRMiU+oSRgdHBldGwYys+OioNWy0ND1Hof
         TTGZ5qZr4TA+sbXFA7qc6TE8gej4sRaLgaeBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kFYTHlNee6tfYAfOphbB8cRVrLMf3yeMjA3SSmVwiHY=;
        b=eW0NLWvan4k+LP2zlV8WS0tNGzs7tYMEIWauiluYCICUmuGyfqqyxvdw6aSfTAhUJ9
         +lI1H/O+VnPCAW5KrEdhVCr1wsPkrDMntEEfIej9EdpLOyhDrZBLJAtPrhHkYvCk0hyA
         DqJ7B/K33ENk02TzYazg2wKthBM1c28z9pc0xtk4Y4iLPLvLTeEEBIphbwKBoMJP0H3M
         EijJ6lgr1degm6M9V5TWfeseyaYtOEFll7ehbi3iIES3nzHqj6/ux2z18gO1Ff8Pweoy
         fDBtNwGb82XhhZmXUnKhhswa4Q2nGKBJ1MmT9jfmSfLN7Q6tiNXQdUgZjbatdyttUtq9
         IyRw==
X-Gm-Message-State: AJcUukcv3EAl+wTTdqFt7eMOfktV6IZ/qio6VOHRg6d28mqe7QaQg2so
        pUx6TOKwUwe5/DrTbiOl3TLeWp92rwc=
X-Google-Smtp-Source: ALg8bN4teKOoSth+oIjEjI0Jq25g0RsX8x6l1IjLkrWXu4u6XcgLytiDX9SURvu0psY2wu4sZF0yuA==
X-Received: by 2002:a67:c31d:: with SMTP id r29mr8123245vsj.130.1547318618919;
        Sat, 12 Jan 2019 10:43:38 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id y195sm34008580vkd.0.2019.01.12.10.43.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 10:43:38 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id n13so11311403vsk.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:43:37 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr8057189vsl.188.1547318617179;
 Sat, 12 Jan 2019 10:43:37 -0800 (PST)
MIME-Version: 1.0
References: <b2d62e31-a64c-4561-a7ad-1625acad8a3d.longchun.lc@alibaba-inc.com>
In-Reply-To: <b2d62e31-a64c-4561-a7ad-1625acad8a3d.longchun.lc@alibaba-inc.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 12 Jan 2019 10:43:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+-944eia65espZo9frWB865rcqswdRKpnH9NJOTqa3MA@mail.gmail.com>
Message-ID: <CAGXu5j+-944eia65espZo9frWB865rcqswdRKpnH9NJOTqa3MA@mail.gmail.com>
Subject: Re: stack-protector: fix CC_HAS_STACKPROTECTOR_NONE depend on -fno-stack-protector
To:     =?UTF-8?B?6ZqG5pil?= <longchun.lc@alibaba-inc.com>
Cc:     "yamada.masahiro" <yamada.masahiro@socionext.com>,
        =?UTF-8?B?5p2O6K+aKOWFgeivmik=?= <lc85446@alibaba-inc.com>,
        =?UTF-8?B?5p2O5Li5KOaWl+mToCk=?= <doukai.ld@alibaba-inc.com>,
        =?UTF-8?B?6K645p2l5YWJKOaclOmjnik=?= <laiguang.xlg@alibaba-inc.com>,
        =?UTF-8?B?6YKs5qGF5qGFKOaXoOW4hik=?= <tom.www@alibaba-inc.com>,
        =?UTF-8?B?5p2O6ICAKOi0peWkqSk=?= <yao.ly@alibaba-inc.com>,
        =?UTF-8?B?546L5L2z55CmKOWHjOWknCk=?= <jiaqi.wjq@alibaba-inc.com>,
        =?UTF-8?B?55Sz5pmoKOWtpOmfpyk=?= <shenchen@alibaba-inc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        akpm <akpm@linux-foundation.org>, tglx <tglx@linutronix.de>,
        mingo <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 7:56 PM =E9=9A=86=E6=98=A5 <longchun.lc@alibaba-inc=
.com> wrote:
>
> commit=EF=BC=882a61f4747eeaa85ce26ca9fbd81421b15facd018=EF=BC=89rename CC=
_STACKPROTECTOR_NONE
> config. but unfortunately if the compiler support option -fno-stack-prote=
ctor,
> CC_HAS_STACKPROTECTOR_NONE will not be disabled.
>
> CC_HAS_STACKPROTECTOR_NONE and CC_STACKPROTECTOR_STRONG will be enabled a=
t once,
> as the following conditions:
>         1. gcc support -fno-stack-protector & -fstack-protector-strong
>         2. enabled CC_STACKPROTECTOR_STRONG & STACKPROTECTOR
>         3. disabled CC_HAS_STACKPROTECTOR_NONE

While it's not very obvious, it's safe to include both
-fno-stack-protector and -fstack-protector* on the gcc command line
since the latter one is the only one that is used.

Are you seeing miscompilation or error conditions without this patch?

-Kees

--=20
Kees Cook
