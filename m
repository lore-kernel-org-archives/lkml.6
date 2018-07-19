Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E270C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7FD2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fZqK3eEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7FD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeGSNHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:07:11 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56158 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSNHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ki/ACVzz7BMh/WJfdOaS3Sxv+m6u48S62NHsZ83NENo=; b=fZqK3eEOr9TJ/WubZ7ho+qPjD
        mnFmvU1h3tnddQMWh3j3pNDhcNsItJQdI3lPn4v6Cvwv8Ne9VhPw7tSQx4WBgMJwIvRTSwU2C/1Dd
        PBApyFwBERAKM0iScejUQPvJv6AfutmBfiaiJDeXMKFp9bpvo8vDsRhIfYKUCAd7v2F2M=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:56711)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fg7yI-0005Xy-J9; Thu, 19 Jul 2018 13:23:50 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fg7yF-0002R8-QB; Thu, 19 Jul 2018 13:23:47 +0100
Date:   Thu, 19 Jul 2018 13:23:46 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to
 eth_platform_get_mac_address()
Message-ID: <20180719122346.GJ6920@n2100.armlinux.org.uk>
References: <20180719082028.26116-1-brgl@bgdev.pl>
 <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719084503.tfv6jllsukk2zv3f@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:48:37AM +0300, Dan Carpenter wrote:
> On Thu, Jul 19, 2018 at 10:20:27AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Many non-DT platforms read the MAC address from EEPROM. Usually it's
> > either done with callbacks defined in board files or from SoC-specific
> > ethernet drivers.
> > 
> > In order to generalize this, try to read the MAC from nvmem in
> > eth_platform_get_mac_address() using a standard lookup name:
> > "mac-address".
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  net/ethernet/eth.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> > index 39af03894598..af3b4b1b77eb 100644
> > --- a/net/ethernet/eth.c
> > +++ b/net/ethernet/eth.c
> > @@ -54,6 +54,7 @@
> >  #include <linux/if_ether.h>
> >  #include <linux/of_net.h>
> >  #include <linux/pci.h>
> > +#include <linux/nvmem-consumer.h>
> >  #include <net/dst.h>
> >  #include <net/arp.h>
> >  #include <net/sock.h>
> > @@ -527,8 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
> >  
> >  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> >  {
> > +	unsigned char addrbuf[ETH_ALEN];
> >  	const unsigned char *addr;
> > +	struct nvmem_cell *nvmem;
> >  	struct device_node *dp;
> > +	size_t alen;
> >  
> >  	if (dev_is_pci(dev))
> >  		dp = pci_device_to_OF_node(to_pci_dev(dev));
> > @@ -541,6 +545,29 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> >  	if (!addr)
> >  		addr = arch_get_platform_mac_address();
> >  
> > +	if (!addr) {
> > +		nvmem = nvmem_cell_get(dev, "mac-address");
> > +		if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
> > +			/* We may have a lookup registered for MAC address but
> > +			 * the corresponding nvmem provider hasn't been
> > +			 * registered yet.
> > +			 */
> > +			return -EPROBE_DEFER;
> > +
> > +		if (!IS_ERR(nvmem)) {
> > +			addr = nvmem_cell_read(nvmem, &alen);
> > +			if (!IS_ERR(addr)) {
>                                     ^^^^
> Never do success handling.  Always error handling.  Otherwise the code
> is indent a lot and the error handling is far from the call.
> 
> > +				if (alen == ETH_ALEN)
> > +					ether_addr_copy(addrbuf, addr);
> > +
> > +				kfree(addr);
> > +				addr = alen == ETH_ALEN ? addrbuf : NULL;
> > +			}
> > +
> > +			nvmem_cell_put(nvmem);
> > +		}
> > +	}
> > +
> >  	if (!addr || !is_valid_ether_addr(addr))
>                                           ^^^^
> Instead of handling the error we dereference the error pointer here.
> 
> *frowny face*
> 
> >  		return -ENODEV;
> >  
> > --
> 
> Maybe this?
> 
> 	if (!addr) {
> 		nvmem = nvmem_cell_get(dev, "mac-address");
> 		if (PTR_ERR(nvmem) == -EPROBE_DEFER)
> 			return -EPROBE_DEFER;
> 		if (IS_ERR(nvmem))
> 			return -ENODEV;
> 		addr = nvmem_cell_read(nvmem, &alen);
> 		if (IS_ERR(addr))
> 			return PTR_ERR(addr);

The problem with doing it this way is... error handling is Hard(tm).
You missed the call to nvmem_cell_put() here.

> 		if (alen != ETH_ALEN) {
> 			kfree(addr);

and again here.

> 			return -ENODEV;
> 		}
> 		ether_addr_copy(addrbuf, addr);
> 		kfree(addr);
> 		addr = addrbuf;

and here.

> 	}
> 	if (!is_valid_ether_addr(addr))
> 		return -ENODEV;
> 	ether_addr_copy(mac_addr, addr);
> 	return 0;

Without checking the semantics, a possible solution to that could be:

	if (!addr) {
		nvmem = nvmem_cell_get(dev, "mac-address");
		if (PTR_ERR(nvmem) == -EPROBE_DEFER)
			return -EPROBE_DEFER;
		if (IS_ERR(nvmem))
			return -ENODEV;
		addr = nvmem_cell_read(nvmem, &alen);
+		nvmem_cell_put(nvmem);
		if (IS_ERR(addr))
			return PTR_ERR(addr);
		if (alen != ETH_ALEN) {
			kfree(addr);
			return -ENODEV;
		}
		ether_addr_copy(addrbuf, addr);
		kfree(addr);
		addr = addrbuf;
	}
	if (!is_valid_ether_addr(addr))
		return -ENODEV;
	ether_addr_copy(mac_addr, addr);
	return 0;

A potential better solution would be to put this code in a separate
function, and then do:

	if (!addr)
		addr = eth_platform_get_nvmem_mac_address(dev, addrbuf);

which returns either NULL or addrbuf depending on whether it failed or
succeeded, which would probably end up with cleaner code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
