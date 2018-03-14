Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1457237-1521024940-3-126526860920540099
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
    t=1521024939; b=asAjRtGtWoc7IdS5tqDW35OLLIjLBxC0aihxdUMN+TwGa+M
    AwP+EtzJPPx7Sy8H8Ataz+6IwgIXH5G5P0uIz3q3WE31f7E43Bs8dVmsRmTeVSIP
    k4e+BAcYxyGWNsa2F8CKCveu7HhAuJrz8meEeq17tj3O5CvOJZsWb2BDJR/x+Lnx
    nogd/tOY1orh/A5w9vKLIzONlAFnxy98CdHxpiEEL2gd4D4jytnqYg1ACAFfx/bv
    6iogyhDOWcttvud+QypL+U+ljOWsg6R5qTR4aaTvXiY3jSLPwbG799mzbGRL6vG2
    mKkQSH7EmYywMGzdZfYV/abyS6u+eyipCKBIm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521024939; bh=v9TO0BfONU8ARyrMr1xJ32M1UB
    OILLL7rBzhSuWHjoA=; b=NRxU0nja6gsj7rG6ZTYTNQcxox2I6r6nAIwhUoMy77
    QMEhzTb/T+ZaIzP7R9SGG7HYC0RtiHOWnJx9FKheG+qYkJX08Fgz5oubL0URmPYW
    4VXn38HmF0hW1jJlRNpdpQh7uL5cJSfx7feJ7S+J5OYeaUKpoku9Ahxn+xbzmjb/
    k7y5inr/aSzpcJGY9GjrzmIz2qRw/EL0LGM79lDwOcV/B1VLIH6oIboB9edyyehz
    ezWe3iP/tx+fjBQC9lCeKk7K9mNNhIF5t8DLL3jo3HnW5cqBzh97/6xgovoA4UYU
    +XU5vp8Q9oLDlPvDDS3rkByFpE6VCom/WVtddXgUu8lQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1751414AbeCNKzh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 06:55:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeCNKzg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 06:55:36 -0400
Date: Wed, 14 Mar 2018 11:55:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/140] 4.14.27-stable review
Message-ID: <20180314105535.GF32615@kroah.com>
References: <20180313152458.201155692@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 04:23:23PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.27 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 15 15:24:23 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.27-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y

-rc2 is out, to fix a boot issue on some ARM boards:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.27-rc2.gz

thanks,

greg k-h
