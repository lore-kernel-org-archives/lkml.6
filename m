Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C57C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FF02661D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FF02661D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeFZHgx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:36:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49616 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbeFZHgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:36:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3E6A5207D4; Tue, 26 Jun 2018 09:36:50 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id F19EA206ED;
        Tue, 26 Jun 2018 09:36:49 +0200 (CEST)
Date:   Tue, 26 Jun 2018 09:36:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: mxc: remove __init qualifier from
 mxcnd_probe_dt
Message-ID: <20180626093650.5835593b@xps13>
In-Reply-To: <20180626092413.703249c8@bbrezillon>
References: <1529679025-5735-1-git-send-email-martin@kaiser.cx>
        <20180626091005.08d56b2a@xps13>
        <20180626092413.703249c8@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tue, 26 Jun 2018 09:24:13 +0200, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> On Tue, 26 Jun 2018 09:10:05 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Martin, Boris,
> > 
> > On Fri, 22 Jun 2018 16:50:25 +0200, Martin Kaiser <martin@kaiser.cx>
> > wrote:
> >   
> > > mxcnd_probe_dt is called from mxcnd_probe, which is not marked as __init.
> > >     
> > 
> > I think this line is just a side note and should be at the end of the
> > commit log.
> >   
> > > Using the sysfs unbind, bind nodes, mxcnd_probe and mxcnd_probe_dt can
> > > potentially be called at any time. After the __init functions are cleaned,
> > > mxcnd_probe_dt is no longer available. Calling it anyway causes a crash.    
> > 
> > The above paragraph explains the problem and the solution, you can just
> > add something like "mcvnd_probe is untouched because it is already not
> > marked as __init" instead of the first line.
> >   
> > > 
> > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>    
> > 
> > Boris, do you think this patch is a good candidate for stable?
> > 
> > If yes, Martin, could you please add a couple of stable/fixes tags above
> > your SoB?  
> 
> We should at least have a Fixes tag. For the stable one, I'm not so
> sure because the bug does not exist in practice (the compiler always
> inline mxcnd_probe_dt()).

Fine, then a Fixes tag will be enough and I will take it into
nand/next as it is not urgent at all to have it in the main tree.


Miquèl
