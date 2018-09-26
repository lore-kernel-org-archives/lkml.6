Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E694EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E1621564
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E1621564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeI0Ab7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:31:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42540 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeI0Ab7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:31:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id h26-v6so29095480otl.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iwWX6YeCx01aT6+yPJ837Z+CZods0Ydje0ucuCRe6U=;
        b=Rt3GQGlO2DDe2dxmaru+ggqOAflBQDUV0YAkavKPZ8lwfqcNdOzFQJgk5m8O4IMaiw
         41ZthvClYP+6zysVIxtjzhlOZgYdayW8mmOHS/Kz2ziY+FIA9gja/OYkErWqWEyoE4Lz
         sQLcAEIgSH0eF7S6KkJoWkf8FZFUMefzjUBU1nQohtJBWFS95PUT3nTS0+MQ6tMbNcmv
         uXzQJ51UC3l8S5Wn+Bg++XHQCCXnQpFANRS+9crlGTnvpmul1bTMtRYC0tD4lWJ1V8Bs
         FfLMjtjsZqhbKWgWPsTm8xMT+AJWR5750vQYYbxAGvGBNvngG9u7a9cidiHwU2UmDcek
         ULaA==
X-Gm-Message-State: ABuFfog7V5EUs8N83WVTUaHnFv0wv+4hM/j8+mH8V6hAJgpWjiZDhO7m
        KqtbdyS3uaRGe9h8WI/YGvPnlqz6
X-Google-Smtp-Source: ACcGV63DBnI0/fHViOjVyYArvSa7xl0xafsPruNVhYdIDaLyw+YkIAQqzLWWYpbI1yN5WttLq931zA==
X-Received: by 2002:a9d:654a:: with SMTP id q10-v6mr4812164otl.256.1537985866199;
        Wed, 26 Sep 2018 11:17:46 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id g26-v6sm1951460otj.8.2018.09.26.11.17.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:17:45 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id e21-v6so16411330otk.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:17:45 -0700 (PDT)
X-Received: by 2002:a9d:614b:: with SMTP id c11-v6mr5255190otk.178.1537985864946;
 Wed, 26 Sep 2018 11:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com> <20180926092706.GA16644@piout.net>
In-Reply-To: <20180926092706.GA16644@piout.net>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 26 Sep 2018 13:15:15 -0500
X-Gmail-Original-Message-ID: <CADRPPNQwWgU6OcE7CjxyrgSXjUjwYe4VY0gQD8jx6D+eT_DWrw@mail.gmail.com>
Message-ID: <CADRPPNQwWgU6OcE7CjxyrgSXjUjwYe4VY0gQD8jx6D+eT_DWrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To:     alexandre.belloni@bootlin.com
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

On Wed, Sep 26, 2018 at 4:28 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 25/09/2018 21:45:56+0200, Olof Johansson wrote:
> > Hi,
> >
> >
> > On Thu, Aug 23, 2018 at 11:36 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > If the qman driver (qman_ccsr) doesn't probe or fail to probe before
> > > qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
> > > unmapped page.
> > >
> > > This leads to a crash when probing  qman_portal as the init_pcfg function
> > > calls qman_liodn_fixup that tries to read qman registers.
> > >
> > > Assume that qman didn't probe when the pool mask is 0.
> > >
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > ---
> > >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > > index a120002b630e..4fc80d2c8feb 100644
> > > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> > >         }
> > >
> > >         pcfg->pools = qm_get_pools_sdqcr();
> > > +       if (pcfg->pools == 0)
> > > +               return -EPROBE_DEFER;
> >
> > This is quite late in the probe, after a bunch of resources have been claimed.
> >
> > Note that the ioremaps above this are doing unwinds, and you'll end up
> > doing duplicate ioremaps if you come in and probe again.
> >
> > You should probably unwind those allocations, or move them to devm_*
> > or do this check earlier in the function.
> >
>
> The actual chance of having that happen is quite small (this was coming
> from a non working DT) and I mainly wanted to avoid a crash so the
> platform could still boot. I would think moving to devm_ would be the
> right thing to do.

Even if it is not failing with the upstreamed device trees, it is
still good to harden the driver for possible issues.  Moving to devm_
is definitely a right thing to do.  But I also think checking if the
qman is already probed should be the first thing to do before starting
to allocate resources and etc and rolling back later.  Probably we can
move the qm_get_pools_sdqcr() to the begining of the probe to
determine if qman is probed as it doesn't seem to depend on any of the
setups done right now.

Regards,
Leo
