Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A8EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4072E21924
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545957569;
	bh=1ddqU3RtRwJWXxclcxRkIZinYqh+4vVVHA0QuoYWCAg=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=upr7yZZdepVGGolX8i7sMd2be4gHib2wUTJB5yy5WGbGKKoOANg3xAjfzFW9o+ayt
	 SjdIJsMcnDBsriKw869JpEk+o8Skhf6LVjZXBp7xDgpy2wzZUlKFNUC81kL40o4n0f
	 xhqy4E4EuZVgEA+HKDpYPP4GXgk5ZtAp12gOb+Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbeL1Aj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:39:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeL1Aj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:39:27 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33682148E;
        Fri, 28 Dec 2018 00:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545957567;
        bh=1ddqU3RtRwJWXxclcxRkIZinYqh+4vVVHA0QuoYWCAg=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=BrT+HptPTHXixErxKdZK0ULHXTRmcI5npZLplUBH05ts30fXdkPbeEcv/FjdiTbBC
         +ZFmMxkL1t0yBrCGKr9qL2Urcb58QJVtfb07U1oB/sKPThRCwrxuMl7aXxUqj+L1IF
         Vj/CtYNqbUZKwtOI2AU5xa0GrCHrcWlVIHprW77I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Message-ID: <154595756614.179992.794211301759568891@swboyd.mtv.corp.google.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com> <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com> <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com> <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
Date:   Thu, 27 Dec 2018 16:39:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sugaya, Taichi (2018-12-25 17:35:27)
> Hi
>=20
> On 2018/11/30 17:31, Stephen Boyd wrote:
> >> +       init.num_parents =3D parents;
> >> +       init.parent_names =3D parent_names;
> >> +
> >> +       mcm->cname =3D clk_name;
> >> +       mcm->parent =3D 0;
> >> +       mcm->hw.init =3D &init;
> >> +
> >> +       clk =3D clk_register(NULL, &mcm->hw);
> >> +       if (IS_ERR(clk))
> >> +               goto err_clk;
> >> +
> >> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);
> >> +       return;
> >> +
> >> +err_clk:
> >> +       kfree(mcm);
> >> +err_mcm:
> >> +       kfree(parent_names);
> >> +}
> >> +CLK_OF_DECLARE(m10v_clk_mux, "socionext,milbeaut-m10v-clk-mux",
> >> +                       m10v_clk_mux_setup);
> >=20
> > Any chance you can use a platform driver?
> >=20
>=20
> Excuse me to re-ask you.
> Why do you recommend to use a platform driver? Is that current fad?

Not exactly a fad. We've been doing it for some time now. From an older
email on the list:

Reasons (in no particular order):

  1. We get a dev pointer to use with clk_hw_register()

  2. We can handle probe defer if some resource is not available

  3. Using device model gets us a hook into power management frameworks
     like runtime PM and system PM for things like suspend and hibernate

  4. It encourages a single DT node clk controller style binding
     instead of a single node per clk style binding

  5. We can use non-DT specific functions like devm_ioremap_resource() to m=
ap
     registers and acquire other resources, leading to more portable and
     generic code

  6. We may be able to make the device driver a module, which will
     make distros happy if we don't have to compile in all
     these clk drivers to the resulting vmlinux

