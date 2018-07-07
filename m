Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E51C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3482156D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="boe3KNFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3482156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeGGRVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753862AbeGGRVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:21:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D2D21528;
        Sat,  7 Jul 2018 17:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530984068;
        bh=mUafxNtpu4zeyQvkwTbMo6F4n/GefHfka9rZtkdggwc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=boe3KNFaH929Y2SfmGufL/9OQpZgKkzO/Rmtjx9BStzkA06LWpLIDILU3Rx9u+734
         yDns9i/pLDSpfpxBSM5kIP/nYqhfml+zAFL6paA4DGxvzp7zDFx4C4l+u3uj+zVcuO
         BSxjmuBxbjYtG2vVa2aa9ViK0asaOuse1aih1NC8=
Date:   Sat, 7 Jul 2018 18:21:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>, Michael.Hennerich@analog.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Message-ID: <20180707182102.4ae47234@archlinux>
In-Reply-To: <20180705211858.GA7441@rob-hp-laptop>
References: <1530714773-18956-1-git-send-email-stefan.popa@analog.com>
        <20180705211858.GA7441@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018 15:18:58 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jul 04, 2018 at 05:32:53PM +0300, Stefan Popa wrote:
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> > Changes in v5:
> > 	- used a dac@0 as a more generic node name instead of ad5758@0.
> > Changes in v4:
> > 	- Nothing changed, just to follow the patch set version.
> > Changes in v3:
> > 	- AD5758 can be both a current and voltage output DAC. The
> > 	  decision is made based on the DT and the channel type is set
> > 	  during probe.
> > 	- range was replaced by range-microvolt and range-microamp
> > 	- dc-dc-mode, range-microvolt and range-microamp are required
> > 	  properties.
> > 	- Introduced a slew-time-us property from which slew rate clock
> > 	  and slew rate step are calculated using a best match algorithm.
> > 	- Added units in the name of the properties.
> > 	- Offered more explanation for the various modes of operation.
> > 
> > Changes in v2:
> > 	- Nothing changed, just to follow the patch set version.
> > 
> >  .../devicetree/bindings/iio/dac/ad5758.txt         | 73 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt  
> 
> Reviewed-by: Rob Herring <robh@kernel.org> 

There was a bit of white space weirdness in here and some lines that needed
breaking.  I fixed up whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Also feels like I haven't explicitly thanked Rob in a while, so... thanks Rob
for your tireless work on making sure we keep idiocy in device tree bindings
to a minimum!

Jonathan
