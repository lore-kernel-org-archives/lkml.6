Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E573621871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWbgZZyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeLRVbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:31:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38863 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLRVbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:31:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so8738197pfi.5;
        Tue, 18 Dec 2018 13:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6fEcCrseyvtI/k575yyz/8reME0lAUB/5w/S3pUblj4=;
        b=SWbgZZyS3FjWvUh1lRYYUolcR4xFmi2CKYN1pL1SYUDsXFihbquVHR1xAkIvO+C0gV
         jmiINJoYlp4fwhHqonCzpdCUDPrz2K+Y7Cq8ShN20xOr39qfhePB05ebucJD894+Fw9M
         NYRVjSjXq3GnefkSt7xPqcojbC4yWDUtwiHMCJQiJGwCOk895QD/GRlMogscIzqheg66
         D66sNoBKnE2IuTvyU9UCJogSlV6ZPK+SMMdu32KXZ1ZqnC7akrIgTwVXN9g/vNJyPbpa
         bALoH58EGs15hz5ck0n7OYexgT2fWSBYJ2YHctSsd2nSBNeFpp6LPIroWJ5/SZ0VhWf5
         cE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6fEcCrseyvtI/k575yyz/8reME0lAUB/5w/S3pUblj4=;
        b=ebTKeLMj0hvjnMZ4Rt30t4WX5/NEGFbKPszazsyhqRHkAByVt4L+R5kf3Ia1hMkqEv
         kSRtltS+ssF4XG71UWueQV9APZPykNxtkKOzegzLaR4naEKbTu+7b078WvRMvL/QBdZ+
         +KMlUHpdHCPSA8oP1q5Ex+Eovb5SzeuDEHNRb9O4if+FpUQCusGEvdqHTyxZvrIHogy7
         y/VvJJ32rY2x3nl7XO+Nv39fddtMqcSGVRYEy9g39JjLaI9GVERB16KbRK6UlfNGyD+a
         KDmpfDX6SzhQOj9gtzQzAA5FcXzoHPAhgbqYwaERsNPDlJuKQBBwZJF/uKBpk6iTyE++
         GfVQ==
X-Gm-Message-State: AA+aEWa50wbuIvBrQ2gFKFa/9ZFPBALlurvgpc8Zw43MA0U+5efCd9z7
        kyyZMIQ5PtMtrv+gVpmFAKQ=
X-Google-Smtp-Source: AFSGD/VKKDMSfwuGR5K4ljubFl9zaekCMDG7hVjeFiMfxRDBPRHB/SSJok+vZrublm+SLoU1vjCwDA==
X-Received: by 2002:a63:2d46:: with SMTP id t67mr17584372pgt.140.1545168690555;
        Tue, 18 Dec 2018 13:31:30 -0800 (PST)
Received: from localhost.localdomain ([207.86.76.174])
        by smtp.gmail.com with ESMTPSA id r8sm19674773pgr.48.2018.12.18.13.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:31:29 -0800 (PST)
Date:   Tue, 18 Dec 2018 13:31:28 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Wei Ni <wni@nvidia.com>, thierry.reding@gmail.com,
        daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        srikars@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Fixes for Tegra soctherm
Message-ID: <20181218213126.GA8850@localhost.localdomain>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
 <74e77548-d10c-fd00-48c5-2b611529eaf5@nvidia.com>
 <1545104154.2052.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545104154.2052.2.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:35:54AM +0800, Zhang Rui wrote:
> On 五, 2018-12-14 at 17:54 +0800, Wei Ni wrote:
> > Hi Rui,
> > I moved get_trend() patch https://lkml.org/lkml/2018/11/20/643 in
> > this
> > serial.
> > Since no more comments on these patches, will you take them?
> > 
> I think Eduardo will take care of this patch series.

Yes, I will take a look on this series.

But, please, next time you send a series of patches on thermal, copy the
linux-pm@vger.kernel.org mailing list. This way we can track your
patches on patchwork.

> 
> thanks,
> rui
> > Thanks.
> > Wei.
> > 
> > On 14/12/2018 5:49 PM, Wei Ni wrote:
> > > 
> > > This series fixed some issues for Tegra soctherm,
> > > and add get_trend().
> > > 
> > > Main changes from v5:
> > > 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
> > > into this serial.
> > > 
> > > Main changes from v4:
> > > 1. fixed for the parsing sensor id.
> > > 2. keep warning for missing critical trips.
> > > 
> > > Main changes from v3:
> > > 1. updated codes for parsing sensor id, per Thierry's comments
> > > 
> > > Main changes from v2:
> > > 1. add codes to parse sensor id to avoid registration
> > > failure.
> > > 
> > > Main changes from v1:
> > > 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
> > > "thermal: tegra: fix memory allocation".
> > > 2. Print out the sensor name when register failed.
> > > 2. Remove patch "thermal: tegra: fix coverity defect"
> > > 
> > > Wei Ni (4):
> > >   thermal: tegra: remove unnecessary warnings
> > >   thermal: tegra: fix memory allocation
> > >   thermal: tegra: parse sensor id before sensor register
> > >   thermal: tegra: add get_trend ops
> > > 
> > >  drivers/thermal/tegra/soctherm.c | 85
> > > +++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 80 insertions(+), 5 deletions(-)
> > > 
