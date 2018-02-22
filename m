Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-294332-1519309758-2-14411313120607429439
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
    t=1519309757; b=GS392+klfcj7p9VIO8dGq1tLueO2dWOLiPpZcmPf7JjXcfF
    lHQ1R8CHqACKWIAKO7e1M4H+tZCB8z48sK5aMEeO3XeAWoi+WH/UeYwklR59W11D
    MNIVz52Hu7P1u4UT99hzRhnZp6EdTg0PULO1IowrRz46E2+i1Up4M6FowznVdd3v
    pSzpCZDV437Og1FvjavHCLwjGnWBneJXYtHomO7UIeJH/QD1Xd2bx7aFKLkqPHVz
    3MBUsQvruayJFyZTq6ZduVWLOr2IUdkiuZr3R2HDzzJZsLoGB2J4oKKGUXH76wZv
    AlbgI1dDlR6kZoVSZZEUf7hHL81wjga7CnevXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519309757; bh=eOfPBV44FivFZ9jQCBBTWVKmDb
    6bhHWzKXzXAxUJNr4=; b=RPr4xSpPRgvVF3m5N8aRQnBPgK+vFM7WV/v7cCpHjK
    uVgAxNlO9foxT820JqyK49PkXrIX9097DDwo0co5L1t3MK3+5s8+4PaG0SwPyqmE
    tE19xjYMwS+zAlptzPB3R0P0sfMeXm6+QkRbMOrnM5Wco1xP+fJ1UYvDptyC8g8t
    TAHmBgIQOLHNdsFJu+4D8OkS6cqCWx5bz06SjLStko6Mhl6tvUYZRIHvbmtOTpg0
    5/UJ7aSs3uTaYNhTw6ojDzJx1MCMgxpKPK+egYcUJNpUiIdHcPqsUmNFH/Wl9l0o
    P+CxGKhii62uaRKjUOHnV03yQOxudwgstdyl0TwLNwsw==
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
        id S932799AbeBVO3F (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 09:29:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeBVO3D (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 09:29:03 -0500
Date: Thu, 22 Feb 2018 15:29:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/163] 4.15.5-stable review
Message-ID: <20180222142904.GA16772@kroah.com>
References: <20180221124529.931834518@linuxfoundation.org>
 <1fede8ac-6adb-ab72-e620-31f726d738a3@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fede8ac-6adb-ab72-e620-31f726d738a3@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 06:14:12AM -0800, Guenter Roeck wrote:
> On 02/21/2018 04:47 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.5 release.
> > There are 163 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Feb 23 12:44:46 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 147 pass: 147 fail: 0
> Qemu test results:
> 	total: 126 pass: 126 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Yeah, I didn't break anything!!!

Thanks for testing all of these and letting me know.

greg k-h
