Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D78C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468E320844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guq8N1ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468E320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbeGZOhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbeGZOhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:37:22 -0400
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com [209.85.220.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 500A02083F;
        Thu, 26 Jul 2018 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532611231;
        bh=ZbK64BjwyyfL+2G5W6SbwILflfzQsxDlF2SRDQsOk6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Guq8N1ZRHFBEBiCLVARnRHB81jkiOgqKrOX8hS4soWIEcopyOC0gwvaVUgqXK9nI2
         HWHJSgAP1tc+D3q4mH1bwIll4Np9YYp3HRZ9uFgBz1vLDCfYpG1G9sshxttnAF3nzE
         2ujFufmnazxpQb9Ziof9YkN2YSEHD6A9s5aI4Dd0=
Received: by mail-qk0-f176.google.com with SMTP id c126-v6so944391qkd.7;
        Thu, 26 Jul 2018 06:20:31 -0700 (PDT)
X-Gm-Message-State: AOUpUlGii2KUddVAyO7lBpecv1HfaSO3AuRnAXf3/Ko8j57s0EgTiEu+
        eFNYHurus4UN614Wu49Og1YnUPFzBBdwrrawfQ==
X-Google-Smtp-Source: AAOMgpfzk1pAeV/z05r9n0vAXB3vMM3yU6HSb5TtkgKhrJuxZnCwrQd3ox3W4wGulHBXhCAAJPocVnTPG/JZ9oV3hNw=
X-Received: by 2002:ae9:e817:: with SMTP id a23-v6mr1639777qkg.213.1532611230558;
 Thu, 26 Jul 2018 06:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180717153643.8806-1-jbrunet@baylibre.com> <20180717153643.8806-18-jbrunet@baylibre.com>
 <20180725190619.GA20234@rob-hp-laptop> <9a71a5644b5257d48436a4d28972d4142a96b0eb.camel@baylibre.com>
In-Reply-To: <9a71a5644b5257d48436a4d28972d4142a96b0eb.camel@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Jul 2018 07:20:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+PCMbK_Ky6N-f-U65Lr9irSVCMNdvgfu3RJTRg_G90Qg@mail.gmail.com>
Message-ID: <CAL_Jsq+PCMbK_Ky6N-f-U65Lr9irSVCMNdvgfu3RJTRg_G90Qg@mail.gmail.com>
Subject: Re: [PATCH 14/15] ASoC: meson: add axg sound card DT binding documentation
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 1:40 AM <jbrunet@baylibre.com> wrote:
>
> On Wed, 2018-07-25 at 13:06 -0600, Rob Herring wrote:
> > > +- amlogic,aux-devs : List of phandles pointing to auxiliary devices
> > > +- amlogic,widgets : Please refer to widgets.txt.
> > > +- amlogic,routing : A list of the connections between audio components.
> >
> > audio-routing IIRC
>
> Wouldn't it make sense to do the same for widgets and aux-devs then ?
>
> audio-widgets ?
> audio-aux-devs ?

Probably so. Those aren't as common.

Rob
