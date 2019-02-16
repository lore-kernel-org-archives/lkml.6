Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B1CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F199F222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550277292;
	bh=SHAAVlBJeDON/otkufPWmGdDwhNYTy9ivi6Y24AuRIo=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=CB25z3mAznmGHDyAToY8NGMmKG0zO4jTIZ78UqK3iaumGNvoGcnVvd+Uc0UYrzr6m
	 v6vufdEzGx5Y/6n/6ZxlwPVW8O7oGdBvvj83x2s8DmJa2zS2gm7Db7BURi9F2m4a1M
	 lzrIKlUowOmeBy32VPZo2AFlTxkOiZTnDS0cDDII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394174AbfBPAeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391676AbfBPAeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:34:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D300222A1;
        Sat, 16 Feb 2019 00:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550277289;
        bh=SHAAVlBJeDON/otkufPWmGdDwhNYTy9ivi6Y24AuRIo=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=kuejumCFShtSikelEQ2ReeQKqIMwNL7UXdvxSJXGGNjPLeBKqfydpIFj4oLzCTrNC
         IM81tHsLCcBwMCJZNlQZ5qLmiRjdjID5lVmXPO9PAedOIBlSChzina2+r+c4DgTA8z
         JiYkjuCYomxt+2Mq1yM4tq3FPWG09e675bytJrpo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
User-Agent: alot/0.8
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
Message-ID: <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com>
References: <20190211181531.GA3238@embeddedor> <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com> <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 16:34:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kees Cook (2019-02-12 10:57:05)
> On Mon, Feb 11, 2019 at 11:41 PM Krzysztof Kozlowski <krzk@kernel.org> wr=
ote:
> >
> > It is just the GCC which has to be fixed not the code. You want to
> > adjust the code for specific version of GCC and what if GCC changes
> > its warning? For example GCC might require "fall through: "... or any
> > other syntax. Another point - what about clang's syntax?
>=20
> -Wimplicit-fallthrough=3D3 is stricter and maps to -Wextra, hence its
> choice. GCC's levels were chosen based on the existing linters, static
> analyzers, etc. The patterns are unlikely to change (see the gcc
> man-page).
>=20
> Clang doesn't recognize anything in C mode (hopefully this will be
> fixed in the future[1]).
>=20
> As long as one of the compilers is able to check this, we'll avoid the
> bugs associated with this mis-pattern. Gustavo's efforts here have
> found kind of a lot of bugs, so I think it's worth a little churn to
> add these (and make minor adjustments to existing comments).

Just curious, what compilation phase does this check run in? Could we
gain a macro like FALLTHRU or even lowercase 'fallthru' that expanded to
whatever the compiler wants to see and then there would only be "one
way" to do this?  It would alleviate the above concerns, but maybe I'm
rehashing something that's already been proposed and rejected.

Of course, I'm happy to merge any of these patches that tweak things so
no worries either way.

