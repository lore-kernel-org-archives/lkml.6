Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3581790-1519283428-2-4065400282465016592
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
    t=1519283427; b=MnMugGQqkd2u+A4Q3x/kIKm/P8ikjE3Sp905IKrAj8EXyN1
    QrR1YAZuiIdtLdFIot4hVT8qFzrIQWhNh36YlQ0TJ6gNPo6keVyQ5ev5+KcMphQG
    NQmY5WnBqY4bfB9AdqLGAMlRec8Cq0Hp+4Krdxc7qZfwDIysTL1Ltgz9/rbPskfC
    7gI23DKfzWpjQQ3/5mPYAxVJ2HR68RNBbDhejqQRCAaTOnD5/CpwtkxjZFiAfL98
    i3ZdszrgXlT7iuupxzunZ+G3L53Sd85RHFi6gU49q/9ub7NtoqFoTt1kvLcgKde2
    S4b4YDlDIRhqDAcES1LpXuo1RyngoJ9ZW7KAhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519283427; bh=PMG8IkgtIo+xh2wU+nQIz52ne5
    6zLH9yM9cO3tF4gWc=; b=c1w4MgTqVi/ZY/bH4f0rS1kgYNIfCACoOXhjv2Ip2k
    XFRLjqqgvNDKrm9ltLYEMShVyvSvuuT73UseDVYcd4YyrY8Lekd2h+M5Udb1Zx/G
    18G0a1DmUT0sXHtrebEMBYNQB4WubdNChakMg182M/eXxYhSnoINETnRMDjlfQ0Z
    MzA8FzOASrTWnJ6fF+HWSABIUyv5PsxcOMgnVMRpGFa+WGDgX4/tGwExNS7bb6EV
    XiudWj5BIC9b6P8v7byOj6jt4cdcDvzEk9SnaSZ9oHswgzXXrqlicsGZyED6r4FE
    oUBR03O6URX8d9LG2aTWo0dAvORkjQevZOEVU8LDYQHQ==
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
        id S1752683AbeBVHKZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 02:10:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbeBVHKY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 02:10:24 -0500
Date: Thu, 22 Feb 2018 08:10:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/163] 4.15.5-stable review
Message-ID: <20180222071026.GA4763@kroah.com>
References: <20180221124529.931834518@linuxfoundation.org>
 <1867e950-0765-da2d-8349-f4babfb21324@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1867e950-0765-da2d-8349-f4babfb21324@osg.samsung.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 01:13:46PM -0700, Shuah Khan wrote:
> On 02/21/2018 05:47 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.5 release.
> > There are 163 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Feb 23 12:44:46 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.5-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
