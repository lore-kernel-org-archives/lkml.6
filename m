Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1963263-1519497501-2-1035819589175922243
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
    t=1519497501; b=FqeR0JSDHmnkuXqShCKMRbYB8zbsxV08yBSCDO14/2w/Mfj
    C+G04/ByDJ6IGaK+2LTezH7aWSP4Fc2ER10bFap0kI288LCOw/NWV90XzZe2jnkU
    9A4XtABRu15S9Jlzt3C5hU9UqF3bwegPrCbgmtfiNUBtR3A5V+ZgBHh+hOpNDi+/
    FFcwehbjLXNiCGy6guWdx/N4ledDDt2mU4K9p5CVmkAZ0QaDUrBBlLrpdAAwTUut
    I44L9HLFxy3GamVk+vxKB461D9VHtcrgoynK6M09JAcIsinNmxp1sA5db5S4dtAG
    SDGQ2C2lX/m6Estjbu3hxxJxaOb4PIbHcqwoIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519497501; bh=n9VBNuRYoLSUfx5jbIJA4aecdo
    wbSu5gjKT3wiVg2XM=; b=CU5BXeilctYN2kj8QJBab9RCOYbSM3yoLen7eEeQoj
    hzqoPTfWYAYDJxDJoHNqLKqNJG9U0ZVbkzQvVCV/Yz3pJGe3uPgVeDGGDHKPdsYz
    TXF7BR21uWOxcRmBQ7fEU9uM6ZpIr+HbA9QmoTXeKq4612R26RBQgMQFPFbx5WSr
    CCg4WXFbIAByxEKq4I834+M+Klrf9bqPf2HPXjkJzks7V4nVOjltndOO2asNtgyp
    jWfKEhG3TqQtf8OQEHG7H2Snd2gK/2vylXIbXsCCjF9XQ9djYLfdvHb4+F+9JlyE
    NFbmMqCmSK1rN6znWDK4kJtm7QaA9VOfipupecacX6jg==
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
        id S1751416AbeBXSiS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Feb 2018 13:38:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbeBXSiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Feb 2018 13:38:17 -0500
Date: Sat, 24 Feb 2018 19:38:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        shuahkh@osg.samsung.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/58] 3.18.96-stable review
Message-ID: <20180224183817.GA11608@kroah.com>
References: <20180223170206.724655284@linuxfoundation.org>
 <CALpmF+EXvmUHRD=bKEKT3fUJYRQ2g48odV4MEbZ2tNRMj7KEbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpmF+EXvmUHRD=bKEKT3fUJYRQ2g48odV4MEbZ2tNRMj7KEbQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 11:41:01AM +0000, Harsh Shandilya wrote:
> On Sat 24 Feb, 2018, 12:01 AM Greg Kroah-Hartman, <
> gregkh@linuxfoundation.org> wrote:
> 
> > This is the start of the stable review cycle for the 3.18.96 release.
> > There are 58 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Feb 25 17:01:41 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >
> > https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.96-rc1.gz
> > or in the git tree and branch at:
> >         git://
> > git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > linux-3.18.y
> > and the diffstat can be found below.
> >
> 
> Clean merge into the msm-3.18 CAF tree, no regressions noticed on the
> OnePlus 3T. Thanks for the update :)

Great, thanks for testing and letting me know.

greg k-h
