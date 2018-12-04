Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED8CC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7020850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs/7M9xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD7020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLDDM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:12:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34481 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLDDM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:12:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so10825133lfc.1;
        Mon, 03 Dec 2018 19:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1ZxP6k+iDcKD6SLSH+x2HhNzQAiQeWUqvQ2W9YY3RU=;
        b=gs/7M9xj6bzPaNH7h+QIalqxAIo2jWhDD0AAEV8box73QEpr8aGkLzTrJQlZyv4ccE
         rX/VYMQhsl+aJ96cqCNKwZ4YNihK+yBUZLlSBFeT6j1UdHQrDiaa1f0Mjoyd5vPVxFvY
         LLASwriJV6jtHVNZtOB1ucEXSi/b+V/o06OmN76c+syMDC7L5C/ek6n6RWzn4Sff1J+w
         EWqrc45gv9R0sp8A33611D7R7oQQTuTIBigIvtxl+nW9VL+SyG6zgxRHQYdVPPooj7jP
         mndMxxAeFKK+5In/s0bKdBRRs32vlmhPv6g2jGZKCGUF+5s2qCln5wDUfjqkvjwSCjaO
         7Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1ZxP6k+iDcKD6SLSH+x2HhNzQAiQeWUqvQ2W9YY3RU=;
        b=FNgcPwNrRZdRYRBgzMGP+ZEkthtz2s3Yd0/VKQhIvMOqVma9daEjsY1jN9CHm5gZ/p
         vhkwsR9FR9UQZMbl8Otu7G5EDe5KGE6csC4n8SYLQS0hSH3EDmsyVpwwH8HVqI0PJuCk
         +ygf9nJNJ3Ne6iT4Be5CrT3l13jBprG8DKcmQIrjpE88h2ofxKp6ptvcU5qhm/f5b8ZU
         mLzoR7n9ej6eCwtN0hd0yREEf0pr/8L0ntXufuPpySrcVzBDT1gtvmdCNkcbAexascR8
         yt8ZlVZ38RRn+5/RwH9Q7+wPLN6gdd/mR3rX2ytyKMJz6hw9d3e3sKsu+aX0yaOTVJ6z
         yksQ==
X-Gm-Message-State: AA+aEWZp4ft12xXmAeNVLIKubcniCs1gMLHw5j20BLCP9CV3kW4htJbX
        hnIiVu7NjXXX4BHvnPmyI0wH77y23zPuVfjEMww=
X-Google-Smtp-Source: AFSGD/XSjRFGljYx2GJtNTCi/xvNuE48EgJ6Qwo852lFJrVhSt+YLQLUjM8bW+lU3lwB5QAKIpUqsZcGoYxSTLdggOw=
X-Received: by 2002:a19:d5:: with SMTP id 204mr9847876lfa.116.1543893146668;
 Mon, 03 Dec 2018 19:12:26 -0800 (PST)
MIME-Version: 1.0
References: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <1543471664-22856-1-git-send-email-zhang.chunyan@linaro.org>
 <f198a61f-40e8-973a-5541-a1bc1dc347de@ti.com> <b771f900-cdd6-5cdf-c3ad-f8b034582439@ti.com>
In-Reply-To: <b771f900-cdd6-5cdf-c3ad-f8b034582439@ti.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 4 Dec 2018 11:11:50 +0800
Message-ID: <CAAfSe-sgvdJ+gaKGvdVFyL0XhH2rub=J9LLzPgjot66Lp=dVHA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA devices
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

On Mon, 3 Dec 2018 at 21:55, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi,
>
> On 03/12/18 5:45 PM, Faiz Abbas wrote:
> > Hi,
> >
> >> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
> >> +                                        struct mmc_command *cmd)
> >> +{
> >
> > Please add a condition for data == NULL here. This was already pointed
> > out by Adrian in v2.

The check for data is added in sdhci_external_dma_setup() .

> >
> > My test with an am335x-evm failed with these patches. Looks like the
> > very first SDIO commands failing.

I guess you didn't add 'dmas' in device tree, like patch 3 shows.

> >
> > https://pastebin.ubuntu.com/p/Y2RDjSKpgd/
> >
> > Currently am335x-evm is using omap_hsmmc driver. I added the following
> > patch to make it work with sdhci_omap.
> >
> > https://pastebin.ubuntu.com/p/VTGrCbJxY3/
> >
> > Will look deeper into this. Please ping if you need any more information.
> >
>
> So I disabled DMA in the driver altogether and still got the same
> messages on am335x-evm in PIO mode. Looks like something more is
> required for it to be supported.
>
> I instead shifted to a dra71-evm which supports both ADMA and external
> DMA. Here is the log:
>
> https://pastebin.ubuntu.com/p/mcJmgcjQsp/
>
> The interface fundamentally works but it complains with the following error:
>

Yes, it switched back to ADMA/PIO since sdhci couldn't find 'dmas'
property in devicetree.

> [3.111693] Failed to request TX DMA channel.

Ok, I will add a check in sdhci-omap.c before switching to external
dma, that should be able to avoid this error logs.

Thanks for the review and test!

Chunyan
