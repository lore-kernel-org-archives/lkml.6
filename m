Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-705158-1524065924-2-3035567850960459817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524065924; b=aIEJitkzA8dDjhjFdFQR9jl2YfK7oPAM249h363AL0+LcJwHJx
    sczG33cQcYyxMJMMYMSDXTb9nEiFBWk397E3NQZCUfZbvfthue58ce1BsddzGP6Z
    QFzbaGtcilSdajQM4h467V3sBGjJISB7cLyDx63V3jtK0SGc6HFae3o+xfPvQW4D
    XZxzNKf2GEO9IUPJwC0HNqhiXMuqtkFwS5vsVwg3TvGkOotTeupIq84N/Gtq8Fb2
    GZzo1kCW09zIYNhi2xkInOMCSnoF+zwk2foQUt+4lK+xxYwYyrM4LYq4AANCFqot
    1MtPyVwGUi24iaT6L3N5GHP6vODrqnPruQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524065924; bh=NS4EhAGAhbU9q21HkP/XWCYno3LCUc
    b8vId28GTEn+o=; b=as0QCWFDKSvpk4KVgSEmVVGC6MS52ELY2X6nOMME/UwgIo
    ICH12AeKadBO4Ur/Xt10ul6676NtjMUW3fpUQSIF6YffkGObQ9qN97xqmbnvDzF5
    2NLIQsPBE/qzwJ1HrAd7i0VnQ7jatoB/UI2cj/zY/EKbaWq1QFVYIZJWXTl37Ray
    zUEFsen6/ekJfTlOG5KCzsMup7qnZ2T8EucxYz4MA/Wga5E3u10MI6vBGxP9Rxfh
    wmJorBex1p7bFeeihIaTPLYAA5yYPP42JKXYQCtOU5ypSvGBIcvyyYcteeMnR2Eu
    GYL91k/jMndPcVnnCxS5R7V1anJmxku5UuKio0ng==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=ON+AOgLG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=ON+AOgLG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCDTKUgKi0LJVhMUojZNHGHHKiPOcaEem03xddlIhvRNA6FxPKYwU7fvKP19YSZb+FwMnazfNaEAjnEnd5O/5qw2irufGZfDFAuDptcE1RoYNz5deVSm
    HeZo77bGVqUQ0BBx9hQJJeFntLHS1zOSzcJO8peIZy2/ExeIFzCERcCXq1QR17eDdhw4E8tEh65UYoAQHen9WDQYlbMFp8+7R6Qls24wTYeXnNLweeKoMiZ2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=J7Nbbob27coA:10 a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8
    a=wSFAT0bzRL9SllPayaAA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeDRPi1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 11:38:27 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:32930 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753681AbeDRPiZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 11:38:25 -0400
Date: Wed, 18 Apr 2018 08:38:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
Message-ID: <20180418153823.GA8888@roeck-us.net>
References: <20180417155645.868055442@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 05:58:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.95 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Apr 19 15:56:27 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
