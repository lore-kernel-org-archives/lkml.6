Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3996454-1521638328-2-10840044617925641079
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
    t=1521638328; b=NmwdfFk1UM5xVHDl/zN51mgHXGcitaFuKUESLLmpBkNy4Qz
    QocqxGdx0dEbnj1bglV7gyS9SnGJQRRXI/xGDZdDxUouXhaTPnhaL7pZSSFr5TMA
    FetYMyB35u0hGzCczdsTDtvGrQeOOHKhU/K35sVlzKKFKH/OG49HhH/rbF0hwmZe
    aJplrnzRidav9HMm2pwwHsQqOQJnw8Z9HdJXX+NXCDJcQkJk8olSrYv0t8okiPAb
    GeuZZ9InuDVnOnv9DuLzW8rLBrxYTSkibUw1YWOx39rg4bSGKlINUHLMOtZ6iLDJ
    LbyLkgE5zdeuX3uciXNYqo/ntBkYKX3Kw5J5Mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521638328; bh=s0LoSSgK6yGJzPGWnwNsieZecY
    eEOJkMXdsmX//euJ0=; b=ZTePDyO7MxtB1ZldaF+H813pB++g2KPxfouKrh8lgB
    wrp76+ARRa6HpmZ+YcadW9XaKcE8DEMEaP06fhcKmINvrl7kHQNR4eBLdEBn5uH9
    CxSwLH1lmW4azPREpDNyOI1o/aEL3RWgyVu6ZR0v+DSldHERenGSgYtoFIk2m/Af
    R9ZHgfbTe47N34Zl4wEuoScEreIcNZEYnj/FkN/YdcwvSPNmI/29E8hUaXh8Ykya
    GEWgGzyzcEaoduGIsYr0ek3YjHT3MYe/c6n4XfI5bluHCU52uuhqeD0lsCAZKYve
    BJ0EkDEPQo+j+YG/kKnpArX856PHrpyZBcOO/wcGfmlg==
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
        id S1751657AbeCUNSp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 09:18:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCUNSp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 09:18:45 -0400
Date: Wed, 21 Mar 2018 14:18:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180321131843.GA27151@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180320075012.GB10034@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320075012.GB10034@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 08:50:12AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.123 release.
> > There are 134 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> 
> -rc2 is out to fix a build error that was in -rc1:
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc2.gz

And now -rc3 is out to hopefully resolve the last of the reported
problems:

  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc3.gz
