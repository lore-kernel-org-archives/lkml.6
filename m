Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFA7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B2920850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="enji7Fix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B2920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeLEDSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:18:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33796 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeLEDSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:18:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so18092177wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 19:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0DWsMZrObglW2zA0/UHdOcvbey0vSWCz623dOeNnbU=;
        b=enji7FixFOHWQnScPC6lRtEQ97E4xNzNAyjfKFD3NHPr6xAbHYfjfJZVXb62n3cqCF
         K3vPNz9ItOqDJ8jwBrv3zGAhgkH2NLsPLKYyG+AqaSTGv1ybHm8TYk5xJcAPYu1Yw4Us
         Ze+QKO5X7C3a4xB9FGkimYsi+Dro3xcn8x8Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0DWsMZrObglW2zA0/UHdOcvbey0vSWCz623dOeNnbU=;
        b=p3cby2plI1mE5563SFU5uo2cq9UUTqot0bvVLIU2Sx7u19f/QZBVok4zmvJarmfcwU
         UXznbaLLx+fOCG8Jl0erIJVvQOYDS4lVnM/8+DjfO3juCIR5RhOa+XFr2my9s5oORE1T
         oXrYyjSDigjPU569+bgIk8I5+KDrZiNXHlcUSfiBj0vCVK0hpqpvGdhWRY/sERxPVPmC
         NIpxkIvJvdeOR0bq4lL1q/7DJ3rrhWmE22B/gzxiqNeka/n1CL6LL0LB7lqd+dXtS+wy
         T0XQmfWuWrlWtSsaoyZoI+LxYSuSA+bXuJXpVprYwLEKGtmfDorKfhSStqExa1oxUcqI
         vA4Q==
X-Gm-Message-State: AA+aEWaLSAUlueuE5z7ZdI7ykDT7sVPjKis2FC1LEVfSbKmPFrynW2Jz
        dRe8OyiKNEx0S79uVEdPNhGbE7WIyd3ppV7tfbtA9g==
X-Google-Smtp-Source: AFSGD/WbHUT4uaDWm5rlmPCXPfeYT7ihZXcqqD41z/n9lpZ6Zu1+Zg+RlG8Fqwl0d8e7QpqHkxr0t9Mxzp7XmBBpeKU=
X-Received: by 2002:a5d:4d88:: with SMTP id b8mr1989730wru.54.1543979883872;
 Tue, 04 Dec 2018 19:18:03 -0800 (PST)
MIME-Version: 1.0
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com> <b6e02875-784f-4908-a985-5ee7e3df3ac6@gmail.com>
In-Reply-To: <b6e02875-784f-4908-a985-5ee7e3df3ac6@gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 5 Dec 2018 08:47:52 +0530
Message-ID: <CABe79T4mpnbkaTCerYegmc1+uY4idOVOxCVDqHramk3fYipiCA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Stingray thermal driver support
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you please provide your feedback to this patch series?

Regards,
Srinath.
On Thu, Nov 8, 2018 at 3:45 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 10/16/2018 8:11 AM, Srinath Mannam wrote:
> > These patches adds the stingray thermal driver and its
> > corresponding DT nodes with documentation.
>
> Can we get feedback from the thermal maintains whether this is
> acceptable or not?
>
> >
> > Changes from v4
> >   - Addressed Rob Herring comments on DT parameters and
> >     thermal driver architecture.
> >   - Removed brcm,max-crit-temp DT parameter
> >   - Changed driver to thermal sensor registration model.
> >   - Added trip DT properties.
> >
> > Changes from v3
> >   - Addressed Daniel lezcano comments.
> >   - Elaborated commit description of thermal driver patch.
> >   - Added brcm,max-crit-temp DT parameter.
> >
> > Changes from v2:
> >   - All stingray TMON DT nodes are combine together into single.
> >     Temperature registers are combined into one mem resource.
> >     brcm,tmon-mask parameter has available TMONs mask value.
> >   - All available TMONs are initialized together in single
> >     instance of driver probe call.
> >
> > Changes from v1:
> >   - Fixed auto build sparce warning.
> >
> > Pramod Kumar (3):
> >   dt-bindings: thermal: Add binding document for SR thermal
> >   thermal: broadcom: Add Stingray thermal driver
> >   arm64: dts: stingray: Add Stingray Thermal DT support.
> >
> >  .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++
> >  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++
> >  drivers/thermal/Kconfig                            |   3 +-
> >  drivers/thermal/broadcom/Kconfig                   |   9 ++
> >  drivers/thermal/broadcom/Makefile                  |   1 +
> >  drivers/thermal/broadcom/sr-thermal.c              | 138 +++++++++++++++++++++
> >  6 files changed, 344 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> >  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> >
>
> --
> Florian
