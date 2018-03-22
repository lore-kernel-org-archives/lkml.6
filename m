Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230827-1521738464-2-13990583575513490954
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
    t=1521738464; b=MSou41JWyBJW63+Cg1bhb23mJq+cdmpQOe9ZcYzLtCCWtID
    1ZdLwbgKudO1mJVSGX3udLNjnxh0YgHBa8GzR/b7J5lahF90fWsytLKLXQdy1vH0
    9ugDaQlhOPv/AfFHgI+GuN0QZe2XxUIf1iaDFftX+7+VB4er8OS38VAKBIIuPOnV
    /nUq8ScgzRXLL9ni/sa/vYQq5qOPr9gG8jL5DW1wSklpyqteYFup0l2ZTCSsAIiB
    NirhhkWZeMYGIOFpjalrHRWeaJY2rBI6fCScziwNMPik+HseoavvVaAaH6Z2CFTD
    CaIDPVkzNxxyg3nKNwXwxZKfArhpf8853UVquyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521738464; bh=/4vWBDqtAxaHSN7VCHK1IeMBa2
    N+mBOC9EkcZdKJaKo=; b=bFZGCkgyNa+Ju3ZzTEUuC7Jm2yMR+g4Q5qPM2cal1p
    La1wQvDdKogcGPuw0VUucRvPOck0oe2m6okbBojwICdFf3WyNQUZv5Gw+3i87X6h
    cemFgZdA92ecvlM4Q2gEN5386wgkKSq7DezUe9sfy0X+/JqaBfUNRfZ+icY1V+Bd
    Sw/l1TY/WJFS9WuMFyrLhfdKsfa1ut093aD3WAN3CSsqZzGllusOpQE0uo8kzPlS
    4En4HpY8DGHKVgUl4POk1uuNZ+imkYXNboxj9KPZODFkGdMdlDptt/HD6JSLG+Be
    iT0Zb1AMztQ3kwN7F7MXKSxVj+xs0l3212cCo9NufmPQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCVRHm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 13:07:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41698 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeCVRHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 13:07:42 -0400
Date: Thu, 22 Mar 2018 18:07:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180322170736.GA23804@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180320075012.GB10034@kroah.com>
 <20180321131843.GA27151@kroah.com>
 <20180322163917.GA31801@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322163917.GA31801@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 09:39:17AM -0700, Guenter Roeck wrote:
> On Wed, Mar 21, 2018 at 02:18:43PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 20, 2018 at 08:50:12AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.4.123 release.
> > > > There are 134 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > > > and the diffstat can be found below.
> > > 
> > > -rc2 is out to fix a build error that was in -rc1:
> > >  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc2.gz
> > 
> > And now -rc3 is out to hopefully resolve the last of the reported
> > problems:
> > 
> >   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc3.gz
> > 
> 
> Indeed it does:
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 127 pass: 127 fail: 0

Wonderful, thanks for letting me know.

greg k-h
