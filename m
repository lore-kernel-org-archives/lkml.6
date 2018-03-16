Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521234601; cv=none;
        d=google.com; s=arc-20160816;
        b=e34qdtl2MeuQp8gVKgOlZ/jkkEHjPpwxZ97Qg+39PMIcUgLJUIVYX6V3dpfQlE/iBo
         Qaawrd/UyNqtj0k2IWfB0aFeD+OCr5J1OH7uJfoGQefvuhtxsPGUNj8LSaXFESECkTeF
         XZBTDcsP4rNEE6LUWVlGiFkJfmvRrXgYDj+X+1uieEwKdMt7ACbkRd0XvAgXAkSNfqq6
         XOb53ONg1H95kI5joIq9/pF24Dy9boYStugKD39uBG7zLjKm9UkyJDVpoJq/x3HS1vg9
         /rB34ESPn/J8qzaY9Vq7bhok9jIIdrCNo7yM4JCtBBK/+mLajYqelYBjGvs05NFTOBwb
         87fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=suxPD0UdTv2jvJ6BpFwiP+eqT8fx0tMmOS9Idzhl6o8=;
        b=n/aVsHrOzV9VfJumErhuGJukIiJbuauocPtWIjiVNxNbgkyhHWMLqwDDSSDTp6J+Um
         Llt9jiAf51GEZySXYUi99ACl7vOyJuSDt+kOnHgWQ2A+knw7347VYAERMMg2AqlyvBtm
         wVvCXGUtf7lqqbrRa+TJAk9sdzC0hSzKwax9UFpq8kMbi/4j9SpAhyCmCPvpGoVO3Ttx
         Cjy2JMTxrO8XAs8SZgpSzOF4wk3dTSl6Ygrfp18qas6G1ldy5R/GUExU2xlw4AKo8ztr
         XsFuFouCKqoHZuc43EqprixzOGgEudh2r2g3YIcD1WuiGShNr2cmRBk5pLlRXyBCrPU6
         cZZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TOgK30H/;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TOgK30H/;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtzRsdWP+euRk/zBqjoUpvcS8418k0WESIq6933nM9QRSkj9FjK9uCPxCIC/yFa6iI75UDxXQ==
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
To: Grygorii Strashko <grygorii.strashko@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori
 <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
 <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
 <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
 <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
 <f9f7ea0b-4e23-d837-c1b1-73ed7d6fb686@ti.com> <20180316195403.GA8735@lunn.ch>
 <0daaae50-ddb9-8a94-d4a7-02861f0a6eb7@ti.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c790757c-0b4f-575b-1f6a-5f870f840e20@gmail.com>
Date: Fri, 16 Mar 2018 14:09:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0daaae50-ddb9-8a94-d4a7-02861f0a6eb7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595130093983276522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 01:13 PM, Grygorii Strashko wrote:
> 
> 
> On 03/16/2018 02:54 PM, Andrew Lunn wrote:
>>> The phydrv->mdiodrv.flags can be accessible only after call to of_phy_connect()/phy_connect(),
>>
>> You need to use a function like of_phy_find_device() to get the
>> phydev, set the flag, and then call phy_connect_direct().
> 
> 
> So, do you propose me to replace direct calls of of_phy_connect()/phy_connect() in
> CPSW driver with buddies of the same functions? Right?
> 
> cpsw_slave_open()
> {
> ....
> 	if (slave->data->phy_node) {
> 		phy = of_phy_connect(priv->ndev, slave->data->phy_node,
> 				 &cpsw_adjust_link, 0, slave->data->phy_if);
> ----- replace ^^^^ with below
> {
> 	struct phy_device *phy = of_phy_find_device(phy_np);
> 	int ret;
> 
> 	if (!phy)
> 		return NULL;
> 
> 	phy->dev_flags = flags;
> 
> -----	[set flag in phydrv->mdiodrv.flags]
> 
> 	ret = phy_connect_direct(dev, phy, hndlr, iface);
> 
> 	/* refcount is held by phy_connect_direct() on success */
> 	put_device(&phy->mdio.dev);
> 
> 	return ret ? NULL : phy;
> }
> -----
> 		if (!phy) {
> 			dev_err(priv->dev, "phy \"%pOF\" not found on slave %d\n",
> 				slave->data->phy_node,
> 				slave->slave_num);
> 			return;
> 		}
> 	} else {
> 		phy = phy_connect(priv->ndev, slave->data->phy_id,
> 				 &cpsw_adjust_link, slave->data->phy_if);
> ----- replace ^^^^ with below
> {
> 	struct phy_device *phydev;
> 	struct device *d;
> 	int rc;
> 
> 	/* Search the list of PHY devices on the mdio bus for the
> 	 * PHY with the requested name
> 	 */
> 	d = bus_find_device_by_name(&mdio_bus_type, NULL, bus_id);
> 	if (!d) {
> 		pr_err("PHY %s not found\n", bus_id);
> 		return ERR_PTR(-ENODEV);
> 	}
> 	phydev = to_phy_device(d);
> 
> -----	[set flag in phydrv->mdiodrv.flags]
> 
> 	rc = phy_connect_direct(dev, phydev, handler, interface);
> 	put_device(d);
> 	if (rc)
> 		return ERR_PTR(rc);
> 
> 	return phydev;
> }
> -----
> 		if (IS_ERR(phy)) {
> 			dev_err(priv->dev,
> 				"phy \"%s\" not found on slave %d, err %ld\n",
> 				slave->data->phy_id, slave->slave_num,
> 				PTR_ERR(phy));
> 			return;
> 		}
> 	}
> }
> 
> and all above just to set a flag which will be used by just one driver as of now.
> 
> Hm. Is this some sort of punishment ;) Sry. I'll probably will take a pause.

I agree, let's not have you run into circles, let's just use your
patches as they are since they fix the problem and are not intrusive in
any way.
-- 
Florian
