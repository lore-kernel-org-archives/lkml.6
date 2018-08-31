Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDB8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58B02083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkiBthFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58B02083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeHaXzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:55:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43864 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHaXzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:55:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6-v6so5904773plv.10;
        Fri, 31 Aug 2018 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=etHduiudE6Z4X4l8IlyNl2zPRNFfSFZbH6iDaXt+C4I=;
        b=nkiBthFp+AcaA1Hy3iAm4MPixUWoYhux5/LZ3v+ONVz/QM3OBdXAc94WyOYntEvArg
         QWs9b6AonKjXQf4/dCmS139vWd8+/HrWGNImiQKPHY+TBJ35QPa1zB3gNqOgi/xL72Kp
         I4bx2NUZwMplq6KC3GKGiBVPgxq7HMIQ31jmnmosM3hsnKZESF6Qq2Gzr1PUm7xSIMch
         u9Uf5ge10kFkAkUzuq6qRV1HtJKEJpehwIMrBOBbcj3mV3/lmhY2s9JEcEbi8VJgLCKT
         Na2+OOfqMdnNEH/Pn9afUTrIQBOK+jbL7z8GvG13d4ITjHf54wdwHZ83i0YHNOx0bes0
         qruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=etHduiudE6Z4X4l8IlyNl2zPRNFfSFZbH6iDaXt+C4I=;
        b=NNoBnby/924NUM3Y3M9En5ErvcNPUXmltmUhoA9aiJDsuJJwemRXVMBMjxBrWe5CYN
         briBW0pwMwxRwjCN40b6z+JuPgt0movHBLnqtvJyNtGFUayNRYjX6yWxQP0C+wiDMv1K
         t1m4Dpmcp1izhQqdvWGu/Q44opVdBRA67NNwNOwUUUZPLh8WmNcrpbcKSKHWLMbl/B8v
         ObDpKmS9qQNbsAatwQya64YVG5veN/IvRbeQrxynMnWWtZt/ESyA0lznn1p1GtpGRL9y
         04pftKHV7n0YtL26cI9CgGptHPWoNKFtYbvIMXyg78Idb+w13ixN8bXu60EBK9gHk2qb
         DNbw==
X-Gm-Message-State: APzg51ChERCthmQ9UYbRkvc0x+tOh+JfBlfTFmVRwmEm5J6LOQ2Az961
        p0CeOxKdzixM2O0tPCK/SS8=
X-Google-Smtp-Source: ANB0Vdb2JKD/QXXZQruFSQwuojatk45llnCNpL3HyhGOu5zkP+UFsM9MT1Ap4Oo14ORX67EBG56QSg==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1-v6mr16982639plb.86.1535744807414;
        Fri, 31 Aug 2018 12:46:47 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id f184-v6sm22625326pfc.88.2018.08.31.12.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 12:46:46 -0700 (PDT)
Date:   Fri, 31 Aug 2018 12:46:43 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        briannorris@chromium.org
Subject: Re: [PATCH v2 00/29] at24: remove at24_platform_data
Message-ID: <20180831194643.GA62862@ban.mtv.corp.google.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 10:04:57AM +0200, Bartosz Golaszewski wrote:
> Most boards use the EEPROM to store the MAC address. This series adds
> support for cell lookups to the nvmem framework, registers relevant
> cells for all users, adds nvmem support to eth_platform_get_mac_address(),
> converts davinci_emac driver to using it and replaces at24_platform_data
> with device properties.

We already have:

of_get_nvmem_mac_address() (which does exactly what you're adding,
except it's DT specific)
of_get_mac_address()
fwnode_get_mac_address()
device_get_mac_address()

and now you've taught me that this exists too:

eth_platform_get_mac_address()

These mostly don't share code, and with your series, they'll start to
diverge even more as to what they support. Can you please help rectify
that, instead of widening the gap?

For instance, you can delete most of eth_platform_get_mac_address() and
replace it with device_get_mac_address() [1]. And you could add your new
stuff to fwnode_get_mac_address().

And important part to note here is that you code isn't just useful for
ethernet -- it could be useful for Wifi devices too. So IMO, sticking it
only in an "eth" function is the wrong move.

Brian

[1] arch_get_platform_mac_address() is the only part I wouldn't want to
replicate into a truly generic helper. The following should be a no-op
refactor, AIUI:

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..b738651f71e1 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -47,12 +47,12 @@
 #include <linux/inet.h>
 #include <linux/ip.h>
 #include <linux/netdevice.h>
+#include <linux/property.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/if_ether.h>
-#include <linux/of_net.h>
 #include <linux/pci.h>
 #include <net/dst.h>
 #include <net/arp.h>
@@ -528,19 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
 	const unsigned char *addr;
-	struct device_node *dp;
 
-	if (dev_is_pci(dev))
-		dp = pci_device_to_OF_node(to_pci_dev(dev));
-	else
-		dp = dev->of_node;
-
-	addr = NULL;
-	if (dp)
-		addr = of_get_mac_address(dp);
-	if (!addr)
-		addr = arch_get_platform_mac_address();
+	if (device_get_mac_address(dev, mac_addr, ETH_ALEN))
+		return 0;
 
+	addr = arch_get_platform_mac_address();
 	if (!addr)
 		return -ENODEV;
 
