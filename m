Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3734533-1521630208-2-8041460278393454716
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521630208; b=Nw3k9gINVZF330+BB389lr/r4hFjxJ7WQQQ1FlDSHTMngHY
    UrFqSaL3EZFyH4ao9q9xnKpttT1/Rv9haFBp9WoueZjvB5Mxa9HPeSqAYktRIdBy
    EuTR3TtHw7UHk1ywZGfHZq1X7e3sSPobVFVZj3x3HOVLZhja1tCWR4VbtyepHS72
    LA/epMZs6KtdDdwTXVXbh9OfgLWg9D4wCsBtyjRDZGpVjtixr/8UtIKPXPz+vY/l
    87UeI2rD+LuOCSrRK/0+OBb2TpHb2C83qeukhSreMlCaVRnMXuLp43L67JoLQvIJ
    bf5/tY3tUa3xqfAJ7ldk5EhMsAkh8jI60O398Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521630208; bh=J1IZ3IMcv/t3sQoVNbBdju7+uw
    I6lVWwYa1aQuqGOyo=; b=VXL+tNS0U6baH8RX8E7i+OvHJ6z443r7ZMQJZOjHFj
    3Sg671wzj1RQ0PAzXNVq5klnSye7qbO/6B7tm6g9z0r4Ovtdbk35iYjd9nTZh0D1
    cx80d8rg5HB/4+lYp1uJgbx+ABQbjW5xljZJ91j4Z4c1FgDL+Grkzi3w6Lg49Lea
    t7x3pzbZMhzDT9G6Cv+aQbuyI8VZeLjMCv0fk1FJYDhaQ/GX9zLpYNtHc3czb9T5
    4s1N5rw6TWM4onjvoBYOS+6/g/5IMrLBBRZJ8XkRiC/p5xvqOZGQzUI1y5aIpNLc
    g4OIbHNWyqrIgG39Cz+J+seQivP6mKq+3mq9FsQ4nBJQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCULD1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 07:03:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCULD0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 07:03:26 -0400
Date: Wed, 21 Mar 2018 12:03:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
Message-ID: <20180321110325.GC24810@kroah.com>
References: <20180319171827.899658615@linuxfoundation.org>
 <20180320144751.GA16028@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320144751.GA16028@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 07:47:51AM -0700, Guenter Roeck wrote:
> On Mon, Mar 19, 2018 at 07:05:38PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.101 release.
> > There are 68 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
> > Anything received after that time might be too late.
> >
> 
> For v3.18.100-68-g290f46f:
> 
> Build results:
> 	total: 137 pass: 135 fail: 2
> Failed builds: 
> 	arm:allmodconfig 
> 	arm:omap2plus_defconfig 
> 
> arm/mach-omap2/omap_hwmod_7xx_data.c:2109:12: error:
> 	'HWMOD_CLKDM_NOAUTO' undeclared here

I've dropped the patch that caused that error and pushed out -rc2 for
the test-bots.

thanks,

greg k-h
