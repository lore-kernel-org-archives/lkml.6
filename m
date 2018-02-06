Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1634197-1517936503-2-4973507610675856297
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
    t=1517936502; b=CcbnZWvwSsTYdEkZInnCaniEGT9gPCbjq22DV+BLUZQ5K4H
    llSRtCKndXF7ZZOVpIzYMiHDzVwRnb1w3cajE1sHjrMf9xM2ijt6lRUDwtc6jrMA
    UC6J2mI+MMOYGBHTCk7C/qmNgCrftlSwjN21kSQe99AiQ5NsmUTsUe1kPJy9Hcrx
    jJee90ThFCDy5FMSVREP+UORNT/tOzTg9J3u4AVRfRaniGmmmamXtSzRkrgijUc6
    IScanqwmj1eDHnVEKSQJdtbUzPN2NmEzDc/KHKho2flrg8FKWPh2WyEg1w6ZqY9y
    Q28fiGd7atbI2UhDH4eRjyqH/qYZyc/WXZaqtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517936502; bh=D7g8R2Kgkt65d5rp38GfekH7at
    Ts6WcsVMSv9cJ81IQ=; b=AlgftYNw1oHX6sGSdzWz61Ix/LPClj1pCRXUtfw1fY
    1sEauu7L6YRS0zIKS4KUJpUnYPYQOwmURBB85vn1si4B6b2g1hdsVT8uz+oRw56u
    xfcQoQwifVu2DVQh6xp3zeskKEGgG5o8kx8Fruv6Ud0fj/1Daa9H3IAaFVJ9aFDY
    1f5g/H0Ba6uJ3vLkLz5vujqj9Fzq63oECfSpaJRMW8DIpyq+eQxRP4s6a3K7CErj
    PeBEHry4GTISMGkQE+NSIjz5iSDSnPpd/HmdNtHQ86Yk4AdaSynSHErbNJMxXhU3
    LgqCQVwtN2rPn5QJ90oqocnvmMbDMQFKemgPszbXrlfw==
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
        id S1752964AbeBFRAm (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 12:00:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752861AbeBFRAe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 12:00:34 -0500
Date: Tue, 6 Feb 2018 09:00:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/60] 4.15.2-stable review
Message-ID: <20180206170033.GB30774@kroah.com>
References: <20180205182213.902626065@linuxfoundation.org>
 <b16b6d88-345d-0da6-b914-403b9d0780a1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16b6d88-345d-0da6-b914-403b9d0780a1@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 06:32:43AM -0800, Guenter Roeck wrote:
> On 02/05/2018 10:22 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.2 release.
> > There are 60 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb  7 18:21:57 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Crap, the previous log was for 4.14. Here is the correct one.
> 
> Build results:
> 	total: 147 pass: 146 fail: 1
> Failed builds:
> 	mips:allmodconfig
> Qemu test results:
> 	total: 126 pass: 126 fail: 0
> 
> ... meaning the MIPS build did not magically fix itself. Sorry for the confusion.

Ah, I was wondering what happened :)
