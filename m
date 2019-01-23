Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AEDC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4C1217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bam9gQH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfAWCou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:44:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38146 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfAWCot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:44:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so496739ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 18:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flH2rmXbAkXYFECvZrwJt+bKiZ7twQVvKyLk5qVzm5w=;
        b=bam9gQH8KIIH5QvwmLu/D1NwHyKCbmw7pQb/ZsWAa0yD4ArCaGiDe2EF+Ao4yDx/Ea
         1fngE+HRFedtVqZwy1iI5cvqa9RpIU5hM3Tu8aBzVqJgey3vTw99cSvhy1OGDzgxot6I
         JGFy/wU9AT2502VNEM1PniiDBr08BK46n50W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flH2rmXbAkXYFECvZrwJt+bKiZ7twQVvKyLk5qVzm5w=;
        b=Im0lgcCAs77T8f3Ub12PV6gIcaHTXgcIDpRswbeUWrTHi3uiq+emweJoTed6xW2WTa
         ApZxFwgOg0idVZ37J0KLlScgUSveEZh6hy0A1HhQrQVW2jMoeeMkZvodszGBqYqC6IAF
         cyXcwhHIyTiSkpd3ctLpM9kz7CPTQol95xXO8yt0qZfVBMpe9RM1v7hjenlCZFxdTNV8
         PConseXVphOHharoKZjbDjZg9e+dW4ZtOzLT+eBYZSvLDTVNIsbFIyGy5JNqeftexCSp
         0CZA479EAGQiwZE2BY/y15OSYU1CZhYyBWF/1EYumwaTEyGDRxFdl1owok0EZB4TgyFg
         5Vmw==
X-Gm-Message-State: AJcUukeaXWgLNe7TKyITK006EWYFyJpVl/Bw0uhjDhFJ6+XC4csMZ6gB
        j/BsdtDBdVDlecrRefbhmwLZw0m1GIjFPCpGHsijJA==
X-Google-Smtp-Source: ALg8bN4aMBDO/S8oCtjCoZzRXe91bGnkFQd8aQ8S9aPSuX8zgxRVnx2C2F9l4SCFJbKdUfbN7ZxxoK2VXIYt/N/Wm9g=
X-Received: by 2002:a17:906:5202:: with SMTP id g2-v6mr787553ejm.139.1548211487535;
 Tue, 22 Jan 2019 18:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20190121232057.GA30919@bogus> <20190122084706.11522-1-zhang.chunyan@linaro.org>
 <7231fba8-de0d-dd22-5ec8-d62d34c6495d@ti.com>
In-Reply-To: <7231fba8-de0d-dd22-5ec8-d62d34c6495d@ti.com>
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
Date:   Wed, 23 Jan 2019 10:44:35 +0800
Message-ID: <CAG2=9p-JcAB0Re2hRB6bu_18Z_SJXjrynw2cRSKVFEBnWHPDKg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: sdhci-omap: Add properties for using
 external dma
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 at 18:17, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Chunyan,
>
> +Rob Herring
>
> On 22/01/19 2:17 PM, Chunyan Zhang wrote:
> > sdhci-omap can support both external dma controller via dmaengine
> > framework as well as ADMA which standard SD host controller
> > provides.
> >
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> > Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> > ---
>
> Thanks for fixing this. However, this change should be part of the

Right, I actually used "--in-reply-to" with the parameter of
Message-ID of Rob's mail, but it seems not work as I expected that it
was expected a reply to Rob's mail for review.

> series (with a change log and a version number). I will send this as a
> part of my series after I get some Acks on the driver patches.

Ok, thanks.

Chunyan

>
> Thanks,
> Faiz
