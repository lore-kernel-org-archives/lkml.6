Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1799621-1528128157-3-14543603156482395502
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528128156; b=dGso0mChzTmnAnXp2xVbhL1SGrzturozOptkkyr5gXZoXCf3mG
    /Z13N8sEjl1lvjvc+9tqnXSDJ2CwSw5NYFMPE/jgoKpRbxL/vGoV5EUjYcZyvRDT
    XwxQmY8wCDRHAfwNIB58X4daijabSsbyFWyzntQmmpynnsN5XUzvtFaXqmEFzx5s
    BjgWcodLrWkaq8fTTK4e/Qu7c4mXTRwmy35QsefUAcbMTgKMDwVUBUDgHwDTDLjA
    b7XmXay44HMvwV8cdx6OyoVKgRflCJiwey2YWf2mCaMK9XhzfxDvjpfGzBP4leLQ
    GSf6WmJ7JRedGsbdlXQ2E3BiiDxUqW8j6Q2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1528128156; bh=ue8e4iDThDciEET3lk/lXFQeLGDxPsIYK1QqT5D
    z1EU=; b=CsJR7byDULspHCD1soO0QRzMtiuCo6bbRk6yVxKJfVs7n/y0M6JHxIq
    DmYxBHkauUQACI5avLaiQLKB56dGVIe7ssu/jHXutdYBHdgjyqChZMpIA813M1Ij
    9kC9VAJronIJj2Kzcz8v5ueD0GKc8jCjCw2AA007FMZZM9E8R4hNZjG4g/HxCIbH
    XWkaGw5ZbRGDc3Atqw9TdS0BCYB6Tm/W72wq2ea3V6Wo6NnV1Z18+h7YE72pjaQD
    T3ZU9n2NQAVivdHVMZOThyntNBygw+oO3iP4AUv24UFqax3cl4NkyKWbgnrVxgdk
    PiehAa9j9RK5igmfs3h06PjByVSkqZw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDNnA/IXPcJS5iZcf7usNaei5cTOymtGhTwKddazuqy5ceHoD1OFyjQKpp5/iPOrV5Mw5v/zDwJF22OFLHx72qeHYjjuG6M1FwrqhTGLbKOJJKhufr1E
    z46pCfviD5KD2bt0vG6gVg6+fzfmMQqE7/ED9MaWFY02dCk9lWK9zNf9BBDgOat8oyVFH8s0HZxyy7NwQwofeZeIgmhpXa/IWSMqX84VERCtDjhRpXw26Fz0
    Hu+iW2c81lK9LT11YEUKQw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=JfrnYn6hAAAA:8 a=K6HrmWtEAAAA:8 a=VwQbUJbxAAAA:8 a=bud9oPW6_xX0CBV-NjsA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeFDQCf (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 12:02:35 -0400
Received: from namei.org ([65.99.196.166]:58148 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbeFDQCe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Jun 2018 12:02:34 -0400
Date: Tue, 5 Jun 2018 02:01:29 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd 4.17 fixes
In-Reply-To: <20180602130001.GA5196@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1806050201050.30339@namei.org>
References: <20180602130001.GA5196@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 2 Jun 2018, Jarkko Sakkinen wrote:

> The following changes since commit 424eaf910c329ab06ad03a527ef45dcf6a328f00:
> 
>   tpm: reduce polling time to usecs for even finer granularity (2018-05-18 10:00:01 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180602
> 
> for you to fetch changes up to 3ab2011ea368ec3433ad49e1b9e1c7b70d2e65df:
> 
>   tpm: fix race condition in tpm_common_write() (2018-05-30 20:11:31 +0300)

4.17 was just released, I'll fold these into the 4.18 merge.



> 
> ----------------------------------------------------------------
> tpmdd fixes for Linux 4.17
> 
> ----------------------------------------------------------------
> Tadeusz Struk (1):
>       tpm: fix race condition in tpm_common_write()
> 
>  drivers/char/tpm/tpm-dev-common.c | 40 ++++++++++++++++++---------------------
>  drivers/char/tpm/tpm-dev.h        |  2 +-
>  2 files changed, 19 insertions(+), 23 deletions(-)
> 

-- 
James Morris
<jmorris@namei.org>

