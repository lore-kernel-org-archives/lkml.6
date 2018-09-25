Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D95C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865BE2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865BE2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeIZEVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:21:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40778 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeIZEVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:21:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id g14-v6so12467947otj.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 15:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAiNAgN+dYL0PdpAZITu7basDKOzzCXwZer8dJER9E0=;
        b=FjjAzPHFFvme6ASMCPFQpCAawzsdxBorwjFtYnbmTV1alPIW21Z+6yuaGk58bZvyL+
         uyJ+YpH2ATGeO31xMt/6+wtD6CsJ2HF/SrcjYYFLOrqeTv6jsSqr5BvIqEIE80Jz6Oam
         9GqGkamZ77/O3sTeL0zvB/0u6H+hEu5/xBXB0JabUsoMOBIL7wC0DhVU+0f2PKEHXGie
         InewriFOGrbeXrfFJy230sqkd2INcrddyRm9YoU970EAq/b4SDau6+ShR5pq2sMWdSLi
         dT3EDWXsABF5SDrKnBP1EVF5rcZi9LOA40FUu78yncgKFxTVKtmNh12n/mICpS8YXVH+
         pL7g==
X-Gm-Message-State: ABuFfoimPysXZaHbpCihQ5zhBvvhtNIQcbBGx9C1OhvZBeAQ0fpA5Xxi
        IyW4pgVN9WlMTQybQpdy8ml9Nu0nQ8Y=
X-Google-Smtp-Source: ACcGV62ZJ1qLlK2lXT+CkspNNJxcOR1BV3XrgtcovhGkZRQi+jo7roXyAoC5f8pKsBuP+z0N2F8jHA==
X-Received: by 2002:a9d:a6:: with SMTP id w35-v6mr2102173oti.109.1537913517416;
        Tue, 25 Sep 2018 15:11:57 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id d5-v6sm1102130oia.57.2018.09.25.15.11.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:11:57 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id h26-v6so26072106otl.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 15:11:56 -0700 (PDT)
X-Received: by 2002:a9d:1541:: with SMTP id z1-v6mr2096345otz.186.1537913516789;
 Tue, 25 Sep 2018 15:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com> <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
In-Reply-To: <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 25 Sep 2018 17:11:44 -0500
X-Gmail-Original-Message-ID: <CADRPPNSwGDsLctOe_yiFBfYVQU3Jm7Z724wyhBFuWmaTZq0T9A@mail.gmail.com>
Message-ID: <CADRPPNSwGDsLctOe_yiFBfYVQU3Jm7Z724wyhBFuWmaTZq0T9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To:     Olof Johansson <olof@lixom.net>
Cc:     alexandre.belloni@bootlin.com, Roy Pledge <roy.pledge@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 2:47 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
>
> On Thu, Aug 23, 2018 at 11:36 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > If the qman driver (qman_ccsr) doesn't probe or fail to probe before
> > qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
> > unmapped page.
> >
> > This leads to a crash when probing  qman_portal as the init_pcfg function
> > calls qman_liodn_fixup that tries to read qman registers.
> >
> > Assume that qman didn't probe when the pool mask is 0.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > index a120002b630e..4fc80d2c8feb 100644
> > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> >         }
> >
> >         pcfg->pools = qm_get_pools_sdqcr();
> > +       if (pcfg->pools == 0)
> > +               return -EPROBE_DEFER;
>
> This is quite late in the probe, after a bunch of resources have been claimed.
>
> Note that the ioremaps above this are doing unwinds, and you'll end up
> doing duplicate ioremaps if you come in and probe again.
>
> You should probably unwind those allocations, or move them to devm_*
> or do this check earlier in the function.

Hi Roy,

Is there any more straightforward indicator on if qman has been
probed?  So that we can check it at the begining of the probe?

Regards,
Leo
