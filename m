Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3964472-1527060977-2-11334958288367776160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527060976; b=Kx/2qloD9iZsmvtOHCHX1gI781Qqc01x5NVw9221Kjo+dUKbFe
    UUB1KW6n14B+LR+WWdN5GI6rzO7WmRwy42umlJEJLE2aC5dCsrLdpvxbSR9SuP5U
    MBUJDF6+q02ODzBlvHEXNmbzCJGYO0zWlvbjQPS3SgPRVlmgVbKKqYJotRQ2czkt
    jYeEMEQkSaZ0Vg+ZkeP7TspYfwfbP4A1flhazvlSjWK4f2dOeGwZsajPMRQOxRDg
    Ij7Vf7LZRaVTidqBpevSueTFNF0v9buxEZkhgUH61qmZRPLxUJGObgmzh5iVQJNd
    Igig+igwoN/hTvXvXYKj0QAwNH94JWRbddMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1527060976; bh=55faTCpnu3kAT0x931xp2yDRDgwtU4
    yXjfq1Vgcs3GY=; b=cbt7uFrGhKvktzQl53sorfj3cey1yVVCe5Un7vmN7hlQZm
    xemow7hL3xaru/JtFAGFmcsnAKq9Q6lcMSYX8IIRRGKH4QoJyCnH7IwRKJCqGqT1
    I5B2bcTutid41tzzdi6I/cu3w5Bire8O9cBsXmgwby91AFYVaBEPYMGPfSTKZ1CO
    34jFR6ffWuvouy4aWtZP6NMKSrEJWjL7ekuWA9P2eFVQNXl4LYUbzWj2mGQsbE7T
    a2boNmE2zULyPXButzIXQsBHm/pHGItESDijEjECK9iUB8qBJ55koFAobv1fJUAW
    5zCC8o2cJGj1jval4UNUsdofFcuPPzaBhXvO4DTw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB+V5OCyykBWC/M6/zyGK3QvSRc2g51AQRbFfIPXTFKOZefuzyYDFoOrxnzbAJ0pRfg4BW4CR9tPKQO5zpqbud9msrGnvE9UZ+yjmptbGLiYwEKy9k/S
    bYCCUzlLfaB9wRqO0E2g98DNY7MxmgHq2MQ7w7hs8BH2Rq5CJ59dvG5OXYmhUDAZ54uQFxG/Xl8kpcuVsA6vPBLwIGEfzQ9/fCGd0Ep1qop6l1dipWUoXC8y
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=P-IC7800AAAA:8
    a=VwQbUJbxAAAA:8 a=lNfA3tt48VZaNn5et4UA:9 a=d3PnA9EDa4IxuAV0gXij:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeEWHgO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 03:36:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56254 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754268AbeEWHgN (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 23 May 2018 03:36:13 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Haim Boot <hayim@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 02/16] arm64: dts: marvell: fix CP110 ICU node size
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
        <20180522094042.24770-3-miquel.raynal@bootlin.com>
Date: Wed, 23 May 2018 09:36:11 +0200
In-Reply-To: <20180522094042.24770-3-miquel.raynal@bootlin.com> (Miquel
        Raynal's message of "Tue, 22 May 2018 11:40:28 +0200")
Message-ID: <87wovuygb8.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Miquel,
 
 On mar., mai 22 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
> specification).
>
> Fixes: 6ef84a827c37 ("arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index 48cad7919efa..9fa41c54f69c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -146,7 +146,7 @@
>  
>  		CP110_LABEL(icu): interrupt-controller@1e0000 {
>  			compatible = "marvell,cp110-icu";
> -			reg = <0x1e0000 0x10>;
> +			reg = <0x1e0000 0x440>;
>  			#interrupt-cells = <3>;
>  			interrupt-controller;
>  			msi-parent = <&gicp>;
> -- 
> 2.14.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
