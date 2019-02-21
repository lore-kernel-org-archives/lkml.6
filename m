Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EBEC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A1920836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550785416;
	bh=1V1fa89HRlAZLgQ1xiUDViIqteCgMYcMAxRF6LJf0Sc=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=ctdzoWl8pJUwN9cnIOd0pIJiv48zXSXyKI/tOUCUafYsh2QxMIwHLM1Vxj9YhxjAU
	 pZV4CCrCP3JgSqaAx3zwR4DphUsIPtJgtu3wyLJ3w8Wrfml3UnbtNS5udIQn24XRFq
	 U+7hB/ZdvCuAJigJjxhD2hgGrerbsntYwJDPjxHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfBUVnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBUVnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:43:35 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1372080F;
        Thu, 21 Feb 2019 21:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550785413;
        bh=1V1fa89HRlAZLgQ1xiUDViIqteCgMYcMAxRF6LJf0Sc=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=0V8xyxYIpdrwrT/l137iDJ7ZvYdrbofQpFPP104vwYKJvlcyEMtcABdWGq8EAauIW
         mXXvmlsk3XMj/7921WXXe3hR7wlreFpLhIwK5zpRCMVgE7EcZSMEyp/x0eb79aI8Tj
         e3zmK+LW8ZztW8nQGRsKIdXXKIWwgXYuQYaV3dxA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
Message-ID: <155078541292.77512.12594007340364187685@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190211181531.GA3238@embeddedor> <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com> <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com> <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com> <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Feb 2019 13:43:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kees Cook (2019-02-20 14:26:06)
> On Fri, Feb 15, 2019 at 4:34 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Kees Cook (2019-02-12 10:57:05)
> > > On Mon, Feb 11, 2019 at 11:41 PM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> > > >
> > > > It is just the GCC which has to be fixed not the code. You want to
> > > > adjust the code for specific version of GCC and what if GCC changes
> > > > its warning? For example GCC might require "fall through: "... or a=
ny
> > > > other syntax. Another point - what about clang's syntax?
> > >
> > > -Wimplicit-fallthrough=3D3 is stricter and maps to -Wextra, hence its
> > > choice. GCC's levels were chosen based on the existing linters, static
> > > analyzers, etc. The patterns are unlikely to change (see the gcc
> > > man-page).
> > >
> > > Clang doesn't recognize anything in C mode (hopefully this will be
> > > fixed in the future[1]).
> > >
> > > As long as one of the compilers is able to check this, we'll avoid the
> > > bugs associated with this mis-pattern. Gustavo's efforts here have
> > > found kind of a lot of bugs, so I think it's worth a little churn to
> > > add these (and make minor adjustments to existing comments).
> >
> > Just curious, what compilation phase does this check run in? Could we
> > gain a macro like FALLTHRU or even lowercase 'fallthru' that expanded to
> > whatever the compiler wants to see and then there would only be "one
> > way" to do this?  It would alleviate the above concerns, but maybe I'm
> > rehashing something that's already been proposed and rejected.
>=20
> When this got discussed a while back, the thinking was that since
> we're also dealing with static analyzers (e.g. Coverity) and IDEs that
> literally parse comments in the code, it was most sensible (at least
> for now, prior to there being a formal C "fall through" statement --
> there is for C++ but not yet for C), we'd stick to explicit comments.
> In theory, we will be able to do a tree-wide change to add the C
> statement once it exists.

Ok, thanks for the background. Looks like the perf tool already
introduced the #define __fallthrough that they use for this purpose.
Maybe they're hoping that it will be formalized.

