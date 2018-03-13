Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795102-1520937204-2-4660791873085596583
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-1', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520937204; b=niig0CywZLvnoouKLbGto6TQ+3hbgFYaSK34BbzOBKYTGnm
    6eisZ/p6GO0wv7aU7Ww6qzrfrHJvd7S3dNTGOIW4exW3cDsQBHfjPPF2Pzy5CCGw
    E6uR20fPosMtJOTE/mfDAvKNHvSrXkwoz6OqnIv4hGN8rEkf+a/PfdrscC0AFimi
    Q8wMifY9VcbEi3Y1imdQbL39/Z+svCDifYqPw7ppRCcIyXsyHttpiNOCqAqHM+Hv
    zoZoA2IycMbVlqYbZnIxHovdrSIfSnSA8rQBz3R/mZFkR3lu5SXqVdHr1U8ZFwzt
    o/cTMoegWopA8PISIbJKu9WWkbUrKkCbHdFTy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520937204; bh=VvxqVftvoLKtQrA/5NSU8OWskmY4S40buS4fNazwgCw=; b=Q
    fTBSh97L2WdqFp9GWzPDfovfQvFl1Q23TwvZu4CSaAFCIJZZUd5X7ADZbC1350BF
    0QBg8ihBRHYV+5sTE+pg5T32Fgb+iGAHc52hguVoAHKe5Mep6zQ0Jg0Li1IpeH7f
    vkxZoDw1tbJ6wZH/k55rL4s49Fyqn02kZkjXfJiFRDOH6ujGME8SnUWHdmOGecaW
    RxXqcKFoXqPEwWo6Z+GKMUew1QLVj1wgjT9tFado/3SFhllL+CBCHEQdvD5t6Wdr
    JtBbzeJG4+19nrwSwyJaOxWuMDlNIbMmfCM1ptPVnwhJ3WH7UxQHAimN6lZiVHyR
    NTD0Qt/wcMYydUM18deCQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbeCMKcu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 06:32:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:35712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932574AbeCMKct (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 13 Mar 2018 06:32:49 -0400
Message-ID: <1520936817.5879.2.camel@suse.com>
Subject: Re: [2/2] net/usb/ax88179_178a: Delete three unnecessary variables
 in ax88179_chk_eee()
From: Oliver Neukum <oneukum@suse.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Philippe Reynes <tremyfr@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "Andrew F. Davis" <afd@ti.com>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date: Tue, 13 Mar 2018 11:26:57 +0100
In-Reply-To: <7d45bd0c-5ab2-a2c0-d746-ef2d859eea08@users.sourceforge.net>
References: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
         <019cc24b-d9c0-d782-35e8-f9f8be0534db@users.sourceforge.net>
         <1520849038.29340.3.camel@suse.com>
         <7d45bd0c-5ab2-a2c0-d746-ef2d859eea08@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, den 13.03.2018, 08:24 +0100 schrieb SF Markus Elfring:
> > 
> > > 
> > > Use three values directly for a condition check without assigning them
> > > to intermediate variables.
> > 
> > Hi,
> > 
> > what is the benefit of this?
> 
> I proposed a small source code reduction.
> 
> Other software design directions might become more interesting for this use case.

Yes and doing so you killed three meaningful names that tell
us what these checks actually test for. That is not an improvement.

	Regards
		Oliver

