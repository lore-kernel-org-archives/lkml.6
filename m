Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D719421850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551203157;
	bh=c2z4jtwehHe3TphH0an2gBgC1jwH9c+EUAZ8n2yejXg=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=2R3YSXbPWEEgEAK4u8kSkuNroNKfq+nJ8yIjY55Z3eEd6qUcAQMLFkMgopZAiPa65
	 fgjCVjqWdRBUXrImlSTijF4wfq+K9biyo8t87NgUZk2gjF2KJMkLWWa/GrF80Y4CUs
	 ctJuA8aGmxNJLg8Bui9QaI5+4tiCQbXqc6VQuVwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfBZRp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbfBZRp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:45:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716162184D;
        Tue, 26 Feb 2019 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551203155;
        bh=c2z4jtwehHe3TphH0an2gBgC1jwH9c+EUAZ8n2yejXg=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=M/PdYZw1E4fFGr2llB9KDjWf/mWEVOkmQ1+z3iUitWRDwd4atQx1zu2MEpnP3KXMd
         niwA/w1GoB1Q5/aG0YE88d+zZTYlOfwjr15BMoXXc4j765TfNzGijU/qHWL2QxT+pc
         NR68QCuB01MobEzpPkcRlLNrG97dFCTtwEnUhJII=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Weiyi Lu <weiyi.lu@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com> <20190201083016.25856-2-weiyi.lu@mediatek.com> <155069033021.77512.14493210110678229730@swboyd.mtv.corp.google.com> <b7abe484-71c1-5ec0-796c-544f1ac5d6f5@gmail.com> <155082168901.77512.12893153125579041936@swboyd.mtv.corp.google.com> <1551153650.1047.4.camel@mtksdaap41>
Message-ID: <155120315465.260864.9490825097795511702@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org
Subject: Re: [PATCH v4 00/12] Mediatek MT8183 clock and scpsys support
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1551153650.1047.4.camel@mtksdaap41>
Date:   Tue, 26 Feb 2019 09:45:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-02-25 20:00:50)
> On Thu, 2019-02-21 at 23:48 -0800, Stephen Boyd wrote:
> > Quoting Matthias Brugger (2019-02-21 00:36:24)
> > >=20
> > >=20
> > > On 20/02/2019 20:18, Stephen Boyd wrote:
> > > >=20
> > > > What's the merge plan here? Do you want me to apply these patches t=
o clk
> > > > tree? Will someone be sending me a pull request for mediatek clk ch=
anges
> > > > this cycle? It's getting pretty late for much of anything making th=
is
> > > > upcoming merge window.
> > > >=20
> > >=20
> > > As far as I can see, the clock patches are independent, so I think it=
 is OK to
> > > take them. SCPSYS patches will go through my tree once they are in sh=
ape.
> >=20
> > Ok great. When patches for clks are interspersed throughout the patch
> > series it makes me think that something later in the series depends on
> > something that isn't a clk patch so then I can't apply it.
> >=20
>=20
> Hi Stephen,
>=20
> Sorry for making such complex dependencies between the clk patches and
> others in this series. And just like Matthias mentioned, the clock
> patches are independent from others. I could resend a clock-only series
> right away if each clock patch in v4 is qualified to merge into
> clk-next.
> If there still some provide need to be fixed, please let me know. I'll
> fix them and send v5 only for clock.

It looks like Matthias has some comments on the first patch that need to
be addressed. I looked over the rest of the clk patches and they look ok
at a quick glance. If you resend just the clk patches without the rest
then I can probably apply them for the upcoming merge window.
