Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66835C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5E52171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VS4d1tLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfABEc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 23:32:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52738 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfABEc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 23:32:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so25698481wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 20:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e64NoCid3NQ++u61fL13VoDWD1H9PCdoaVblLH37Kxs=;
        b=VS4d1tLAze7sRQKbNFHP6uZGVCJ3R7BVaD0PpO96VaJ6HjM5EvJDFJn8H50mrhI0iV
         32EwHuM5Dyj0qKtAmG2Ijfn42xmffnCxtvOGGhhSAeO/uEgbjQjypZs0rOXLEEOOmjC0
         DpPfLlvoDug/21ZO7eyBZUXD2F6IntYfJzaNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e64NoCid3NQ++u61fL13VoDWD1H9PCdoaVblLH37Kxs=;
        b=VpswMF9dPCdbRuqK3UY7rKOsBOJt81fqE8iEqFCRB75GpnYL7Qci+t/S9mz+r8/EcC
         o64PGW1UQHWJ5i6OwimJYWRMM4tzPRi+7GpZUBl7TKJjTh8BlMb9GHo+yud88OAYSRBD
         kgLl1EA8NN/0lXbULPZ+nAkYovLhTS42m60vAByfPoETo7IXJwoECCTVQKE/eOWXU20F
         QkBNCv2o2TgfU7ZYyobVDGpCKyyI1fktMt85x33OtDci/qwfpRoQS37odUzXmEML+wdn
         mPl3y4UhU9TEGpYFk3JhRto0ILG2vgde2KyhQN7o+w6W9ftAUhFbRquZjrbCu1wYgxpF
         8C5Q==
X-Gm-Message-State: AJcUuke01VbQG0pQyc1+zLlXCGzNzgNL/JpeOusSjIg2Y5/MzG4e5AfC
        ECcCO85/M7h5cQKMhsuD0H4JA4T8qMMM7aZ/YjJyEw==
X-Google-Smtp-Source: AFSGD/X1YYqsEEGFqSFCEWy8HihMhO9nK9oGgO8rSCyRmpU0W6F8ULTpPT/9VWuj+1m2Fqvty/iGYfnhDeQjhTjVFbg=
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr33650697wmg.53.1546403574489;
 Tue, 01 Jan 2019 20:32:54 -0800 (PST)
MIME-Version: 1.0
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
 <b6e02875-784f-4908-a985-5ee7e3df3ac6@gmail.com> <CABe79T4mpnbkaTCerYegmc1+uY4idOVOxCVDqHramk3fYipiCA@mail.gmail.com>
 <3c05a1f1-5041-ebb7-27e5-0a2321314b0a@broadcom.com> <1546351479.2077.1.camel@intel.com>
 <20190101160733.GB3306@localhost.localdomain>
In-Reply-To: <20190101160733.GB3306@localhost.localdomain>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 2 Jan 2019 10:02:43 +0530
Message-ID: <CABe79T7FiAiCELmgK9xUiSaW8g=Vx6mBzan7+=8zx4uZ2jh1Rw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Stingray thermal driver support
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui, Eduardo,

Wish you very happy new year and Thank you very much for your response.

Regards,
Srinath.

On Tue, Jan 1, 2019 at 9:37 PM Eduardo Valentin <edubezval@gmail.com> wrote=
:
>
> On Tue, Jan 01, 2019 at 10:04:39PM +0800, Zhang Rui wrote:
> > On =E4=B8=80, 2018-12-31 at 14:15 -0800, Florian Fainelli wrote:
> > >
> > > On 04/12/2018 19:17, Srinath Mannam wrote:
> > > >
> > > > Hi,
> > > >
> > > > Could you please provide your feedback to this patch series?
> > > Rui or Eduardo can we get either one of you to review the thermal
> > > driver
> > > parts of this patch series? Why do we constantly have to chase people
> > > to
> > > respond in this specific subsystem?
> > >
> > Eduardo, can you please take a look at this patch series?
>
> Yup, I will take a look.
>
> >
> > thanks,
> > rui
> > > >
> > > >
> > > > Regards,
> > > > Srinath.
> > > > On Thu, Nov 8, 2018 at 3:45 AM Florian Fainelli <f.fainelli@gmail.c
> > > > om> wrote:
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > On 10/16/2018 8:11 AM, Srinath Mannam wrote:
> > > > > >
> > > > > > These patches adds the stingray thermal driver and its
> > > > > > corresponding DT nodes with documentation.
> > > > > Can we get feedback from the thermal maintains whether this is
> > > > > acceptable or not?
> > > > >
> > > > > >
> > > > > >
> > > > > > Changes from v4
> > > > > >   - Addressed Rob Herring comments on DT parameters and
> > > > > >     thermal driver architecture.
> > > > > >   - Removed brcm,max-crit-temp DT parameter
> > > > > >   - Changed driver to thermal sensor registration model.
> > > > > >   - Added trip DT properties.
> > > > > >
> > > > > > Changes from v3
> > > > > >   - Addressed Daniel lezcano comments.
> > > > > >   - Elaborated commit description of thermal driver patch.
> > > > > >   - Added brcm,max-crit-temp DT parameter.
> > > > > >
> > > > > > Changes from v2:
> > > > > >   - All stingray TMON DT nodes are combine together into
> > > > > > single.
> > > > > >     Temperature registers are combined into one mem resource.
> > > > > >     brcm,tmon-mask parameter has available TMONs mask value.
> > > > > >   - All available TMONs are initialized together in single
> > > > > >     instance of driver probe call.
> > > > > >
> > > > > > Changes from v1:
> > > > > >   - Fixed auto build sparce warning.
> > > > > >
> > > > > > Pramod Kumar (3):
> > > > > >   dt-bindings: thermal: Add binding document for SR thermal
> > > > > >   thermal: broadcom: Add Stingray thermal driver
> > > > > >   arm64: dts: stingray: Add Stingray Thermal DT support.
> > > > > >
> > > > > >  .../bindings/thermal/brcm,sr-thermal.txt           | 105
> > > > > > ++++++++++++++++
> > > > > >  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89
> > > > > > +++++++++++++
> > > > > >  drivers/thermal/Kconfig                            |   3 +-
> > > > > >  drivers/thermal/broadcom/Kconfig                   |   9 ++
> > > > > >  drivers/thermal/broadcom/Makefile                  |   1 +
> > > > > >  drivers/thermal/broadcom/sr-thermal.c              | 138
> > > > > > +++++++++++++++++++++
> > > > > >  6 files changed, 344 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644
> > > > > > Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> > > > > >  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> > > > > >
> > > > > --
> > > > > Florian
