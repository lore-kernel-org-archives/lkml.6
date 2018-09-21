Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935AEC46471
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839D721580
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDZ4dr9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839D721580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390414AbeIUVaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:30:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44282 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390316AbeIUVaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:30:22 -0400
Received: by mail-io1-f65.google.com with SMTP id u12-v6so7645640ioc.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkFDCul34hIhWd7S2ibRl0Dwd0s0rGpS2Nwb4spgIzU=;
        b=NDZ4dr9ccjiGoWSNT9X7ScBVIxj6npmaS7gLwKVe3jgp6kv2bogRBad2GKCl8hAHqt
         WMOASTXPpXXCSISfCgdvbPfy+/0gLjZBTyEUmcu4M2pTXA172AVebPb37A7RMdSLBjbG
         mhtQIx9/PRQ0idma8GCg7Z7XbvbXeC5lps9Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkFDCul34hIhWd7S2ibRl0Dwd0s0rGpS2Nwb4spgIzU=;
        b=ObV3Xb7qLqPeTff3x/eDdjYy65hFDYtIA50jbapeEJoLlknzKLF5gb5smWMeI6pb0X
         5s7E+znoSCh76Xc6DeFVImXYhR7oHCNbDeWk3mMXXlpJ1ZcKmhRqfYKyD7EaXOH8HOsH
         mGs69qxoO6XfXDpSGpRZ+HU3l2pIjB+V8ALiaxxueZZ+WCiBVi8cmjByQKkRxCCZpUUG
         0PHDmR2nTvmr4Cn83UnKL/E/tPUh1zZjMV/pEMIn3lHCDGLd9YvDAMS7ZzglngSCNGwQ
         vBB9dQphhgnIAM3v63/GDfhAsvKYQNUpWq/5WvGtEEY0BZvY7sj9vTvLfFQP8hyMLuQB
         d8vQ==
X-Gm-Message-State: APzg51BRifj3bRkcpj5ygpkJ2VWrkJcwbcMXBsYHe2d0EpfX4VnBoE3/
        mXcQDbuUGWJ5ChnZ7PMwDRuO+JTDOWEjC3B7HVTZZQ==
X-Google-Smtp-Source: ANB0VdYfAAbV3+xsZGFCzkI11JRDXQeUrR2q8WXrWmakIGc+QNrlo0v05X2gxjiGf9B9DVXeMJr3V5BZ/oyvTskCz+Y=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr37197316iog.175.1537544456576;
 Fri, 21 Sep 2018 08:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180614151435.6471-1-ctatlor97@gmail.com>
 <20180614151435.6471-3-ctatlor97@gmail.com> <20180916121045.aptj6nciwskfg4st@earth.universe>
 <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com> <20180920165847.6xqzeoqzqkyotshx@earth.universe>
In-Reply-To: <20180920165847.6xqzeoqzqkyotshx@earth.universe>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 08:40:43 -0700
Message-ID: <CACRpkda70HAnnQ6a06E-VZwPUveb-OPDYrKYzm+XFAC1LP+rqw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
To:     sebastian.reichel@collabora.com
Cc:     Craig Tatlor <ctatlor97@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 9:58 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> I prefer the second binding (with mV -> uV), but I think it becomes
> messy when temperature is added. What do you think about the
> following proposal (derived from pinctrl style):
>
> Proposal C:
>
> ocv-capacity-table-temperatures = <(-10) 0 10>;
> ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;

I think this looks very elegant. It's going to be very
easy and intuitive for people who need to maintain these
device trees and it will be easy to handle in centralized code
for all platforms. Even with the microvolt notation.

If possible could we go with this?

Yours,
Linus Walleij
