Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 98568C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D87F208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D87F208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755086AbeFNNAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:00:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49958 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754869AbeFNNAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:00:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B4968207EB; Thu, 14 Jun 2018 15:00:28 +0200 (CEST)
Received: from localhost (unknown [37.170.129.148])
        by mail.bootlin.com (Postfix) with ESMTPSA id 68C502079F;
        Thu, 14 Jun 2018 15:00:28 +0200 (CEST)
Date:   Thu, 14 Jun 2018 15:00:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ben Whitten <ben.whitten@gmail.com>, devicetree@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] arm: dts: add support for Laird WB45N cpu module and
 DVK
Message-ID: <20180614130028.GA16660@piout.net>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
 <03f0f635-3fc2-085b-20e0-e1fcaa9e8062@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f0f635-3fc2-085b-20e0-e1fcaa9e8062@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2018 14:52:25+0200, Nicolas Ferre wrote:
> > +	gpio_keys {
> > +		compatible = "gpio-keys";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		irqbtn@pb18 {
> 
> I'm not sure that the @pb18 can be used like this. This address extension
> must be used in a "reg" property in the node. dtc used with warning switch
> on might trigger an error for this.
> 

Indeed, no unit-address without a reg property.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
