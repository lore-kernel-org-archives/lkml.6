Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F94CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3DF22513
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw70dGXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3DF22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbeKNA5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:57:54 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41866 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeKNA5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:57:53 -0500
Received: by mail-yw1-f66.google.com with SMTP id c126-v6so5866186ywd.8;
        Tue, 13 Nov 2018 06:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AeGC0ZPWGLv8jVLfgprlpkfxTGPkh2MoYONkBrp8rZY=;
        b=Gw70dGXoeRl46mCQiQuX3RgucFC0zi4/gQJQOK7dVewABV5scvtySycuszODqUgw+B
         A6HDtsub1QBnzi9JNFH3qTJYwBzAOCHhb6cx9eVOXToCoMjvWbXl1rBkww6F2NxYrXp0
         GjwJZUfg05NMy8zeqX/RFHTNsVMHQUDM39upfeM+ragV9JVzBVHSegWMjLCGtY7KOQVy
         1eeTK/f7oWyI7b51EZqx5e1dlJ8c1tWF0nhS2KP28oWMX+lMHNTXoF1eyqHVmod9jc5S
         R/r7XuNm/Hpo1Mcv7r3H8MnLFMlgHJMawto72YoB6lfASg9BUaFlODL4X+xXDSrxd+F6
         QTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AeGC0ZPWGLv8jVLfgprlpkfxTGPkh2MoYONkBrp8rZY=;
        b=scZlAoP+MET0abIFxA8tLHNm7k3mA3V3xc563XxtgEM6JSXfQMJmMvu6F7tvEYZTae
         D0a0AS/TkLDTi+h2Ws85EAyb8DItSf+HmpLRry5yEUE2N4fMdTfXyPq09FMb7KqW8D6I
         bKWEWkQ91HF1CSltyyvmlbtd/zEI0VsTBMcKL3bSl9hkFxk0A3UBHhJdWjH3vbByQPXD
         hUaCeFOaZAbxBSxT4bIu9Gdv7ck2HUf/DUb7jkMyb+kVy0Nt7jJPOmoU29ssmzxAy8I0
         PwaTR22WXfqjEsNCLoxq8QJ3Q2ROHt/22ELWJZlxlFDANCR8KtWVJJ3oWCHYtDAy5BFV
         fecw==
X-Gm-Message-State: AGRZ1gLWGEWJdX73x6/CLAuljq0CcBUpuRSqqo1CLU4DL63gYs+0dIFa
        HJOnxgs2dXTIKItVxkMt/Z0O1wo9F4gacfb3JHw=
X-Google-Smtp-Source: AJdET5esVg/6d7XH+I4yGHzjcQegGIxwM/dHg9zjxZSog9XcwXOiOWwojhs8JHMdQy9YAEaWkNDVJJmL8K0N7TMHxJE=
X-Received: by 2002:a0d:e810:: with SMTP id r16-v6mr5160126ywe.36.1542121161057;
 Tue, 13 Nov 2018 06:59:21 -0800 (PST)
MIME-Version: 1.0
References: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
 <20181104144614.GJ26016@tiger> <20181105091230.z2ooz7olbdpopxyd@viti.kaiser.cx>
 <20181113144209.GB4557@dragon>
In-Reply-To: <20181113144209.GB4557@dragon>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 13 Nov 2018 15:59:09 +0100
Message-ID: <CAJiuCcc1dh9CYO1QcTUOfUPZdjZng80GX=0PiX+cQQ-m4=vq_g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     martin@kaiser.cx, Sascha Hauer <s.hauer@pengutronix.de>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Tue, 13 Nov 2018 at 15:42, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Nov 05, 2018 at 10:12:30AM +0100, Martin Kaiser wrote:
> > Hi,
> >
> > Thus wrote Shawn Guo (shawnguo@kernel.org):
> >
> > > On Thu, Nov 01, 2018 at 06:32:47PM +0100, Martin Kaiser wrote:
> > > > The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
> > > > function blocks. Add their ipg and per clocks to the device tree.
> >
> > > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >
> > > Are these EPIT devices actually used in upstream kernel, or just
> > > somewhere else?
> >
> > Until I saw Vladimir's mail this morning, I wasn't aware of any mainlin=
e
> > driver that's using the EPIT devices. I found that the clocks are
> > missing when I tried to use EPIT with a company-internal driver that's
> > not suitable for mainline integration.
> >
> > Still, I think that merging this patch does no harm. If the EPIT device=
s
> > are present in the DT, we should add all resources they're using.
>
> Agreed.  I will be happy to apply the patch if I can get an ACK from
> Cl=C3=A9ment saying this works with his driver in upstreaming.

I have paused the dev of this driver for now, but this is fine for me.

Regards,
Clement

>
> Shawn
