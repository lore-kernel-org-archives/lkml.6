Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1819693-1519227070-8-14858033873716200741
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519227070; b=uB97R9S4gLd1qXot8BfvpjKiAhad3s5/aN1NGw2OaC6JEKg
    Pg4nE0FnFup7JVZZ7UjOsj9xX357WgVey7F6A52KOE0raCXwonxfsYvvckLbjMCs
    lsQfCTckY5RpsU2ahKw023ZvExXL/URVsQDua5Tq0VlwlNMmeae99mWBOJdH9E5A
    4B06muoAavzG7VDN4tTdwq6YzBPx+xOGWPxRJJzCGNSRDC3JFPe8vIi2w/qTqX5+
    Hvnd9afJa09A+16sGsTvtFslyfF12U8Eh4CaK/bbp9detTCeF5jhLPKb0Cg1zrVA
    WkPIcKTNViGEYfEWcvR/vIywohSfpWwMFeedTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519227070; bh=+r8wEsCyqtlOlZjeAGQVS7VY/T
    tqjSsyO3VI+ix+o5o=; b=bR6n4bM2X+CJvrxZOYrXwQrxgmqyFf9W+qq4daPEsL
    HjMjmG7vtZdUI0tvxmPTIulOr7LWz4x8Hr4fygrZgEmWoUVJuQxxVhn6orGsxB9t
    P0P5SnVch/pZsl1Dmn+U5+vjxX4dr+9IKU1frG8Ni9Fn7nN9Romul0zh3gTJ0kwZ
    kt2E/8LXcrR9KHCLjyd92OvBPXwiSCm/X7V4grVSPVq5GVpbZDggDxTw/Av/U/RX
    KZ2h2ghGpdhXu65eik7r9Ys0brt0ax73dyuB1BMMAvjoHw7ZW2H5gblsaLEG2xyD
    7AVCcDn/sf3zIWkIzx8qvotK0MI+KSox69VXRs71z9PA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938366AbeBUPat (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 10:30:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44052 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938264AbeBUPar (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 10:30:47 -0500
Date: Wed, 21 Feb 2018 16:30:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/33] 4.4.117-stable review
Message-ID: <20180221153044.GA23757@kroah.com>
References: <20180221124409.564661689@linuxfoundation.org>
 <20180221144626.GA21376@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221144626.GA21376@flashbox>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 07:46:26AM -0700, Nathan Chancellor wrote:
> On Wed, Feb 21, 2018 at 01:44:43PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.117 release.
> > There are 33 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Feb 23 12:43:54 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.117-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> >
> 
> Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.
> 
> No conflicts and no apparent issues in dmesg or general usage (I've been
> running the RC before this one since yesterday afternoon and not much
> changed for Android since then).

Great, thanks for testing and letting me know.

greg k-h
