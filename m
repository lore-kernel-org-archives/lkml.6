Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1457237-1521024988-2-2038540901084507334
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
    t=1521024988; b=be+HDsc4ox9BvsMhlQj1UrHFaKWmSxw2SQ3hgJO0YgSDOJW
    4QHDIurKe1sxuVK7cqZoZmehO5bXm4xbuS6DC3qjnHuiKAP9TkAkumHJv8zyjtLp
    MJnPXDnaPQd9Qwhkz6ddeR6X21Onm1gwTM4E2WP+4Sag34e4TGYWdtlVa0tREgEg
    3F27MML5jW3IVAcczzUzXOczBmWi9IvM45txqdUMnt9kclS5g1V+1QT/NjX3wJLa
    gEOjndwjxJYLzoRF+LkSKqid+JEmBq+QkjeuQ4Z3XOBBZ7hPnInMjR41amzLWzQ9
    o+IwsFI4g5a6qmKx6RqFkPFqHQFz6msabn9BqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521024988; bh=gXnUGpNjmL4tQZ7fEmObTgqUpZ
    KOVbjMJhbOym2dnho=; b=avgKcvV2ALooNn+GAS2Pu/B960wiHprlg9qKyc47aw
    IVGods2KzKxDuX/A3Y2kNIEjU8AJy9lrekz+ez4Ps3TnqJsueIWg+u/x1HgsR0Kq
    zUceb/VUD9Lj9IxRjdk8ZQi3/Z8bqDf8ORUMEboif4pLEvyOH2gEzP7jV1s2ZWFj
    wIfFWNB0cv8K8RZ0Ecr9RYpZTmK/e8p5pqpnErqtfXNufe8gKkKGooF6H8n9Z6DY
    6boFz1ZnFOdl32Ut3IMzrGYXJYdyrJlGE2cXgKn9dPfzLlDdZZgDjaCtzMyZWZCH
    Jtpmu7bImOFGIted7PHik72wMdXsJD5FrhX+I+so8gJg==
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
        id S1751408AbeCNK41 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 06:56:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbeCNK40 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 06:56:26 -0400
Date: Wed, 14 Mar 2018 11:56:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/146] 4.15.10-stable review
Message-ID: <20180314105625.GG32615@kroah.com>
References: <20180313152320.439085687@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 04:22:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.10 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 15 15:22:37 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.

-rc2 is out to resolve a boot problem on some ARM boards:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.10-rc2.gz
