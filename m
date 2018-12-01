Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74F0C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB34121473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZTUad3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB34121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeLBCt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeLBCt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:49:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021D62146D;
        Sat,  1 Dec 2018 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543678629;
        bh=hdji0d+vrZdDwOejfuNW/RtzwujO+56H2jBgCAviXSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kZTUad3nZGpJCG0x+0n2A/jgJ3DkRc7tRn2/Av4hBQzNf96zIBrwnCzkLoZlLa+Mf
         aUnYhbsIymlv8KRhigUniYxuWIFyileQiJGL2OOOQgG000t/Hup7AVAQL/uxfme9iK
         qerHutVEdZpXjfaQ9QyS7vivfiTg/bz6ajSR7pPY=
Date:   Sat, 1 Dec 2018 15:37:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH v3 4/7] dt-bindings:iio:resolver: Add docs for ad2s90
Message-ID: <20181201153704.0f17dfcc@archlinux>
In-Reply-To: <20181127015227.GA11401@bogus>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-5-matheus.bernardino@usp.br>
        <20181127015227.GA11401@bogus>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 19:52:27 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 23 Nov 2018 22:23:09 -0200, Matheus Tavares wrote:
> > This patch adds the device tree binding documentation for the ad2s90
> > resolver-to-digital converter.
> > 
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> > Changes in v3:
> >  - Added reference to spi-bus documentation after spi properties, as
> >  suggested by Alexandru Ardelean.
> > 
> > Changes in v2:
> >  - Rewritten 'spi-cpol and spi-cpha' item to say that the device can
> >  work in either mode (0,0) or (1,1) and explain how they should be
> >  specified in DT.
> > 
> >  .../bindings/iio/resolver/ad2s90.txt          | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan
