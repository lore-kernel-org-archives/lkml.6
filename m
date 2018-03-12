Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4187132-1520849405-2-1383333962047824963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='ISO-8859-1', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520849405; b=T6N/GGNdYTLMSHmSrtFFnIB4Hcs/5F9UmKbbAAohezBaSlG
    YCTPGOTmXfwSzTZKVYcZuX+r8rwdkIueP59jNoFlF0B//zeuPpYl1VQfU4+ekXbp
    ARodNFlD46HCA3lD92oJQ9ZIOnjRme9frK1bEAWF3a6wiPwU1tPFbphCe18X75Jl
    mu0d05NidV/kQOA2Ab2J30Sap2Hlc8ssgD+j5b2T6eOHUWIYAN/CrBNIho4nG5jz
    8GprNFD8MS7ym80xP0rdyfSg6m6biimoa81W0s08dw1BW6b24rhzA/Gc0mJJy//U
    Pba3X+wXEFyEbHZep6MMrzphahWpkM9UeFOEq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520849405; bh=7C+shE8EzK1eQxLGhI5q1yBtLzxxOpQjvzxoeY2t/bQ=; b=p
    ShAQmPk8kUkvtBj2rC8dIcAyx1Wd7PZl9dCiCRVTbc5qggM2eqavrYXNF2lSEcuo
    llaVC3mQVedRm2vnWLOCtfMMefsfAlgEFhM6AYz7DphcBTFS0nqb5pIV8tGyQLMl
    4FTJcna4c9Lv5SyBRA7PhHi3HUPx8sGQ0Dfbr2JZgayw1GreQkLDX2MJnm1N47gc
    P83vLb2NCDVLKw1ve30A1qZd3cnViKvXvh7Wi8GUJBnrbqn9oIqddHA+YGEcftGu
    f93nCuA2JK3PGtGGHUNVHZukbjdzI9tOm2sbCieSR2epBEwctxOuK23vMOaT1rBC
    O26CiOLLlRY4WxEIE5/SQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S1752740AbeCLKJv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 06:09:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:44697 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752737AbeCLKJt (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 12 Mar 2018 06:09:49 -0400
Message-ID: <1520849038.29340.3.camel@suse.com>
Subject: Re: [PATCH 2/2] net/usb/ax88179_178a: Delete three unnecessary
 variables in ax88179_chk_eee()
From: Oliver Neukum <oneukum@suse.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Reynes <tremyfr@gmail.com>,
        =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "Andrew F. Davis" <afd@ti.com>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 12 Mar 2018 11:03:58 +0100
In-Reply-To: <019cc24b-d9c0-d782-35e8-f9f8be0534db@users.sourceforge.net>
References: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
         <019cc24b-d9c0-d782-35e8-f9f8be0534db@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Samstag, den 10.03.2018, 19:26 +0100 schrieb SF Markus Elfring:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Mar 2018 18:53:28 +0100
> 
> Use three values directly for a condition check without assigning them
> to intermediate variables.

Hi,

what is the benefit of this? It looks like needless code churn to me.

	Regards
		Oliver

