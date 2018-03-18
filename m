Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521368757-2-13219051546154781850
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
    t=1521368757; b=RHfQD6x78ns9HwwtfyH+ZBzCaqTVof4tw+/fOYWiWZJhozP
    jPn+bDyhYYV538ANdeXEO0dyAYIfRraav+fjKv/kdeUBoKnl+O0hB8afZn86myWK
    jga+/g+AEIs9ga+JrWRwzaUi7uZVtUJnkyn5qh2/G1BNc5rxRb4/p+AkXfXGWQKQ
    UQG4R76aW67QIHv9UJ92t2xBkv0nh9M7bm1hFVyIeW3ZaJhcQquDlqem3GsgCUVI
    zQO2rgfrLs+Bk8ReNX5EuJ2WKm7HObMbYCSimxGT6ydRRsB4Ga5+qRYsHLTRJfNI
    nI0vz1NHspHm3pWBt2H60xRrG2KQKL8VuSGCgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521368757; bh=nB9UKvkCNYhA2TakINLhURZBAy
    T6oKuvIsa/A3SUHds=; b=GVWwnm9gEx87kRTzYaJ1FPXOeS4/QUxktMLFGb6co8
    araubnxleYhYZJcls1KwDiZgFUuugXi+sktMtLwq1T7dtSlbS0rYrIeVyBist7rc
    hwBwz76ENk1xnniV9TSShO6EsSM0VlEm1EKomk6qoXd94Y+suwg9oipn+8iaG/qo
    vPZEmqc6gFObTLDrf8dHBcEb5sH0a7LsqGNwRKca1KJ6IlA1hbId1oDM2wAGXDld
    uU1OKK5ROv8QQXCbWzcoEiv7d2tVBKe1Y0AJ4APjgT1hYzhpoC9Zwga8LXxvXKcA
    a+D3m83TCdNZxoTW8L+OhgDh5aU46nh/6AEFgvOZYZyg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeCRKZ4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:25:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCRKZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:25:55 -0400
Date: Sun, 18 Mar 2018 11:25:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
Message-ID: <20180318102554.GA32470@kroah.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <e3602cfb-31ba-b3ca-0c74-01cf172eface@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3602cfb-31ba-b3ca-0c74-01cf172eface@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 07:46:20AM -0700, Guenter Roeck wrote:
> On 03/16/2018 08:22 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.28 release.
> > There are 109 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 145 pass: 140 fail: 5

Thanks, I've pushed out a -rc2 to hopefully fix this build issue.

greg k-h
