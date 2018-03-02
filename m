Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2297825-1520016838-2-16926848019326959916
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520016837; b=JwCEYHtPFiawqP0ogAbqMGGqPvtQ62nJStF+tfKDO8Jijft
    qyLXvXepukTWIXyT1oTfZO/JJ2bBx3X65Il7SWPIEYcpm4VwxaohGF2jwdpA1ORn
    cxSFoce6t3+h80wLKNo2tChjbM4OQEmhHcfsfcZ1CQt8sYkN0UdYBGDl6vuda+js
    T9YKzgSkQaxguflfD2CfLUq/j7JdqAkwTe7XrHTBIb1XWGq5ulZnDXguFgrMdmNR
    IsDmf1EfqV2W1O0u+ugKeeSacLc5WhIeDaFub6gqtQ5f2KxKqCuzYsribJXQyz37
    xks8bOHmFZOAb6jjowaihdL07ySIw4gA1Ztz79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520016837; bh=zpALONG2AF458SxhQVBrT69XAs
    iWsfMVoxMPZ32Ryxs=; b=I71hLJBzCfIThtQfu7yohJ5D1HEAWoq+KU1zAhOSCm
    +d1Q08/d356r0O4Usskn3LYKCljPYm6YhmQBrQBir08kVOj4DjofAozyeMkMDIkr
    AkfWlbZ7YvwkFrgxiq4vOm3lBDmnDBTU7YHWZsMBS5sL6ZYmHVEb++cPSDCg34Qv
    Jc9QYD7owwF9OfZ4uvP/eEzOet1JiACGKPCiTw2pIHhPVW/sjIU9ZFECX4odSSI1
    yK0uL9l8twsMz4jsSH4vDcU8Kt0UW97TNEMGVS9CLH7pKtmLxbr29WEq9wQ4eIMW
    3o/abockQkv970pD5LwDR7jnpSSFQarY6JYgxPZXxULg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947591AbeCBSxj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:53:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947573AbeCBSxh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 13:53:37 -0500
Date: Fri, 2 Mar 2018 19:53:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/115] 4.14.24-stable review
Message-ID: <20180302185337.GD16331@kroah.com>
References: <20180302084503.856536800@linuxfoundation.org>
 <20180302171503.GA9473@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302171503.GA9473@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 09:15:03AM -0800, Guenter Roeck wrote:
> On Fri, Mar 02, 2018 at 09:50:03AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.24 release.
> > There are 115 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar  4 08:44:32 UTC 2018.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 134 pass: 134 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Yeah, they all worked this time!  :)

thanks for testing and letting me know.

greg k-h
