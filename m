Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62973C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9D420870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="deSePhgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9D420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeGaQrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:47:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37069 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbeGaQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:47:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so11005517lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOyZ/HhD3i22N6PdNepBmB8YpRctB9CHi6QdKJkqAyc=;
        b=deSePhgYwZT4KBiSRw6d5bE4SIHdYIkhIAHloKpiN+edvMLD/V6svlg2aiHND2XJWf
         mfpeQa+GaMllCQnjtvs5B2MtThutnTqreNmUVNLmmubt0RcJ3n1OpYZIsVXPampMCcJK
         gYg7nw/FB4+j2/DimQqePZCgFAp+J2lxYMuOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOyZ/HhD3i22N6PdNepBmB8YpRctB9CHi6QdKJkqAyc=;
        b=R+8PjujpMTZ7c46YeshJ/N6crrF3SYTDAMJpU2pBrbQu+fEfBYWe/MSeWJWFC7/Gpp
         sV7wY2TigBmeb0b5Mg2XsdDT6F9ZPxh7EvtmntFpmZYRAgRPwqOAhLaElbnM9RDS6sd1
         JXMcvbICusFbAdMX5A/UIqOvjuCWqc24LlZufq0bACLQI3QRvRMIVE0ZquOSFUZa/AIm
         gmuzLul7tmAnbiwzgXKOIgvUjvR9OkwKJDXQ+tDL9Yb4qqcneqPE2dVTblS4/DfrMDum
         YnmimmG5U67JvXWK94gZaEKcs68v0CxZg6uMnd8DgUPUWd6TAUwYbfbBwtItZBqUywcT
         TeQA==
X-Gm-Message-State: AOUpUlF+G3AJ2wKiVvEWNM98jKskGiCZmxLPaqE78nJvswBB4iv0vS4b
        QbG44vKiz9DsAv3MDT5WAs/D/3QkNc5TiANKvTOVcA==
X-Google-Smtp-Source: AAOMgpeLsJS9uSYCuXeTFyts1rNJCA70gdEERLiZFPeGvs22V2VyaTpruo6Um3X25Mnny6MyBn/CZ2IUMVWxxi8vZHI=
X-Received: by 2002:a19:f104:: with SMTP id p4-v6mr11191932lfh.137.1533049628905;
 Tue, 31 Jul 2018 08:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com> <20180730200232.GA31755@xps15>
In-Reply-To: <20180730200232.GA31755@xps15>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 31 Jul 2018 09:06:57 -0600
Message-ID: <CANLsYkzBfCydwDO-KyDub4X=GTy_dtv-478RyMReBEH6VybSAg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] coresight: Update device tree bindings
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Matt Sealey <matt.sealey@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        John Horley <john.horley@arm.com>, Al Grant <al.grant@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >
> > Suzuki K Poulose (9):
> >   coresight: Document error handling in coresight_register
> >   coresight: platform: Refactor graph endpoint parsing
> >   coresight: platform: Fix refcounting for graph nodes
> >   coresight: platform: Fix leaking device reference
> >   coresight: Fix remote endpoint parsing
> >   coresight: Add helper to check if the endpoint is input
> >   coresight: platform: Cleanup coresight connection handling
> >   coresight: Cleanup coresight DT bindings
> >   dts: juno: Update coresight bindings
> >
> >  .../devicetree/bindings/arm/coresight.txt          |  95 +++++---
> >  arch/arm64/boot/dts/arm/juno-base.dtsi             | 161 ++++++------
> >  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |  52 ++--
> >  arch/arm64/boot/dts/arm/juno.dts                   |  13 +-
> >  drivers/hwtracing/coresight/coresight.c            |  35 +--
> >  drivers/hwtracing/coresight/of_coresight.c         | 269 ++++++++++++++-------
> >  include/linux/coresight.h                          |   9 +-
> >  7 files changed, 359 insertions(+), 275 deletions(-)
> >
>
> Good day,
>
> I have applied patches 1 to 7.  I will wait for Rob's ACK before doing the same
> with 8 and 9.

I just applied patch 8 and 9.

>
> Thanks,
> Mathieu
>
> > --
> > 2.7.4
> >
