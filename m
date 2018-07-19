Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FC5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D995920693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5Xa2nax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D995920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbeGSJco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:32:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43386 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeGSJco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:32:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6J8mhBv190332;
        Thu, 19 Jul 2018 08:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=th+6as+7V0mMz1JVuMHoUwA2eJFxJGz38gpcHLx3e7Y=;
 b=H5Xa2naxwG6V5YjXiRgvGHXpsCzBK5oqZM22gC/P/78jZud76NBTt8kW7w/nInXufrw8
 LV+KmqFNb/gbpuvh5Y10g1JrXSMAjUCI/SwpPgTv+qGw4TmTDyoVFRXzkar10lYXcPdK
 jt99UPh9aHBh+4IIIfvm3GWBD8HNP5kvIGsRC25MYyIL2CWXLmZzmxS4by9tXp4EKyWT
 v85td2l3ksSqiT0/NIQN1wHH4hc2hxfndHDqkDpqiPJA+FD7xKrrOqT2Kpe1KJs/G7Oh
 I/HJDUQUYQrK3fyOn/ZwlYJ6UecW1J8n7AQWjY+AvMbQigAQ4AhnO7uuGHcuQtU0YsZN 6w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k9yjx6676-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 08:48:58 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6J8mtfh028971
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 08:48:55 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6J8mnnT022590;
        Thu, 19 Jul 2018 08:48:49 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 01:48:49 -0700
Date:   Thu, 19 Jul 2018 11:48:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
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
Message-ID: <20180719084503.tfv6jllsukk2zv3f@mwanda>
References: <20180719082028.26116-1-brgl@bgdev.pl>
 <20180719082028.26116-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719082028.26116-3-brgl@bgdev.pl>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=821
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:20:27AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Many non-DT platforms read the MAC address from EEPROM. Usually it's
> either done with callbacks defined in board files or from SoC-specific
> ethernet drivers.
> 
> In order to generalize this, try to read the MAC from nvmem in
> eth_platform_get_mac_address() using a standard lookup name:
> "mac-address".
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  net/ethernet/eth.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index 39af03894598..af3b4b1b77eb 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -54,6 +54,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/of_net.h>
>  #include <linux/pci.h>
> +#include <linux/nvmem-consumer.h>
>  #include <net/dst.h>
>  #include <net/arp.h>
>  #include <net/sock.h>
> @@ -527,8 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
> +	unsigned char addrbuf[ETH_ALEN];
>  	const unsigned char *addr;
> +	struct nvmem_cell *nvmem;
>  	struct device_node *dp;
> +	size_t alen;
>  
>  	if (dev_is_pci(dev))
>  		dp = pci_device_to_OF_node(to_pci_dev(dev));
> @@ -541,6 +545,29 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  	if (!addr)
>  		addr = arch_get_platform_mac_address();
>  
> +	if (!addr) {
> +		nvmem = nvmem_cell_get(dev, "mac-address");
> +		if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
> +			/* We may have a lookup registered for MAC address but
> +			 * the corresponding nvmem provider hasn't been
> +			 * registered yet.
> +			 */
> +			return -EPROBE_DEFER;
> +
> +		if (!IS_ERR(nvmem)) {
> +			addr = nvmem_cell_read(nvmem, &alen);
> +			if (!IS_ERR(addr)) {
                                    ^^^^
Never do success handling.  Always error handling.  Otherwise the code
is indent a lot and the error handling is far from the call.

> +				if (alen == ETH_ALEN)
> +					ether_addr_copy(addrbuf, addr);
> +
> +				kfree(addr);
> +				addr = alen == ETH_ALEN ? addrbuf : NULL;
> +			}
> +
> +			nvmem_cell_put(nvmem);
> +		}
> +	}
> +
>  	if (!addr || !is_valid_ether_addr(addr))
                                          ^^^^
Instead of handling the error we dereference the error pointer here.

*frowny face*

>  		return -ENODEV;
>  
> --

Maybe this?

	if (!addr) {
		nvmem = nvmem_cell_get(dev, "mac-address");
		if (PTR_ERR(nvmem) == -EPROBE_DEFER)
			return -EPROBE_DEFER;
		if (IS_ERR(nvmem))
			return -ENODEV;
		addr = nvmem_cell_read(nvmem, &alen);
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

regards,
dan carpenter

