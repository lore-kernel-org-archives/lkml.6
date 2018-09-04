Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822CEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB4C20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHSbRe2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB4C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeIDNUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:20:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45822 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeIDNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:20:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id u83-v6so2438494lje.12;
        Tue, 04 Sep 2018 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-transfer-encoding:content-disposition
         :message-id;
        bh=i7s6Ud3Wx/CrNUnJQgvITCGAMMzaDOwfW9CNk2TVdUc=;
        b=qHSbRe2brU4czL5exG06QkESFt10DBeOpAcYoXoWIqaYGEoSSf53LAJHTahpJVSpge
         xhADu0SGCZBEjtT1q/aeQwK/gdqkcRgLDHhEyxy4riWwDm9/TOiivMCFcaUMaGzD1lqx
         RMHxsGNVsshvEjmkwUH7+9AXO8JXJbrr0PuyxlgNm2Qof5yX113+pm5z7+jutYUY7/pX
         4BRBqyVtCutKathZ1BUv7uOAH6sgTdJNNeX+Nn3SURMbQf47nyf24DCJdW2UWFfHK6ih
         JT/43HEl4KH6ixfLf1D+d0modJ7GVJnRY6diA4bmzGHDQPqErj1NE/SrzYz+jr1laG3Z
         d4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-transfer-encoding
         :content-disposition:message-id;
        bh=i7s6Ud3Wx/CrNUnJQgvITCGAMMzaDOwfW9CNk2TVdUc=;
        b=a3nJwUVNHMYF/oS084Yb8sppi8soSk6jSf/B+iMM5HUAZcrq2paWMdsyX9E9u6z5nJ
         ONiT1soK8Ws5KPHZthsmPe447y8SkG3ADX4FfZTgOLBXuQWZK3leo60undbxbm2X484w
         a8dCXtjWE0rQZbsPa41sfBkUJ36zXK8K31g1Ne166qG0oNxDbP5GBleapP/LYQVz8o/m
         ASffRDO1w008VUxtmLnoQyOKxsomaTBkVebI4RR9hNsIx8Q0wCaFQt/YCYprHcp0OlTQ
         FMVeKSk4TbjDX8giaIFB/aQcp8u7TElXTMJ4F9TUiV5oaIDHFq1Z76r/e4IqwL/Ym3+S
         FkLA==
X-Gm-Message-State: APzg51ASOdgixPicKZSq/fz/OqSEtBIrw+Dfr2GCbb/VgYfcDwxgyJKe
        MY1MbK9k3DcwUEc2V8mMrvI=
X-Google-Smtp-Source: ANB0Vdai94+GRUbKJMSOo1Ej/KrkrIb0p7Ddd0SRnS+yfVD3le/L2fWLvm9zrIT5jJ/AaEq2qLfLNw==
X-Received: by 2002:a2e:9448:: with SMTP id o8-v6mr19677310ljh.34.1536051386227;
        Tue, 04 Sep 2018 01:56:26 -0700 (PDT)
Received: from dimatab ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id s15-v6sm3841079lfc.56.2018.09.04.01.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 01:56:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v3 09/19] memory: tegra: Adapt to Tegra20 device-tree binding changes
Date:   Tue, 4 Sep 2018 11:56:22 +0300
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20180818155430.5586-1-digetx@gmail.com> <20180818155430.5586-10-digetx@gmail.com> <1536008759.25080.2.camel@toradex.com>
In-Reply-To: <1536008759.25080.2.camel@toradex.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201809041156.22715.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 September 2018 00:06:01 Marcel Ziswiler wrote:
> On Sat, 2018-08-18 at 18:54 +0300, Dmitry Osipenko wrote:
> > The tegra20-mc DT binding has been changed, GART has been squashed
> > into Memory Controller and now the clock property is mandatory for
> > Tegra20. Adapt driver the to DT changes.
>
> Minor nitpick concerning the commit message:
>
> Adapt driver to the DT changes.

Yes, thank you.
