Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859500-1521726860-2-13387560956667077472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521726858; b=GAp8A2/l59dkeVDFQaFzk9Io1MNpY8/x/Jf6jolzXwIEhIH
    3MwsPB0RihYecyZKX02OWYSGURC3FteGGN9QDtAnopXmE/KzZKKanPopFsaILcJq
    h7qqsyWtU66SGgL8BXKAp0V5YZM8p3uT11c355ZoxcQqh1aq4Yuezm4Guy3VHtrk
    TjhUTdtMm63FcemFAjDliaK5OeqxxpmjG35IBCG1sKLYred6bDRncith4bTJ/hDc
    Zat9yESg1f9XY+5MrwQKxVeR5cj+Ux0ODAxdEYpKL0EhzMQb4eCpOr9sAcUQFRVK
    eIQ+BPVnV/C+oArj7jXFK5iQrpfKtPXsN6Bqx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521726858; bh=S41qvS1foYvwSxjYw6EltvAbld
    ne1I9xP3a5i5wkK/w=; b=UcU/kTw7WkVzknzLwNhwmGW/ipZZXHGFwpQIE3NtWa
    irxHCdR1Gq7+PXIeUQZiSuiRjVrZCNRqIHxCR3IS5Jt5isKxKRDnTDmH7UUT/TFP
    B4/d66KcUsU9Y0bU80MIJX5xa1gkU+hsJA9tHhraQXYjKClC1R/Karkv47i3m9Wf
    CyXkzyDQHjsseJdpo+v7K29taNiMuvEqSVWkQjddzAcwEruTR9WIEZi9iM/a+sGQ
    28WB3nRRDvgonWq1x8OlSkRtFqv78icggOi++mkMLibu6nBBsKZ97sA2hDsgzjGi
    pVqNilaVwrWpQHY3dl+oDHGPhKqQX/J/fLNWs+JX2bBA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=g5USc1ID x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MMYkWyUS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=g5USc1ID x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MMYkWyUS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755792AbeCVNxJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 09:53:09 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32933 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755793AbeCVNxC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 09:53:02 -0400
X-Google-Smtp-Source: AG47ELuCsTzDxaWpRhq0mRmoLREgd2dKsgmU9HdZrt6lMaMI9TsovRr9kbuf6T5wF9XWNS0yrgwglQ==
Date: Thu, 22 Mar 2018 14:52:57 +0100
From: Johan Hovold <johan@kernel.org>
To: Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH] soc/tegra: pmc: fix child-node lookup
Message-ID: <20180322135257.GB8272@localhost>
References: <20171115094458.31666-1-johan@kernel.org>
 <43890bb2-f902-2fc4-7480-a8cb71061048@kapsi.fi>
 <20180112091951.GC11344@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112091951.GC11344@localhost>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Jan 12, 2018 at 10:19:51AM +0100, Johan Hovold wrote:
> On Thu, Nov 16, 2017 at 01:40:24PM +0200, Mikko Perttunen wrote:
> > On 15.11.2017 11:44, Johan Hovold wrote:
> > > Fix child-node lookup during probe, which ended up searching the whole
> > > device tree depth-first starting at the parent rather than just matching
> > > on its children.
> > >
> > > To make things worse, the parent pmc node could end up being prematurely
> > > freed as of_find_node_by_name() drops a reference to its first argument.
> > >
> > > Fixes: 3568df3d31d6 ("soc: tegra: Add thermal reset (thermtrip) support to PMC")
> > > Cc: stable <stable@vger.kernel.org>     # 4.0
> > > Cc: Mikko Perttunen <mperttunen@nvidia.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > >  drivers/soc/tegra/pmc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> > > index 0453ff6839a7..7e9ef3431bea 100644
> > > --- a/drivers/soc/tegra/pmc.c
> > > +++ b/drivers/soc/tegra/pmc.c
> > > @@ -1321,7 +1321,7 @@ static void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
> > >  	if (!pmc->soc->has_tsense_reset)
> > >  		return;
> > >
> > > -	np = of_find_node_by_name(pmc->dev->of_node, "i2c-thermtrip");
> > > +	np = of_get_child_by_name(pmc->dev->of_node, "i2c-thermtrip");
> > >  	if (!np) {
> > >  		dev_warn(dev, "i2c-thermtrip node not found, %s.\n", disabled);
> > >  		return;
> > >
> > 
> > Good find!
> > 
> > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> 
> This one still hasn't made it to linux-next so figured I'd send a
> reminder. Will you be picking this one up for 4.16, Thierry?

Another two months, another reminder; Thierry, can you pick this fix up?
It's got Mikko's ack.

Mikko, can you please ping Thierry in case I'm getting stuck in his spam
filter or something?

Thanks,
Johan
