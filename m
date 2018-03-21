Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4050712-1521638409-2-13557590402108630728
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
    t=1521638409; b=kWjhpYrX9dKIlmr5A8Zmk0cByHQxDgFC+gLr/wYC7ygT+fu
    zB5Z/36L+kfylTfwOIlbeJxg1t58ItAHgKU9RZ08ZT7ALDvuOcW1dCgywSR7VOmz
    zsKs+BgmXEhhLtNd7QDXQkjeZ05J2rAddA0k9h92Ah9QNERX9CQANYgdaw6Iouer
    124oQ4ZlqiooXq5wzsJwqm2t4EJqNLqwEv67osH2sEKPFkY0o57F2ZBgx72l5+cA
    mGx21wHwVjZGehY+o7UEYqCt+zIzW5QyQUF2H9b5ifu4HDvN9qa76kJeD1DSU8Lv
    h/kOF5R1kBBBjNJ338icOpaouma1TUmCNvxWmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521638409; bh=Mb17xdziruKt8tQUgDHIIysV5t
    nGjuyltpL4Bq2Nx4I=; b=hUxTCuh1YlhvaxhmF50RFWgAAC3eYjwhFbW5v0ky0/
    m+2ye6fZMJ+cWbQf954JFewHF8dvx/iehdVVuGR0aOIF/lKd08RWoZ+IMJS3qGG3
    W2XlO2QjDBg75/7v3Y9nYwmGOnfijwU/xKgz3Y2XPdo3n95JOO5ZZ9e2yi9JA6kX
    vCdQoY35Sh+4Ygmke5oYg3CnpuwYcBOg8KMgUNKeuqEtUzC6CCGu4GDKXrAv4+3D
    gHKps/T8nt94C6wD5owA8voKezX1b3ksPmJ2Y7olKKCJf1U+pep7bOZsd20omNqB
    Wosn+8tS9OwHMKndrAICqE3aR8t1+ejIAPoK5vZXtBtw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1751680AbeCUNUI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 09:20:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeCUNUH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 09:20:07 -0400
Date: Wed, 21 Mar 2018 14:20:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
Message-ID: <20180321132005.GB27151@kroah.com>
References: <20180319180751.172155436@linuxfoundation.org>
 <20180320074945.GA10034@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320074945.GA10034@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 08:49:45AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 19, 2018 at 07:04:25PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.89 release.
> > There are 241 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> 
> -rc2 is out to fix a bunch of arm32 build errors:
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc2.gz
> 

And -rc3 is out to fix some more arm32 build errors, as well as an x86
one I noticed showed up in the build tests:
  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc3.gz
