Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3376651-1518247346-2-10398441146053606679
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
    t=1518247345; b=UQsknuh+pZF8MbL8Fuwf9R7mbZFc5aAAMWQTpmj2EBpeAuG
    NK6nakm5GMejl7SbnhEsQ6k6JymUMs/lOxpVjEsXe8agETKKaJ10SPYiMkMuvZVj
    b29qIhUBc/8dCkCDGOn2fbywDAgGqgB4kcsmxDG7XP3mK/zTNYqFzLEHX7mri0rV
    zv9x50f12fvT3+ZA777q9KL3VuLYpMnG1JVYMRYI3do79ZTrgYhe3RWlGcSR9es+
    FDS65hhCF0SZ1bj+Me54sUzYNBDmnfzNAy2jUEYqBMty3Is6h13zFBgzGT9zDME0
    JMMqfryBE8j04l3SymGfXTv2dg/uOVQ6LhIjwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518247345; bh=thqrbgD/YSpmzOeCbxjdHRZ2g4
    NN7lDPOfQOasE34/Y=; b=qUI59GVGBO1ue5uMS40pczNFfibdaOdZO94H0q4PHq
    fnwnM/KlXtO0PzTtKoiehW+aIfcZaprNBQGZYSAmKpVWxFpUdAT1tpUTNs3LMgzI
    v9TxEsYdkU9k58zsUa9AIOd+9kNMdyXgEf68SEVurvBa0K32oxY55ANnJM2uinCP
    roX3qbLSjwRNhOrKbLKdXPLkXNs5injG1LxiWZiYEkY8mOlDG4c14sH/FKbO94RR
    LGmgnJYE9MbdV2AADmw59r33AF4aysleRTx4jBc/MzBvXrjmHAWfLUsQTY4Y9AG8
    xZjIb8h5KBkrWqZHfuSzBlbfq957Bl9W2Htz6mZmJsug==
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
        id S1750761AbeBJHWU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 02:22:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeBJHWT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 02:22:19 -0500
Date: Sat, 10 Feb 2018 08:22:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/23] 4.15.3-stable review
Message-ID: <20180210072216.GA8814@kroah.com>
References: <20180209133938.366024920@linuxfoundation.org>
 <f53caa75-a957-6553-7869-66d89b2de7c4@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53caa75-a957-6553-7869-66d89b2de7c4@osg.samsung.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 01:20:26PM -0700, Shuah Khan wrote:
> On 02/09/2018 06:39 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.3 release.
> > There are 23 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb 11 13:39:20 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.3-rc1.gz
> > or in the git tree and branch at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all 3 of these and letting me know.

greg k-h
