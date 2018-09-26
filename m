Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDDBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8D02089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcpVHO8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8D02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeIZGoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:44:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33907 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeIZGoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:44:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so12791329pgv.1;
        Tue, 25 Sep 2018 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2JXXPDw4oVgpuOkMbRM41t8uAB300H0mXTVIzLUezsg=;
        b=tcpVHO8wHhXLGHBkQ2RpnfNcclnAaTLZ7Fay96ycYbxVv0jI0EuGoGsRA3l/kpnrer
         HFQ57sLaXZtNAQYOxbplAyz2J+SzMemyeVfsgxtKsC6OO7mjdGPSBSz3bwdw0ubiS1W3
         dQOguGcCAWbHuHEwDOp8dxA0kU8XwyT7lmPyGWPKZzJZtQe2l14tXDIl32RMYWHR983V
         hLaIHX76sUO5AAI1HPRbRdBS8C/FdZghM/i+lrr/TECy1F0IYtpcb662aBDoL8iDyKKk
         1igGq5iwqt2wojNTkN3G5M9c83/jk9qT4pV62ZfQu9kIpcQUE1sKot58y7ouyNHZzEUN
         SJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2JXXPDw4oVgpuOkMbRM41t8uAB300H0mXTVIzLUezsg=;
        b=KTOpZLDx1xRXxSkC31/Z32DZ4N7fojZb8bNfc1CkQDmrv7xcnq5KuBeAwHbSyeiPBm
         JBwkGlwJ4sRihLOr0I+eWzSPQ53Goxp7YPtCD004/hchNUBS3pOHiQegTJyHg6qNJOGU
         FDVxVbRLFEyFN4O7tAHfa6Tdh5cpmBdERQToXlJjiMUGo4W3YARzCzCF8R87dbGlDs02
         oRu3//P3WLKcCiJuKhFHaNnwaPrkPO57olq84zvTPRb6VM8oKBc75GXT1QMUzzXUSEKh
         Dv+nD0znQOwOI/iJsvXdDbLMy07NYEB5xVyxmySS2eyUYtcFFu9k8lmgnJDlTV4eeuUE
         /yRg==
X-Gm-Message-State: ABuFfoid74zpc5LXj5pIGo0Zkbup2BemDOCNXt13UJkhr7XAxezn2h3g
        QK2hhOn8VSJCljauo+njAUs=
X-Google-Smtp-Source: ACcGV63XcwYyX6okDHcm2vttHWw0K+DbrPwYJYbrkao1FmTP2RjkaKidau9CcJ7l3UBi/nXxiYnb4Q==
X-Received: by 2002:a65:5083:: with SMTP id r3-v6mr3121098pgp.355.1537922049764;
        Tue, 25 Sep 2018 17:34:09 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id l21-v6sm4577689pgo.81.2018.09.25.17.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 17:34:09 -0700 (PDT)
Date:   Wed, 26 Sep 2018 08:34:02 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180926003402.GA6020@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
 <5baa1b01.1c69fb81.f0d8f.30c6@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5baa1b01.1c69fb81.f0d8f.30c6@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 03:23:52PM -0700, Rob Herring wrote:
> On Thu, Sep 20, 2018 at 09:13:40PM +0800, Song Qiang wrote:
> > PNI RM3100 magnetometer is a high resolution, large signal immunity
> > magnetometer, composed of 3 single sensors and a processing chip.
> > PNI is currently not in the vendors list, so this is also adding it.
> > 

...

> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 41f0b97eb933..5bf3395fe9ae 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -288,6 +288,7 @@ pine64	Pine64
> >  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
> >  plathome	Plat'Home Co., Ltd.
> >  plda	PLDA
> > +pni     PNI
> 
> PNI doesn't stand for something?
> 

Hi Rob,

PNI should be 'PNI Sensor Corporation'. I saw that PLDA above mine and
thought I should write down its abbreviation, which apparently is wrong.

yours,
Song Qiang

> >  portwell	Portwell Inc.
> >  poslab	Poslab Technology Co., Ltd.
> >  powervr	PowerVR (deprecated, use img)
> 
