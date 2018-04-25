Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1043372-1524676425-2-5228983857826754956
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
    1524676424; b=SsQ37Ay9XvAbArk8O3k4LEAWkVqa6PBsCXy2j0pC4joAg2rr4D
    1ZatK6y8lEj8vEbsTb6LEn0LMK8Sw4VkU99scBLoBo2kelO8scEPmtWGUhjOrl24
    bzdLZdfVhTvHawBvefiOJfKPYvo+MHkSJDJeHDEV1wRsGLCvSMI74R+b0Vzntsrs
    wEEy5Qg43Y7a0d4x/An+EmrBP/Y8rTP/5YU1+3uCT1uSmUbIlL3Z8rxv4XnrSXoR
    9EGB4Tj2nIus+R/1R34To3cPsYNz33AbiGF76fFSiunjHUOCBgDD9NiU6n3O/srY
    6rAToR2ODI+NcVr32AwNnHHNsTxZj7FFF9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524676424; bh=yMOphp9Gga1L2WRd/dg9YYOlDLRTE5
    tdK7WUZtmEyYc=; b=VGfgod524Cb7nQjqayTQty3XCvlkVCXi9fAJj0K6bnsBUB
    wMOj8L5qSgRdC6++ZehJg5JnIeuAJcfw9TNmkXp8TxFjX9i3Eg/4CKXeZcy1HKbD
    DOzy8lF5HAb770i7PP6uFg4+hOsOK9tXLGVAJvdlgNMEie3M/g7zSCY0R0EZV8YL
    KGBJJc/THdcxUh+7PPO+DBYiVMZOwpuuROGKebGfGxaxvGleYu9PxkxYIpIcWcVD
    ra+P7H2LLsW7av3/fOX4fbBQw5NiRMqUpFC0H3O3eJ5OhndDmz5ob5zJIsrq0b68
    GoFdWSCGJj31ZUeeFwZoBjbpm4aEy5hJhp2dCHvQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfLc7l2tbm8BFcJGmnMCFQL5sqGggtm3+Gpku51y8Qoz/ooGPecfGfpqYvyqMGB4zhmkJGMS4HkV23eclcCyof4X9Dv/2Vhcy1KRI9i/Bj4Re2WN0hzGx
    d4NjbuQ0O2OoAG1jfJdprdIW9mfM0E5RIe1heBR3uPAG+dUi5nrq7ddQZfHgHvxzbIXwjKn1luQY9nHpugxAtIlmCjuxzHmhzSJDGmrTB2N35bcehxKMOrrZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=viYhoEuuK30A:10
    a=Kd1tUaAdevIA:10 a=MWGFQ0ytA6VXrqngUXEA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbeDYRNn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 13:13:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33684 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754552AbeDYRNm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 13:13:42 -0400
Date: Wed, 25 Apr 2018 19:13:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/183] 4.14.37-stable review
Message-ID: <20180425171335.GA3565@kroah.com>
References: <20180425103242.532713678@linuxfoundation.org>
 <20180425144110.GA12890@roeck-us.net>
 <20180425150754.GA29414@kroah.com>
 <20180425170931.GA19712@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425170931.GA19712@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 10:09:31AM -0700, Guenter Roeck wrote:
> On Wed, Apr 25, 2018 at 05:07:54PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 25, 2018 at 07:41:10AM -0700, Guenter Roeck wrote:
> > > On Wed, Apr 25, 2018 at 12:33:40PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.14.37 release.
> > > > There are 183 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Fri Apr 27 10:32:04 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > Build results:
> > > 	total: 146 pass: 145 fail: 1
> > > Failed builds: 
> > > 	powerpc:allmodconfig
> > > Qemu test results:
> > > 	total: 141 pass: 141 fail: 0
> > > 
> > > arch/powerpc/kernel/eeh_driver.c: In function 'eeh_report_resume':
> > > arch/powerpc/kernel/eeh_driver.c:395:13: error: 'struct eeh_ops' has no member named 'notify_resume'
> > 
> > Thanks for the report, I've now dropped the offending patch.
> > 
> 
> For v4.14.36-183-g55d212d:
> 
> Build results:
> 	total: 146 pass: 146 fail: 0
> Qemu test results:
> 	total: 141 pass: 141 fail: 0

Great! Thanks for testing and letting me know.

greg k-h
