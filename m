Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A182087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A182087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeH2Cn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:43:27 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36033 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeH2Cn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:43:27 -0400
Received: by mail-it0-f66.google.com with SMTP id u13-v6so4742872iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 15:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qL7z73fKeOxfx9ihsofhTALxcpvN7NS+XjNXNUVEJqQ=;
        b=WWGsGGcLyYIvZE+5PwYERU6WA7Y9R2CqdxX5Rh7PaFvDKgdYRnaakYQLEmqC3DNbho
         Ad9vImXtczyC+mzBEwL1fJumwXyOpK1sbr7tPKALIdApH3C89qeDezMff7stX8WbIXwy
         vdJXkj8WdbRg2zsEP36U5VyZ6XPN/q6n4S7fA3L10yaK5U6qbUnrbIYhJGKAYOy55yt8
         70XXEzINyO16qNjQEpUKtKi+1G1W2kwL8DJUEoVPbOm+nzNceDfGpP6Sh9M+POoH+fQV
         iZfKbBCTcuNLWLOfv+el71lxQdCUlyFiUwmkCEYuDPO/nrd7/ozD7GaOB2UYdGAgV6Sr
         ND0A==
X-Gm-Message-State: APzg51BBACAeDzGnlpgAR+4W8fK/KzgSpyYLoTnlaMOVt63O2OCST06k
        N/VH10HQM4bBl73Es8/HAibl5f0Czjs=
X-Google-Smtp-Source: ANB0VdYreL1D8tpfWlxOJxgXi9jdLjIPSnMXxWPrITwP0bQv9BAisxhCYyq7mEOBjUXNvZeH3W8IVg==
X-Received: by 2002:a02:9962:: with SMTP id d31-v6mr3321232jak.1.1535496577874;
        Tue, 28 Aug 2018 15:49:37 -0700 (PDT)
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com. [209.85.214.48])
        by smtp.gmail.com with ESMTPSA id 65-v6sm1912071itw.44.2018.08.28.15.49.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 15:49:37 -0700 (PDT)
Received: by mail-it0-f48.google.com with SMTP id h20-v6so4737585itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 15:49:37 -0700 (PDT)
X-Received: by 2002:a24:21c4:: with SMTP id e187-v6mr3337680ita.5.1535496576935;
 Tue, 28 Aug 2018 15:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com> <DB6PR0402MB27276B417034E7356B0CFA5886360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB27276B417034E7356B0CFA5886360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 28 Aug 2018 17:49:25 -0500
X-Gmail-Original-Message-ID: <CADRPPNRJFii=ybTVm=NMGMT8U02JKsjYsgA6PR52owK=Bc3cgA@mail.gmail.com>
Message-ID: <CADRPPNRJFii=ybTVm=NMGMT8U02JKsjYsgA6PR52owK=Bc3cgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To:     Roy Pledge <roy.pledge@nxp.com>
Cc:     alexandre.belloni@bootlin.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 9:54 AM Roy Pledge <roy.pledge@nxp.com> wrote:
>
> On 8/23/2018 5:36 PM, Alexandre Belloni wrote:
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

Series applied to the fix branch of soc/fsl.

> > ---
> >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > index a120002b630e..4fc80d2c8feb 100644
> > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> >       }
> >
> >       pcfg->pools = qm_get_pools_sdqcr();
> > +     if (pcfg->pools == 0)
> > +             return -EPROBE_DEFER;
> >
> >       spin_lock(&qman_lock);
> >       cpu = cpumask_next_zero(-1, &portal_cpus);
>
> Reviewed-by: Roy Pledge <roy.pledge@nxp.com>
>
>
