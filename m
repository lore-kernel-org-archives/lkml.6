Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FA1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE1D217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfBZJpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:45:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:47741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:45:36 -0500
Received: from 5HSWXM1 ([87.191.24.82]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Ma0HM-1gSnMK3JkS-00VvUa; Tue, 26
 Feb 2019 10:45:28 +0100
Date:   Tue, 26 Feb 2019 10:45:20 +0100 (CET)
From:   Rolf Evers-Fischer <embedded24@evers-fischer.de>
X-X-Sender: rolf@5HSWXM1
To:     Kishon Vijay Abraham I <kishon@ti.com>
cc:     Rolf Evers-Fischer <embedded24@evers-fischer.de>,
        linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH] phy: ti-pipe3: Do not overwrite the whole PROGRAMMABILITY
 register
In-Reply-To: <1dd2c361-2219-05c7-6ca6-27dc049a9c7d@ti.com>
Message-ID: <alpine.LNX.2.21.99.1902261031420.13528@5HSWXM1>
References: <20190226092421.13440-1-embedded24@evers-fischer.de> <1dd2c361-2219-05c7-6ca6-27dc049a9c7d@ti.com>
User-Agent: Alpine 2.21.99 (LNX 239 2017-12-04)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k93m/OQnFYGIDrj3C4crThd4Xvz0d+iuJALMZisjNBCq/sr83Bm
 wWKuKw5U4PUT3TRS/mFZgQVKcu9BlavzEdD8PBbEeOdGxZ2lT9C6y+YuCA3IAN52x0rP0/O
 ZqqN6vYDdnROwFLoNlbgraKFz/1slthVIdKrrle4xCOJ27qMCp52z1Rqrk9VFqf3c/rka1Y
 7NI6q5Srj7dFt2+XTvd9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tyykDGHVHnU=:PTRu5uhlECr8A5ZWZd5Isw
 cUvvE28OVXHlRmgr5WEocIGy+SStDd1yDeex/coJ6VYErmF39Os5tUcY8Ncxf7W70Jm1kCBvF
 bE0xKezz0Z9hn9EKUB7oUaU5w1iVMUQampuSxWOAaWhEZpiNPihl1flc8XpFnri7+pwqxEffr
 9PCUGt4E0T3TSm/sn9cC+49Yw2y7TTZvl2hLZZXKnWXHaCdJeQOapzlawUcu38Fujz8Oxzu5V
 Dd9wvUPqNf3CTf5rKnlKeq7e8isaEd20j0t8jvJW31PQ1H1iFHegRjkfIJFl+mOsf4ocTMMkx
 AvbIPGiVsKaZ1OEhDqHzy+iWqgvdXVbV7lfksZJYGraSF4KIQ+Vu7tsaq4wMygV07sfBVAmnR
 T2cGR+4+pMIL4NtDJzTKkSi3QWhiqNwkXlfNg8PY4C13jWCbu+rqtl/YPzHNy6WFPWz5bt+SR
 EUPK5BXd3mC+bcpwu30iup6UNvXWuseG16Hkdcx5BgQM4YvTL1WwLy8eMlwxLBgjVs2m0kcZg
 71h8nZyaWUElfP1CDp2iyS2t1sRgiK+5PcCXMienzVmgkGWdZVV393b4jxtOFP2zzP1/wfain
 6KAjJwW3PJR977CwXN1HL4HfgU6Z6v/O2YzYxdmbMqQwTAeNHekcl3BCxAt1TXm0JNPaFdcjH
 zyYro/GJTeuhemhsiMd9VriLP3lh8cVWWTBz3K7jGY4U0YfgOz9I42LakG2LPvDdy/QM56eQR
 O1ocAOclflILn7He7M0jMIDxJT0pvPNcu24u59rf7Rd+N4WqJSyK4wJJ3L4tQCyr2VTDD1kPL
 BWRWBIAC0CdurAXgmWzBGuVTUEjCpM7aVeNnleDvEznDoGZp9R0IsbV9QqPn54KSNRwnztMZk
 uiVQvBFhqtKUI22t04yl63vpHTStN+CgBYSIKFBEQZrTzyCQqCF6TBTwbfpsjoptReE+Vhby2
 /s3P2aHV9PyyHzG2WwG8LH6b9vaEvGIQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On Tue, 26 Feb 2019, Kishon Vijay Abraham I wrote:

> Rolf,
> 
> On 26/02/19 2:54 PM, Rolf Evers-Fischer wrote:
> > From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > 
> > Previously, ti_pipe3_calibrate() wrote all bits in the
> > PCIEPHYRX_ANA_PROGRAMMABILITY register, thus overwriting bits,
> > which should not be modified.
> > Fix ti_pipe3_calibrate() so that it only modifies LOSD and
> > INTERFACE bits.
> 
> A patch to fix this was sent a week earlier by Colin
> https://lkml.org/lkml/2019/2/19/459
> 
> Thanks
> Kishon
> > 
> > Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > ---
> >  drivers/phy/ti/phy-ti-pipe3.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
> > index 68ce4a082b9b..693acc167351 100644
> > --- a/drivers/phy/ti/phy-ti-pipe3.c
> > +++ b/drivers/phy/ti/phy-ti-pipe3.c
> > @@ -303,7 +303,7 @@ static void ti_pipe3_calibrate(struct ti_pipe3 *phy)
> >  
> >  	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY);
> >  	val &= ~(INTERFACE_MASK | LOSD_MASK | MEM_PLLDIV);
> > -	val = (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
> > +	val |= (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
> >  	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY, val);
> >  
> >  	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_DIGITAL_MODES);
> > 
> 
please excuse me. I must have missed that one.
Therefore please forget about my previous mail.

Thanks
Rolf

