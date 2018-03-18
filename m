Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3741325-1521368792-2-10549451632005803677
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
    t=1521368792; b=lDTQGEUw2FfiCOmGZm0gLecHC5p6Uq1BpNLbH2eZJ1QL2q6
    nn+DBorVmH4bXNQMjJhsZ+ol53FxepTOgLcVdmDR43jKxvF+hhfzUn8S2I7S/tKK
    F+DpS1qi/HtkgfkS1TK0cGHDYWCadsgFBl+2c9/R6XSvMoRwC9lQqH1snScV+cYG
    LBQhPm5+Y0NqewQbORfPJRigGTUBD0BS+7vtWScwEqNXprBWYZzLn8IE+tVsTfnk
    RvXuG9yOGH7/OdqR3HX0inb3BDciJA+59kXpLFhI/agA3TKj2X3m5mVTvgbCCFCX
    2BPVD+y4V+fGGdH8mycaIVtLfUP7RIN8tu/ktaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521368792; bh=wt2vMh8A80kR8fgIWsI2ssp6gw
    oYlEf4e52YOn1Ft1o=; b=pogORkNkbfHAPBtpW7NX8Oc0yDR8Ak4X8HOPqvF0cn
    eJ5dShF5K+sEsUh1TqD+1/0/qZnmf3h87zwCiXlIgDI4qGhrEv3ypt+Bo1k3QeiC
    U+AUeI51OaLIIxEI4eAYeIX18IZPo94BccLhgzA3Gw1zd4KHJp6II/XyqmzWh9e4
    y5Q8YXbXt9o+LEhglWCFXawcExICFLOCFjkCx3YzjBKNryIRugRewi+lDfjcfD7o
    9q3IotVMDJTsz6ztZ0HakzZEr6Oh6Ci107k5tSmhCs6yGTvOBIqgPIkcsThZS3UZ
    eQWnfIBwrK27FuuiIuTd8peWKDYR3IsJuLtUAkZUUnYg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeCRK0a (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:26:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbeCRK0a (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:26:30 -0400
Date: Sun, 18 Mar 2018 11:26:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, peter.ujfalusi@ti.com
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
Message-ID: <20180318102629.GC32470@kroah.com>
References: <20180316152336.199007505@linuxfoundation.org>
 <CA+G9fYs81eFKnN9411PQtkHsvtVRLWhPH_Txx7PCkVH=0sutvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs81eFKnN9411PQtkHsvtVRLWhPH_Txx7PCkVH=0sutvg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 01:06:21AM +0530, Naresh Kamboju wrote:
> > Peter Ujfalusi <peter.ujfalusi@ti.com>
> >     dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free
> 
> arm and arm64 build broken due to this patch for 4.15 and 4.14
> 
> drivers/dma/bcm2835-dma.c:815:3: error: implicit declaration of function
> 'vchan_terminate_vdesc' [-Werror=implicit-function-declaration]
>    vchan_terminate_vdesc(&c->desc->vd);
>    ^
> cc1: some warnings being treated as errors

Should now be resolved, thanks.

greg k-h
