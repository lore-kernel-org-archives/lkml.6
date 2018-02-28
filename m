Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3768768-1519805801-2-17182071045433583221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519805801; b=c0YDUD4qX/LRoFRvRU5iT0Evz1Og769Kedflsl5Poa0A/PE
    mYIVWYqJKrd0f0Fx/c1QxHeW5HvEI1mwAmnCsHqKX706CcEtJlCuBA/G1xM6qOT2
    Xk+TmSw7cIdGj8IB7jZATuW09U1Xcxgd0+TPamG3GuKtYMB3fQq6k/+R7acWyeSY
    F1noq/C05tNGY+lvBp1fwcdlzsJA3/B3R0a1Cg9K+zlOn82o/wEFmoXXVQ18OxOb
    ZlUJtMJj6WzOVDvOF1RQieNA/+CuaRa451kpTuOQE9Xi90EF0d1ovlQpTb1d9fdJ
    IHWmzvFTzjdEusJx1izCbKwM4H5VwmJAhskrbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519805801; bh=w08fbeD
    254DP8zid/JHTzmso2BU1gV15egTkvPvJlq4=; b=d6IzMmryiHyxNJKPlzo2NEa
    oJ2gDvcs0zrRZdn1Tjw9HUGTt9NHAb2QM6/+Y/ds1ECwf1raKnxFzqL3pR1aUPOo
    BmgLBKI+7Bv7s35HrKcciSRORe4xq17sqxaBYWdcICjMpW980fErZWMSRuxRIbqX
    LW/HvZmgUJiGoEpjXcuEZtq6WiwGEa4R/W+SKIxVRz5Bxz/3KGKry2INihm6UeAh
    G2SMIgyrjf4+y51nKPLhZJtc7UbR2dy722BfxA9oG9VBwNAbKXF3fa1X84wt/jcr
    4+Ww/CRwWBXvINB5X7O/2CfKVZIGrhIwr36EGiwugk/QxUbiA/F9i+CgrR+OnuA=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeB1IQg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 03:16:36 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:3202 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeB1IQg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 03:16:36 -0500
X-IronPort-AV: E=Sophos;i="5.47,404,1515456000";
   d="scan'208";a="68757198"
Date: Wed, 28 Feb 2018 08:16:23 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: "Shah, Amit" <aams@amazon.de>
CC: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "Valentin, Eduardo" <eduval@lab126.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "shuo.a.liu@intel.com" <shuo.a.liu@intel.com>,
        "anoob.soman@citrix.com" <anoob.soman@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 2/2] xen: events: free irqs in error condition
Message-ID: <20180228081623.umnyv4w67h2rsrwk@MacBook-Pro-de-Roger.local>
References: <1519746958-52077-1-git-send-email-aams@amazon.com>
 <1519746958-52077-3-git-send-email-aams@amazon.com>
 <20180227170740.jcaxsvpepsn6eot2@MacBook-Pro-de-Roger.local>
 <1519752774.4965.23.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519752774.4965.23.camel@amazon.com>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 05:32:53PM +0000, Shah, Amit wrote:
> 
> On Di, 2018-02-27 at 17:07 +0000, Roger Pau Monné wrote:
> > On Tue, Feb 27, 2018 at 03:55:58PM +0000, Amit Shah wrote:
> > > 
> > > In case of errors in irq setup for MSI, free up the allocated irqs.
> > > 
> > > Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message groups")
> > > Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
> > > CC: <stable@vger.kernel.org>
> > > CC: Roger Pau Monné <roger.pau@citrix.com>
> > > CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > CC: Eduardo Valentin <eduval@amazon.com>
> > > CC: Juergen Gross <jgross@suse.com>
> > > CC: Thomas Gleixner <tglx@linutronix.de>
> > > CC: "K. Y. Srinivasan" <kys@microsoft.com>
> > > CC: Liu Shuo <shuo.a.liu@intel.com>
> > > CC: Anoob Soman <anoob.soman@citrix.com>
> > > Signed-off-by: Amit Shah <aams@amazon.com>
> > > ---
> > >  drivers/xen/events/events_base.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/xen/events/events_base.c
> > > b/drivers/xen/events/events_base.c
> > > index c86d10e..a299586 100644
> > > --- a/drivers/xen/events/events_base.c
> > > +++ b/drivers/xen/events/events_base.c
> > > @@ -750,11 +750,14 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev
> > > *dev, struct msi_desc *msidesc,
> > >  
> > >  	ret = irq_set_msi_desc(irq, msidesc);
> > >  	if (ret < 0)
> > > -		goto error_irq;
> > > +		goto error_desc;
> > >  out:
> > >  	mutex_unlock(&irq_mapping_update_lock);
> > >  	return irq;
> > >  error_irq:
> > > +	while (--nvec >= i)
> > > +		xen_free_irq(irq + nvec);
> > > +error_desc:
> > >  	while (i > 0) {
> > >  		i--;
> > >  		__unbind_from_irq(irq + i);
> > It seems pointless to introduce another label and another loop to fix
> > something that can be fixed with a single label and a single loop,
> > this just makes the code more complex for no reason.
> 
> I disagree, just because there are two different cleanups to be made
> for two different issues; it's not as if the if.. and else conditions
> are going to be interleaved.

Oh, I don't mind so much whether it ends up being two patches or a
single one, but IMHO the code should end up looking similar to what I
proposed, I would like to avoid having two loops and two labels.

Could you rework the series so that the end result uses a single loop
(and label)?

Thanks, Roger.
