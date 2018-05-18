Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-77256-1526665365-2-12770333747893423610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526665365; b=K5nuUhHEYMFOafC09Tfhr3bGU9AvVZ5U0BdnutQvEOOYqrEjZ8
    bGiVFGrazP4RlrkuPLQzPxpCGmqoLpf60BovQvlbWiBHYA9ZIWqYW1VGj9FapWi9
    44Cyf40E7i5Wq9rpKoqa6quQIKPxOxlWN2ZlIzlrpNovgnI15DFpwVxsS2WKQe+Y
    QCqstB1W7E2gMYHr81Vwj8YjvyQDJGXPqn7Fq94gQdz/FpeMbdLvguoutlByCign
    fpxjiHd5RUuR0Rmhg79RxIAgT0jUPkPyeepGs6JgGpJux4YCi3N/vWAWi28p7M46
    MxJLLx63qqqVdtcEeSJPAsBqIU9P13qlfQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1526665365; bh=6S6bfNVJfDEgjYm+/TLliJTE9T+36aj9impAkCM
    +tp4=; b=PtMZs3gx94OXUpGs7w4R0+J/eloMQzMj/BVD3HBUjjiDr7I1I7/NoIP
    kYcEDDUuUkAw1lTrPopn/0lSI1znkz28yZzy4lBHrQLvOUVOY6PGdMgdK30l7Tn8
    r9zkRn2MwSJMzjfWC6zMiDlEyTn/Di5ihYQs8SNZ36izOQtp+pz3qoeKWAo4Evdh
    an3sOPOiC5xrJn4zkBkYrvqV8dDajrel4Z3NyKgNxwGNoNwzNQRi/SpHdVG9wtNL
    5T6JOd+do73piiXOiJ87Jo35SoMTGk3Vq2XYVIcdxMYZG4IQhMIRmhyxHzbuX+jS
    YGVrSPl4P7R/p92bW7trk+ms2MhGn3g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCFIY0kymVqbrzC5BNi04nCFCTDLVQZVLghUNwjQnJpjagBMGV/EhvSQ0SKAEB0xdl6ZNCpZLqfA+53YiG3DppJ/Qtuz7bWedElE3Q39dXts9zDzveIw
    RKvb+JurCT/vm5tPkTCMyEI83RK/LgUrev3hbDFlMRuJFmub/YwyjZ2YPyPdiodpPZuFtFYynoBN2dmdxHlzlek8XMQqydHcHUKPZ9YawU9zRSxIlaIcLibJ
    JoOZ+A8eR+vRB7lM2YC8oA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=K6HrmWtEAAAA:8 a=Hg_bX2r6BB8swuZ2grsA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=yV38gEssg_2GhkhKF82i:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeERRmn (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 13:42:43 -0400
Received: from namei.org ([65.99.196.166]:36336 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751969AbeERRmn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 May 2018 13:42:43 -0400
Date: Sat, 19 May 2018 03:42:40 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc: linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for v4.18
In-Reply-To: <20180518070851.GA11123@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1805190341500.26396@namei.org>
References: <20180518070851.GA11123@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 18 May 2018, Jarkko Sakkinen wrote:

> The following changes since commit 5859cdf55063943192f316b3d6c673fd6fcbee46:
> 
>   smack: provide socketpair callback (2018-05-04 12:48:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180518
> 
> for you to fetch changes up to 424eaf910c329ab06ad03a527ef45dcf6a328f00:
> 
>   tpm: reduce polling time to usecs for even finer granularity (2018-05-18 10:00:01 +0300)

Pulled to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm
and next-testing


-- 
James Morris
<jmorris@namei.org>

