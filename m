Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222B6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AA6217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8p5+Z5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfBEWSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:18:13 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40069 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEWSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:18:13 -0500
Received: by mail-yb1-f196.google.com with SMTP id y13so1692106ybr.7;
        Tue, 05 Feb 2019 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ISjGueC4Bcor3RsrLG9HVCIaVkDQGy5UfhMO1aFtVKI=;
        b=E8p5+Z5aO1Cbb0ZInfI7to5kLL285Yw3lx/qq5N7ozZHMk9Rl0xj1csLT3QFeFZbxF
         Sd6PPtq2bsfFyUhRgau7Xa3iJLUZMQH1yBEPk5nRZvJOcHDQT6yEk09FA/x11WKgFCWk
         hFwJqsBULNGMZ4mAlgrStLTYAojWuCKV70AkAv1anPfw0s4aOnS0xXmXz4g6SkI/n4Ut
         2bdys8v8haSe9vdWHqYY6EXaTn95sc6rVCvT6arDnieLN9zd7up38lPePvzF2DbrPeIb
         9usuRkHZilKcDpDDMAP+jWtmVzX19Af09z3VIMdCrCZVL+bkt3bSfpBFQaUxpkrmA1lk
         evOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ISjGueC4Bcor3RsrLG9HVCIaVkDQGy5UfhMO1aFtVKI=;
        b=GdKOebUy1KsNzrakGOCYuEVmD6nJsgv0/9zlihIJA+cjNPB8RyQVgEdu79olYHw67U
         6X+PlBbBzJ7nNsMTtMjWNKTt98q5Urs+guuV0zWNtpTcR9BOstUo7hE4o9TOwWP45Efx
         p0s7BVzHGrnLdkCZrey9mR9HszIIV6nAVvsGfsFaGHwVaVe0WxR52e2xTNpSetgdtm3j
         WvT5rEWXxHw84uEEHrBSpu/tPi4v2lcpRas+cKsCm7NlZLIza1nuLehRBOFfmQC4a9YG
         NHlsW30ghL0k1HKF0TdUhilrIwDY56VDjrYhIRvQt4gCkYPnemGXDERhKffDDTh1v4ns
         56nQ==
X-Gm-Message-State: AHQUAua5T1LY8nTGuKWkfcn0BV62mNkQRrc8JC2fhhD/qfRPsNKQ3BfT
        id0yGOlfKi9XvDCyB1Jd71k=
X-Google-Smtp-Source: AHgI3IbChBhiyYArGly3/brylm0DR/4QVEyqj54HAkTIjH9ukkz7ZvZTGwJ9X+HmjnQWKZcYNkD2yw==
X-Received: by 2002:a5b:4c1:: with SMTP id u1mr6000767ybp.82.1549405091439;
        Tue, 05 Feb 2019 14:18:11 -0800 (PST)
Received: from [10.67.48.231] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id u188sm2862964ywu.77.2019.02.05.14.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:18:10 -0800 (PST)
Subject: Re: [PATCH net-next v2 10/12] staging: fsl-dpaa2: ethsw: Implement
 ndo_get_port_parent_id()
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
References: <20190205221311.18476-1-f.fainelli@gmail.com>
 <20190205221311.18476-11-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <32de3be2-7e6a-f34e-9e04-3e3d39989317@gmail.com>
Date:   Tue, 5 Feb 2019 14:18:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205221311.18476-11-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 2:13 PM, Florian Fainelli wrote:
> ethsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
> of switchdev_ops eventually, ease that migration by implementing a
> ndo_get_port_parent_id() function which returns what
> switchdev_port_attr_get() would do.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> index daabaceeea52..622f32377b91 100644
> --- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> +++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> @@ -505,6 +505,17 @@ static netdev_tx_t port_dropframe(struct sk_buff *skb,
>  	return NETDEV_TX_OK;
>  }
>  
> +static int swdev_get_port_parent_id(struct net_device *dev,
> +				    struct netdev_phys_item_id *ppid)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(dev);
> +
> +	ppid->id_len = 1;
> +	ppid->id[0] = port_priv->ethsw_data->dev_id;
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops ethsw_port_ops = {
>  	.ndo_open		= port_open,
>  	.ndo_stop		= port_stop,
> @@ -515,6 +526,7 @@ static const struct net_device_ops ethsw_port_ops = {
>  	.ndo_get_offload_stats	= port_get_offload_stats,
>  
>  	.ndo_start_xmit		= port_dropframe,
> +	.ndo_get_port_parent_id	= swdev_get_port_parent_id,
>  };
>  
>  static void ethsw_links_state_update(struct ethsw_core *ethsw)
> @@ -634,10 +646,6 @@ static int swdev_port_attr_get(struct net_device *netdev,
>  	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
>  
>  	switch (attr->id) {
> -	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
> -		attr->u.ppid.id_len = 1;
> -		attr->u.ppid.id[0] = port_priv->ethsw_data->dev_id;
> -		break;
>  	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
>  		attr->u.brport_flags =
>  			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
> @@ -1434,7 +1442,6 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
>  	SET_NETDEV_DEV(port_netdev, dev);
>  	port_netdev->netdev_ops = &ethsw_port_ops;
>  	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
> -	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;

This hunk should not be removed, I will respin a new version after
getting feedback.
-- 
Florian
