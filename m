Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D52AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20912218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGss0F3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfBAMFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:05:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46332 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbfBAMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:05:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so5531564ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9WunhkcVNnc7qqwFVSoWpkdTQdxgKjD8Aq4PO7VEJ0=;
        b=PGss0F3MD3HT4TDT+aNQPtMqr05rGuhCO+vOOV3bZbgCqnA2zwjSRVZ1ypph54jNSu
         1mOTJLiEdCwPIbEWakyv0b68IPgpQ0jyOcyGoqOhQ7VggF4oODzid4xXwj6MSv3oTp9p
         ZqNApiq7O06Peys+bWPCmzDPxjzeZ2aul9W98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9WunhkcVNnc7qqwFVSoWpkdTQdxgKjD8Aq4PO7VEJ0=;
        b=Nwd07vkXxrzJLueMmCXsGwiQZ5bd6We9sbSLM9df/4wpXFX94ryxVvOcZJNf6l6mWc
         ubpyEdRgxc0g1kNRVr8hwjkprT1jhjeKhdcBFuSxpDy7OE1sTfoMPMceXjmEetkZoBUz
         ToHSLtUpWfqUOFKxaoTZX/8LQc+ZCHnmFcjsQ+Zl0zT14obavm/DWqMRHp+SIaYgM4SM
         U9Si0sN8HcajTjqmYPD8gtQScg9ylkTEjVkrCSiKCSzVryt6pdGIX3v/K/PD+bsQSx7j
         9Zfot/X5SJ6gK8R0QEy4WFJ79cPeNRoZsJiu/x0knVih+W5ekHx++/H/GWLxNAYIFUoY
         i/Qg==
X-Gm-Message-State: AJcUukeC/Rh09EJPxj8neTpBSp6zwAyVKXLWS4KbuWUwpPeXac/OKumt
        WXUGflN3MEahc+zQrBgYEjqoIuGtcN0a/MHJ+p/eWQ==
X-Google-Smtp-Source: ALg8bN46lO7K3tOta5hrw+lUf9nsJnwT3Nhnoa6ufjpRecAKxQwcjlL+q7k6lud3a5WJwsBsXQW90ZZ+JQsKne5SI/w=
X-Received: by 2002:a2e:9d8e:: with SMTP id c14-v6mr32846984ljj.146.1549022742822;
 Fri, 01 Feb 2019 04:05:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org> <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
In-Reply-To: <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 1 Feb 2019 20:05:30 +0800
Message-ID: <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, 31 Jan 2019 at 00:46, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 21, 2019 at 8:39 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > This patch set adds charger and fuel gauge device nodes for Spreadtrum
> > SC2731 PMIC, it also removes redundant irq trigger setting for PMIC
> > devices and adds nvmem cells for ADC to calibrate the ADC channel scales.
> >
> > Baolin Wang (4):
> >   arm64: dts: sprd: Remove PMIC INTC irq trigger type
> >   arm64: dts: sprd: Add ADC calibration support
> >   arm64: dts: sprd: Add SC2731 charger device
> >   arm64: dts: sprd: Add SC27XX fuel gauge device
>
> I did not apply these because of the 'sc27xx' wildcard matching.
>
> Please fix those up and resend.
>

On Spreadtrum platform, we use one mfd driver [1] to populate the
SC27XX series PMICs including SC2731, SC2721, SC2720 and SC2730. So we
use sc27xx to be compatible with different PMICs' devices, otherwise
it will be difficult to define the mfd cell arrays in mfd driver. Do
you have any good suggestion? Thanks.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/sprd-sc27xx-spi.c

-- 
Baolin Wang
Best Regards
