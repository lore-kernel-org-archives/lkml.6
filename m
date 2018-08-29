Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD833C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942D12086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSz8vis2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942D12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeH2MKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44088 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeH2MKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so3887200wro.11;
        Wed, 29 Aug 2018 01:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fyWwnWzhTFxdNzOlw/kjrykPJ9vCKYMC9ZTioASyThw=;
        b=KSz8vis2Fk3l8eIRcL4yRZ9ScD18rWcBkTew67KbiH1TF6iE0s3z2LB6BCBoSv+0jw
         xQDESQ8+NNIqcatF3PDjX4R7aLaiXn7uFyWwigm/58f+0TIrS96M0T4nSfxim46B7zwN
         SI7Ta1wbzhuGpO0mv7f6WxSPMa98QByyrEwGH/ivPl6ihMfo1+GoKY4ud3qe4bevFODL
         Q+a3GAWF9fzFauVsZAWDJlfT18bF215xXzYUEfKBPxVLTG3P0LxUAQJc9CJ7FoJ0myVf
         BQAREb9A6Y7cUcAknYrtpA6WFYWLQmGOLrJ7slpDE//cwD0hXWz9e27HcUeIRvmld0qb
         AYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fyWwnWzhTFxdNzOlw/kjrykPJ9vCKYMC9ZTioASyThw=;
        b=J9cDRUSf0yzqAJ+gaxQ0eviK6Un6L5c3lrb8WyYsPELI/iRxn2koozXUiErz+fgcFn
         DPLzHApTDiTx418gko/C92w/DBkDivuhR+aTAPp5mEo3IvsoOae88UbBBJ+rJ9HxBAxQ
         a+K4GhP1xHG3z4ARDpHWesTE686l7Rhx42Jf80HqKXZX7NPW62ezSQGIjPLKrpte4Gof
         KoGEilq9NeFIaUALSQyffJxmndjGzHttppZaNEp/YZSbaqDv7M/Y2V819KmfAgofUNEv
         3U0bgFXvQF0v4HFvK0GloBFPqgNkrhOylvlNWAQq0HMwSmYi0PUoydRY2NwQzZ+rItan
         OX8Q==
X-Gm-Message-State: APzg51AIYtfYDtrcxb0pMhOwSCtbsqInSlNgC9jZPKKLJiiWFtMItRaq
        o/v3mbMeugPW72BVqqkv/WyB4u5KPJb+fmAXlmA=
X-Google-Smtp-Source: ANB0VdYYKVrb4QA1oLPH0TqFt3C5PtFM4EX62vmA33uj5RrlRPNc49yO/iU5LDSueR6bAyFZMvRXpa3YSL605DX41sE=
X-Received: by 2002:adf:80ea:: with SMTP id 97-v6mr3387445wrl.57.1535530465001;
 Wed, 29 Aug 2018 01:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-3-andrea.merello@gmail.com> <20180827053103.GU2388@vkoul-mobl>
In-Reply-To: <20180827053103.GU2388@vkoul-mobl>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 29 Aug 2018 10:14:12 +0200
Message-ID: <CAN8YU5P3beS3uxaOMAkMzL_Jb9Nb97MARKKkW0pMKgGicwy3EA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
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

On Mon, Aug 27, 2018 at 7:31 AM Vinod <vkoul@kernel.org> wrote:
>
> On 02-08-18, 16:10, Andrea Merello wrote:
> > The width of the "length register" cannot be autodetected, and it is now
> > specified with a DT property. Add DOC for it.
>
> Add Documentation for it...

OK

> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > ---
> > Changes in v2:
> >       - change property name
> >       - property is now optional
> >       - cc DT maintainer
> > Changes in v3:
> >       - reword
> >       - cc DT maintainerS and ML
> > Changes in v4:
> >       - specify the unit, the valid range and the default value
> > ---
> >  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > index a2b8bfaec43c..aec4a41a03ae 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > @@ -41,6 +41,10 @@ Optional properties:
> >  - xlnx,include-sg: Tells configured for Scatter-mode in
> >       the hardware.
> >  Optional properties for AXI DMA:
> > +- xlnx,sg-length-width: Should be set to the width in bits of the length
> > +     register as configured in h/w. Takes values {8...26}. If the property
> > +     is missing or invalid then the default value 23 is used. This is the
> > +     maximum value that is supported by all IP versions.
> >  - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
> >  Optional properties for VDMA:
> >  - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
> > --
> > 2.17.1
>
> --
> ~Vinod
