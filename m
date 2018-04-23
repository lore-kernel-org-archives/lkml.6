Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1593853-1524506658-2-8575191130965805463
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
    1524506658; b=lkgqrT4u0B9wnWNedHZziNAkIeo0Vh/ZVwdt18Zm/fJWr3AFVg
    BOF8sz9lz3m6gl4sXB02BRcpIm+XpAmrBmkTn2ENFU5fouBO9vf/wjYjpjZ95vEm
    J2B6DsiHSvrlU0jtkmfuCXtMa0b7KkzruNGwVCo7jIkvSxyAaCWAiy5F5OTB3kPH
    FrwPmGKsr5+JT23cIpFsRWjz/dyCVavBUSDROf5Rno/XrHHbOQzBJztf/TjDMFJb
    QqRPkUC5wGOQANkp3cCzELPJ7RrVrmMA8cBSGDIjX6HoHCVCGJk11n9gLGLXkpXW
    577ozutFiGGduztWvAFI/Vub9o63mjbZ32pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524506658; bh=5WkkqyWanCbXBaWLQmJX2rNY2qlXbd
    8zkrbbo0bfsJY=; b=KZ/3Ax+KfM6NTs1q/gAbB3N8Bnqbmg1VbE9szTTIFUk5He
    0YfiyH4RUtoFh7txa6UkIcWpKIeKKZg0Qb/oxZUYy03hGZeafqZnHGMpeAlraYkj
    seurDR9Wdsloy9Ko2QNnKcVoj9uaowHuZS9fo/5yi+aKlojoerrxlmW8NTSD21TJ
    vCmFP6r8nicm293aTbYqR3OTyubz/ck1JrG5veRf8yZiEJs2W99tEya+MKiOrLkp
    OXLD1YFhhoNoOShyNe9UK0Ko8JJdrOnsAZ3RbhQjk4LmPSvb98lxyRK1cNcaAegm
    EqzPdrUnNFAmhPRIXL0w4mREx05Mqzv59pRRE+Eg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFD9UdsLOeocIqWNGrWtnsoPmLqeMwXLOOYGOMN1cardNSDB3YqqNqMBECQ9Y61d/0IRXmD54ATWfBKD1ligfgi7Dsm851tM14TBUXweAMAF+FnwytpY
    W5LGezV8qJI6+RQU5wB3NCj+hzuPOF2KeDoFB/1vaAYLRwWFnU1zSk232QnTAXj3NO824P7r9OOSSbrNPYuqjXfkdUfo5g8Rl76P00MvWwArNAtAxRkmWm3f
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=RMlRvZAwo0AA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbeDWSER (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 14:04:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeDWSEQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 14:04:16 -0400
Date: Mon, 23 Apr 2018 20:04:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
Message-ID: <20180423180410.GC27081@kroah.com>
References: <20180422135210.432103639@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 03:52:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.96 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:51:53 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.

And there is a -rc3 for this tree as well now out:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc3.gz

thanks,

greg k-h
