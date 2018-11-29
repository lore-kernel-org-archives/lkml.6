Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0318BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF75F2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBgNxZAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF75F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeK2RTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:19:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39670 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeK2RTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:19:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so649654ljh.6;
        Wed, 28 Nov 2018 22:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RnE1S5GxdoR5Qe5wQf/RJVbAMP5EsitHBNG8ikrUglM=;
        b=ZBgNxZAJqZ9c4ZUTsvvwBzBb0y0m/BTCOQGG3/O3PrJXi70yH7PgBTn18y/Ng5rmDo
         r98oTURGIyVryBH4DENIk3PDaXvmEX7FJX24YVdJCBPwp8JAty6D6GImdj4OtZH8U7XF
         FAJG9xDQbwLR0+uuUgcinbV5FsnOpiVi/Gj4Js9hxH9XORSua7Z54WcgbW4/puB7nf0n
         mDM6ZE3t5vyqjV1BWqQj+AlhBa7voDjV3Px2A/+hBvq9YU9q5V/KaRwHjvrSeyS/4KwQ
         qy10vf1LESwIw3xO7ohF3CQqBGSxUrir6zg2ds/waRBNwZ+68Pq9tVVcKoAwITBl2Hij
         iDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RnE1S5GxdoR5Qe5wQf/RJVbAMP5EsitHBNG8ikrUglM=;
        b=g/mPLsywmTPzScV8mLQ3X73R19JvZmZ940X+RlYhiC8gebynzl1P3p76QdCkNdBI66
         5rWhMzCQDgVEKvMq16Urf1UVhk5dKw044HU+yIZiAsSoKpHKnYkVRsCyk6QB6XHqP0DL
         yfWniJbT6enNh48qCjTOtP2naC7tjcG0j31Gtv8kI8Am35EccXxLbMCwtr0HPQjSQOyS
         UP3AFZcLqQxYtwhlk/7lYNX6yRIu5Xsp7kl4bZxMzRqZD3v1txTTiJuNAvF9PCmjfL2z
         57lBZn9CpNlptJpCa++cdw++SyAB6XbKW3uI18IfVkeDauYVba7rDbAiNlF06NcIJPCp
         s6Fg==
X-Gm-Message-State: AA+aEWZkqMoOzagOgZDXqRZQNAvBDY8/ILaio0qVniF1Va6lN6CeQlGZ
        oN1pWIZerMDwMIEr0fvpjp0IZV41/AcHBjMNGhc=
X-Google-Smtp-Source: AFSGD/Uzyu41Zwx82mrTW3hRDwhwunG3TiPp2FsfyhpjUlUsfA4cwGownDLb8eoA5ryNkNkQ0JoO8lQg4uNkEKcEFZk=
X-Received: by 2002:a2e:21a9:: with SMTP id h41-v6mr151163lji.103.1543472092515;
 Wed, 28 Nov 2018 22:14:52 -0800 (PST)
MIME-Version: 1.0
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <fb8a9eb6-82a1-1299-489f-9fed4ee48a02@ti.com> <5a45f520-03b0-3679-2175-a19681062bf6@ti.com>
In-Reply-To: <5a45f520-03b0-3679-2175-a19681062bf6@ti.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 29 Nov 2018 14:14:16 +0800
Message-ID: <CAAfSe-svPfr5SL4WHUUgt4+eB026HYkpG=bwOManZ52+KzWpnw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add support for using external dma in SDHCI
To:     faiz_abbas@ti.com
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        kishon@ti.com, nsekhar@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Faiz,

Many thanks for testing this.

On Thu, 29 Nov 2018 at 00:59, Rizvi, Mohammad Faiz Abbas
<faiz_abbas@ti.com> wrote:
>
> + Mark Brown
>
> Chunyan,
>
> On 11/21/2018 5:17 PM, Faiz Abbas wrote:
> > Hi Chunyan,
> >
> > On 12/11/18 12:56 PM, Chunyan Zhang wrote:
> >> Currently the generic SDHCI code in the Linux kernel supports the SD
> >> standard DMA integrated into the host controller but does not have any
> >> support for external DMA controllers implemented using dmaengine meaning
> >> that custom code is needed for any systems that use a generic DMA
> >> controller with SDHCI which in practice means any SDHCI controller that
> >> doesn't have an integrated DMA controller so we should have this as a
> >> generic feature.
> >>
> >> There are already a number of controller specific drivers that have dmaengine
> >> code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
> >> in their specific driver for sending command with external dma using dmaengine
> >> framework, with this patchset, them will take advantage of the generic support.
> >> TI's omap controller is the case as an example.
> >>
> >> Any comments are very appreciated.
> >>
> >
> > This is great. It helps us move am335x and am43xx platforms to
> > sdhci-omap. What platforms have you tested this on?
> >
>
> Gentle ping on this. I tried testing these with an am335x-evm board. In
> their current condition, the card fails to enumerate altogether. The
> changes suggested by Adrian should fix this. Let me know when you post a v3.

I addressed Adrian's comments, and posted a new patch under 1/3 of the
last patch series, if this patch can be verified workable, I will send
another new patchset also add your tested-by.

Thanks,
Chunyan

>
> Thanks,
> Faiz
