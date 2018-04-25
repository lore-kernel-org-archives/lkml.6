Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524671044-2-6115949349533680485
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
    1524671043; b=mF4jE6Tk5isUdtOktdH7qqwlECzwpsekzhLG63cp6Hy8JglE93
    uYeqz6qIChjYzvgp7PcHdt+mWjhPwqPNRehDa/9qfwZfnNKmA6YsNqYOK5YLu9hl
    WT6MVH9TrtWNmCvXnhSxgDJ1t+B5+AirFEBXAGav1cNZBMAle2YYT0LiENrn+5PX
    aims9G9amcQBMQQFLw1MT2F6Q3/q9Wm2T5NM5ndU8Pv0m2dPfWdka3/AE14tDNGU
    pCZeT0YIWGmH2/gCqhWMO2ZhOffXFL8IGCVU4IPplmCdyJj+rUE96XyHltVxS7kM
    7YdD5cENhrqcQssysLIXHj+c9brnbjxeryRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524671043; bh=n75f5SQN4IVMapNSxHGNcXW1CtNFpG
    fqeritNAas6sY=; b=eU4opddxnfTET/nd1K1fxPlucVQij2PXG+uhVEl6ftFo/A
    uuOnQMIFYPcdglL1uTkhHk0CnrLUurqbCQztvMmCf0yQDW5f5gKwnywWU3TVOacj
    c4eAxilcRinI7Ugb5eahCqueNmR6dFWo8RBx3XBeFCMkwXNp9D+vMydE5ruHNOut
    VgQZUiRFiz9Z4X4MGEYmDPw2NjfbPR1+UxsWla/egmW6ZUoMb3/UvEOx0vqtWw6v
    TNYxzbBgHjbJrSokeF8oFS1VA+DPcSjnA8FXAfpD14tK6K8JoJExsER4eDsFLl9U
    eMTSv4mFj9K0WAyc/W48nGGIC2LeljngFcTfWC0w==
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
X-CM-Envelope: MS4wfCJhZYv/v6/0gN7sIFsQHPKc1SQ+5htSFAUGWltiq5Uq9ep8Sy1CqO1IUQ8cyTGZjXbxmOsdylcfcUOdkOzP53LihUMtozVE98sWgo4pqE68bxXU4rVX
    dPgqwunk06g2PT4dPEDD7y434YoP2eM9id9Ib4WyFrWquWTk6ib/I2WndkkgVlG4rPIgUIM2bLnnGX0OdnhKcdYGAasCBfWpiKp1ptEdBgYZ1wqB044wI0i7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=hoiGki7t42oA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=fysUe6hv5sp62ZdVHb4A:9 a=CjuIK1q_8ugA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeDYPoC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:44:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeDYPoC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 11:44:02 -0400
Date: Wed, 25 Apr 2018 17:43:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/26] 4.16.5-stable review
Message-ID: <20180425154335.GA7210@kroah.com>
References: <20180425103314.842517924@linuxfoundation.org>
 <20180425153443.GA8850@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425153443.GA8850@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 08:34:43AM -0700, Guenter Roeck wrote:
> On Wed, Apr 25, 2018 at 12:33:09PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.5 release.
> > There are 26 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Apr 27 10:33:04 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.16.4-28-gb04d14a:
> 
> Build results:
> 	total: 143 pass: 143 fail: 0
> Qemu test results:
> 	total: 139 pass: 139 fail: 0
> 
> Details are available at http://kerneltests.org/builders/.

Great!  Thanks for testing and letting me know.

greg k-h
