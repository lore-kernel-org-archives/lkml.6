Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEE6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BE5216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BE5216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeI1Bot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:44:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40689 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeI1Bot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:44:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id g14-v6so3687780otj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzsjO9h7V10qHOZxD5XIsRojhm72Dwp0dDZrz1FkINA=;
        b=MCAO0f+LIPMx/rzV5kZCKVfJuyp0dXYocjWdO+FmKS1XmMxSVZ0dhBcfe2EP+C1czL
         rLp+/x9dQKdlb+KGOSMId7CDbwbmhLe7nxBDarRrbipYaFF3pnk2oVowHXauhchnb2ID
         yKaiH+0HtCNZyFft1oT1b7gzvG52p5IW/0peU0kAyRYg57g4QMZQd2wA5RdFA55tU1bD
         g2rM+TiDH18RepuD+lDgI6Vemr4S6b5DcDC6RFZF+3mWz4miBYEK4gPFTqJKQEw6h7+z
         GqA5QqbUVc3Y2AfQcX7q1SXC7niJlJl2qo3lT5Dru4Fa1IwBrtKU4dladrntmCCM/D6U
         jwxA==
X-Gm-Message-State: ABuFfojMBzSIPevc7DH2s89ML8RsOB68ZXxllHVeYWNrmvUFjm2zQLIx
        +gKOkMivn/PU0GawNFS+9DrfDEY49u/n0g==
X-Google-Smtp-Source: ACcGV61eObLL4t4PC2wrD1OmiXHvTMJWXumpwvV/Y1LRJUzSo4YBGd6ZdQJSPprR9AJIzdloc3NV3g==
X-Received: by 2002:a9d:4d0c:: with SMTP id n12-v6mr2355183otf.286.1538076301015;
        Thu, 27 Sep 2018 12:25:01 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id y26-v6sm1128429oti.53.2018.09.27.12.24.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:25:00 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id y81-v6so3196791oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:24:59 -0700 (PDT)
X-Received: by 2002:aca:5217:: with SMTP id g23-v6mr1132684oib.293.1538076299687;
 Thu, 27 Sep 2018 12:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
 <20180926092706.GA16644@piout.net> <CADRPPNQwWgU6OcE7CjxyrgSXjUjwYe4VY0gQD8jx6D+eT_DWrw@mail.gmail.com>
In-Reply-To: <CADRPPNQwWgU6OcE7CjxyrgSXjUjwYe4VY0gQD8jx6D+eT_DWrw@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 27 Sep 2018 14:24:48 -0500
X-Gmail-Original-Message-ID: <CADRPPNRTWSLapqLHO=y5_Rcbh27CigAjPuorLYPrzqxUGYt-9Q@mail.gmail.com>
Message-ID: <CADRPPNRTWSLapqLHO=y5_Rcbh27CigAjPuorLYPrzqxUGYt-9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To:     alexandre.belloni@bootlin.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Olof Johansson <olof@lixom.net>, Roy Pledge <roy.pledge@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 1:15 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Wed, Sep 26, 2018 at 4:28 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 25/09/2018 21:45:56+0200, Olof Johansson wrote:
> > > Hi,
> > >
> > >
> > > On Thu, Aug 23, 2018 at 11:36 PM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > >
> > > > If the qman driver (qman_ccsr) doesn't probe or fail to probe before
> > > > qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
> > > > unmapped page.
> > > >
> > > > This leads to a crash when probing  qman_portal as the init_pcfg function
> > > > calls qman_liodn_fixup that tries to read qman registers.
> > > >
> > > > Assume that qman didn't probe when the pool mask is 0.
> > > >
> > > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > ---
> > > >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > > > index a120002b630e..4fc80d2c8feb 100644
> > > > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > > > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > > > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> > > >         }
> > > >
> > > >         pcfg->pools = qm_get_pools_sdqcr();
> > > > +       if (pcfg->pools == 0)
> > > > +               return -EPROBE_DEFER;
> > >
> > > This is quite late in the probe, after a bunch of resources have been claimed.
> > >
> > > Note that the ioremaps above this are doing unwinds, and you'll end up
> > > doing duplicate ioremaps if you come in and probe again.
> > >
> > > You should probably unwind those allocations, or move them to devm_*
> > > or do this check earlier in the function.
> > >
> >
> > The actual chance of having that happen is quite small (this was coming
> > from a non working DT) and I mainly wanted to avoid a crash so the
> > platform could still boot. I would think moving to devm_ would be the
> > right thing to do.
>
> Even if it is not failing with the upstreamed device trees, it is
> still good to harden the driver for possible issues.  Moving to devm_
> is definitely a right thing to do.  But I also think checking if the
> qman is already probed should be the first thing to do before starting
> to allocate resources and etc and rolling back later.  Probably we can
> move the qm_get_pools_sdqcr() to the begining of the probe to
> determine if qman is probed as it doesn't seem to depend on any of the
> setups done right now.

I just find out Laurentiu also included the following patches in his
SMMU patch series (although not neccessarily related to SMMU) which
also fix the same problem.  I think they are more straightforward and
can deal with the case that qman failed to probe.  So we can take
these to fix this problem instead in 4.19.

https://patchwork.kernel.org/patch/10616021/
https://patchwork.kernel.org/patch/10616019/
https://patchwork.kernel.org/patch/10615971/

Regards,
Leo
