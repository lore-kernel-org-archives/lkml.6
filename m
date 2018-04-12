Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872240-1523536329-2-8065770063271568238
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
    1523536328; b=lq8VKmz6Obki+EY8l3PQti3NixM3KtyAG9W7PkSmRC2ltM+/7a
    iassvnv/sRK4RMKF/u35iWEJ1SdGepfK+BBaY/VM2JtVil+CVvxwuZ62kUTZ10JH
    zW/wDMdA9LUdVcSYY94VyCQgzVpeCyR9892T6/mKkOG/OWURwNmvUheM5EIlU4cr
    xPjV1B/ZX44yMD8dUW/Jfg0KuGAdD8T4o61Hdz7Xp3ZaQxCArpeVmhKznpY0J4qO
    3DNAW0lb6O5/Y12BU+k37NEHNX2Jw7TrNNH9GGpklThxC+hI6GsEZ3scEXnDhen4
    qIkB41vIHvt1n7KdJaOuHouGFuHhux/xGQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523536328; bh=wyoReLTLzZRLPAIkaSbG4lWnrWNHo5
    X8qV/WHnUntOs=; b=ZCJ7ptLisiJBO4IXuIMvvt/thPSJn6tSr1adJbpymMvW4p
    4+cSQqhR6knxV4aCIWHCiINZrwPABdISCSIy5cJyKolBkeIyqLqS5SucRp9J4MG9
    31SVBSRlWpJl6g/4Y5mDp71KGU/k9MQ7Nzs2h/PFFjKdoYTAAR46u63CJ5ZAjnnf
    P0pTnVW32OmdarjMfYlFKlGJM71EfaQZYEmC08hCjsvlBJ/24gYx8qt4fzK9Cp4/
    vrLmurhi4BXO883IYVFLRHUAjwoYhBbDc3qXPz4t8mfD9dWW8R0gD17Iisf30rls
    th4GSNg1nAvrDqA8FlduafCObny32oJ8QJGyOF0Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfFDHJa6nol2KgZDI/+dfX/Kg0qi5ZWllA3PJ/bLUZ17w+mpqysSzWpE2cSoMA2RrmIL6AEA8GA776rF+1wrpQ33/MxNlJ5CHinw0AsicITd9LeIcIS9/
    Bdxs/Vgy9/3rSCq9Sy3Rffy7q5W9bQDswI1LbbnJIpHAC4HP07MWBE5kG8t6AycG49Iv/65HBj9FU0V3UMYG+LtVdEakmfW8gyNAPM/bnwqM5/WEVsL7h+w1
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=QQrbzgpHJRgA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=_ltfmzFIPYaNbB-H_NAA:9 a=CjuIK1q_8ugA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeDLMcH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 08:32:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbeDLMcH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 08:32:07 -0400
Date: Thu, 12 Apr 2018 14:31:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/18] 4.16.2-stable review
Message-ID: <20180412123158.GC20501@kroah.com>
References: <20180410212758.564682823@linuxfoundation.org>
 <20180411172724.GC27459@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411172724.GC27459@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 10:27:24AM -0700, Guenter Roeck wrote:
> On Wed, Apr 11, 2018 at 12:23:35AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.2 release.
> > There are 18 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Apr 12 21:27:41 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 142 pass: 142 fail: 0
> Qemu test results:
> 	total: 139 pass: 139 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Great, thanks for testing all of these and letting me know.

greg k-h
