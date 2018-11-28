Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D141AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E22620832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUvVZdXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E22620832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeK2JFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:05:36 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42618 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2JFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:05:36 -0500
Received: by mail-yb1-f194.google.com with SMTP id o204-v6so11288241yba.9;
        Wed, 28 Nov 2018 14:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n9DjwpVPcO8qMCgWeLW1awsMeFllRn7jIHwDB0Yp9X4=;
        b=JUvVZdXEeyw73IIWVStQr5lHm8u8XCq+G992dVBEFDj3XWJFztViG8DjisRl4YjL5t
         mZgK7cIZ0yekpQL9HcHPtATGrf63ln2UdJZ6nIWvD/fln37cmaMCiKHhFXQnMrmM8xct
         Omyilg6ChWQuJuuvp21llepxhdi/olDufla6g65U/6UYb4uxJA9U6ISDD8ZvRJc/8q1T
         zYgtxqLlIKBrAowqgflOeBklGbZnTXPUagzMwy7VJOn3YE4hdQleN53N4BZjgSVxNXsE
         VXlvdWppYmD0BEAQaDgHvLEAPtWeW7Slx4Y3cB/eDim0zuyMGal6/xNbY5nfh+ESwGmP
         ocqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9DjwpVPcO8qMCgWeLW1awsMeFllRn7jIHwDB0Yp9X4=;
        b=VLzXMt/VYSexuuiDB3upO1ptG1INe5gxYP/s+uPBC7k2Q7TNa/vP/gvhe7fRJDUyIA
         pdmho5KUMw9UiZFAW8otl1OC6d4QzS7zFUm/hATAgwb94Sjg2WUwag8td9WNkcqs8N+q
         p1V8RWdXFPEp973kB2+IkMvR4Q/VMwj/a6ofuGQGWv8gFTBsCons5ehS7KZvok688JvK
         /KIQLZzP02SnEyfmRPYB3n5vHsby+rt3B9N0ewP8JHcjxulGfEuGCK9SjOJQv3sXV+FX
         7h283TbelJqkM3bJNj85FaLIHTQl+p91aLIWnqnaTgtsAr/LUBFjI9gJ5w5+tiV8EFZy
         Cypw==
X-Gm-Message-State: AA+aEWZqeAAHlMAQVcpRrh5px3eSAJaq8BSHBQNKbirfOJXRi36DLm32
        VHe6mrN0Jr2/ZBjUkHPmnbfBFoV/
X-Google-Smtp-Source: AFSGD/X615Rh/MRs+6xs8rnHIJz1VpriaOALuyoSecu83HACFVtCdnhgsVRmRuNddAO3AFidKnjJKQ==
X-Received: by 2002:a25:2ccb:: with SMTP id s194-v6mr39607155ybs.415.1543442549597;
        Wed, 28 Nov 2018 14:02:29 -0800 (PST)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f191-v6sm790296ywh.98.2018.11.28.14.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 14:02:28 -0800 (PST)
Subject: Re: [PATCH net] net: dsa: Fix tagging attribute location
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20181128214012.16397-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a0aeb7f0-57f0-f331-1490-ae8424b70624@gmail.com>
Date:   Wed, 28 Nov 2018 14:02:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128214012.16397-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/18 1:40 PM, Florian Fainelli wrote:
> While introducing the DSA tagging protocol attribute, it was added to the DSA
> slave network devices, but those actually see untagged traffic (that is their
> whole purpose). Correct this mistake by putting the tagging sysfs attribute
> under the DSA master network device where this is the information that we need.
> 
> While at it, also correct the sysfs documentation mistake that missed the
> "dsa/" directory component of the attribute.
> 
> Fixes: 98cdb4807123 ("net: dsa: Expose tagging protocol to user-space")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

The changeset in the Fixes tag is in v4.20-rc and has not made it into
any final kernel yet in case you are wondering.

>  Documentation/ABI/testing/sysfs-class-net-dsa |  2 +-
>  net/dsa/master.c                              | 34 ++++++++++++++++++-
>  net/dsa/slave.c                               | 28 ---------------
>  3 files changed, 34 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-net-dsa b/Documentation/ABI/testing/sysfs-class-net-dsa
> index f240221e071e..985d84c585c6 100644
> --- a/Documentation/ABI/testing/sysfs-class-net-dsa
> +++ b/Documentation/ABI/testing/sysfs-class-net-dsa
> @@ -1,4 +1,4 @@
> -What:		/sys/class/net/<iface>/tagging
> +What:		/sys/class/net/<iface>/dsa/tagging
>  Date:		August 2018
>  KernelVersion:	4.20
>  Contact:	netdev@vger.kernel.org
> diff --git a/net/dsa/master.c b/net/dsa/master.c
> index c90ee3227dea..5e8c9bef78bd 100644
> --- a/net/dsa/master.c
> +++ b/net/dsa/master.c
> @@ -158,8 +158,31 @@ static void dsa_master_ethtool_teardown(struct net_device *dev)
>  	cpu_dp->orig_ethtool_ops = NULL;
>  }
>  
> +static ssize_t tagging_show(struct device *d, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct net_device *dev = to_net_dev(d);
> +	struct dsa_port *cpu_dp = dev->dsa_ptr;
> +
> +	return sprintf(buf, "%s\n",
> +		       dsa_tag_protocol_to_str(cpu_dp->tag_ops));
> +}
> +static DEVICE_ATTR_RO(tagging);
> +
> +static struct attribute *dsa_slave_attrs[] = {
> +	&dev_attr_tagging.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group dsa_group = {
> +	.name	= "dsa",
> +	.attrs	= dsa_slave_attrs,
> +};
> +
>  int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
>  {
> +	int ret;
> +
>  	/* If we use a tagging format that doesn't have an ethertype
>  	 * field, make sure that all packets from this point on get
>  	 * sent to the tag format's receive function.
> @@ -168,11 +191,20 @@ int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
>  
>  	dev->dsa_ptr = cpu_dp;
>  
> -	return dsa_master_ethtool_setup(dev);
> +	ret = dsa_master_ethtool_setup(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = sysfs_create_group(&dev->dev.kobj, &dsa_group);
> +	if (ret)
> +		dsa_master_ethtool_teardown(dev);
> +
> +	return ret;
>  }
>  
>  void dsa_master_teardown(struct net_device *dev)
>  {
> +	sysfs_remove_group(&dev->dev.kobj, &dsa_group);
>  	dsa_master_ethtool_teardown(dev);
>  
>  	dev->dsa_ptr = NULL;
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 7d0c19e7edcf..aec78f5aca72 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -1058,27 +1058,6 @@ static struct device_type dsa_type = {
>  	.name	= "dsa",
>  };
>  
> -static ssize_t tagging_show(struct device *d, struct device_attribute *attr,
> -			    char *buf)
> -{
> -	struct net_device *dev = to_net_dev(d);
> -	struct dsa_port *dp = dsa_slave_to_port(dev);
> -
> -	return sprintf(buf, "%s\n",
> -		       dsa_tag_protocol_to_str(dp->cpu_dp->tag_ops));
> -}
> -static DEVICE_ATTR_RO(tagging);
> -
> -static struct attribute *dsa_slave_attrs[] = {
> -	&dev_attr_tagging.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group dsa_group = {
> -	.name	= "dsa",
> -	.attrs	= dsa_slave_attrs,
> -};
> -
>  static void dsa_slave_phylink_validate(struct net_device *dev,
>  				       unsigned long *supported,
>  				       struct phylink_link_state *state)
> @@ -1374,14 +1353,8 @@ int dsa_slave_create(struct dsa_port *port)
>  		goto out_phy;
>  	}
>  
> -	ret = sysfs_create_group(&slave_dev->dev.kobj, &dsa_group);
> -	if (ret)
> -		goto out_unreg;
> -
>  	return 0;
>  
> -out_unreg:
> -	unregister_netdev(slave_dev);
>  out_phy:
>  	rtnl_lock();
>  	phylink_disconnect_phy(p->dp->pl);
> @@ -1405,7 +1378,6 @@ void dsa_slave_destroy(struct net_device *slave_dev)
>  	rtnl_unlock();
>  
>  	dsa_slave_notify(slave_dev, DSA_PORT_UNREGISTER);
> -	sysfs_remove_group(&slave_dev->dev.kobj, &dsa_group);
>  	unregister_netdev(slave_dev);
>  	phylink_destroy(dp->pl);
>  	free_percpu(p->stats64);
> 

-- 
Florian
