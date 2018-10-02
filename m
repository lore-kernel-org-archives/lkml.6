Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC594C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D78C20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jt5LQw5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D78C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeJBT3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:29:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51952 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbeJBT3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=QKsmzS6GocpsXY99GIbmO/r0yAAUe3kjlkidBBmiFSA=;
        b=jt5LQw5wNxc/EKrCArSqf2TdHXN3w/vgrKND7T0FIzzG/ggAa0MDiU6Cn41Ao80wRm6Pquf6I3mwL61xOK/XHG5rQ4LmctL3M7VdZIWqXqZ6H1o2b5hWif/E0Q0u/8ofyTCIf3k5hoRMlEwuflEwAxZsp0eySXIM28LOfKtNkmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g7K4A-00037X-Oa; Tue, 02 Oct 2018 14:46:18 +0200
Date:   Tue, 2 Oct 2018 14:46:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     netdev@vger.kernel.org, oneukum@suse.com, davem@davemloft.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 1/4] usbnet: smsc95xx: add kconfig for turbo mode
Message-ID: <20181002124618.GD9155@lunn.ch>
References: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
 <20181002092645.1115-2-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002092645.1115-2-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:26:42AM +0100, Ben Dooks wrote:
> Add a configuration option for the default state of turbo mode
> on the smsc95xx networking driver. Some systems it is better
> to default this to off as it causes significant increases in
> soft-irq load.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/net/usb/Kconfig    | 9 +++++++++
>  drivers/net/usb/smsc95xx.c | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
> index 418b0904cecb..a32f1a446ce9 100644
> --- a/drivers/net/usb/Kconfig
> +++ b/drivers/net/usb/Kconfig
> @@ -351,6 +351,15 @@ config USB_NET_SMSC95XX
>  	  This option adds support for SMSC LAN95XX based USB 2.0
>  	  10/100 Ethernet adapters.
>  
> +config USB_NET_SMSC95XX_TURBO
> +	bool "Use turbo receive mode by default"
> +	depends on USB_NET_SMSC95XX
> +	default y
> +	help
> +	  This options sets the default turbo mode settings for the
> +	  driver's receive path. These can also be altered by the
> +	  turbo_mode module parameter.
> +

Hi Ben

Is it worth adding a comment here why you would want to turn it off?
To reduce soft-irq load?

Thanks
	Andrew
