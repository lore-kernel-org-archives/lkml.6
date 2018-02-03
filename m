Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1266991-1517672664-2-8862591077119292409
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517672664; b=gco0jyGkBv4o2IctDgT41zcwXSIscDpJDHpmtNjiwMeMGkR
    qC1+uj4opBIH7nRpgALZTHSDXL9gERZkiFIcG3TSL9UlCtRwjS/+HcDPI0IVjoZa
    /0zcfWnWQuxBF8YX/9jcnyG+hPIPZIfpR3bXM4n3ADnQtWNPyyMKza3pLrMHtbSY
    wU9hsLQlC/RtIJp/WyggO9cKAcRssrz5tI6bTpSTIpQSFr/rd7p488N3oVmw68uI
    j1retaFWzibuzJO08TuS8jj6W06HdrHDweT/Gr17tcgx7iojdpFSMXW6dFS+hRI8
    ocyGaWDvPetJwQbaWN0b22TNs9Dy/nFBhmKnf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517672664; bh=cqaCm8YKsYAD1jNgqBN54JPYkc
    kgGPvcjR22RsDPKEI=; b=nqvDBNr2Vc9TrzL9xe6CRxmVjYJRg7K9bn2g6zY+c4
    /OejoGFhmxiyc4qNn9zmF95ayIPzG87/i9zziKXJS/S2I+7rOXRwpydEVT6W0T9U
    enlm/YX6rNpVlQPwstZRsKWjkDbLDIJeiPSdTsf6OCgpVRUAa+VRh+0NYVjyr3H/
    L7ot0FtSH40c3E2TpsJ67XT4jO3cVMSjRmY+1rDtaLOJwIp/3KzzXZdXqNLvP54j
    zwXoGdjORmF8a5nh08jEHzmhmZAx3d6xJUyIuK4b2Am0TdJyzNfhcfOkg65/k0Oi
    DZm8rOg0xlDd+lUR6TXDGrWuBjRpxmI40uYzlNakxpRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBCPoV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 10:44:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbeBCPoV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 10:44:21 -0500
Date: Sat, 3 Feb 2018 16:44:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/67] 4.4.115-stable review
Message-ID: <20180203154418.GA9631@kroah.com>
References: <20180202140815.091718203@linuxfoundation.org>
 <dfe4da5a-1c80-96d3-2b61-e8b4fd375fd6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe4da5a-1c80-96d3-2b61-e8b4fd375fd6@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 03, 2018 at 07:28:54AM -0800, Guenter Roeck wrote:
> On 02/02/2018 08:57 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.115 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb  4 14:07:31 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 145 pass: 145 fail: 0

Really?  0-day is saying there's an issue with i386, but that must just
be a build warning, so I'll not worry about it :)

Thanks for testing all of these and letting me know.

greg k-h
