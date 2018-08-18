Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD41C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0AB21710
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVOYQRd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0AB21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeHRUKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 16:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeHRUKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 16:10:17 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F67121570;
        Sat, 18 Aug 2018 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534611715;
        bh=ht0Pfb6q8L+p4DbY8QjFF10uEGozIdmbeAYZY1o7xBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DVOYQRd47kFf8vJoRn/TsI0ERYPU60b2D5GN5Dqn0/WBuwIdAJhSDltXle/quWOKF
         fUFR/jT1SLw0L7PrxOMDVrd0O058PpyktotiG2hKiGKgGvF2lBUwb4MyalEQum88e5
         KmZncozdJ0gh09z2SQ29jupB3cwRzALMai6u1bno=
Date:   Sat, 18 Aug 2018 18:01:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca,
        jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
        bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 4/9] dt-bindings: iio: tsl2772: add new bindings
Message-ID: <20180818180149.3bec7294@archlinux>
In-Reply-To: <20180807165426.GA7007@rob-hp-laptop>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-5-masneyb@onstation.org>
        <20180803224838.362d6cf5@archlinux>
        <20180807165426.GA7007@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018 10:54:26 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Aug 03, 2018 at 10:48:38PM +0100, Jonathan Cameron wrote:
> > On Thu,  2 Aug 2018 20:18:55 -0400
> > Brian Masney <masneyb@onstation.org> wrote:
> >   
> > > This patch adds the new properties amstaos,proximity-diodes and
> > > led-max-microamp to the tsl2772 driver. This patch also removes the
> > > driver from the trivial-devices.txt.
> > > 
> > > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > > ---  
> > This and the implementation look fine to me, but I'll leave them for
> > now to give Rob time to take a look if he wants to.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > I got a Reviewed-by: Rob Herring <robh@kernel.org> on my last series but
> > > didn't include it due to the new file tsl2772.txt in this patch. Device
> > > tree bindings need to be complete.
> > > 
> > >  .../devicetree/bindings/iio/light/tsl2772.txt | 37 +++++++++++++++++++
> > >  .../devicetree/bindings/trivial-devices.txt   | 10 -----
> > >  2 files changed, 37 insertions(+), 10 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to ignore it.

I'll apply the other dt bits to this as fixups.

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

