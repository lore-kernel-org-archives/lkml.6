Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC3DC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436542085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNQOkJnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436542085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389382AbeKGM3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:29:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45281 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389320AbeKGM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:29:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id w39-v6so7844177edw.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 19:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6Wudk1T2V/jEzrgGaZ7Bl/Cz6VjYO8rNqjfNWQ1HzY=;
        b=GNQOkJnXGtzIi6IFoSV/k+5gRciq/Sp/nRI2iBj7Lt6LzWTZGJBbdFsZ7uVuZq4vpq
         POE8gzXohaV5MrfkyDM7lt7mnUlyji/LaVVgbPQ3MTifAh0fLkO5xdu5pEBDqgS59Kpk
         E9wRKsLwNFwZanOJsEOWCBuuZfrZEsJtbWN24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6Wudk1T2V/jEzrgGaZ7Bl/Cz6VjYO8rNqjfNWQ1HzY=;
        b=HR2yROAcgYIfsxZrqozLALkRx59W4BNyMpjTXjUyKKrXFaGC3aLNzE/UBBV4LcXPKr
         juGildfu+bmCN213uumwVCF49Em33jSFqEP0u/rWfFzqqBaJJYF7k131YcyFqydC/qoz
         2IGS316TjjRBzmkY5CuX2J3rcu3B2HNVOjNZgvVxzSyAimP5aVp/x+QGz4SKPukqmYpF
         Kj+pfvrMlwdk17x+x+5AFOHO4kPQtxd6BcKznkzLfPNKpq6jwjEEvlwjRPx0rZHMOu51
         lEK1ZcsBfOJ9ZjIQWNuONDfGFpQiiV2V23XFgVZWO8UtywXkN85xZK8vFa0ReWMYlYWO
         nWRA==
X-Gm-Message-State: AGRZ1gJYPJ5Ja9/ytb3GUc1jIYCSfbhaGqJzFFddwfOMhHM2VBF/lDHu
        EI5iPFBnO8bdrhr1KkJRKov/74RktrsID6Q1i+CiaQ==
X-Google-Smtp-Source: AJdET5eLtQELRfVcpDoSET82CbT6qe8Je1XuaUGMkINCCEd2iKuVmQsWgvBBvaRFt6DeLJIHWfzjGuoeuil+busp8Rc=
X-Received: by 2002:a17:906:a301:: with SMTP id j1-v6mr354212ejz.188.1541559668864;
 Tue, 06 Nov 2018 19:01:08 -0800 (PST)
MIME-Version: 1.0
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org>
 <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com> <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
In-Reply-To: <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
Date:   Wed, 7 Nov 2018 11:00:57 +0800
Message-ID: <CAG2=9p-skR8xqqBrULS6_EWFX0H_mvvOJKDGVfzf026H_dychg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mmc: sdhci-omap: Add using external dma
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Lyra Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018 at 20:51, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 11/5/18, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > On 05/11/18 8:46 AM, Chunyan Zhang wrote:
> >>
> >> +    sdhci_switch_extdma(host, true);
> >
> > A number of devices using sdhci-omap supports ADMA. So switching to
> > external
> > DMA shouldn't be unconditional.
> >
> > IMHO sdhci.c should see if the device supports ADMA or SDMA. If not it
> > should
> > try switching to external DMA and if external DMA too is not supported, it
> > should use PIO.
>
> What's the reasoning for preferring ADMA/SDMA over external DMA if
> both are supported?
>
> I'd expect that if the external DMA for some reason is worse than
> ADMA, we just wouldn't list it in the DT at all, but if it's listed and
> ADMA also works, then the driver should try to use it before falling
> back to ADMA.

Thanks Arnd and Kishon, let's see what Andrian and Ulf would suggest,
and then I will address in next version of patchset.

Thanks again,
Chunyan

>
>        Arnd
