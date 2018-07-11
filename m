Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C9020C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0h3RIyld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C9020C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbeGKQiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387712AbeGKQiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:38:54 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B165520870;
        Wed, 11 Jul 2018 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531326826;
        bh=OrrrmTpmrRu5UlEOZyeTGdhzSpcIAQd1JrXp59jWp4I=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=0h3RIyldJGlN/fbm9nmvq2z0M/HouyERxiQWk53Bqxfjj1TWdxlCOjV70A+hfusBH
         MnzPliE8vaI3M7HcBCVQ3wHRRLrUi4F2AUmgGC6BBCJzVSgORHGjuXklNcu1csRyfk
         zxd6x4n8UzwvxG6stRaBVClh8XOYzj1BVV0/Zt6A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180711084302.GB6959@dragon>
Cc:     Anson Huang <Anson.Huang@nxp.com>, aisheng.dong@nxp.com,
        fabio.estevam@nxp.com, kernel@pengutronix.de, mark.rutland@arm.com,
        mturquette@baylibre.com, ping.bai@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
 <153091072630.143105.2849049240391576710@swboyd.mtv.corp.google.com>
 <20180711084302.GB6959@dragon>
Message-ID: <153132682598.143105.16881098765923078751@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
Date:   Wed, 11 Jul 2018 09:33:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2018-07-11 01:43:03)
> On Fri, Jul 06, 2018 at 01:58:46PM -0700, Stephen Boyd wrote:
> > Quoting Anson Huang (2018-06-21 23:32:33)
> > > According to Reference Manual Rev.0, 06/2017,
> > > there are GPIO LPCGs defined in CCM CCGRs,
> > > add them into clock tree.
> > > =

> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > =

> > Applied to clk-next
> =

> Stephen,
> =

> If you can apply this patch to topic branch 'clk-imx-gpio-gates', I will
> be able to pick up patch #2 for this cycle.

Can you merge in clk-imx6sll-gpio topic branch to your tree? I'm making
topics for all patch series, so that's why this got stuck into a
different topic branch.

