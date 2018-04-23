Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-608163-1524466644-2-7844315440080966397
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524466644; b=FBWGC3ilV7GZwAGPtzGElgdeQ3YR41KpO59RP0jj9ZU6Ge6Q6E
    sgXclTryrCKMM8r06nM/LF/2OAEgSsrxBCEi98IU85j8y5q4Xk+7Q8wEjiPnOP/D
    rxPIBazabSD4OWUcrZDDrGcVCyIj4V+oCQHiZqVJOtYNzQGG3EcCbHNVuQZyE0QN
    DLzart4lGPDusPZ7m3j5sGONN4pLWgHOBYGJVcfKR7nV25HtNr2F5y7ip3MkExbr
    ws14clhFW+P3yzT+elFr+qrc3YFUUzhN+voLFo0wcHMdOGkFcDoun0Q0n12cpb5U
    6ImOHZiGQdnIri4JpcNM/1JPLvkMtnc7xjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524466644; bh=+bLLU4+T/dq+K2jpTY4dpf6qWgT21B
    vbhAPsC5Nuhxk=; b=uN5EtgSOFNy+0BKqvipLNMc/FU/DdYzfwpBhxGDUEC1NeP
    ebccnDsLJ6NAlevQPX6kW07t8lR45d2CQgLwOiUabSBOUBvZQPh0kaVoUamslZfI
    DmGJ/51+ZkmVgA6fDDjzqxIcNUhfT5b5mP2rjCAUnniOV2CRgN7drTdJob5sAI/c
    eCCTsUUCv6mM+X1sQ46IbdD4CB41pgL4BrJIujtuOpx5/4g6S3FEeHjVMruJ5BvB
    mhUBlk5TTL3Isaz0ryibuldp8iTXZjGu25ZHiuGd6kNtY5BmtqTZY9phR+1opG7m
    kIh4TIohAshSta3xO4YrJt2AuzRYwLVk75tbXlFw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMkQrQ2ReCCbh7kxIF5NcNQ62vID3dUa3eyNtsUARBX4wUPOfIILvuLZeks3tRqpEd74hm25XJkSreI2CyGbphlUm/S3HAXloaWbxufMFI3RaU3m8lpq
    G6M8bvZRDXP587y51Murc4D9sTGgUYW3fV6l4HkpYy+6eu7dQa4LH+jccPFaU+0nky4VO0HgKIiykytfRKCocd/WBhJOJEFciy98wo5RIP6/BYN9IYKPBn3V
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=BKw5nfpAfisA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=hN-cBIHaJWmPhV0rXjAA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeDWG5X (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 02:57:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbeDWG5W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 02:57:22 -0400
Date: Mon, 23 Apr 2018 08:57:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/97] 4.4.129-stable review
Message-ID: <20180423065715.GH4208@kroah.com>
References: <20180422135304.577223025@linuxfoundation.org>
 <20180422204407.GB2319@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422204407.GB2319@flashbox>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 01:44:07PM -0700, Nathan Chancellor wrote:
> On Sun, Apr 22, 2018 at 03:52:38PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.129 release.
> > There are 97 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue Apr 24 13:52:47 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.129-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.
> 
> No initial issues in general usage or dmesg; all images build clean with
> GCC 4.9.4, GCC 7.3.0, Clang 5.0, Clang 6.0, and Clang 7.0.

Thanks for testing and letting me know.

greg k-h
