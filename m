Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3315673-1520950985-5-18134266522642663968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='ch', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520950984; b=vsqJilvL/ENS/k+mB3eaTy9KG/LaZ/S0B87RqidVDnJia/5
    j3PWPghaZ46YorDtqmLi0EpjGz14/il79CT4OdaA/V3DH90FdV5satZCTSN6IMFE
    yg+RFG+lDmQ4gzbS98Mi0mon04u2FoYP5/kGIU3M2vwROvJFoMwzH4M2mh2T3SyV
    SrvomRStL2YAXfQ0gurVz39NMoA9xM69imrIBxNxBQDEU/9LU9LA9N1GhZ3rdRAx
    twrI3B8m5VKX5fdFxJWHMM29z5qhvukFjnF/gUpJiEMtQazeUNSWAz5LUCQuJmd9
    gfucdhqFfnRUs6720rD0F2V+XTSPv57R9Q22GxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520950984; bh=D
    h6nhtPhSBerTVzeGP2/z8flYJCsf/Moa9HmDFEmY90=; b=o7WHXF53kojRR1ies
    QfdWXBNhj6OzFwWSQokz0JIV2iKzWU0fO/AvrFgcASczMkWmv5I2qfIiZbQwxXJR
    qo48iOf2Bhbt09dJpYCFmucEdbbD/58PIqUlCEZLdW/2yUW/GVkHhu/Sxi95573H
    Cy9OpuzUCRAnsSwTB+/o3BT0bo9YHmGIMvWJ82e4X2dugczCCs1N2kV2F9SG3jLb
    6BCynbjzBJwYTl1xT8HTpWhb9IZgCgR78sEywPniIBDedeCTUl9cKw0QA4sfCFGH
    sZgX9AjGbDHwSoeGEJ+VrpdC+7YIVGXb7LUZiV/5UyTBEuvLyXrYBVQemMtwA6Wg
    lFeSw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=T/YBEfcp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=T/YBEfcp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 13 Mar 2018 15:22:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Subject: Re: [PATCH v5 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Message-ID: <20180313142251.GB3814@lunn.ch>
References: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
 <20180313135156.3322-3-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180313135156.3322-3-razvan.stefanescu@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 ioana.ciornei@nxp.com, alexandru.marginean@nxp.com, agraf@suse.de,
 linux-kernel@vger.kernel.org, stuyoder@gmail.com, netdev@vger.kernel.org,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> +/* For the moment, only flood setting needs to be updated */
> +static int port_bridge_join(struct net_device *netdev,
> +			    struct net_device *upper_dev)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	int i, err;
> +
> +	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
> +		if (ethsw->ports[i]->bridge_dev &&
> +		    (ethsw->ports[i]->bridge_dev != upper_dev)) {
> +			netdev_err(netdev,
> +				   "Another switch port is connected to %s\n",
> +				   ethsw->ports[i]->bridge_dev->name);
> +			return -EINVAL;
> +		}
> +
> +	/* Enable flooding */
> +	err = ethsw_port_set_flood(port_priv, 1);
> +	if (!err)
> +		port_priv->bridge_dev = upper_dev;
> +
> +	return err;
> +}

Hi Razvan

That is not what i was meaning.

brctl addbr br0
brctl addbr br1
brctl addif br0 lan0
brctl addif br0 lan1
brctl addif br1 lan2
brctl addif br1 lan3

Is there somewhere in the code which sets the scope for the flooding?
lan0 can flood to lan1, but it should not flood to lan2 or lan3, since
they are in a different bridge. I was expecting that
ethsw_port_set_flood() takes upper_dev, in order to configure which
ports it should flood to.

      Andrew
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
