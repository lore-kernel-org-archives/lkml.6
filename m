Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA23CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBB221855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfAXI6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:58:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57230 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfAXI6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:58:36 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 51573209BC; Thu, 24 Jan 2019 09:58:33 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 21E44209B6;
        Thu, 24 Jan 2019 09:58:23 +0100 (CET)
Date:   Thu, 24 Jan 2019 09:58:23 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        sd@queasysnail.net, andrew@lunn.ch, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 03/10] net: macsec: move some definitions in a
 dedicated header
Message-ID: <20190124085823.GD3662@kwain>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-4-antoine.tenart@bootlin.com>
 <955d1bdf-037e-ae26-a9da-8da2a51a7cbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <955d1bdf-037e-ae26-a9da-8da2a51a7cbd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Jan 23, 2019 at 12:11:37PM -0800, Florian Fainelli wrote:
> On 1/23/19 7:56 AM, Antoine Tenart wrote:
> > This patch moves some structure, type and identifier definitions into a
> > MACsec specific header. This patch does not modify how the MACsec code
> > is running and only move things around. This is a preparation for the
> > future MACsec hardware offloading support, which will re-use those
> > definitions outside macsec.c.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > ---
> >  drivers/net/macsec.c | 164 +--------------------------------------
> >  include/net/macsec.h | 178 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 179 insertions(+), 163 deletions(-)
> >  create mode 100644 include/net/macsec.h
> > 
> > diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> > index 56e354305f76..c3a138dd4386 100644
> > --- a/drivers/net/macsec.c
> > +++ b/drivers/net/macsec.c
> > @@ -17,10 +17,9 @@
> >  #include <net/sock.h>
> >  #include <net/gro_cells.h>
> >  
> > +#include <net/macsec.h>
> >  #include <uapi/linux/if_macsec.h>
> 
> I would probably go with include/linux/if_macsec.h and have
> uapi/linux/if_macsec.h include that file directly. This would be
> consistent with other types of network interfaces: bridge, vlan etc.

It's always a good idea to stay consistent with what's already done.
I'll update in v2.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
