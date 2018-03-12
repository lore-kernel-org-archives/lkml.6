Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-515744-1520865424-2-8505751884641559257
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='ch', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520865424; b=MCa6RysQyA0ekUfR/bdg3VX7AOPlPOetG53Fnbq8FU3vdIE
    by074mMcs+N0OSq83g3SHIYMH8nOwNC3cDZqC/Z4PMCK4TBspohZzFhbyZ7JqMxw
    Twv+AXDHX83gWH5kFtnaGULrvHC67axduiW+NrFkP7/wylVR5d6QprTVB1yJfrtb
    yPl3utE+fGjg9fh4+mZiIHmNlfRxTzCFvnMFAP1fBYgMCqeJ336DVErq4QwBOK0O
    bMvZThs9Le9QEbGGw2FoftIpxubaG3SEsbW66mrsL3HcPx4Rde+aAQAOtSUBwXbL
    Hy2qWRLDyz0G/baALX0xnM3kLHtucv+biPSpIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520865424; bh=C
    +S8ZejWFpaFaGXG4VpseVIOoDdSQmMcpiYUY7hQB3Q=; b=i7a9w8DISLHc/3PpB
    XK85jpjweBDRckQC4GFD8CB1q5CMc/sA7k7BJCDxONO+IwITTwHaxoG74SuCx6ak
    /3+OMXluAsPa+SjDiWy4+dKLK3/Mxr5iK0FI8jImeeL5yII0yBXotjFDiq86n3uv
    DIyh7SCskumteiKYbOio34UcgU+QEwsPJpjzheUVirLpYCHou0C4lJT5Cag+iaL6
    IwgXolztsQJ8QYfGziRu0sl/PT9UFdW2MX5GrkPANUFyrTVqsreiuGfpHwPicJ4g
    KinD66iYRmGNDhfPtRM+P7M+XIMimQ4XKbefipIGYQshPs8sX5ITtr5pGdwXlnzw
    PhOsQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=NfDcQBHy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=NfDcQBHy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Mar 2018 15:36:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Subject: Re: [PATCH v4 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Message-ID: <20180312143654.GB21068@lunn.ch>
References: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
 <20180312084955.12686-3-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180312084955.12686-3-razvan.stefanescu@nxp.com>
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

> +static int port_netdevice_event(struct notifier_block *unused,
> +				unsigned long event, void *ptr)
> +{
> +	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
> +	struct netdev_notifier_changeupper_info *info = ptr;
> +	struct net_device *upper_dev;
> +	int err = 0;
> +
> +	if (netdev->netdev_ops != &ethsw_port_ops)
> +		return NOTIFY_DONE;
> +
> +	/* Handle just upper dev link/unlink for the moment */
> +	if (event == NETDEV_CHANGEUPPER) {
> +		upper_dev = info->upper_dev;
> +		if (netif_is_bridge_master(upper_dev)) {
> +			if (info->linking)
> +				err = port_bridge_join(netdev);
> +			else
> +				err = port_bridge_leave(netdev);
> +		}
> +	}
> +
> +	return notifier_from_errno(err);
> +}

I could be missing something here, but don't you need to pass to
port_bridge_join() which bridge the port is joining. There can be
multiple bridges, so you need to ensure the port joins the correct
bridge.

	Andrew
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
