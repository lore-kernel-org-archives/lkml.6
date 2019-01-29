Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B81C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2502D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="dq1OobNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfA2Asa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:48:30 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46091 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfA2Asa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:48:30 -0500
Received: by mail-ua1-f66.google.com with SMTP id v24so6278135uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 16:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gN5vmDnPmSv2DRa37CoJKGRoROeGwwa4VJ9rNEAXij8=;
        b=dq1OobNzL5A4XDDOwDV0HC2NwTDHIKBNTO+F227SSBFnpewijZdFJZUImCOjhuN5oh
         ALqyYIdKTFX2gsIKbv1r1YtIIN4EPqFMmjzfsb4GOPj1R/FKG1pe3bvFiVWxb4hK4uAf
         r9XIyRL0qkslBHPgvglcBX9QOW1y9iFT9hZ9AWoMrRsvf4JsI8f9DVySr0kGMTTbX3aK
         knN6yLGTQE7YkpS5pwqrKijYgumDeT8YvTWnK0uiiUvXK7XaYvgS5kcdW0Gd6QAht2ND
         3FqIt0vrpp5wrl6DfqPbNkKnP4R2StwBqyugRlgF5a7PbVAyaymJg7coBAiyAq+6VlD6
         Xw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gN5vmDnPmSv2DRa37CoJKGRoROeGwwa4VJ9rNEAXij8=;
        b=LggcGubt6XwiWHYWLPlvG0+5smfZyOTr5n9JWZJWYku+yHG3EoBuENlfIMROoTcFZg
         HiELSszCizwJfiXrBGKslBlJvUQeurz5fjFWSqjEfFyId4sLpchsrsLD0K7PgKD/SsQs
         Om+7dpFVn0W+eLRFS/Lw3QioZ342HxmWWINhziDSO/AZMORs41/CKef0JK2qHj+2s2vL
         0QBTdFFreo3Q90mKld5TC4A9MsdlA8rXst+S1qFpZI7tF4hXbyGh5NWlFo93Dh1eIOxo
         klqkNUw/4ojBA45Ccxpwzlu/GPyEyPACdcLWTehBM0Cf0yoBUvcpS+maqeOzNSRxmqGC
         cwvQ==
X-Gm-Message-State: AJcUukfYbVhpvufWKTL6EsK3mulQCAV4anYyp+NwAw5UfLGgaiF/3yFH
        YlzvnuFsMyHX75LBOQxzBGPAJVnYhwAhSJFkAq9n1w==
X-Google-Smtp-Source: ALg8bN7mh+uWi1TSK82nM/J8+Dg9lXKVH1uVcNN5vbvj2ALU0zE5h5/c9gPF3Gu1yQVymBJhywbhhcU9AjrESYE1pcs=
X-Received: by 2002:ab0:6652:: with SMTP id b18mr10458980uaq.46.1548722908698;
 Mon, 28 Jan 2019 16:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20181030091528.28211-1-heiko@sntech.de> <fa732d7c529c28135b2c9a1ccf902d4658a53682.camel@collabora.com>
 <20190124161812.GA10550@ulmo> <20190124175136.GP114153@art_vandelay> <20190128155938.GC26200@ulmo>
In-Reply-To: <20190128155938.GC26200@ulmo>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 28 Jan 2019 21:48:16 -0300
Message-ID: <CAAEAJfALOKWyW6t8XC7fqs4hJKbN-80o7C_8pccJtNRKUUzumw@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND] drm/panel: add Kingdisplay kd097d04 panel driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sean Paul <sean@poorly.run>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        padovan Gustavo <gustavo.padovan@collabora.com>,
        nickey.yang@rock-chips.com, Sean Paul <seanpaul@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, hl@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 at 12:59, Thierry Reding <thierry.reding@gmail.com> wro=
te:
>
> On Thu, Jan 24, 2019 at 12:51:36PM -0500, Sean Paul wrote:
> > On Thu, Jan 24, 2019 at 05:18:12PM +0100, Thierry Reding wrote:
> > > On Thu, Jan 24, 2019 at 12:01:55PM -0300, Ezequiel Garcia wrote:
> > > > On Tue, 2018-10-30 at 10:15 +0100, Heiko Stuebner wrote:
> > > > > From: Nickey Yang <nickey.yang@rock-chips.com>
> > > > >
> > > > > Support Kingdisplay kd097d04 9.7" 1536x2048 TFT LCD panel,
> > > > > it is a MIPI dual-DSI panel.
> > > > >
> > > > > v4-resend:
> > > > > - Thierry noted missing dt-bindings for v4 but forgot that he
> > > > >   already had applied them one kernel release back in
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Debc950fdff6d5f9250cd5a5a348af97f7d8508df
> > > > > v4:
> > > > > - address Philipp's comments
> > > > >   - real range for usleep_range and
> > > > >   - poweroff ordering in kingdisplay_panel_prepare
> > > > >   - return value beautification in panel_probe
> > > > > - update author naming for full name
> > > > > v3:
> > > > > - address Thierry's comments
> > > > >   - error handling for init dsi writes in init
> > > > >   - unconditionally remove the panel
> > > > >   - don't use drm_panel_detach
> > > > >   - a bit of variable signednes wiggling
> > > > > - I did talk to ChromeOS people and the delays really should be a=
s short
> > > > >   as possible, so dropped the 100ms from the delay comments
> > > > > v2:
> > > > > - update timing + cmds from chromeos kernel
> > > > > - new backlight API including switch to devm_of_find_backlight
> > > > > - fix most of Sean Paul's comments
> > > > >   enable/prepare tracking seems something all panels do
> > > > > - document origins of the init sequence
> > > > > - lanes per dsi interface to 4 (two interfaces). Matches how tegr=
a
> > > > >   and pending rockchip dual-dsi handle (dual-)dsi lanes
> > > > > - spdx header instead of license boilerplate
> > > > >
> > > > > Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> > > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > >
> > > > Hm, this v4 patch has been stalling here for *four full months*.
> > > >
> > > > Which deity do we need to pray to get this one moving? ;-)
> > > >
> > > > Seriously, can someone please apply this?
> > >
> > > If you care about this driver, perhaps you'd like to review and provi=
de
> > > a Reviewed-by?
> >
> > Looks good to me,
> >
> > Reviewed-by: Sean Paul <sean@poorly.run>
>
> I was aiming for a Reviewed-by from Ezequiel, but I'll take yours as
> well, thanks very much.
>

Looks like this got reviewed and merged before I could react.

Thanks Sean and reviewing and Thierry for merging it!
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
