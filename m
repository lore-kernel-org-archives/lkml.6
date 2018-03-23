Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1536617-1521817617-2-2651010526321368829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521817616; b=iQVjcCyODWWtKYb8bIW3DkXU5ZmYZLuICC0uQnDVoIevU2I
    /leOQnHb0cQIf3HtgRWA3Yv9BTvtiBcfVzrKpK14bqCq3Y4HMQfS2IGlWuD2OS72
    8tZOcH0ibNINWczDHTsV3JRNyEY6FrSfalJWfneTetFuPmd2OW6Go+70+Jl18FV4
    wFf7sup/6RcRureha41bKCadMPJ1xpmVPdlgXdjoF8I+FuX58BNo17RIKS3VOOeQ
    RMlVm2UjQFE3ltJ/Pap4T6jPYK6Hw1ewKISdBJjeGpdGrmGalLlA4dtaTMBTwYaw
    5CLp6YdTd3O3mVEhNAT7u+CbWd3tVgTDbk3dlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521817616; bh=4
    666QriPUHjGZAQ2xSbD0RHTNgbR9eg2QIjJ5CzO5J0=; b=kbGW5kdnNH6UJBRjO
    OAP7kWWeeMdnFPTd0D9h8xBx+eTbi6dIcAz6ue2ZbwSJaBxjQb791wHnkFvp1CZ4
    CU5QxbN5jeYEMN3YWWE0XbeBT5V7LqR90WyzBPUsaDwwqIKNL9k61/5socV/pnJl
    af8ZKde7mRRCIFaxWJKpmeP8FeqOyG9KqjS7zirmWq7TumOKllY9Y1/XT1WpQPEQ
    34wV2XWiVRa8RgyktbQNqR18RWmiN+5bxMYq66guCTiZI/gJbW4+rRWS9MiS0boj
    75KrN9w2jU2uM/oeX3+vg6cUFgbamEoiPlatzQEtLyoCje1PM6MxYimBHoCMTWy9
    9cSBA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 16:06:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 2/9] staging: fsl-dpaa2/eth: Move print message
Message-ID: <20180323150647.GA4968@kroah.com>
References: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
 <20180323134413.1532-3-ruxandra.radulescu@nxp.com>
 <20180323150126.GA12656@kroah.com>
 <HE1PR0402MB2700B5484AAEE6F1E5799DEE94A80@HE1PR0402MB2700.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB2700B5484AAEE6F1E5799DEE94A80@HE1PR0402MB2700.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 03:03:29PM +0000, Ruxandra Ioana Ciocoi Radulescu wrote:
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Friday, March 23, 2018 5:01 PM
> > To: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
> > Cc: devel@driverdev.osuosl.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/9] staging: fsl-dpaa2/eth: Move print message
> > 
> > On Fri, Mar 23, 2018 at 08:44:06AM -0500, Ioana Radulescu wrote:
> > > Let the driver remove() function print an informative message
> > > after it finishes removing the network interface, not at an
> > > arbitrary point during cleanup.
> > >
> > > Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> > > ---
> > >  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > > index beb5959..9fb88f2 100644
> > > --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > > +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > > @@ -2550,7 +2550,6 @@ static int dpaa2_eth_remove(struct
> > fsl_mc_device *ls_dev)
> > >  	priv = netdev_priv(net_dev);
> > >
> > >  	unregister_netdev(net_dev);
> > > -	dev_info(net_dev->dev.parent, "Removed interface %s\n",
> > net_dev->name);
> > >
> > >  	if (priv->do_link_poll)
> > >  		kthread_stop(priv->poll_thread);
> > > @@ -2571,6 +2570,8 @@ static int dpaa2_eth_remove(struct
> > fsl_mc_device *ls_dev)
> > >  	dev_set_drvdata(dev, NULL);
> > >  	free_netdev(net_dev);
> > >
> > > +	dev_info(net_dev->dev.parent, "Removed interface %s\n",
> > net_dev->name);
> > 
> > Why is this even needed?  I'll take it but spamming kernel logs for no
> > reason is not a good idea :)
> 
> Fair point, should I make it dev_dbg instead?

Yeah, that's a lot nicer, thanks.

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
