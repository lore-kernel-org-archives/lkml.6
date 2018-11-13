Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D82DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6149E2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCSpQ/1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6149E2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbeKMSdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:33:39 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52102 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbeKMSdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:33:39 -0500
Received: by mail-it1-f196.google.com with SMTP id m34-v6so16893085iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XWeqlo+6lwHoVaCLUge+Tebs94xhxS3Zq6e11aLK7U=;
        b=eCSpQ/1mLuWyKTCjy2uBcgud6vismnEyRTCrv2xi5jErbTwCEs3l0m5bLsjvxndex3
         XIX2aKP21RPzZHBfGPdbHBfAwRdmh0wtdjkRRiwUMs96kFjQunMz1WtSa5/yJ2cghg0Z
         78Fo9Bsamwc5PY8mCnInEgCjRT74bnEEKDGeBkaX85FGCfhwgx9mWUrs+xgEHzwJ6npp
         omY9Q91hMCfIoGu7snbEJmhTKNb6xQBvYcStnru1pNTUUzZQ+yVe3wmn7e7apfWhw/nZ
         NBPQKPrKGohR8IuhuNiLNsGyxUT+zLEwf/0jaNJ60teSUQL8b/86eMy7ko1CVlmuE9M5
         zVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XWeqlo+6lwHoVaCLUge+Tebs94xhxS3Zq6e11aLK7U=;
        b=D+5lFbC5ehfsUqg5zhw7gv+TaYJecjPin5763MffON6CnTFBdYhFfvAmjjoRNvk4q4
         rjgp1jczkd5nNjDzGREbLxap6E3AkZjtx3TnVm+rd5cpOzi8Pvo8fXIYYdxo6Lo4B45q
         f+uahuoTRiiaoOJ5ULMGAVvzAhzVD81P7bR6J4eYp3/RG21fwAflINZkyj42+sxBkhIT
         3G2/du9JjspEkYnnJs01jhQsPTZXBETXa550wV3OxQBl1oNFy0pS6iYqxU6Kw0Hu4Wgk
         wsIsi0bJ2Vakapkf76AIZ030xRro6wVq698k0Mej6vQNzy7jrHUZazUw4HkAVz3GW+mj
         3+QQ==
X-Gm-Message-State: AGRZ1gJ6I1uEh1KMCotWgsrInElNu1dOLQOiE63UIGG4UGXCgt3bs4m2
        9B+mR2w4gdQGHqaJwQTkXwT15B0qQZR905APvuL7lbF/cA4=
X-Google-Smtp-Source: AJdET5dWCBGf8ZKedODaDgUJR+5eV+6KUrp2EPb3et2CMDZM2G1rKMxMlAtuqQR8P+BgjNmHd9b6f6yr9wvpSK1jBnQ=
X-Received: by 2002:a02:a0c9:: with SMTP id i9-v6mr3906372jah.116.1542098195925;
 Tue, 13 Nov 2018 00:36:35 -0800 (PST)
MIME-Version: 1.0
References: <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
 <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
 <20181109183436.GA45531@google.com> <20181110.085826.230851261@genki.is>
 <m24lcpjjss.fsf@linux-m68k.org> <20181110.201050.925673938@genki.is>
 <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
 <20181111.174140.002789201@genki.is> <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
 <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com> <20181113000938.GA16783@google.com>
In-Reply-To: <20181113000938.GA16783@google.com>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Tue, 13 Nov 2018 10:35:59 +0200
Message-ID: <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     Brian Norris <briannorris@chromium.org>
Cc:     sky@genki.is, schwab@linux-m68k.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 2:09 AM Brian Norris <briannorris@chromium.org> wrote:
>
> On Mon, Nov 12, 2018 at 10:42:26AM +0200, Alexander Kapshuk wrote:
> > An even simpler approach would be:
> >
> > {
> >         git --no-optional-locks status -uno --porcelain 2>/dev/null ||
> >         git diff-index --name-only HEAD
> > } | grep -qv scripts/package &&
> >         printf '%s' -dirty
> >
> > Sample run:
> > cmd
> > sh: cmd: command not found
> >
> > {
> >         cmd 2>/dev/null ||
> >         date
> > } | grep -q 2018 &&
> >         printf '%s' ok
> > ok
>
> You lose accuracy here, because now you're skipping any line that
> contains 'scripts/package', which would include, e.g., paths like
>
>   tools/some/other-scripts/package
>
> Maybe if the grep expression were more like this?
>
>   grep -qv '^\(.. \)\?scripts/package'
>
> I think it'd be safe enough to ignore paths that start with two
> characters and a space, like:
>
> xy scripts/package
> x/ scripts/package
>
> Brian

Thanks for your input.
I've found the following grep command, that uses extended regular
expressions, to work as required:

{
        echo hello
        echo scripts/package
        echo '.. scripts/package'
        echo tools/some/other-scripts/package
} | grep -Ev '^(.. )?scripts/package'

[Output]
hello
tools/some/other-scripts/package

If the participants of this email exchange consider the proposed
implementation as fitting the bill,

{
        git --no-optional-locks status -uno --porcelain 2>/dev/null ||
        git diff-index --name-only HEAD
} | grep -Eqv '^(.. )?scripts/package' &&
        printf '%s' -dirty

Was the original committer of the patch proposed here,
https://lkml.org/lkml/2018/11/10/55, going to take it in, and resend it
as v2 of the patch, or did you want me to submit the patch instead?
I would be happy with either way.

Thanks.
