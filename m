Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ACEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507A52173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfBZRoI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:44:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35424 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:44:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id z19so11857017otm.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z1OS+Lzpj3DeHAi3lqfkSXwSW4LD8wDRWAjP9wzKHak=;
        b=cEV48nxU0M29TNHTex5BZlw8qGakOAbg86E4yNazOo1yYQcaCQ7/a5YFAvFCUq6Y02
         x3oKESbzYfCZE6WsBXnOU8N0WrbCFguvQ1im/eCJQ+/q5K/kUlMoqtovNb8/92AqbiRJ
         yQsO4PG/0AX6SDJ0RMuECfCijm9sHhTISSXBtMPSGiFTdbOVcUJAKR1+b0ha3D6Oo+z5
         cVuL2J/UHUOH6fP9aNZuAPknwiVykekGv7JtK/sKPoOT5bNG8R71fNgRYExg8BGQkmmd
         LZnyN5CgmmNlL42XaDLi30pZBYYuqHD+l3CMhae1+zO9ek1Ad+LXdAjcnzXvw2iha7MZ
         Xmpg==
X-Gm-Message-State: AHQUAub9JLL+VwM+m9Ets5r+dDW8wKhhNAISFeX630E2xebCT137uows
        +w28d8EPRzVeuUJGkozASiBLIQ9K
X-Google-Smtp-Source: AHgI3IbLy+ct/7148WXNWMyBKH+dZBYdGIBzEf+bL9f6fqDcUrh0OAHIVGlbObWBFjMS0amGW3SQhg==
X-Received: by 2002:a9d:7dcb:: with SMTP id k11mr16497703otn.192.1551203047224;
        Tue, 26 Feb 2019 09:44:07 -0800 (PST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id c38sm5489776otb.3.2019.02.26.09.44.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:44:06 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id m1so11839571otf.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:44:06 -0800 (PST)
X-Received: by 2002:a9d:4708:: with SMTP id a8mr15251874otf.51.1551203046342;
 Tue, 26 Feb 2019 09:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20190221103731.28978-1-horia.geanta@nxp.com> <VI1PR0401MB2237C56CD38D546E83218C8FF87F0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB2237C56CD38D546E83218C8FF87F0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 26 Feb 2019 11:43:55 -0600
X-Gmail-Original-Message-ID: <CADRPPNSPpYdvCqDh+m0J7VtuRsYx-nP6_20JvPrb1yt93gmPxQ@mail.gmail.com>
Message-ID: <CADRPPNSPpYdvCqDh+m0J7VtuRsYx-nP6_20JvPrb1yt93gmPxQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: guts: make fsl_guts_get_svr() static
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 2:09 AM Y.b. Lu <yangbo.lu@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Horia Geantă <horia.geanta@nxp.com>
> > Sent: Thursday, February 21, 2019 6:38 PM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: Y.b. Lu <yangbo.lu@nxp.com>; linuxppc-dev@lists.ozlabs.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] soc: fsl: guts: make fsl_guts_get_svr() static
> >
> > The export of fsl_guts_get_svr() is a left-over, it's currently used only internally
> > and users needing SoC information should use the generic soc_device
> > infrastructure.
> >
>
> [Y.b. Lu] Acked-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next.  Thanks.

>
> > Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> > ---
> >  drivers/soc/fsl/guts.c   | 3 +--
> >  include/linux/fsl/guts.h | 2 --
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c index
> > 4f9655087bd7..63f6df86f9e5 100644
> > --- a/drivers/soc/fsl/guts.c
> > +++ b/drivers/soc/fsl/guts.c
> > @@ -115,7 +115,7 @@ static const struct fsl_soc_die_attr
> > *fsl_soc_die_match(
> >       return NULL;
> >  }
> >
> > -u32 fsl_guts_get_svr(void)
> > +static u32 fsl_guts_get_svr(void)
> >  {
> >       u32 svr = 0;
> >
> > @@ -129,7 +129,6 @@ u32 fsl_guts_get_svr(void)
> >
> >       return svr;
> >  }
> > -EXPORT_SYMBOL(fsl_guts_get_svr);
> >
> >  static int fsl_guts_probe(struct platform_device *pdev)  { diff --git
> > a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h index
> > 941b11811f85..1fc0edd71c52 100644
> > --- a/include/linux/fsl/guts.h
> > +++ b/include/linux/fsl/guts.h
> > @@ -135,8 +135,6 @@ struct ccsr_guts {
> >       u32     srds2cr1;       /* 0x.0f44 - SerDes2 Control Register 0 */
> >  } __attribute__ ((packed));
> >
> > -u32 fsl_guts_get_svr(void);
> > -
> >  /* Alternate function signal multiplex control */  #define
> > MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
> >
> > --
> > 2.16.2
>
