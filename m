Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08D6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F79216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="03kPgimj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F79216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeI1CFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:05:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47691 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbeI1CFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=HM4RfbVqLG7eGdMrF3z0jTsB70HILxkQnF+vjA2TZqc=;
        b=03kPgimjH+5zdF6KqnUEJWOHUWNhg64n7by+LvoRw8kZ3CZEyGrQ9nLKoyybaGO0SatoErDI0EWEoplCVKVFvOhZ1xrCp+ddwYhb1FWNk5/U/+xktCZKzlc9l2zlnUNYo2az13cKeWvD893JEpnUmEcxj9x82ZhuZQmj46aKxy4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g5cEQ-0000Wh-6B; Thu, 27 Sep 2018 21:45:50 +0200
Date:   Thu, 27 Sep 2018 21:45:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Yuiko Oshino <yuiko.oshino@microchip.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        m.felsch@pengutronix.de, Markus.Niebel@tqs.de,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 net-next 2/2] dt-bindings: net: add support for
 Microchip KSZ9131 Ethernet PHY
Message-ID: <20180927194550.GL12979@lunn.ch>
References: <1538079415-6260-1-git-send-email-yuiko.oshino@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538079415-6260-1-git-send-email-yuiko.oshino@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 04:16:55PM -0400, Yuiko Oshino wrote:
> Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet PHY
> 
> Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
> ---
>  .../devicetree/bindings/net/micrel-ksz90x1.txt     | 29 +++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> index e22d8cf..d23d14a 100644
> --- a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> +++ b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> @@ -1,4 +1,4 @@
> -Micrel KSZ9021/KSZ9031 Gigabit Ethernet PHY
> +Micrel/Microchip KSZ9021/KSZ9031/KSZ9131 Gigabit Ethernet PHY
>  
>  Some boards require special tuning values, particularly when it comes
>  to clock delays. You can specify clock delay values in the PHY OF
> @@ -64,6 +64,33 @@ KSZ9031:
>          Attention: The link partner must be configurable as slave otherwise
>          no link will be established.
>  
> +KSZ9131:
> +
> +  All skew control options are specified in picoseconds. The minimum
> +  value is 0, and the maximum is property-dependent. The increment
> +  step is 100ps. The default value is the neutral setting, so setting
> +  rxc-skew-ps=<0> actually results in -700 picoseconds adjustment.

We also have:

KSZ9021:

  All skew control options are specified in picoseconds. The minimum
  value is 0, the maximum value is 3000, and it is incremented by 200ps
  steps.

and

KSZ9031:

  All skew control options are specified in picoseconds. The minimum
  value is 0, and the maximum is property-dependent. The increment
  step is 60ps. The default value is the neutral setting, so setting
  rxc-skew-ps=<0> actually results in -900 picoseconds adjustment.

So this is the third meaning of 0.

How about making 0 mean 0. Have the range being -700 to 1800 and -700
to 800? KSZ9031 and KSZ9131 then use the same meaning of 0, with 0
actually meaning 0!

   Andrew
