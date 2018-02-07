Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1044006-1518045443-2-12781077407923275894
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
    t=1518045443; b=X/+yu2xpRvfVAekfT4+iVXGtO6oECQ85RmwV93O6gE5tANX
    l8PFqUq1jUylnYXjgL8OAMaiIbPfqhwaDkuYa5H37tPBDyYPsUaO0BuzLML64m5S
    tTPs7TyolgxjoeN1+BEzL6LBB9Plu47D9M5MhEmk5d5LWfUuustCDJk+wqZr+Fqc
    pKwqdCyyXdaZhhQLgrat+xjnsD7cPjpQVpdv9MD+sj6sUHCgFOGtWVS7htTi7/qa
    uFUfbLHmQTV/NYYSjOM4p20N50EghVyDH/Qoucej5YtgeMjuNWQTy5R9H+6AaFB1
    zPrDcYgC0TrC5zCo45EOo42eSNYa9Dpblr0Bi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518045443; bh=CyKFhnBDJF3MkCN7ZINlBFolDu
    O7MJrvtQgas8CvCT4=; b=tgxncDQlEXAg5WCihqHy/vc41qbjV+4C6BYKeYw2Rf
    526UIWeorrWTNS1mxfNP6ZwKp6IJXQ9dKSPi6AiC1PKrws6SiXxxmLalP3STu4zw
    ZGE49V8BkqSmL1KLdNF6HXuZoazrl/r3PjQ84XlZyba6bh8HejLycnmP7/tlIVhQ
    EHKbJ03itNfCG8ki0VUbzWj8aUj/kWbudY8ZCiFGx62bh3xTkq63AEREYgXD15x8
    R2u0knKGxN2m7ImfbjKX5/O91lQLGGAyc3+Z9W7GLZgzyFe4hiqFBQYzJPOLQvRc
    yae1ew2Mu3J4yP7USDTQt2D/ri2S992ML6R7CbNeYkSA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBGXRU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 18:17:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeBGXRU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 18:17:20 -0500
Date: Wed, 7 Feb 2018 17:17:19 -0600
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        shuahkh@osg.samsung.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
Message-ID: <20180207231719.GE10647@kroah.com>
References: <20180205182351.774761393@linuxfoundation.org>
 <CALpmF+F0K4eXMe2BrHraRyhNK3hktKoEQNNjhdELC9tqaAZHvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpmF+F0K4eXMe2BrHraRyhNK3hktKoEQNNjhdELC9tqaAZHvg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 03:19:07PM +0000, Harsh Shandilya wrote:
> On Tue 6 Feb, 2018, 12:09 AM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
> wrote:
> 
> > This is the start of the stable review cycle for the 3.18.94 release.
> > There are 36 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
> > Anything received after that time might be too late.
> >
> 
> Let's find out if I am too late.
> 
> https://www.spinics.net/lists/stable/msg213160.html will have to be lined
> up for 3.18.94, or to .95 if I'm late since it's fixing a erroneous
> backport from 3.18.93 which went unnoticed until after release. The email
> bringing it up and the subsequent patch were probably lost in the usual
> stable noise. I have applied it to the CAF tree for the oneplus3 and
> verified that it does not break compilation or userspace for arm64.

It will be queued up for the next release, I missed it this time, sorry.

greg k-h
