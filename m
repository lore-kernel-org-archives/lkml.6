Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AEEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C9C206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o41GQMt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C9C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeGQSOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbeGQSOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:14:16 -0400
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com [209.85.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0C3E20837;
        Tue, 17 Jul 2018 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531849232;
        bh=Px1GozGzbDixcgRN1Qk8qM50W7B/5iHOjIxyUQScFiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o41GQMt3eHCcA8+qu9duTkREATQLvjjuVCtEvgePUhTKf0KOd/MQTcEOqWaHQ4Ud7
         +jjdOcZQr0Juq8CrZF8dN5LPOG9PZQXno1tC67wlGc4QqPzGc6LuEYLUdDIXAo3YPk
         KgWv74FYMczvkUbrn9Ao2jg3ynNJOJJ3EwjCKluA=
Received: by mail-io0-f177.google.com with SMTP id l25-v6so1688419ioh.12;
        Tue, 17 Jul 2018 10:40:32 -0700 (PDT)
X-Gm-Message-State: AOUpUlEF41KgOc76/tm8uv8osM/uNC+CD2xCxWz36yJZIMkzVsqRlIO/
        xXqhs8R8l+RbwWo4fyFOjvtj4I/nDlN/S9bbjQ==
X-Google-Smtp-Source: AA+uWPx6BWxAYKB0a3crEhm5YK9hRuTgQLs0rwIzh/Ec1eR5B0KKdgUkeANjNEqcMcYC7vaW8LQdvqDha+Ydf45VdLM=
X-Received: by 2002:a6b:6407:: with SMTP id t7-v6mr2402963iog.111.1531849232149;
 Tue, 17 Jul 2018 10:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-6-paul@crapouillou.net>
 <20180709171226.GK22377@vkoul-mobl> <20180716213339.GA19161@rob-hp-laptop> <20180717153407.GF3219@vkoul-mobl>
In-Reply-To: <20180717153407.GF3219@vkoul-mobl>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 17 Jul 2018 11:40:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJBw9vBURZQxa4RkDAfiinnNRK6CVTBmpnC3TaSukZLRA@mail.gmail.com>
Message-ID: <CAL_JsqJBw9vBURZQxa4RkDAfiinnNRK6CVTBmpnC3TaSukZLRA@mail.gmail.com>
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740 SoC
To:     Vinod <vkoul@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 9:34 AM Vinod <vkoul@kernel.org> wrote:
>
> On 16-07-18, 15:33, Rob Herring wrote:
> > On Mon, Jul 09, 2018 at 10:42:26PM +0530, Vinod wrote:
> > > On 03-07-18, 14:32, Paul Cercueil wrote:
> > >
> > > >  enum jz_version {
> > > > + ID_JZ4740,
> > > >   ID_JZ4770,
> > > >   ID_JZ4780,
> > > >  };
> > > > @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
> > > >  }
> > > >
> > > >  static const unsigned int jz4780_dma_ord_max[] = {
> > > > + [ID_JZ4740] = 5,
> > > >   [ID_JZ4770] = 6,
> > > >   [ID_JZ4780] = 7,
> > > >  };
> > > > @@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
> > > >  }
> > > >
> > > >  static const unsigned int jz4780_dma_nb_channels[] = {
> > > > + [ID_JZ4740] = 6,
> > > >   [ID_JZ4770] = 6,
> > > >   [ID_JZ4780] = 32,
> > > >  };
> > >
> > > I feel these should be done away with if we describe hardware in DT
> >
> > The compatible property can imply things like this.
>
> So what is the general recommendation, let DT describe hardware
> including version delta or use compatible to code that in driver?

Compatible is the version. Looking at the above, the version or ID
isn't even stable.

> Is it documented anywhere?

Not really. It's a judgment call generally. Maybe # of DMA channels
should be a property because that is something most controllers have.
But you really have to define the property up front, not when the 2nd
version of h/w shows up with different properties.

To start defining guidelines, a couple of things come to mind:

- Define properties for parameters that vary from board to board (for one SoC).
- You can't add new required properties to existing bindings, so the
not present default must work for all existing compatibles (or you
need per compatible driver data).
- Bugs/quirks/errata should be handled by compatible, not adding a
property. Because bugs should be fixable without a dtb update and only
a kernel update.

Rob
