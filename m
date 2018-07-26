Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C198C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1D20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A/tlpi2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C1D20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeGZUTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:19:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47586 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbeGZUTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=S2CBQvnViKkGesXU9121g8aa2y+4Z8n8kef/RZ6mH0c=;
        b=A/tlpi2E8AmbmTCm6UO6feivEeRGZkfoQEJS1L3iXB2EfjP0SYE82LnwC9fYn7IJpMtjsmVxq/KfhcUIjFwoiLatCBECD1j+eIgpS/98S9Lrop2KbABTMFrDBGhWGIizVeUCwwcc8w4QTVZjatoNn2KuISWB8vvJNIFlfJHCT4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1filVX-0004z9-Qs; Thu, 26 Jul 2018 21:01:03 +0200
Date:   Thu, 26 Jul 2018 21:01:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/7] dt-bindings: net: Fix Broadcom iProc mdio mux driver
 base address
Message-ID: <20180726190103.GF10686@lunn.ch>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-2-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532630184-29450-2-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:36:18AM -0700, Arun Parameswaran wrote:
> Modify the base address passed to the Broadcom iProc MDIO mux driver
> to point to the start of the block's register address space.
> 
> Fixes: ce8d5dbfd64f ("Add DT binding doc for Broadcom MDIO bus multiplexer")

Hi Arun

Fixes generally means something explodes, throws an Opps, userspace
does the wrong thing. Documentation/process/stable-kernel-rules.rst
says:

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).

Please explain how this is a real problem and what people it bothers.

I also don't see any attempt to keep backwards compatibility with
older device tree blobs. Is it intentional you will break such old
blobs?

Thanks
	Andrew


> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> index dfe287a..dc8aa68 100644
> --- a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> +++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> @@ -18,9 +18,9 @@ at- Documentation/devicetree/bindings/net/mdio-mux.txt
>  
>  
>  for example:
> -		mdio_mux_iproc: mdio-mux@6602023c {
> +		mdio_mux_iproc: mdio-mux@66020000 {
>  			compatible = "brcm,mdio-mux-iproc";
> -			reg = <0x6602023c 0x14>;
> +			reg = <0x66020000 0x250>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -- 
> 1.9.1
> 
