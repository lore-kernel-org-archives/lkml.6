Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D6FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C8921531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C8921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbeIUQz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:55:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34537 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbeIUQz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:55:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6702E20719; Fri, 21 Sep 2018 13:07:31 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 399EB204AE;
        Fri, 21 Sep 2018 13:07:31 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, jason@lakedaemon.net, davem@davemloft.net,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: marvell,prestera: Add common compatible string
References: <20180907005926.27134-1-chris.packham@alliedtelesis.co.nz>
        <20180907005926.27134-2-chris.packham@alliedtelesis.co.nz>
Date:   Fri, 21 Sep 2018 13:07:32 +0200
In-Reply-To: <20180907005926.27134-2-chris.packham@alliedtelesis.co.nz> (Chris
        Packham's message of "Fri, 7 Sep 2018 12:59:25 +1200")
Message-ID: <87a7obhzwr.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,
 
 On ven., sept. 07 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Add "marvell,prestera" as a compatible string so that drivers can be
> written to account for any prestera variant without needing to
> specialise to the more specific values.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>


Applied on mvebu/soc with Rob reviewed-by tag

Thanks,

Gregory

> ---
>  Documentation/devicetree/bindings/net/marvell,prestera.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/marvell,prestera.txt b/Documentation/devicetree/bindings/net/marvell,prestera.txt
> index c329608fa887..83370ebf5b89 100644
> --- a/Documentation/devicetree/bindings/net/marvell,prestera.txt
> +++ b/Documentation/devicetree/bindings/net/marvell,prestera.txt
> @@ -2,7 +2,7 @@ Marvell Prestera Switch Chip bindings
>  -------------------------------------
>  
>  Required properties:
> -- compatible: one of the following
> +- compatible: must be "marvell,prestera" and one of the following
>  	"marvell,prestera-98dx3236",
>  	"marvell,prestera-98dx3336",
>  	"marvell,prestera-98dx4251",
> @@ -21,7 +21,7 @@ switch {
>  	ranges = <0 MBUS_ID(0x03, 0x00) 0 0x100000>;
>  
>  	packet-processor@0 {
> -		compatible = "marvell,prestera-98dx3236";
> +		compatible = "marvell,prestera-98dx3236", "marvell,prestera";
>  		reg = <0 0x4000000>;
>  		interrupts = <33>, <34>, <35>;
>  		dfx = <&dfx>;
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
