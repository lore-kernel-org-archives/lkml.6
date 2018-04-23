Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1593853-1524506794-2-14138065143858727893
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
    1524506794; b=LYCxyArUlbuhTpfLS3e1XQbmilQqjd8eoX3Z4hd5RxXNam5Hzd
    9+OZ4QrTsEVyP+P59j7g2ysQm9qnj1QNCeAfoLJ95RxI58CoGgOTz5CGW0h723qH
    KgrgAUZhUvsNdW1MmieWKh6rRyqIOvSNTGnWm3swlEpFivR9Dj9U84QYmiQQ2MH9
    gTWFyMm4wq9L1N6jb9ZqQM1DTVk+y41osiC2YGSCwVvGqSgi80o3JBtDFqjMQ1Dz
    oxQy6pkXD9bnYetfTucVnXSSszIXYC3s5e2UBf6dnhabFCSYmvy7LzrRu1yHVAZr
    pwgN3wOdKcW2Mpff6OujfE8rEUvuUjg5kTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524506794; bh=OgFAdJJrlos8wah44LpBZ5aGrS78M9
    DIsxybuTuP2dE=; b=h2QSI9Zi43EYZRZ3+knPwkReSiM0qXWCwiYOvMkXEh+Idq
    oQ/143RCf1euMd5vBHSdlxaBw5ZlaNJIlYlaBRsSJu2Oo/hsWJFjGpa/2klb+qgq
    gedkUgYjNmcLYmUZXFEbxxbQQu+c2kGt069ZLbsjxxZ0Xk2yZLz/6nUxLfa+KS+i
    9V2sGdID6gwH04Meqaphb5jlqcG0e8+rKVF5zYbX+674ljWO2+yJU/CAOOiRKujL
    YUarQX5kogkoSFdv/Oy+icc5fT2SlklKdskFRDy18pPOBaH/hT2SKPajhoJjj1nd
    1MhltcTq5evfpVZEvq37MlyRe4AHkjBlpaaPiGPw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCXVWVOvWISSUewKUxse7fR0zSRK5pLHrSn1d4VmcvycA6BvF6ep7ztbPwp/91aqJo+sy5Q6OhvJoUYe7Q5Mw2nFjnWZVt4nTKAdRYjBdGXA1QY4Yxyb
    yMRL7dNeGVFejrvxHmpkqBqOuhI9bpO8Da3y6nusR3VTKuGbqcxOccd6fIwMfyuBcadhUgucjRLMOJ0Wqj9ENwcn/9gMSXqC7ipBC8bqUw+iP45YftvHeFj3
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xRDiy12qv0EA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=3xrE4qHWlcdj12eQslgA:9 a=CjuIK1q_8ugA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbeDWSGS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 14:06:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49440 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeDWSGO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 14:06:14 -0400
Date: Mon, 23 Apr 2018 20:06:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
Message-ID: <20180423180607.GA27360@kroah.com>
References: <20180422135104.278511750@linuxfoundation.org>
 <20180423165605.GE12958@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423165605.GE12958@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 09:56:05AM -0700, Guenter Roeck wrote:
> On Sun, Apr 22, 2018 at 03:50:20PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.4 release.
> > There are 196 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.16.3-197-g405d1f8:
> 
> Build results:
> 	total: 143 pass: 143 fail: 0
> Qemu test results:
> 	total: 139 pass: 139 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Thanks for testing all of these.  I've pushed out new trees for 4.16.y,
4.14.y, and 4.9.y so I'll watch your builders to make sure all is good
with them.

thanks,

greg k-h
