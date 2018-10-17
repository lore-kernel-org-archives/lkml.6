Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82314ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AEF21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AEF21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeJQXhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:37:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36481 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeJQXhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:37:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id x4so25223791otg.3;
        Wed, 17 Oct 2018 08:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xuvGiJ+KX8gr+zh+zq4f5qp15rIa+KAWSbn2uDHQuD8=;
        b=sHIUqJyPrqDKO4UVW9xsJCTUYId7DJ2CT99APs8ow7Me13G4/ySnXmL8N+qcDSaV8q
         /HYuxZFexVuhMvBK7mFoi198VxGddAmNEnqrKxGPmcIfl4Oe0Piy/CgyvXGmRa64CLB+
         ktyIyjN3LoGguZPhDju7ZSOzSZ82rc7so0eH5/gay87JJwwSzpm9V9UYJWu+1LI4lUmV
         jZ61JGz0Iqb7pQD9BqTfs4S4F19avasYxXBPG80fOavgWQEQLQ8uasvxpqVjrj2DdsBj
         m+y6/UM4M5yH7t7tLLl8VP2iGPv8OtKTieJZNn/b98Y/y8A3Inpqk9r0/zAr9hhyclUn
         ok6g==
X-Gm-Message-State: ABuFfojEUzeiJqvXaNduqjpeyjsvhsy0ZYr5bTy5vnN1f7dFJCm2RZ3i
        hZu8+Ir8tukeonQTgClGVQ==
X-Google-Smtp-Source: ACcGV617WHtXKEsfGGAZYGh3vaDPFvt3gENoyhJJ/jnviDF+GKX/1SxHiNqT00QsHSIFgJrgn2Bf1Q==
X-Received: by 2002:a9d:7452:: with SMTP id p18mr17997613otk.50.1539790874118;
        Wed, 17 Oct 2018 08:41:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l10sm5403418otc.64.2018.10.17.08.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:41:13 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:41:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 04/11] dt-bindings: net: ti: cpsw: switch to use
 phy-gmii-sel phy
Message-ID: <20181017154112.GA18218@bogus>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-5-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008234949.15416-5-grygorii.strashko@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:49:42PM -0500, Grygorii Strashko wrote:
> The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
> deprecate cpsw-phy-sel bindings and update CPSW binding to use phy-gmii-sel
> PHY bindings.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  Documentation/devicetree/bindings/net/cpsw.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
> index b3acebe..69d7ef8 100644
> --- a/Documentation/devicetree/bindings/net/cpsw.txt
> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -22,7 +22,8 @@ Required properties:
>  - cpsw-phy-sel		: Specifies the phandle to the CPSW phy mode selection
>  			  device. See also cpsw-phy-sel.txt for it's binding.
>  			  Note that in legacy cases cpsw-phy-sel may be
> -			  a child device instead of a phandle.
> +			  a child device instead of a phandle
> +			  (DEPRECATED, use phy-gmii-sel PHY phandle).

phy-gmii-sel is outside the scope of this binding. Just say use 'phys' 
property instead.

>  
>  Optional properties:
>  - ti,hwmods		: Must be "cpgmac0"
> @@ -44,6 +45,7 @@ Optional properties:
>  Slave Properties:
>  Required properties:
>  - phy-mode		: See ethernet.txt file in the same directory
> +- phys			: phandle on phy-gmii-sel PHY (see phy/ti-phy-gmii-sel.txt)
>  
>  Optional properties:
>  - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
> @@ -85,12 +87,14 @@ Examples:
>  			phy-mode = "rgmii-txid";
>  			/* Filled in by U-Boot */
>  			mac-address = [ 00 00 00 00 00 00 ];
> +			phys = <&phy_gmii_sel 1 0>;
>  		};
>  		cpsw_emac1: slave@1 {
>  			phy_id = <&davinci_mdio>, <1>;
>  			phy-mode = "rgmii-txid";
>  			/* Filled in by U-Boot */
>  			mac-address = [ 00 00 00 00 00 00 ];
> +			phys = <&phy_gmii_sel 2 0>;
>  		};
>  	};
>  
> @@ -114,11 +118,13 @@ Examples:
>  			phy-mode = "rgmii-txid";
>  			/* Filled in by U-Boot */
>  			mac-address = [ 00 00 00 00 00 00 ];
> +			phys = <&phy_gmii_sel 1 0>;
>  		};
>  		cpsw_emac1: slave@1 {
>  			phy_id = <&davinci_mdio>, <1>;
>  			phy-mode = "rgmii-txid";
>  			/* Filled in by U-Boot */
>  			mac-address = [ 00 00 00 00 00 00 ];
> +			phys = <&phy_gmii_sel 2 0>;
>  		};
>  	};
> -- 
> 2.10.5
> 
