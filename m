Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-878196-1526306274-2-17573819654048303488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526306273; b=B8yqT1hJYctF4Y8BErYRLZkyElGazNHElVwArxlDd8lKMjFnHV
    c2I8A08ZGDD9A3E1kzShwgZmoKTF+1W50DjPpCil6JCR2i6CD/lKpUW3O6cOhhgf
    vTVcg9WtShbl1xwBhCqxaXNsCSfi/NTaNV/uD60LKmHCuXuk2TC4ENys5F7zk3/T
    cLrEMZM8ULd26O0swFrNgVCKxGjhg3zronXATwAd5aknmyl37DnQwpR+Ufhagfq9
    67RM1MhNa8+JBxGti9pQ1NP6bUgs5YXsCQqFsOn1frwG7T7HrPsU07WTYQbN1sNa
    wIwXz4YCmZ2O2oNXXvye01KaPB5VXmO9kotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526306273; bh=YX9XG6zenBdDc6q+zqaMtdHHa1YHEE
    niAePImvJlQFA=; b=UhMbrTv70ps5XhibBPo80G7A8HoL09JLvqIyBRtz/wmkQs
    K9RgJRqF+eM5UjIJaRuru/teDzpbFD8fnOIVx0dm8hLZP3IRGsveZjrXujjhDUhI
    6ggY+q+KfGWCjI84rJylqNwSXwOO55BOzhm5dbjMgHEpVApf2wY6oOSIZtvIdBqC
    FKBsZzzTpVDDkDYChDPa1WgiK8A8BXdBs9bLYurw3i3LFiPr3Je5ObwzJH7fjJGK
    m0XW2XZANmsACJUZCIkLEx4AIHbcJpSus10qpx5jJjMfy/y5ycNOLeRLTwN61zzw
    E6hJErgOyeFT5k0TPpT2KYl2zKMvaCmrBIVR8YOg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=EiK5aeKL x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=EiK5aeKL x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBFPAGKB9j55Ktk5yB6NxsZMs3yswVXWQhejhfkuhDLeIR0RLZLEyDuKfpk/X+KOGTpAIlQ7Fca1T+P27YL0vUWFK5EpGxDvpnxMZunY1fi5I9mMVKRI
    uWG/qzLtNXY0IhThjoHIo+u9Jhps56iFk/cXfPb3qcjhjqCNRCpZjBNtj4GIW98XHa361PGOiagsQnWvLVUgDEj0afYuekMBZFFJQHPhjaBLmb+2+uZCKE70
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=0U73VwB4dlIA:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=qfd2YHwZ0bTNW4XGlakA:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbeENN5e (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 09:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbeENN5c (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 09:57:32 -0400
Date: Mon, 14 May 2018 15:56:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <harsh@prjkt.io>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/23] 3.18.109-stable review
Message-ID: <20180514135622.GB2220@kroah.com>
References: <20180514064704.046463679@linuxfoundation.org>
 <BCB46BB5-7FF1-40C3-AC7F-548194797025@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCB46BB5-7FF1-40C3-AC7F-548194797025@prjkt.io>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 02:42:28PM +0530, Harsh Shandilya wrote:
> 
> 
> On 14 May 2018 12:18:29 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 3.18.109 release.
> >There are 23 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Wed May 16 06:46:49 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.109-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-3.18.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> 
> Merged and compiled on my OnePlus 3T, no immediate regressions. Thanks for the update!

Great, thanks for testing and letting me know.

greg k-h
