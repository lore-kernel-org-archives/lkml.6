Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED35C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884E12176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQ0FVTAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfBRKw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:52:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36714 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfBRKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:52:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so13973967ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CC6KdorLKJMkicgELgpTwOMSFBb61BLug+n8sMHlNNE=;
        b=aQ0FVTAgAh1AmDGYYGeP5HNVOgDbZIQteYFysIV8WjWXEkf1yp+T7u04DWjDBhBOeo
         14Ldk8cyUD6YCbdrD+Np+wqszjJuxDSsLR2piGuurRL2X2MDsqJCY8Yg5bhDRMvnf/ek
         IQ3PAP/UcBLPGe0d+Ldgq0M2H1kWdAuTnAzRU/GBEdBRV6JAR91lol1oisE5AFj5Oq8h
         1M/9FHtT4DgRDJYVHERn7BGIWyY+CHDJ0kW6xa4eiHuKrgr0lTJHbwiGR84G1VzeTtim
         6Fc1Bx/zf8ohHxVTFHY6bdBgXmhm3bsmb0pEcwQOLAt3ck0x0SOrPqphy9XJv7mhFwvO
         lj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CC6KdorLKJMkicgELgpTwOMSFBb61BLug+n8sMHlNNE=;
        b=RHRLPilhfkkLzNkLq5iXFbYr1Iuf5BRrJxFpCK5WH5ciosyma3LJ/4sYaQywtQ8ZBD
         vYQsByUema+W8YkdOH3V1yjNgV0l57lXI/hoFJ42OYcCVWA1va0KiddPuzGZRH5YNoqZ
         yNdrACatT76mn10/ibvrc9VDWAj5lAygFEA5kSbGNL5NnspVPPSgZhtPNoSZWD3Hs07n
         tdOPkvLfr2pK5Gn3T4NSbxbAngcnYGxv47lwQmMQUC3gHsy1TeLDe2KuEDkRHb5iSQGZ
         Hki3fXPzIfzhMSkoRk4iq6lIX5WS8VvpbyEe1lRKqvhq/TLIgL1VHOUDtPgjRXpsCQ9x
         8YAw==
X-Gm-Message-State: AHQUAua4O7Z8YJvwRZiDBU+wwUjhzwNF7jAobOirun31aUrGdqOeCNs6
        s3Ea5joHteXG9WT6YpJvYDY6xqGMrMbC7Q0QKUUg4Q==
X-Google-Smtp-Source: AHgI3Ian99yzYlQaqTBpe48UhUpXkh7SKZMzNP8m7UWC+tojep5CMiISRwWf0mHl2AoC0RY96Ps/vRq/UiAyHfwNaY4=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr14330316ljc.97.1550487174177;
 Mon, 18 Feb 2019 02:52:54 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com> <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
In-Reply-To: <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 18 Feb 2019 18:52:40 +0800
Message-ID: <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > >
> > > > >  Client:
> > > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > > -The two cells in order are:
> > > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > > +The three cells in order are:
> > > > >  1. A phandle pointing to the DMA controller.
> > > > >  2. The channel id.
> > > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > > +automatically.
> > > >
> > > > I notice that this is an incompatible binding change. Is that necessary?
> > > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > > and <3>, and then implementing both in the driver.
> > >
> > > Yes, this is necessary.
> > >
> > > Yes, current code can work, but the problem is that the DMA clients
> > > must add one property (something like "sprd,slave-id") to specify the
> > > slave id. So considering this, we want to change the dma-cells to 2,
> > > including dma channel and dma slave id, which can avoid introducing
> > > some similar properties for DMA clients.
> > >
> > > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > > we want to upstream our first DMA clients: SPI controller. So no other
> > > drivers need to change when we changing dma cells. Thanks.
> >
> > Do you have any other concerns about this patch set? If not, I think
> > Vinod can apply this patch set. Thanks.
>
> Sorry for the late reply. Yes, this makes sense since there are no
> existing users then. For the DT changes going through the dmaengine
> tree
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your reviewing.

>
> One more question, to make sure we don't need to edit it again:
> Why do you need both a 'channel id' and a 'slave id' here? Is this
> a strict hardware requirement for your DMA engine? In many
> other designs, only a DMA request line number needs to
> be described, and I think this would correspond to what you
> call the 'hardware slave id' in your documentation.

I try to explain why we need the slave id.

For our DMA engine driver, we have software request mode and hardware
request mode. For software request mode, the DMA engine driver need
trigger DMA to start transfer manually. But for hardware request mode,
we just set one unique slave id corresponding to the slave hardware to
the DMA engine, then the slave hardware can trigger DMA automatically.
And the slave id is not always same with the channel id according to
the SoC design, so we add one cell to specify the slave id.

>
> Does each request line here correspond to a fixed channel
> id as well, or can a channel be shared between multiple

Yes, each request line corresponds to a fixed channel id.

> slave devices?
>
>       Arnd



-- 
Baolin Wang
Best Regards
