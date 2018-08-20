Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E66C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E83D2173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E83D2173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeHTVKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:10:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41051 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTVKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:10:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so4379379pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 10:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K0B+x53c1FrdvFPdXbKKm1a4L/60D7QPvjhvERfqF8A=;
        b=Lbq0yi+fH/SehAGOICR4UHtDx/cKNeTVljvJ1uJNpVugnOizJGRqskXYQodjyYu+be
         GbGqLq69S5f03+g2qTfMgbMN3Ivk1L6+dS5nr7DkpgkxfFnajDzJZXDh3ViCqRBrUpAA
         QnJxVMYI6tUNgFRG30xHn4SIC4KGMQoF0GE0P5GEPCJaDk63qSGu8DNTn7LJASbTYtk/
         TeX/h5pXVq5CRwVMzIBmKA5kZoZVjKScZBEmQ7g40DzVxVbkCHj+04XTTweYwkhocD0D
         vpgOG+I8G57bZ++x7NPpqtnmBGuDOQpfmJuX5uMmGpxGdX5GAXksZRYNuCBjfSLS2uwP
         hjJg==
X-Gm-Message-State: AOUpUlG3uy+41hmzyArxnsFufnRrHZ0W4+lZ/l3h31qdtf6T69CL5/zG
        RIWi1gmiKjD2fEqme+NlJwA6gA6BaBg=
X-Google-Smtp-Source: AA+uWPxouhmhKHMt+91/byGjFoAkJIm5y2rRDymZBKWbS92hh4hG2tmAl/+S8cgmEgumlzXBqzRm+w==
X-Received: by 2002:a63:571d:: with SMTP id l29-v6mr43224423pgb.296.1534787648437;
        Mon, 20 Aug 2018 10:54:08 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id n18-v6sm17873744pfa.50.2018.08.20.10.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 10:54:07 -0700 (PDT)
Date:   Mon, 20 Aug 2018 10:54:25 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fpga: dfl: region: Restory symmetry in
 probe()/remove()
Message-ID: <20180820175425.zoxnbcz3ziutxaq5@derp-derp.local>
References: <20180820171818.7710-1-mdf@kernel.org>
 <CANk1AXSMSLGCcaRcZo4TWKEJW+YUQqbHWEuHpz_csF5J1m-Sew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSMSLGCcaRcZo4TWKEJW+YUQqbHWEuHpz_csF5J1m-Sew@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Mon, Aug 20, 2018 at 12:46:32PM -0500, Alan Tull wrote:
> On Mon, Aug 20, 2018 at 12:18 PM, Moritz Fischer <mdf@kernel.org> wrote:
> 
> Hi Moritz,
> 
> > Replace dev_get_drvdata() with platform_get_drvdata() to
> > match the platform_set_drvdata() in the probe function of
> > the platform driver.
> >
> > Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for FME")
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >
> > Changes from v1:
> > - Still compile after change ...
> >
> > ---
> >  drivers/fpga/dfl-fme-region.c | 2 +-
> 
> Thanks for catching this.  of-fpga-region.c does a similar thing and
> needs s/dev_set_drvdata/platform_set_drvdata/ in the probe.  Could you
> fix it here too?

Yeah, can do in a v3 series ... Will add your Suggested-by: ...

Cheers,

Moritz
