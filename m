Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5941208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544038522;
	bh=UQcEC3lOYxzmO7G3948nOyr4EYkWEM4aL5QnY6s0R+w=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=Nr3j6oYu3gxWL4SZ5xVeAJac4ZnuPtlq5DhqW7Bz6shIXjYRbrsabl44UwV/2jWvU
	 hzTzGMXWANRp45Ai6a2RSbUUc+BcJ9MHKU+WsGcWy3UoIbopDfEuu54X46GiwTZ6kL
	 9cRzxi7Hj8yEPBZ+bh+KGv2opjoEzbCUKBoIx2x8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5941208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeLETfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeLETfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:35:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1827120892;
        Wed,  5 Dec 2018 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544038519;
        bh=UQcEC3lOYxzmO7G3948nOyr4EYkWEM4aL5QnY6s0R+w=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=FGhavkkRZhVmFhwBh/loWWnIPWRHGIt2+CZuPSXjxfUWkdCKZS2e2sl4gumnEiZj4
         k78K635v1p//Ov67xqqjZ02PhIypJ4QMFU6yk6UXr7yx61E+URmcW2zKe/LjK5dFIl
         aGRvF7Q1dMzN3RLnwcWC4hVTRDPCE/C+IwnUjfw8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181205182058.GF31204@localhost.localdomain>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, pavel@ucw.cz, andrew.smirnov@gmail.com,
        pombredanne@nexb.com, sjhuang@iluvatar.ai, akshu.agrawal@amd.com,
        djkurtz@chromium.org, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
 <20181205070046.GD31204@localhost.localdomain>
 <154403037317.88331.9382087418367713867@swboyd.mtv.corp.google.com>
 <20181205182058.GF31204@localhost.localdomain>
Message-ID: <154403851843.88331.12634260159268245703@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered device
 has no provider info
Date:   Wed, 05 Dec 2018 11:35:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-05 10:20:58)
> On Wed, Dec 05, 2018 at 09:19:33AM -0800, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-12-04 23:00:46)
> > > But that won't solve the issue if we don't do "dirty hacks" in driver.
> > > The devm interface still only gets the device-pointer, not the DT node
> > > as argument. And if DT node for device is NULL (like in MFD cases) -
> > > then there is no parent node, only parent device with a node. For pla=
in
> > > of_clk_add_provider() the driver can just give the parent's node poin=
ter
> > > in cases where it knows it is the parent who has the provider data in
> > > DT. But our original problem is in devm interfaces.
> > > =

> > =

> > I was misunderstanding the MFD design. Should still work though, so I
> > squashed this into the patch to clean things up a bit. Does this work
> > for you?
> =

> This looks good to me. Especially changing the of_is_clk_provider to
> get_clk_provider_node which allows to remove some repetition. If you
> apply this then I will drop my patch from the series. Just please let me
> know. I will cook version 7 of the series at Friday - tomorrow is the
> independence day in Finland and I'll be offline =3D)
> =


Ok, I applied it this patch with the squash to clk-next.

