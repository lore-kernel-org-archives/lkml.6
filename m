Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B94DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAD72087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks593vd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAD72087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJHN5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:57:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51979 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJHN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:57:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so6910385wmf.1;
        Sun, 07 Oct 2018 23:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=JzFjrOfLL4/DvsxbDYjb+g9bzA9eEfIxBmbTlDtlCDQ=;
        b=Ks593vd1spStyM6Hr4zGLn7ix56z5XBXNI56nZ4bVfqR+G2Lhoi1Ldyc1IWODQ9aJq
         9TLnpnN0Cj1ai6fL1esmLcOHY4SAgBRG3z3LFh6WFQYIcmFFD9qBsmJWeTnpDVJ0f0sS
         BH23v+d2d2P62RFRfcFqpDa5523xMt3GrNRL+xQDplFlcN17XtKpr3/2Ga+1ZJV9WpNo
         ThXKvR/6jf5yu+lnBuvHNnkbHRTV/++qaZeObHO8EIONhjvWaCmcLa/wp5s7nNlmQlRy
         y9E0LZnVR3et3IlThImqJyzkja0b7fluqZwq2JVwJmnqGiUQPLI29x3onyIzVXNIDI49
         QRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=JzFjrOfLL4/DvsxbDYjb+g9bzA9eEfIxBmbTlDtlCDQ=;
        b=ZVUfWgK5ik2cRi3qIGjRaztFC3xyOXxYEtGEySmaU7n0huGOG122bmRouYdwdmfXMJ
         mydpn/SoqEvuLyaDIqJGzrfVKhLFQLVjLGeaRpskq4niNE89wMYT4dbDGFrlYU2BdY16
         Dh6LwuvDwgGcjSaFY7KcRXMPXCu0eVZew9jyUv4fR8oLDmfjTOFAuHHfvePRM1FROHut
         QGHZzJm/kkQ0p2hY+AVvXU1bamLxMBc2ESo0eO+erX/bR0YU/pbiW16NZ+IIrwH0W9B1
         YqFkaSmf/Ffkzioh5deOKXkS35HXn/9rhKKcCvBxqYgBScGyc8/V+kxIYuaQKAVjISg5
         PgWQ==
X-Gm-Message-State: ABuFfoiZwris2+LQ/N/78gaLw4lxtQ2R/lSFFGPX/wDSothW5d6+ys4F
        2bMqNZNcV2OUGxnlyUDnB8F7nI4ALzuFeFiA/Sk=
X-Google-Smtp-Source: ACcGV63kwAXWWys3OhkAeC8E6W6ZNl5nXXSGCAI7hNp3sF3MKlNwR0PuxPco93bXfZ6FOZkRjQRGeLHu/c0ZwrVuEck=
X-Received: by 2002:a1c:9bc7:: with SMTP id d190-v6mr10404208wme.2.1538981213358;
 Sun, 07 Oct 2018 23:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-4-andrea.merello@gmail.com> <20180918162508.GD2613@vkoul-mobl>
 <CAN8YU5OySuzAyQ=Buad=Jidhes28koV52Gi-QJ-qOiG5TFBO=Q@mail.gmail.com> <20181002145647.GG19792@vkoul-mobl>
In-Reply-To: <20181002145647.GG19792@vkoul-mobl>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 8 Oct 2018 08:46:41 +0200
Message-ID: <CAN8YU5Psx=O5n3HTEoTd4h3qvXDCUbDGjCEetKvxDWso=oL10g@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dmaengine: xilinx_dma: program hardware supported
 buffer length
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 4:56 PM Vinod <vkoul@kernel.org> wrote:
>
> On 28-09-18, 08:53, Andrea Merello wrote:
> > On Tue, Sep 18, 2018 at 6:25 PM Vinod <vkoul@kernel.org> wrote:
>
> > > > @@ -964,7 +968,7 @@ static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
> > > >                                   int size, int done)
> > > >  {
> > > >       size_t copy = min_t(size_t, size - done,
> > > > -                  XILINX_DMA_MAX_TRANS_LEN);
> > > > +                         chan->xdev->max_buffer_len);
> > >
> > > hmm why not add max_buffer_len in patch 1 again, and then use default
> > > len as XILINX_DMA_MAX_TRANS_LEN and add multiple lengths here :)
> >
> > Sorry, I'm not getting your point. Could you please elaborate the "add
> > multiple lengths here" thing ?
>
> IIRC (sorry been travelling and vacation), add
> chan->xdev->max_buffer_len in patch 1 and initialize it to
> XILINX_DMA_MAX_TRANS_LEN. Then in subsequent patches update the length.

Ah ok. IMO introducing max_buffer_len seems more related to what 4/7
does (actually getting the max transfer len from DT,  thus it is not
constant anymore) rather than to what 1/7 does (commonizing the
calculation of transfer len as it is).. This is why I've introduced it
in 4/7..

.. But if you prefer this way, I'll change this :) .. Maybe we can
change 1/7 commit message so that this change looks less off-topic..
But I have not found a very good title yet.. Something like "Prepare
for DMA copy size calculation rework" ?

> --
> ~Vinod
