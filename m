Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56360C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E8E22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KtlO+dr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E8E22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbeKMKFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:05:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34257 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbeKMKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:05:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id y18-v6so5091753pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 16:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjWSqIblg/uWEWgFA9FuA2eG283Bsg+968hnKdxMoSw=;
        b=KtlO+dr6DWXPL5bTQlpyO1d0mkoQz8AnUqBL91w4e4b6W0K5yZPG6nTpcv1mXwnSKm
         8oFgnSckVTlRJXwkm6qOWtKsxlXki2ipX+qxpEfZf9laqVyDwFXmZ9NadFE3pjA8XLGd
         9wMTLfpt1VKovORSPWj6kGQ8tUaP04kjBEuJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjWSqIblg/uWEWgFA9FuA2eG283Bsg+968hnKdxMoSw=;
        b=VG223PfEnws9nr3IUGpNOqgSAl9j5aU6GPGEFEgdEQAzzkiUmoh4Nbls+tIyx9zcXv
         ADr5Hhe5F2Q1YpVpM5n0wSdOnx/QKpavbEsf7RkXJjddqLjVJrqaqN59KjvYVwfNW4Os
         Fq8+Nqo/Sx7aY+MfOeNfxzVn2YxsIUyses/TBHZA93zyNmR4hCZdN4MFTCkqN9pGVtYt
         1yZG1O2sSgkTX3LZFFBHZMvPD6kr/ggxxdfQpnb6ez5gOcqnaYWKhfzhmcW09eLrgqwb
         YTWZIS8k2pquAo2dZeTcgGxZqNPIeH4+PVGXn7U9JnvkSyX1ZcQ7YXb/YbgRFfMzvTuC
         YGKQ==
X-Gm-Message-State: AGRZ1gIhPcDRxPeaxT3avwYPyxT9fza7xb15vc/sOPwwVJJiZP7OOhTm
        e+4BwroAXKIE4KgIc4PLvHpLkQ==
X-Google-Smtp-Source: AJdET5emJoknIG2WZJTiGDIOBmDm75cuXUC9D1FhlCu7FGXYIvyVvF23WRLf52uL/ufR2ItfpH1O1g==
X-Received: by 2002:a62:cdc1:: with SMTP id o184-v6mr3004673pfg.181.1542067784280;
        Mon, 12 Nov 2018 16:09:44 -0800 (PST)
Received: from google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id j197sm21805842pgc.76.2018.11.12.16.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:09:42 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:09:40 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     sky@genki.is, schwab@linux-m68k.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
Message-ID: <20181113000938.GA16783@google.com>
References: <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
 <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
 <20181109183436.GA45531@google.com>
 <20181110.085826.230851261@genki.is>
 <m24lcpjjss.fsf@linux-m68k.org>
 <20181110.201050.925673938@genki.is>
 <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
 <20181111.174140.002789201@genki.is>
 <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
 <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 10:42:26AM +0200, Alexander Kapshuk wrote:
> An even simpler approach would be:
> 
> {
>         git --no-optional-locks status -uno --porcelain 2>/dev/null ||
>         git diff-index --name-only HEAD
> } | grep -qv scripts/package &&
>         printf '%s' -dirty
> 
> Sample run:
> cmd
> sh: cmd: command not found
> 
> {
>         cmd 2>/dev/null ||
>         date
> } | grep -q 2018 &&
>         printf '%s' ok
> ok

You lose accuracy here, because now you're skipping any line that
contains 'scripts/package', which would include, e.g., paths like

  tools/some/other-scripts/package

Maybe if the grep expression were more like this?

  grep -qv '^\(.. \)\?scripts/package'

I think it'd be safe enough to ignore paths that start with two
characters and a space, like:

xy scripts/package
x/ scripts/package

Brian
