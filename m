Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521368810-2-18399562554097201112
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
    t=1521368809; b=X12yf/QYcQLyNS5SsAu+q6XzsKchIyVnK3cW9tU6DovjP0C
    8aKAlMfTVwR6m/TpdscHBLwV+vfRs9hxRFW65QzsVr75CYQh3RAc6RShkDIWeqQh
    Xoho8omsmCVtexRbGYPDwOvl+2KAtt0VXHQx+j07S/P0KnhvR3EkPkcSkGDnkQfr
    ui1A0ss0lEbOejkD10kKjpHOOY3m24ibaJQW9tVq4r+ZKpjermQ58wCrv+e/57i8
    wwAIZMCRI/D/d0nk3oH9h4YjDrm/LCkS+JDvx4cgfaKZvz5Q4C6rtt+isUVqAKFB
    BL+9Uavs+CJVeKaQYNHjHlYZitDpjmTb8oR87Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521368809; bh=QRhAyhgz3pTCnycAoo/0c/vT2q
    8bi5z9L/GwZTiascY=; b=phTW/861FMbVMkJZ4h+zfrbUHg5WfR+mRNeb7T8/f5
    wCsipeqBlXarhxb/hA+jR+fFxlZUIpkzpBC8RbejT5mF5un6QuzWrnJLJKCCscsk
    qQBgTIq+EN5mQ6v4ivRDDwQJ9b9GFrbkT749Y3WhppyHJzLrfXCNhwgSc4J7VzX3
    wXFXLdOQDfZGjxqwfAukzaldkeIzssanFXgM06PGMkDjM1vPqbbBojcW8zxmlaop
    c3ge9cKmzYpCy68iBXSR2lgW90HB/r44oVGlnP0veuOtUspg7VFxxR92uFcWYfMa
    8rCo+1P8DuRTIrJ8qqg/dqLDqazd3vesFI+8+jMS2Dvg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S1752228AbeCRK0s (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:26:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbeCRK0r (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:26:47 -0400
Date: Sun, 18 Mar 2018 11:26:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>, peter.ujfalusi@ti.com
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
Message-ID: <20180318102646.GD32470@kroah.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <CA+G9fYtjgL5GWOnu0_2zfKBP=FN=vQDdGYTE8-4SsJMv_13V+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtjgL5GWOnu0_2zfKBP=FN=vQDdGYTE8-4SsJMv_13V+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 01:10:28AM +0530, Naresh Kamboju wrote:
> On 16 March 2018 at 20:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Peter Ujfalusi <peter.ujfalusi@ti.com>
> >     dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free
> 
> arm and arm64 build broken due to this patch for 4.14 and 4.15
> 
> drivers/dma/bcm2835-dma.c:815:3: error: implicit declaration of function
> 'vchan_terminate_vdesc' [-Werror=implicit-function-declaration]
>    vchan_terminate_vdesc(&c->desc->vd);
>    ^
> cc1: some warnings being treated as errors
> 
> FYI, build using GCCVERSION = "linaro-6.2"

Should now be resolved, thanks.

greg k-h
