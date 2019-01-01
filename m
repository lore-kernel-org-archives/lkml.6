Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAE6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B8F21019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fktClN+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfAAQHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 11:07:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41666 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfAAQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 11:07:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so13580812plm.8;
        Tue, 01 Jan 2019 08:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Kn6rNictp1Dew3UUAZaRUmeDmCNm+3V7xeDdhxN8a00=;
        b=fktClN+DhDl+8XsGO0JLqloF85gYR9Wpi7JlBXj0w/FqH4Nb6jw+Tud4PJtmTmvwhj
         4H/wXYct5rWEP4lm8o0aFwYq6FxQNadvR/icdUaiGyYkZKagKwVu/rhSLApy1kHOYkNn
         rtjiaaIfItxS+6FmO5/+8ksFk/tk+5P3KSMlbsqLvJ/G5Tqdy0jF0aUj+bweI5PebiFp
         qgbDRE/DbwMDF5eOCPeF/HpBJlpnn3FHAnVWyv2JCTrs4EPZu1q4hRnhTQd5HBAQ8CTm
         8Ntsg56Bafw+/ilDhVEqDFL2mEVvHpDPC/H6/eDLavU5xg6kYz56iKa3DIBQxz4IqDXq
         sPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Kn6rNictp1Dew3UUAZaRUmeDmCNm+3V7xeDdhxN8a00=;
        b=HipiwN2lDflflODtx+I3TIPxRYqKjtJSeZaYzA3UsteWtCthvi0G7OXCxcMQannpaz
         2aNZoqyUD77NA6wVKrNP9vIVmnb37GfSbLVk81Ar5kC8iBeOZc7rtiSjVeGIhYyVhoKt
         V3U8A8tCy7fuLLI4BrF0tz2hYcV66khsNiKFY3Nfq9BFD4qsAFODvEQvqBY295KG1fIn
         WuoYVxIgf1h1txd5ejpuVQFGAYY0csASExyAU4atCrQHQwVKZlYerIaYnOse9rGl73cw
         wIfKdgaBivQrteShYZhnw9nJozWulLkZaB2IFSngwdqVZUPLTmKrWH4XB78Fd1NrnyF/
         0UEQ==
X-Gm-Message-State: AJcUukfArqcm9MGKwCHU9qArdKL+0z4vTlf46rylbjhHCaUH3J5N9tlk
        eh1GtcMdTlcaNrR5AcE3g6M=
X-Google-Smtp-Source: ALg8bN56DbfMcg2EpG9IS/28PeapaxzeVFca5rUUBdXeRCsvMZcfSH264G9ZTQQXqtZmE8RzkGLjJg==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr14025061pla.228.1546358856974;
        Tue, 01 Jan 2019 08:07:36 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id n68sm83224498pfb.62.2019.01.01.08.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 08:07:36 -0800 (PST)
Date:   Tue, 1 Jan 2019 08:07:34 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v5 0/3] Stingray thermal driver support
Message-ID: <20190101160733.GB3306@localhost.localdomain>
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
 <b6e02875-784f-4908-a985-5ee7e3df3ac6@gmail.com>
 <CABe79T4mpnbkaTCerYegmc1+uY4idOVOxCVDqHramk3fYipiCA@mail.gmail.com>
 <3c05a1f1-5041-ebb7-27e5-0a2321314b0a@broadcom.com>
 <1546351479.2077.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546351479.2077.1.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 10:04:39PM +0800, Zhang Rui wrote:
> On 一, 2018-12-31 at 14:15 -0800, Florian Fainelli wrote:
> > 
> > On 04/12/2018 19:17, Srinath Mannam wrote:
> > > 
> > > Hi,
> > > 
> > > Could you please provide your feedback to this patch series?
> > Rui or Eduardo can we get either one of you to review the thermal
> > driver
> > parts of this patch series? Why do we constantly have to chase people
> > to
> > respond in this specific subsystem?
> > 
> Eduardo, can you please take a look at this patch series?

Yup, I will take a look.

> 
> thanks,
> rui
> > > 
> > > 
> > > Regards,
> > > Srinath.
> > > On Thu, Nov 8, 2018 at 3:45 AM Florian Fainelli <f.fainelli@gmail.c
> > > om> wrote:
> > > > 
> > > > 
> > > > 
> > > > 
> > > > On 10/16/2018 8:11 AM, Srinath Mannam wrote:
> > > > > 
> > > > > These patches adds the stingray thermal driver and its
> > > > > corresponding DT nodes with documentation.
> > > > Can we get feedback from the thermal maintains whether this is
> > > > acceptable or not?
> > > > 
> > > > > 
> > > > > 
> > > > > Changes from v4
> > > > >   - Addressed Rob Herring comments on DT parameters and
> > > > >     thermal driver architecture.
> > > > >   - Removed brcm,max-crit-temp DT parameter
> > > > >   - Changed driver to thermal sensor registration model.
> > > > >   - Added trip DT properties.
> > > > > 
> > > > > Changes from v3
> > > > >   - Addressed Daniel lezcano comments.
> > > > >   - Elaborated commit description of thermal driver patch.
> > > > >   - Added brcm,max-crit-temp DT parameter.
> > > > > 
> > > > > Changes from v2:
> > > > >   - All stingray TMON DT nodes are combine together into
> > > > > single.
> > > > >     Temperature registers are combined into one mem resource.
> > > > >     brcm,tmon-mask parameter has available TMONs mask value.
> > > > >   - All available TMONs are initialized together in single
> > > > >     instance of driver probe call.
> > > > > 
> > > > > Changes from v1:
> > > > >   - Fixed auto build sparce warning.
> > > > > 
> > > > > Pramod Kumar (3):
> > > > >   dt-bindings: thermal: Add binding document for SR thermal
> > > > >   thermal: broadcom: Add Stingray thermal driver
> > > > >   arm64: dts: stingray: Add Stingray Thermal DT support.
> > > > > 
> > > > >  .../bindings/thermal/brcm,sr-thermal.txt           | 105
> > > > > ++++++++++++++++
> > > > >  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89
> > > > > +++++++++++++
> > > > >  drivers/thermal/Kconfig                            |   3 +-
> > > > >  drivers/thermal/broadcom/Kconfig                   |   9 ++
> > > > >  drivers/thermal/broadcom/Makefile                  |   1 +
> > > > >  drivers/thermal/broadcom/sr-thermal.c              | 138
> > > > > +++++++++++++++++++++
> > > > >  6 files changed, 344 insertions(+), 1 deletion(-)
> > > > >  create mode 100644
> > > > > Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> > > > >  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> > > > > 
> > > > --
> > > > Florian
