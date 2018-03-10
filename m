Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3854521-1520711300-2-151481215107796043
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
    t=1520711300; b=xFiwulze8Z85f4Yu16apu6dz2c/wSk2FhpR8DxrHjN/vSRX
    xVvvZsd/10iMs6s2CQBwhlI5z5U4Wc8qMWohyK6H1tlpG++MTzUK6t+hDhiBBx8H
    AKtGTRCk/khFjxQ9kvnXHIqdV0lvFp6tS6jabEhTP7d5fLQ8T9kM/f33kn+YBG5j
    qQwjzkDPQCzwXcv3N75bU+b7kxs4mTGczmAnRBLd0dNlX2WvoCpZ6wDw18/1eJqG
    G6ExeLosmy8Omyxu81w0upPsyvupFuABKAwCh45yoluS3AghJIx0e7T9P/JDlNVK
    +BxayGpdtyOa8SlhHz0XOOAgqpRO61VFVf9QlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520711300; bh=OPN+AlPP/m3kTD2oABCft3hePB
    bWqZ0x13D3plw6szc=; b=CZbfsFJ9Q6KxiPfdFTcoCu4uH57i2xTSYlfr3i/2xO
    xH6/dxxVyrHSs9auol1YcvmgHtM84P2BDJQMUkCZu4DsftD3hdC7RG64Fi0S7603
    8/82Q2rUM56If5q9vKQI0OQ3UNuaKfSF0MkunYGVH9EXOYMHgYkL2fsNT18zVpX6
    p1/Nq0BJhB3GzKuQa2nvOe29VRPRfU10bT33wgs7E7oCT8++pCvwjODPQnB3wfKq
    EZs6n7B7/WUHD2rw/nvjHFijAvknDEZBAaglr2h45jZt5Umin23S7Y5WdWEWBNoo
    Os2bDfLzviLUthg6h30gDSoIERYPP0K90K8bYGfTezvg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1751238AbeCJTsS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 14:48:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeCJTsS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Mar 2018 14:48:18 -0500
Date: Sat, 10 Mar 2018 11:48:19 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        shuahkh@osg.samsung.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/21] 3.18.99-stable review
Message-ID: <20180310194819.GC12279@kroah.com>
References: <20180310001801.045114869@linuxfoundation.org>
 <CALpmF+FAUJRNkuMDc4bZ6fKGNsVwd_1m=jY0vTdqkpbJqNPuNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpmF+FAUJRNkuMDc4bZ6fKGNsVwd_1m=jY0vTdqkpbJqNPuNw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 03:51:27PM +0000, Harsh Shandilya wrote:
> On Sat, 10 Mar, 2018, 5:48 AM Greg Kroah-Hartman, <
> gregkh@linuxfoundation.org> wrote:
> 
> > This is the start of the stable review cycle for the 3.18.99 release.
> > There are 21 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Mon Mar 12 00:17:44 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >
> > https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.99-rc1.gz
> > or in the git tree and branch at:
> >         git://
> > git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > linux-3.18.y
> > and the diffstat can be found below.
> >
> 
> No issues on the OnePlus 3T, clean merge into the CAF msm-3.18 tree.

Great, thanks for testing and letting me know.

greg k-h
