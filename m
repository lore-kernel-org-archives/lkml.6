Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ECBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD94C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551203594;
	bh=VjJneA/s4eX6456hCNL9/imBB29/UyDasE0Hx0zHNCI=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=Go3myqG5TPeIBVUucg/okDOudHPQjeTJCO+qiVC1u7KOWblTKuptT26WRZFAUM5zt
	 tHT4OccS27E47Na2lpfgYkTLUnUO1/SpxIaf7Znm5qRya5WgX+jM1lQLkWUGr3I+mc
	 etPPDLW1v+Y1eXWli5ex9HAHf1MGu4xEUcxUtwRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfBZRxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfBZRxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:53:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D959A2173C;
        Tue, 26 Feb 2019 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551203590;
        bh=VjJneA/s4eX6456hCNL9/imBB29/UyDasE0Hx0zHNCI=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=d0UjWaAtvIVdH8EDkUxHLXUl2OzRAgrXAPVzsawVpPVJV9G8p2x0qwYeAkuDjOagp
         Oeq+qB6V+E2r9FxCo1lF5aIN+ptBdXgQeVnxUK/kesFdDF+Wnm+tAdFex0KQ66R+j+
         3SVwVZQtAqQXR75kbZMHO5zyhmxd7vZoR5J1ZdhE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com,
        matthias.bgg@kernel.org, mturquette@baylibre.com
References: <20190214163026.26073-1-matthias.bgg@kernel.org> <f7ed0750-665a-76bc-df1a-95af39fef8ec@gmail.com>
Message-ID: <155120358914.260864.17734674975447226263@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     sean.wang@mediatek.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v4 0/3] Mark clocks as critical for MT6797
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <f7ed0750-665a-76bc-df1a-95af39fef8ec@gmail.com>
Date:   Tue, 26 Feb 2019 09:53:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2019-02-26 04:59:44)
>=20
>=20
> On 14/02/2019 17:30, matthias.bgg@kernel.org wrote:
> > From: Matthias Brugger <mbrugger@suse.com>
> >=20
> > Jasper send this series some month ago. As there was no reaction from
> > his side, I'll do a friendly take-over.
> > I tested the patches on my Helios X20 boards and they fix the issue.
> > I didn't add a Tested-by tag as I added my Signed-off-by.
> >=20
> > Changes since v3:
> > - add comments explaining why the clock muxer and gates are marked
> >   as critical
> >=20
> > Changes since v2 (https://patchwork.kernel.org/patch/10686759/):
> > - axi_sel is not needed, drop CLK_IS_CRITICAL for it.
> > - update commit message
> > - add Acked-by from Mars
> >=20
> > Changes since v1:
> > - add a fixes tag.
> >=20
>=20
> Steven, Mike any comments on this?
>=20

I got patch #1 and #2 in my queue and they're not threaded properly as
replies to each other. I'll have to go dig out the last patch somehow,
but probably I can apply them now.

