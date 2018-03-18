Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521368775-2-60912400687326574
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
    t=1521368774; b=fXvfbRigX8ryGLMm4Sl7nSr5M1KEwPaxJDePiMARO7HF3U1
    F/TCKahIg7VZxWYV4QWbHf5+9XjMf3yU5Pr2ab3O/kXA9u9zOm40SNrYqcKjmmGy
    Q8E6lV2dCr7soepfSvkv5E/+I85hVRNnpbYnVVij4lqUciDf8eK6nMjbWTB4czKc
    DByh5hSPJnYAemgocD9E3c92bvYa849NMqUOpLDrcAliHD5yDfjy/cawa2fPwGOJ
    LAGlC27802+ss7r5A0RKz5W2zGit8ccZSZAMexMeDCBM56PDF7FV+tWfoMafgbfr
    YHiajJ22Rw/OGD96rm/7TwylnPW0WynlBF+w2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521368774; bh=FeVifHu317n6EDo8o+kmfWKd/c
    Hm6v7WLHACHmdIWVg=; b=qPsuuD4Ji+ikkLQYZc1wXRBJ9V22H5tGsMVcjmUde7
    wHu2qwGn5aIm/AxbiqZUg6k2tCYWeA6r4v3s7+eCLsoj9B00k2MylbBAF5vP/qVm
    09zYLtVy4NOpAwKIQkkKSIQtvU1r3Mwhh4/S9XPlSnLrL8VgwkEPCwYikFXdJSb6
    3t3NmTbPCRwyntNRYoI7I0EcluDeUNwIe1dpeohOMGoOShIepcSTafbv2+n+Mi+G
    U/5BImEXMtgahqXcXVBPDWkQrUT0rh8mMdhu4RNooGq1lBnJJuY5Y6z0+G3neTVd
    u6qtA9pscNqoHWwbl1lPUiH8r7Rthy9OFFqC66b560JQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeCRK0M (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:26:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbeCRK0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:26:11 -0400
Date: Sun, 18 Mar 2018 11:26:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
Message-ID: <20180318102610.GB32470@kroah.com>
References: <20180316152336.199007505@linuxfoundation.org>
 <120779fd-01fa-fd6a-66d6-fcaefa12ca2e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120779fd-01fa-fd6a-66d6-fcaefa12ca2e@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 07:48:59AM -0700, Guenter Roeck wrote:
> On 03/16/2018 08:22 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.11 release.
> > There are 128 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 18 15:22:57 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 147 pass: 142 fail: 5

I've now pushed out a -rc2 to fix this build issue.

thanks,

greg k-h
