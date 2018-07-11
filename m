Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC777C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A646C208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A646C208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbeGKMd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:33:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32873 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbeGKMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:33:58 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fdEFf-0006CU-GI; Wed, 11 Jul 2018 14:29:47 +0200
Message-ID: <1531312186.3163.52.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Date:   Wed, 11 Jul 2018 14:29:46 +0200
In-Reply-To: <1cc67fd7d1214f93f7ace6f0c2a46303f79a828e.camel@nxp.com>
References: <cover.1531310547.git.leonard.crestez@nxp.com>
         <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
         <1531311392.3163.47.camel@pengutronix.de>
         <1cc67fd7d1214f93f7ace6f0c2a46303f79a828e.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 11.07.2018, 15:21 +0300 schrieb Leonard Crestez:
> On Wed, 2018-07-11 at 14:16 +0200, Lucas Stach wrote:
> > Am Mittwoch, den 11.07.2018, 15:11 +0300 schrieb Leonard Crestez:
> > > Handle this in the safest possible way by keeping the DISP domain
> > > always-on.
> > > 
> > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > 
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > 
> > Can you send a follow on patch to switch the i.MX6QP errata
> > workaround
> > to use GENPD_FLAG_ALWAYS_ON and remove the -EBUSY stuff in the
> > power
> > down path?
> 
> Sure.
> 
> I was thinking of converting it to a new GENPD_FLAG which allows
> power_off in suspend (as suggested by Ulf) but switching to
> GENPD_FLAG_ALWAYS_ON in order to simplify the code could be done
> first.

Sure, if you are going to work on this I'm fine with converting it over
to this without first going for GENPD_FLAG_ALWAYS_ON. Just wanted to
make sure that things are consistent.

> The -EBUSY stuff is not very harmful.

It's dead code once the appropriate flags have been added to the
domain, so should be removed.

Regards,
Lucas
