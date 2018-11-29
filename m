Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2919DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FFA20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="t5SmATrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FFA20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeK3DwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:52:02 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35568 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbeK3DwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:52:01 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so4665535itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q/GbKuFaptQvUEl4Wd84DaujVYfeqvfBlIlbov2Mlak=;
        b=t5SmATrTqyxoYaOPsWS1isXu69wHi5PApSbmSdcsjVmAIaMTmWEr6sHeeu+QcnvmnM
         y8AKxeTUhRM157i1hdhz/3qxRIYwBJEHvR3wzmdZ8QKmJkB2J6ayMIVSp6VN4zXcKvL5
         4nuhxSYvPf92WEuLFnIwtcyOmgdpWOiUUdbD0aBB+siPThe1kGatDIFD5yRiEKMybeLp
         414LzhDar0l7qSdPOBcBSDL5408aXFERDCAj+jfb7dTdfdHzDu+syi5wL+c47WIe2b0g
         vPCFTRQWRVAZUUCABSyDZGS6ooTaU+2O9TIGWkppwjV3vViWBb79ED0O4NVJ/DXMdSCc
         zTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q/GbKuFaptQvUEl4Wd84DaujVYfeqvfBlIlbov2Mlak=;
        b=Lg0bmTYmnCQOc01hzlugGr6SYhkpydztm3B00XZ4sRagJapB9sWUouwP3huOCLqZKc
         wrn6AijWnMeBcRxYCk+wPJQmTy97A06uh4XtiQ/nbghfysATHwLq0kPuhKTG1Wh0o9H4
         TSIu+EByMmNtf1ufTAu1KrQDlgPjPTLb0KCLkyrKuiqG6qS6zPw23XGnuliCU18atPfJ
         OFZ+UG3slo6uZae1pYfC1U1JBnG9Ddz9ICZKYLGaTqdlJsugUXQbUM290Y/mLF0KqMo0
         CVsThVKmDnUZ2tgb8zOPqQBuHh97KiR/ExJPcopbTg+6+t8yiNQoXNAUGS/GRo9DRC7G
         3aPA==
X-Gm-Message-State: AA+aEWa62dHad6tmrzeptTPQFnh9eKGJl9ZmqmmP15OL923bzdGRCVPv
        GFm8D+5L9BYv525Zm28j7b3BWBCATSt2NYzjX2pG4Q==
X-Google-Smtp-Source: AFSGD/WRnDKDcgGOsgeEZErKEgs5yDvhgf9+ysbM80udT5JKDQ+ATrra5z8TWOE9+7Jh/+SzWH8Fec6sqqt0ef0ujP4=
X-Received: by 2002:a02:3d42:: with SMTP id n63mr2027489jan.136.1543509962311;
 Thu, 29 Nov 2018 08:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20181113140133.17385-1-brgl@bgdev.pl> <20181113140133.17385-11-brgl@bgdev.pl>
In-Reply-To: <20181113140133.17385-11-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 29 Nov 2018 17:45:51 +0100
Message-ID: <CAMRc=MdLSVw11hzzqPLfSyz38uA46+LvobGk3vSNcTvtqnD5XQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/25] net: ethernet: provide nvmem_get_mac_address()
To:     "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 13 lis 2018 o 15:02 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We already have of_get_nvmem_mac_address() but some non-DT systems want
> to read the MAC address from NVMEM too. Implement a generalized routine
> that takes struct device as argument.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  include/linux/etherdevice.h |  1 +
>  net/ethernet/eth.c          | 38 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index 572e11bb8696..2c0af7b00715 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -32,6 +32,7 @@
>  struct device;
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
>  unsigned char *arch_get_platform_mac_address(void);
> +int nvmem_get_mac_address(struct device *dev, void *addrbuf);
>  u32 eth_get_headlen(void *data, unsigned int max_len);
>  __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
>  extern const struct header_ops eth_header_ops;
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index fd8faa0dfa61..df38593d1bb4 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -47,6 +47,7 @@
>  #include <linux/inet.h>
>  #include <linux/ip.h>
>  #include <linux/netdevice.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/etherdevice.h>
>  #include <linux/skbuff.h>
>  #include <linux/errno.h>
> @@ -548,3 +549,40 @@ int eth_platform_get_mac_address(struct device *dev,=
 u8 *mac_addr)
>         return 0;
>  }
>  EXPORT_SYMBOL(eth_platform_get_mac_address);
> +
> +/**
> + * Obtain the MAC address from an nvmem cell named 'mac-address' associa=
ted
> + * with given device.
> + *
> + * @dev:       Device with which the mac-address cell is associated.
> + * @addrbuf:   Buffer to which the MAC address will be copied on success=
.
> + *
> + * Returns 0 on success or a negative error number on failure.
> + */
> +int nvmem_get_mac_address(struct device *dev, void *addrbuf)
> +{
> +       struct nvmem_cell *cell;
> +       const void *mac;
> +       size_t len;
> +
> +       cell =3D nvmem_cell_get(dev, "mac-address");
> +       if (IS_ERR(cell))
> +               return PTR_ERR(cell);
> +
> +       mac =3D nvmem_cell_read(cell, &len);
> +       nvmem_cell_put(cell);
> +
> +       if (IS_ERR(mac))
> +               return PTR_ERR(mac);
> +
> +       if (len !=3D ETH_ALEN || !is_valid_ether_addr(mac)) {
> +               kfree(mac);
> +               return -EINVAL;
> +       }
> +
> +       ether_addr_copy(addrbuf, mac);
> +       kfree(mac);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(nvmem_get_mac_address);
> --
> 2.19.1
>

If there are no objections - can patches 10-13 go into the networking
tree already so that they spend some time in next before the merge
window?

Best regards,
Bartosz Golaszewski
