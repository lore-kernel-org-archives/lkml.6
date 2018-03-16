Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELvlNjhAvjRQIvp1wOMAdXxoCW64UMb5186UJvKLXJ48NKkPxo4o5qblc3Pkj45Q2sVcdtuo
ARC-Seal: i=1; a=rsa-sha256; t=1521231192; cv=none;
        d=google.com; s=arc-20160816;
        b=F773z6ccgShVOa8zRRXkAl2D2MtZ9AiW2Um6/iH8L3bqWlNH9FKko5wNx9HSY6NZXm
         XqbTorktc08ADSW2ZHS0EgfKdPZGlP0+X/6b1bYoNqnI4U9gaJoU2AqTHuLiWAqCuWpt
         snTADuRE4xvwMKt4ElOcUCLwr3L95FMQ3P1UiF9siQC7Hu3Mk8Um+ahD8OdC5O1KJZe8
         JtUgyM+h1lGXooFmFdzKqGK4ghcN+XflXwpIbNCkFci8VLtLp1pZBufXI5tW0OyylUhg
         WssdITBYPtCpU2YXCCo0Wr7L8SR7ZG7f8d1rF/eJg7fUzjzMVujYjtJGz2o6D/Dqsnit
         3yOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=lK+QfrvHbacUuFRZgK7WtpElNaJSeKbFE9gHpSTjj+Y=;
        b=tLxNlm0BSIit4IhsGIQLs8SwMQLeVznh6lE0PupeGmP95Cj5VnHoA6S4ZRtPD8HN3P
         AJyNj78+8rIHz2OQDOJ2EdIrMzd8ddErqNnIJD9WVjnscck2qcsb3yG9t1NRCRWwJssS
         t01muFMf7KnIC/PJ0gp4HIvCX8pfPa9yYgG6+0zPCRQn4WYqtVivYPxMwvrS6dpPLUaX
         T73FRRcQJzkYcEZtD8dBs6ub+rn8LWxNvq0oURpMHgEtGkawB9H/l+HolhbcBjSl9zfg
         cDkOU10Vtj8iIY1G8OOttoEB2PjaFOlmTL4TEisYqMklhqgVGwUmN1OMiYNZZ+PDVtZa
         QhxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Bpsgm+EX;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Bpsgm+EX;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
To: Andrew Lunn <andrew@lunn.ch>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>, <netdev@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
 <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
 <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
 <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
 <f9f7ea0b-4e23-d837-c1b1-73ed7d6fb686@ti.com> <20180316195403.GA8735@lunn.ch>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0daaae50-ddb9-8a94-d4a7-02861f0a6eb7@ti.com>
Date: Fri, 16 Mar 2018 15:13:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316195403.GA8735@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595126518614732242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 02:54 PM, Andrew Lunn wrote:
>> The phydrv->mdiodrv.flags can be accessible only after call to of_phy_connect()/phy_connect(),
> 
> You need to use a function like of_phy_find_device() to get the
> phydev, set the flag, and then call phy_connect_direct().


So, do you propose me to replace direct calls of of_phy_connect()/phy_connect() in
CPSW driver with buddies of the same functions? Right?

cpsw_slave_open()
{
....
	if (slave->data->phy_node) {
		phy = of_phy_connect(priv->ndev, slave->data->phy_node,
				 &cpsw_adjust_link, 0, slave->data->phy_if);
----- replace ^^^^ with below
{
	struct phy_device *phy = of_phy_find_device(phy_np);
	int ret;

	if (!phy)
		return NULL;

	phy->dev_flags = flags;

-----	[set flag in phydrv->mdiodrv.flags]

	ret = phy_connect_direct(dev, phy, hndlr, iface);

	/* refcount is held by phy_connect_direct() on success */
	put_device(&phy->mdio.dev);

	return ret ? NULL : phy;
}
-----
		if (!phy) {
			dev_err(priv->dev, "phy \"%pOF\" not found on slave %d\n",
				slave->data->phy_node,
				slave->slave_num);
			return;
		}
	} else {
		phy = phy_connect(priv->ndev, slave->data->phy_id,
				 &cpsw_adjust_link, slave->data->phy_if);
----- replace ^^^^ with below
{
	struct phy_device *phydev;
	struct device *d;
	int rc;

	/* Search the list of PHY devices on the mdio bus for the
	 * PHY with the requested name
	 */
	d = bus_find_device_by_name(&mdio_bus_type, NULL, bus_id);
	if (!d) {
		pr_err("PHY %s not found\n", bus_id);
		return ERR_PTR(-ENODEV);
	}
	phydev = to_phy_device(d);

-----	[set flag in phydrv->mdiodrv.flags]

	rc = phy_connect_direct(dev, phydev, handler, interface);
	put_device(d);
	if (rc)
		return ERR_PTR(rc);

	return phydev;
}
-----
		if (IS_ERR(phy)) {
			dev_err(priv->dev,
				"phy \"%s\" not found on slave %d, err %ld\n",
				slave->data->phy_id, slave->slave_num,
				PTR_ERR(phy));
			return;
		}
	}
}

and all above just to set a flag which will be used by just one driver as of now.

Hm. Is this some sort of punishment ;) Sry. I'll probably will take a pause.

-- 
regards,
-grygorii
