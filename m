Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B877DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837632192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gye/jHNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfBOEVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:21:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41309 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfBOEVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:21:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so8829712wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 20:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RJUQALfhh0Z+nvhG34lMCIvDNcnO8WzcexCEEVtxyA=;
        b=Gye/jHNFgsaYcDDt7SwgEShPGqbyFPWKndxghZmdx76Tehmqi9gGzsPodSSwwLvpsD
         Kc9nhRfLM0jACKEXVzK3LzAJoOr2H4yRhgg+BJzfI4iAfYr8GW81PHdkBYdGxUOgg5FD
         7VmJCT6MLKOdTMhRS7HqlPxIJOWl4le8mg8AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RJUQALfhh0Z+nvhG34lMCIvDNcnO8WzcexCEEVtxyA=;
        b=oAYYXB0YS3WKXKzl065YYHvcaBmdQPsiiuK0vz9JHUF7syVwEkucb+d+BDrjeLtFcX
         OdJqJcRSNe1PZ0zpePUvJFT5qbNStPYTLdG6rDj05Ee6fR5itUpd1Tf71o/v/sTWP7vf
         /wUHgbHp46SlPL0CUb52N7zJJCT8/tTV+trkjoYwYk2yIXN84TflW7u/2sWbg5+pykQP
         PKKY8qsYrQ7e/HdZpi0mKaCeypiKpbvmAoAftENiefPSmmnzxhCiPEL0PSbVCqPWSbJl
         wTAPhVQ0D3azTgu4SmCmMiY3RaHgvFjuvnAz7Q8b0W5P9yVnbdZl7sECV3RrwQ4xOD7f
         jRgg==
X-Gm-Message-State: AHQUAua2g6ZbN6IQbT7mKO6rXHyE+3il7KYjvHjt3CIenUxgL2EB2eia
        3b/l7A6gaigdOgkzyanjlj8qxoocEJCGMldaZFVl2Q==
X-Google-Smtp-Source: AHgI3Ib51h/wHkRYv0eitf4FpYL77KSOxGGRPojSm5DY7U3x2tK+P7W5MvWfyqhv/PTdk/TaYUsDPcUOamtLjjLabNw=
X-Received: by 2002:adf:9ecc:: with SMTP id b12mr5181629wrf.83.1550204463210;
 Thu, 14 Feb 2019 20:21:03 -0800 (PST)
MIME-Version: 1.0
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
 <a6113115-453c-4606-f99d-c79263d8f4bb@broadcom.com> <20190205235811.GA19687@localhost.localdomain>
In-Reply-To: <20190205235811.GA19687@localhost.localdomain>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 15 Feb 2019 09:50:51 +0530
Message-ID: <CABe79T4bcNs9efLRt1OsTekT+9PHq837x0fngf0kGUdkC5mMsA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Stingray thermal driver support
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo,

Could you please provide your review comments?

Regards,
Srinath.

On Wed, Feb 6, 2019 at 5:28 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Hello,
>
> On Mon, Feb 04, 2019 at 04:16:19PM -0800, Ray Jui wrote:
> > Hi Zhang/Eduardo,
> >
> > Can this patch series be merged? It looks like Srinath has addressed all
> > review comments?
>
> I will take a look. Side note, thermal patches are reviewed on
> linux-pm@vger.kernel.org. Copying that list it does help because that
> is how the patches get assigned in patchwork.kernel.org.
>
> >
> > The following tag should be added to the binding document patch:
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Thanks,
> >
> > Ray
> >
> > On 1/3/2019 12:55 AM, Srinath Mannam wrote:
> > > These patches adds the stingray thermal driver and its
> > > corresponding DT nodes with documentation.
> > >
> > > Changes from v5
> > >   - Addressed Eduardo Valentin comments.
> > >
> > > Changes from v4
> > >   - Addressed Rob Herring comments on DT parameters and
> > >     thermal driver architecture.
> > >   - Removed brcm,max-crit-temp DT parameter
> > >   - Changed driver to thermal sensor registration model.
> > >   - Added trip DT properties.
> > >
> > > Changes from v3
> > >   - Addressed Daniel lezcano comments.
> > >   - Elaborated commit description of thermal driver patch.
> > >   - Added brcm,max-crit-temp DT parameter.
> > >
> > > Changes from v2:
> > >   - All stingray TMON DT nodes are combine together into single.
> > >     Temperature registers are combined into one mem resource.
> > >     brcm,tmon-mask parameter has available TMONs mask value.
> > >   - All available TMONs are initialized together in single
> > >     instance of driver probe call.
> > >
> > > Changes from v1:
> > >   - Fixed auto build sparce warning.
> > >
> > > Pramod Kumar (3):
> > >   dt-bindings: thermal: Add binding document for SR thermal
> > >   thermal: broadcom: Add Stingray thermal driver
> > >   arm64: dts: stingray: Add Stingray Thermal DT support.
> > >
> > >  .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++++
> > >  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++++
> > >  drivers/thermal/Kconfig                            |   3 +-
> > >  drivers/thermal/broadcom/Kconfig                   |   9 ++
> > >  drivers/thermal/broadcom/Makefile                  |   1 +
> > >  drivers/thermal/broadcom/sr-thermal.c              | 122 +++++++++++++++++++++
> > >  6 files changed, 328 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> > >  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> > >
