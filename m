Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4897FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E412186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="PUDiD8Lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfBFNnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:43:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55696 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfBFNnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:43:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so2501804wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ea8KLwt7ZKSqHUShsrcmEDqwMxkJhQyNCqQz+/bcxtg=;
        b=PUDiD8LtXtusVPMhZXzBHr79w7dFirxJJ50XDlKT3CTF+GknXGH4c/RrW4f8Ydo+N+
         vfPfQslUAxu+L+SzFU/sJfimux139XRPUaAbFGhaQUlu1ELEFQZnFMC2bOgjfPyH+Lq3
         r+snBSDomdONDx7Bz3RewPppcheJdR062JkDz8urtfx+hWkBOuF6KB6w8cj9PWU2+H9M
         LPMwBKFeQgGvGqUHXHYWUdowY5m6yUDdcLM5dX9lfk1zLe5PnsvbjpgYrAWsdI35NjzR
         L4VPxONhcS19bd/lZ8tIOhLebgzYCTMhZAM92ysKtE9YBSZ2En2lAMnyKgfMJKyTyg/3
         CB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ea8KLwt7ZKSqHUShsrcmEDqwMxkJhQyNCqQz+/bcxtg=;
        b=p0dStqVqkhF94hsnDo4HdFhMpdZJf+aMuAYLRxAR5bv2Hsl1ESXWvB3vIgFXIBhIFb
         unqurtP4Wq5P5/epywr/v8mm6spoIIdAElPO+D1RIpZb1+GZXmnkDLbRhd9k8epH6xbS
         zNH2zS65mWltBMYy/nObHkw2HdnRRkV9ymjwgF4o2ybrFk+sa08UrZqexAliMSJrggWQ
         Lb5/hI5AICnQV8TpPdaXzt3u8GK0gg6J/TXPIQBmJ2tSe0XzgJFnjWAFs9vTWTcHyjgU
         g1Z9rmptianmsLwkWcuFLrpbr6rOseAW+KROTZ53drUmZd368dZbjI/5OEJ+zH0eCUos
         8YkQ==
X-Gm-Message-State: AHQUAuaaZo23yGJFYaX/zYcfn5Lef3vD2arGFu9e5PgikfwML+JQUclR
        93ssv3h4VxYGUPpvTr5AMgOTedD+qAA=
X-Google-Smtp-Source: AHgI3IZkVkytrY1Naybh18rgcvqMMmTb5gEwJZtMaS3z7lFEzWnIfgt+IPk4J6dWWq6b1/9kL/YW2A==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr3171889wme.1.1549460622858;
        Wed, 06 Feb 2019 05:43:42 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id u25sm14013736wml.31.2019.02.06.05.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:43:42 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:34:31 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 12/12] net: Get rid of
 SWITCHDEV_ATTR_ID_PORT_PARENT_ID
Message-ID: <20190206133431.GL2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-13-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-13-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:26AM CET, f.fainelli@gmail.com wrote:
>Now that we have a dedicated NDO for getting a port's parent ID, get rid
>of SWITCHDEV_ATTR_ID_PORT_PARENT_ID and convert all callers to use the
>NDO exclusively. This is a preliminary change to getting rid of
>switchdev_ops eventually.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

[...]


>@@ -24,19 +23,12 @@ static int br_switchdev_mark_get(struct net_bridge *br, struct net_device *dev)
> 
> int nbp_switchdev_mark_set(struct net_bridge_port *p)
> {
>-	const struct net_device_ops *ops = p->dev->netdev_ops;
>-	struct switchdev_attr attr = {
>-		.orig_dev = p->dev,
>-		.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
>-	};
>-	int err;
>+	struct netdev_phys_item_id ppid = { };
>+	int err = -EOPNOTSUPP;

Pointless init.


> 
> 	ASSERT_RTNL();
> 
>-	if (ops->ndo_get_port_parent_id)
>-		err = dev_get_port_parent_id(p->dev, &attr.u.ppid, true);
>-	else
>-		err = switchdev_port_attr_get(p->dev, &attr);
>+	err = dev_get_port_parent_id(p->dev, &ppid, true);
> 	if (err) {
> 		if (err == -EOPNOTSUPP)
> 			return 0;

[...]


>@@ -1146,26 +1145,17 @@ static int rtnl_phys_port_name_fill(struct sk_buff *skb, struct net_device *dev)
> 
> static int rtnl_phys_switch_id_fill(struct sk_buff *skb, struct net_device *dev)
> {
>-	const struct net_device_ops *ops = dev->netdev_ops;
>-	int err;
>-	struct switchdev_attr attr = {
>-		.orig_dev = dev,
>-		.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
>-		.flags = SWITCHDEV_F_NO_RECURSE,
>-	};
>+	struct netdev_phys_item_id ppid = { };
>+	int err = -EOPNOTSUPP;

Pointless init.


> 
>-	if (ops->ndo_get_port_parent_id)
>-		err = dev_get_port_parent_id(dev, &attr.u.ppid, false);
>-	else
>-		err = switchdev_port_attr_get(dev, &attr);
>+	err = dev_get_port_parent_id(dev, &ppid, false);
> 	if (err) {
> 		if (err == -EOPNOTSUPP)
> 			return 0;
> 		return err;
> 	}
> 
>-	if (nla_put(skb, IFLA_PHYS_SWITCH_ID, attr.u.ppid.id_len,
>-		    attr.u.ppid.id))
>+	if (nla_put(skb, IFLA_PHYS_SWITCH_ID, ppid.id_len, ppid.id))
> 		return -EMSGSIZE;
> 
> 	return 0;

[...]

	
>@@ -920,15 +917,10 @@ static int vif_add(struct net *net, struct mr_table *mrt,
> 			vifc->vifc_flags | (!mrtsock ? VIFF_STATIC : 0),
> 			(VIFF_TUNNEL | VIFF_REGISTER));
> 
>-	attr.orig_dev = dev;
> 	ops = dev->netdev_ops;
>-	if (ops->ndo_get_port_parent_id &&
>-	    !dev_get_port_parent_id(dev, &attr.u.ppid, true)) {
>-		memcpy(v->dev_parent_id.id, attr.u.ppid.id, attr.u.ppid.id_len);
>-		v->dev_parent_id.id_len = attr.u.ppid.id_len;
>-	} else if (!switchdev_port_attr_get(dev, &attr)) {
>-		memcpy(v->dev_parent_id.id, attr.u.ppid.id, attr.u.ppid.id_len);
>-		v->dev_parent_id.id_len = attr.u.ppid.id_len;
>+	if (!dev_get_port_parent_id(dev, &ppid, true)) {

Please split this to:
	err = dev_get_port_parent_id(dev, &ppid, true);
	if (err) {


>+		memcpy(v->dev_parent_id.id, ppid.id, ppid.id_len);
>+		v->dev_parent_id.id_len = ppid.id_len;
> 	} else {
> 		v->dev_parent_id.id_len = 0;
> 	}

[...]

