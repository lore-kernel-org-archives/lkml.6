Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7E9C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0449D20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbfAOR7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:59:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:54367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfAOR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:59:49 -0500
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MGBB1-1gUtzO3VeZ-00F8Wp; Tue, 15 Jan 2019 18:59:26 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id 01E3C6E85603; Tue, 15 Jan 2019 09:57:48 -0800 (PST)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     bp@alien8.de
CC:     robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, mchehab@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org,
        sschaeck@cisco.com
In-reply-to: <20190110095049.GB17621@zn.tnic> (message from Borislav Petkov on
        Thu, 10 Jan 2019 10:50:49 +0100)
Subject: Re: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
Reply-to: schaecsn@gmx.net
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-2-git-send-email-schaecsn@gmx.net> <20190110095049.GB17621@zn.tnic>
Message-Id: <20190115175749.01E3C6E85603@corona.crabdance.com>
Date:   Tue, 15 Jan 2019 09:57:48 -0800 (PST)
X-Provags-ID: V03:K1:EzR5CvvaIGLH0zWOSwVGWmSucprjb3tra4g1OF2Een2KafAqRjg
 yFqZ849BZBASOjINZxOP/fle2JvDB4Pw96wU0zquP6SYgQxg9B95NfXmxtzomQ3myKJSeEu
 Tn6RXzTte0iOff+hz4q/U1qGwYQLUSEQx/V6g0SM1yQQWvjv98IJ/weYbWsICTgqwI+pBy/
 WbtTSnBLYI30SSq0NoytQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XBytXecmnfY=:kiKrTDa3DWashyjYe5WhLX
 Rpzw/HP/kLoc52zb/FNyUv2ZjNF1BTD5GaJXibn/osDAxbBSHU+Mp1RuvYNtnnCnNawyD4+zt
 U4ehmsQJ7P4w5IPK6TIDEQmXFti9freSPMY4DqZ+LlVCaJkSE6SlyocPZ5uoEpfvuKz9Tk2bB
 xGnXw+/g/oTgJhVdpePgRyVakggcUw4xQG5JWonq9LouJtUStFp/ghrQ4FVgFEjAI+lsS6thd
 SZe00rqVOceztKVgbMNTF/aEqNTcUbtPRfL7HyCgu4k7BrXM+KsfXQgF2VuggyJWOl5OAFdIC
 NhiPzcHhIaypXR5Jq7/D+NdNCJMsairve+J1fKMGVcXiHD0CA4zDJoRyWPvRpFga7/hyC3Q34
 f1RX9Y+Hqu+UqV74uZPDzA9yQTXRVtkOvnV/dGhcqxmZ6iuw48sDpTtZCzj2UAcLfdtLhyejr
 J7+MPC9etjsuA4BqZdrQAE9TriUnXk8q3+o2gK06/IDRM9W1ljGXucTlZguCw9HfY9EEVMBHN
 /PxQpuDA837gfm6amPJI/MjLKV9Vc+nmotZbbir36RN3hPICJK7T83xugdP/rKFSQeITyAAH1
 pcb95zWxivil3PbHVwgX6MmOSRT50vdN9GSGxrz1Htk83x7IFLno+N97FXy6CL5inv2XPzoFS
 hGFX2xizwjwzs2uZznOIKDea/7Uus0naK9AJ6I9JLm4WGhIi4uZ1hzPHqHyji5imTg1g100wY
 Til24Bpo8murnGgl5RBfzsgl6wlbAp0QoKPMTajtf/2Q6MrC4uSo8pFe0Eurh0dbG5H2r26f9
 gO0dVOinRpPUPLMpK4Xa2FRzEVOwvx3ZvrVDSu4SMnlIuRHWlIgWxrrRLpmXNU2PR2k86xzgc
 QJhUFQRcyHUpxtYyX5eV7Sjtwgi7loI4kJ11qV7mj17rEhnWHLd88kzR80m+lS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Boris,

Thank you for your feedback.

> From: Borislav Petkov <bp@alien8.de>
> 
> On Sun, Dec 16, 2018 at 10:01:56PM -0800, Stefan Schaeckeler wrote:
> > From: Stefan M Schaeckeler <sschaeck@cisco.com>
> > 
> > Add support for the Aspeed AST2500 SoC EDAC driver.
> > 
> > Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> > ---
> >  MAINTAINERS                      |   6 +
> >  arch/arm/boot/dts/aspeed-g5.dtsi |   7 +
> >  drivers/edac/Kconfig             |   7 +
> >  drivers/edac/Makefile            |   1 +
> >  drivers/edac/aspeed_edac.c       | 457 +++++++++++++++++++++++++++++++
> >  5 files changed, 478 insertions(+)
> >  create mode 100644 drivers/edac/aspeed_edac.c
> 
> I couldn't see anything out of the ordinary - only nitpicks below.

[...]


> > diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> > new file mode 100644
> > index 000000000000..d6ed119909eb
> > --- /dev/null
> > +++ b/drivers/edac/aspeed_edac.c
> > @@ -0,0 +1,457 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2018 Cisco Systems
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> 
> You have the SPDX license identifier - no need for that text.

That's interesting. I did a grep over all 16944 GPL licensed files with an SPDX
identifier.

785 of them have a license text while 16159 don't. I will remove mine.


> > +static int aspeed_edac_regmap_reg_write(void *context, unsigned int reg,
> > +					unsigned int val)
> 
> All the static functions don't need the "aspeed_edac" prefix.

When stripping off aspeed_edac_, some static function names will become quite
"bare-bone":

aspeed_edac_init(), aspeed_edac_exit(), aspeed_edac_probe(),
aspeed_edac_remove(), aspeed_edac_of_match(), aspeed_edac_isr(),
aspeed_edac_config_irq().


Does your suggestion also apply to static variables? E.g. aspeed_edac_regmap,
aspeed_edac_regmap_config, aspeed_edac_driver? Also, here some variable names
would become quite "bare-bone".

 Stefan
