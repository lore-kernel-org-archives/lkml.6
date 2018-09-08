Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9068C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3DC206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmo48689"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3DC206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeIHTBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeIHTBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:01:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77CF5204EC;
        Sat,  8 Sep 2018 14:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536416124;
        bh=j/jTxoGMbceL2HrLLf0L+bWGH3PuNPUYGDMsCcmUEaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nmo48689dkRBH+EcNx6IB1B+oeM0rzhyD5ohJWBdyAJIbHA6Bmg2yrVUpMzxgTBM4
         dowo6dPPSI2XJMFMPShUr9EgiU304Z+ij8qZRrPCyp4KL5bmJh8/WcK8kSVj4Brn9c
         Rb7FJX+zh1QY2EKRsYcuwrq8Azb5Ts3d4SD7vCbY=
Date:   Sat, 8 Sep 2018 15:15:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
Message-ID: <20180908151518.1a235bff@archlinux>
In-Reply-To: <20180906212206.GE22824@google.com>
References: <20180906210454.247219-1-mka@chromium.org>
        <20180906210454.247219-4-mka@chromium.org>
        <CAD=FV=WLcgKQWAp8HnBFZhZ4+32keMANcYJ+nGquePqsOnjJ7A@mail.gmail.com>
        <20180906212206.GE22824@google.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018 14:22:06 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> On Thu, Sep 06, 2018 at 02:10:43PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Sep 6, 2018 at 2:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:  
> > > Add a channel node for the die temperature to the ADC.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>  
> > 
> > Double-SoB?  
> 
> I must have run 'amend' with '-s' out of habit, which wasn't the right
> thing to do in this case :/
> 
> > ...presumably Andy can remove that when he lands and doesn't need a re-post...  
> 
> Andy, in case you need me to repost let me know.
Slightly worse than that (as was patch 1).  You accidentally used
-- rather than --- to separate the change log.  So I ended up with

Signed-off-by: M..
Reviewed-by: ..
Signed-off-by: M..
--
Changelog

Signed-off-by: J....

Good think the double signed off was raised as chances are I wouldn't
have notice it.

Jonathan
> 
> Thanks
> 
> Matthias

