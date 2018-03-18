Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3741325-1521368079-2-4747426359705268287
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
    t=1521368078; b=tRE1CcvwOM2NrKeoHKfNQ31qdb6YPpqrzIcTj4WXwiTpVWm
    +H9lsOvuzw9sm24O6MBUBijy/w/hHO/mDXy7DC3EKT9uQvJ24PiUpMHO+gQ1SvaR
    z0+hiw3Kxk2GcXtUqVcMYotD75gvn+PgEsgrV7fCqu7Xg18pvC4lQM/QOndbBeni
    DTyXTBT/+bFpDlWdD//k8wCAtOSQy2WC+ReFBWVakJCp4eOVB9I/ZOukFXIdjwlV
    jc0TpDaADZISRu7nBSWCVv2jirfqz2cfojjOO2j84pZQQzCQUMHjfA6+iPI7xZnU
    TauynjewBU7zUkFByohPqy3AOLCB7VEY0xE77Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521368078; bh=N0akRzvPJuHSTVCwgmR3Ae7Xmt
    zF8Gc+3Gx/zsf/SYE=; b=PjzTRpNw8bBd9Ud0EVu586UCxWpXgtVBPRtm5ilVn8
    nDgAMnERuGLm0Z8p+ej7/nEeu73adImrj6bdmwEG2RxLpMJ7ryKr+HnWB4rDKbO/
    CtomVybP8p4WrtTw2ZHG/GXy3cYBbEV1PF4v22sexRw4JWSd2B3QsxwPBtXfIpfn
    tb5/cnkaxIBi5/mWzhl8j7DmLNFRLIp+jEH31s2cPh+m9MtzdL4LgppKMcg4Q71R
    XfQRHAw7vSCgsVwBvVS4xYXp3fErLKpO74OfloDHjjJBtGMzFqzOxeMLnw9m0Nr9
    bRYf1rDK3HWMxKCWBL33/EdQXOYlohojTdMrpGJu1FJQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1753990AbeCRKOh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:14:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35986 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbeCRKOg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:14:36 -0400
Date: Sun, 18 Mar 2018 11:14:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        shuahkh@osg.samsung.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/25] 3.18.100-stable review
Message-ID: <20180318101435.GE13276@kroah.com>
References: <20180316152232.750180431@linuxfoundation.org>
 <CALpmF+FmSSq9S=PX+pZzDmgFZRWJk5hNSd5msqAnfp=xFDFSEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpmF+FmSSq9S=PX+pZzDmgFZRWJk5hNSd5msqAnfp=xFDFSEQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 07:21:53PM +0000, Harsh Shandilya wrote:
> On Fri, 16 Mar, 2018, 8:53 PM Greg Kroah-Hartman, <
> gregkh@linuxfoundation.org> wrote:
> 
> > This is the start of the stable review cycle for the 3.18.100 release.
> > There are 25 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Mar 18 15:22:18 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >
> > https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.100-rc1.gz
> > or in the git tree and branch at:
> >         git://
> > git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > linux-3.18.y
> > and the diffstat can be found below.
> >
> 
> Builds and boots on the OnePlus 3T, no immediate issues noticed. Thanks for
> the update.

Thanks for testing and letting me know.

greg k-h
