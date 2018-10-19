Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5788ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9057421479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teiCy9VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9057421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJSWIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:08:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46793 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeJSWIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:08:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so38343359qtk.13;
        Fri, 19 Oct 2018 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgoJx498Csj6POOAmeDLRXcHy/mbPmfZalD8hJUB96s=;
        b=teiCy9VA42YOczLteWHPwwp1rqAl9IFvAfOPsxlVIpeKcGjDX4uuJoweHLW4+z6J7d
         lUKO65GO82gceVvbrjJQTaFZOsnQjENosZvcPCyvhLvSGaAM4b8xpzbfxLM7LV4Cdig7
         rMG1RZ6C/Q+2KMd7t1YfbAkvy9uRTgYl748RuX0Yo5NF/z+Ds2sm8L/R2ImukTrbp77s
         MCht79KaTRqiqNfmFiSP8uXEYyaRG7Lfk26VOus5lHZXeATTXCwRX2IIG0oPEfrDutb+
         9VkJTf0enpWqAX1+eqyRzK2kq1/oj/yebLTejreA0L/YdHB2LwnB4WvfwVx3sGx5zCGF
         CcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgoJx498Csj6POOAmeDLRXcHy/mbPmfZalD8hJUB96s=;
        b=kLkVe60tEGN1DzcETb5fcVMuCeeCcK54ThWsD3LfhvlYT01ixwuuYszaZ0Z4ZNkSiv
         XJHOHeHZcZV76Uxs+o1KCcYiBU4HJKofmQD1pVg7w1ckSPjkcIQlzv97d69g157mAeYk
         q5h6yfQvahEkJuWdX9z2AgzTMDIWDgGLUddjMrq5fK0qY/Fz3QCaenJtOA38vOZJFUxp
         1OsYAqi7+c+YTn4AfCZ/yEqff1mslASei7eE/YScbHgjp09xR19qsPMafZONUBWv+9VJ
         ai6dtAZNr/MMGelffCf1ei4dW6n13Ad5VRoHELvIzrgX6wqzKw5PxvGYAIxTgRr/m9cA
         3nyA==
X-Gm-Message-State: AGRZ1gKwhvyzvn526uiJcdpzusjKSMPGyhEsfVEjJqE9Ee+lYC14C6jr
        DgU8zZRzYasXEgZL/ry2rWhfaPpf/tRxuubdF30=
X-Google-Smtp-Source: ACcGV61eq582Nsz4UA1OYiS9Rp2QLJtC8dv7ATESrTmUgahjVHmk6ROJ+EH6qYEmBWXQncc2CACOnZTw3YJuzFrQX00=
X-Received: by 2002:ac8:191a:: with SMTP id t26-v6mr1461138qtj.327.1539957742769;
 Fri, 19 Oct 2018 07:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <262d8a05cedc76bc90fa5be7d3b92d5faa2b4ce9.camel@perches.com>
 <20181012162816.14396-1-david.e.box@intel.com> <6fd036103f87d52214694ac0a172527a113c07b5.camel@perches.com>
 <CAHp75VcPiyU+NKnzEdqSye2Eat8RtxNyFbUKZ3DGdXinF5A=eg@mail.gmail.com>
In-Reply-To: <CAHp75VcPiyU+NKnzEdqSye2Eat8RtxNyFbUKZ3DGdXinF5A=eg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 17:02:11 +0300
Message-ID: <CAHp75VdvVCcnqBZ7Ctd86MSCgYqubaybMhZoPSi_p9hZ310xkg@mail.gmail.com>
Subject: Re: [PATCH V3] MAINTAINERS: intel_telemetry: Update maintainers info
To:     Joe Perches <joe@perches.com>
Cc:     "Box, David E" <david.e.box@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rajneesh.bhardwaj@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 6:51 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Oct 12, 2018 at 7:46 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Fri, 2018-10-12 at 09:28 -0700, David E. Box wrote:
> > > Remove Souvik who has left this role. Add Rajneesh and David who work
> > > jointly on telemetry updates for new platforms.
> > >
> > > Signed-off-by: David E. Box <david.e.box@intel.com>
> > > Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> > []
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> > > @@ -7355,7 +7355,8 @@ F:      arch/x86/crypto/sha*-mb
> > >  F:   crypto/mcryptd.c
> > >
> > >  INTEL TELEMETRY DRIVER
> > > -M:   Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> > > +M:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> > > +M:   "David E. Box" <david.e.box@linux.intel.com>
> > >  L:   platform-driver-x86@vger.kernel.org
> > >  S:   Maintained
> >
> >         S: Status, one of the following:
> >            Supported:   Someone is actually paid to look after this.
> >            Maintained:  Someone actually looks after it.
> >
> > Perhaps this is driver status should be marked
> >
> >         "S:     Supported"
> >
> > >  F:   arch/x86/include/asm/intel_telemetry.h
>
> Thanks, Joe.
> I may fix it when applying.

Hmm... Since it's not related to the change done in the patch I would
do rather a separate one. And moreover hear an opinion from Darren. I
don't remember if we have any rule of thumb for the drivers to be only
"supported" and not "maintained".

-- 
With Best Regards,
Andy Shevchenko
