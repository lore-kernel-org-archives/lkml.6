Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2956C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC21220828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546288534;
	bh=eW8bq0/HwIRe+kO6Sj/Bfv3mmIDXI4ZanuR9Yq/IyP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FMG22CfYWs4C7GiFzqy628YEDMqPnDb36LxnpMkrkvjdSGY6BFaA/J7A+yHiqho/e
	 JzA6eO4PwlgrgwDkC81YSt9ULfP6Zj+M8+1ABrUkqw6xkabP2HjYJG6lw/dRkrCUFF
	 KfVtjCRtU8+/t3Ww8ZhcnJi4TH1RCfMNGIMQawEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbeLaUfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 15:35:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbeLaUfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 15:35:33 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15489213A2;
        Mon, 31 Dec 2018 20:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546288532;
        bh=eW8bq0/HwIRe+kO6Sj/Bfv3mmIDXI4ZanuR9Yq/IyP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CPEuBf9uELEraY3WcU/yb8QT19h69U8F6NJHFQkuCt3EShAQ4oVMj7Ut7ffUSe6j8
         3IBfjEsqNw7yP1fERNErjNQzI/2cDOhgXOuzb4oK+ezLhGu4uVPcN/8loinAKSlwnC
         /j/yNhlelfXQhLfsFd5eeXy0fGVQ23Lb3ypiPnYM=
Received: by mail-oi1-f176.google.com with SMTP id r62so22551023oie.1;
        Mon, 31 Dec 2018 12:35:32 -0800 (PST)
X-Gm-Message-State: AJcUukdMNmC4XSaHREQ3P5V0i/zlOxrBa1LZQ+OSAUlcN5xcE/5UqOJa
        VNU5bFh3o/HzIBbZYhpRdger9FMqiLm+gOrVmk8=
X-Google-Smtp-Source: ALg8bN6Cm8xDg2lTwxTZUyqMj3s7LenjF6n4wZMcu8pIIWYkeSxU7uhyF/E44qVq9z7CXZq3lts/mwZOajGHGi9OKoc=
X-Received: by 2002:aca:c682:: with SMTP id w124mr26009412oif.319.1546288531348;
 Mon, 31 Dec 2018 12:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk> <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
 <20181231193017.GN1846@sirena.org.uk> <CAK9iUCNf9JqwvtL4O5KVHP9ZN3y66wZOTjOsGcXFc-T_g6xtEQ@mail.gmail.com>
 <d288e6cf-158f-e832-6096-17d3faf9e3e9@linux.intel.com>
In-Reply-To: <d288e6cf-158f-e832-6096-17d3faf9e3e9@linux.intel.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Mon, 31 Dec 2018 23:35:21 +0300
X-Gmail-Original-Message-ID: <CAK9iUCNhPg21ZFxkbqquTQ5aRRh7ojsSiFP4_RJ2_MsD4t=cYw@mail.gmail.com>
Message-ID: <CAK9iUCNhPg21ZFxkbqquTQ5aRRh7ojsSiFP4_RJ2_MsD4t=cYw@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 11:29 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> On 12/31/18 1:35 PM, Sinan Kaya wrote:
> > On Mon, Dec 31, 2018 at 10:30 PM Mark Brown <broonie@kernel.org> wrote:
> >> On Mon, Dec 31, 2018 at 08:52:52PM +0300, Sinan Kaya wrote:
> >>> On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
> >>>> I don't have the cover letter or anything for this series, what's going
> >>>> on with dependencies?
> >>> Here is the executive summary:
> >>> I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACPI
> >>> used to select PCI. This is no longer true.
> >>> You can build an ACPI system without any PCI devices.
> >> So there's no dependency and I can just apply this?
> > The plan is to apply this patchset via ACPI tree. Need an Acked-by per patch.
> Anytime we change the Kconfig settings for audio, we get all kinds of
> problems with randconfig and 0day/kbuild due to depend/select issues.
> I'd like to give this a spin first, can you share a link to the entire
> series? Thanks!

Sure,

You can find them here

https://lore.kernel.org/patchwork/patch/1028330/

Click related.
