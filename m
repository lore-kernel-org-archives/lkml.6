Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2513731-1524554743-2-15892602713446291594
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
    1524554743; b=AKXoD9x7eiGD/1NyjGASEK8v+qbg0Jr+mX4S7ozmgnpPgM3eSt
    joGo/plEjOgwPvbzHSsik4SLQSa711yttebOSUbAd8BO2ngCa+PDVSYDRukf9o1o
    jv3Wjl4a6ZxiZBOHyXkLy4u19HhdHn6C89F+fEKP/U8NP84XrxqNEfV2pA0b7kt0
    npylAiyCTD+/gqXzvEmNqbo/jDI9qR9iuIDwX3W3p3YCxIvDcipgF+Ea1wdO6DES
    waa6IoWhmXhihfj7aw8p54eXQ70Y9ckUvjDYhMcg5rrNAfcDodL/GmQ0nZvYoZWP
    wuIcJpHw6eYUakZOJ3Zsa1jS0EC092wokbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524554743; bh=hNGtrQDDdUV0usiK0jFWqGYnE3UvQ1
    u9BTpcMjZ17ts=; b=YXSRmBK1/YrxmxYDsAgo6XBFeMSjpZGnA1koywqcZcT1jB
    py3pXlShv9Fqp2OXtJKmL0+oCPDrUeTiwZfk3Ag/sZ6/0VNdVvkmc018OhZl2eNC
    b8H7q/BEQYSvNo+Gcmwid5My9sFnEkR1UVlCEaFlFkpvdWrv10prOAsVyJDXMAkR
    NcJHElZJbYBMjA3Wfzvf/YVfcvwAyZyPOejFBDp9LLHTYgZT80Evj7nglLxKErub
    9+Nf0PxKa3IlDKA1QkP6o7PXwGqLLD247WeZAMzLUrqmg2WPNoWw6QPo9CZdpXy6
    wWUVh+Roy3AOXHpyWh0TgHOBXhNp4mo7Ir+viVOw==
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
X-CM-Envelope: MS4wfAz2j/iRPr7UAYx019AJZ13JptxlZ0RhvqB1ks4AavF54XPSL9LFkmx1VNwpDP4i0PXg/qkm341V5C1odyospoGo6X5l30WvDik2lY6T9gKvzXuvUpx/
    LHsGXFLIA2OhBNV7ixXtBsr/6QaAIZsYDeZmasIOP2U94HgQhJLJCpAOqnf3HTKUzdxPgB8799wrLYogiHyqpB4zYX4uwfWaGlZE+TaiXbPtKsm+PGZZ+FOI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xRDiy12qv0EA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=3zB3tIwD0MfBNlhhfxUA:9 a=CjuIK1q_8ugA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756075AbeDXHZl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 03:25:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755224AbeDXHZl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 03:25:41 -0400
Date: Tue, 24 Apr 2018 09:25:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
Message-ID: <20180424072534.GB18419@kroah.com>
References: <20180422135104.278511750@linuxfoundation.org>
 <20180423165605.GE12958@roeck-us.net>
 <20180423180607.GA27360@kroah.com>
 <20180423215813.GA3976@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423215813.GA3976@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 02:58:13PM -0700, Guenter Roeck wrote:
> On Mon, Apr 23, 2018 at 08:06:07PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 23, 2018 at 09:56:05AM -0700, Guenter Roeck wrote:
> > > On Sun, Apr 22, 2018 at 03:50:20PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.16.4 release.
> > > > There are 196 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > For v4.16.3-197-g405d1f8:
> > > 
> > > Build results:
> > > 	total: 143 pass: 143 fail: 0
> > > Qemu test results:
> > > 	total: 139 pass: 139 fail: 0
> > > 
> > > Details are available at http://kerneltests.org/builders.
> > 
> > Thanks for testing all of these.  I've pushed out new trees for 4.16.y,
> > 4.14.y, and 4.9.y so I'll watch your builders to make sure all is good
> > with them.
> > 
> Still no failures after rebuilding all three releases.

Wonderful, thanks for letting me know.

greg k-h
