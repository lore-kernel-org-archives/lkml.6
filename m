Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1599531-1528108805-2-16166854035591085400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528108804; b=IcWGr5dZDgL5UEwKUYKOm7yKr0EHlmMFwqqCrF8IOz/aL/9pzj
    VClHEJqEYVBGixb9KMSgSI7LCnF7yFi0JEufFT92GCu4VFY8KZmlQZEKcaMYlwoL
    6ZxXkzvkf1bKP79MnArwKeQi7hrUydHfDBVNvhdnuJb8eUKrQOj/Bn2avn4AhOmR
    BDlF1heAS4T8f5zAzcYURyQ+PsRfkPLFBzHS5F/e+GiqPl6x/sKTM8FZ1taMDwGx
    lGW+Sx30fCSoGVc9n6oFuk9i6Yi228CkMS3FEWVVPjzacviBxJgpcYuaKC1mMeHs
    rZiSS5XTkv7LOaIj37bKmve/KXXCPtqF02Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1528108804; bh=orvLIDaPaZM/Um+L4In0/dKmLZmmiP1pzdoq5SIb7Q
    w=; b=KuWX0zHjfu9av3HYZ7AOvKgsPPb5onKkKDvkAD+SLMoiGXZgskPV9xGKeF
    Wr5lXqtRCmRu5+CKyl0pfQTOQBVovLtoBVjD4OrOLc5VFG48kC8HkH0OF9+uyvza
    pwF/fRcKa7AxaADM3umWhl2j78LA7J5Ztx57xSq5/dXx7dVwqAUfduCZoMgyz+4V
    j4PdiDEIZBgBHrjIS2wa2bY+5shQ8ofrrfvSxwVKMNW3LFO98dXcsC1sxykC8GTI
    SguXp6PltJoBr346DmpqcwZ1VzLyFd/hDJPFJP//F2Sr01rCVJ266T2yaE6zKMg9
    2pqDssb4a6PUn3czIXoeZoUKlPCw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ellerman.id.au header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ellerman.id.au header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBLhwbYAsOAOUClE3op23v3/zS+U8s+nFnpimBjpkm+cnARtdA5q9+srh+quPRnIOIyIg1TfOC8KuYuCUF8YZhxoRZ3eEE4VutFNb+d+esRmNjsvII+f
    aJYeXhknuMi/+t4PIni+kPvuFMHbxEGSbblpzvi8wxHQrOPSEjQyCls6tiR026ikyDEUER6iYlFn95G9AYrcQqO4Slx4o6/b4KFyWkpmoFlfPFeIuF3019py
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=rOUgymgbAAAA:8
    a=VwQbUJbxAAAA:8 a=eH2RijnDu-jjeJ9H5W4A:9 a=x8gzFH9gYPwA:10
    a=MP9ZtiD8KjrkvI0BhSjB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeFDKkB (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 06:40:01 -0400
Received: from ozlabs.org ([203.11.71.1]:34897 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751168AbeFDKkB (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 06:40:01 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Michal Suchanek <msuchanek@suse.de>
Subject: Re: linux-next: Signed-off-by missing for commit in the powerpc tree
In-Reply-To: <20180604042626.286a9469@canb.auug.org.au>
References: <20180604042626.286a9469@canb.auug.org.au>
Date: Mon, 04 Jun 2018 20:39:54 +1000
Message-ID: <87in6ybzt1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Commit
>
>   cb3d6759a93c ("powerpc/64s: Enable barrier_nospec based on firmware settings")
>
> is missing a Signed-off-by from its author.

Sorry my fault.

cheers
