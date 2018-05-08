Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3079855-1525796471-2-13365694962903641147
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
    1525796471; b=MJxGFBFkAFLyVKi01kJZ4HouPTqBA8SMMUVZFHKlXbTz9yJfSf
    mJoEGj1uo3xset27GMB9tBVHQ+QOOUwEhmtEsApEYc0rmo52tvQjDXvYBrmvsU3Z
    Fsz6YNjjeMsvTXM2A2sjwUpcdOlck1+grLMzuyx6MIW4bUfKgXv/S5Xu4wBjbS+i
    PlUOzpQVy9+X6xJM4Ip2GQivip4G2Tp1RNnmqoCtj1LWJ5RMohi+57c6jSlfmw9U
    abgYaN9ydNz5Kr3i5AwcM7h+97E62o2xWEism/zCUtLkJidQAarPQAm8nPBEVkAd
    06DFtYNQQm2K1cxJhA1svQTexLtwJNIedrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525796471; bh=SHkOhgxGriMKVE32HSWa1mXep7N3Hw
    Unqn4RpYTj4Nc=; b=Me3GevHQTVmeO+EDjA0P40JRlk1iMeCPEqwd6Y+YMqWN0s
    5muLYgmerkfvMSQy3sJIc7tcvabu6tU5Bvgyj+SKPegXNGa9TqcBcLnjdEFRPu9M
    HXgmwvc+iY311L8m1E2UmkqszVNK5WPLs3vrpECfM4mFrjsaXK7r4xbTVdaBGWC5
    bKPNLAusmdbzsYfLf3pxrFDC9xQHYd2y+u4HIF5h06nvBm+Lfr9yv+qUTnw6B9EP
    usxYI7gQbgP2z3u5O918Ey5m+NJ+o2t3r7Ucs9SWJn2Padtxem08z6Pei5cqRuEs
    LZavMspUIUv7iwsOrtwIxpKFm4jsAUf+NHfKlKuw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=LkUlfDoR
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=LkUlfDoR
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK2J2fuz9xQ8Gr017uwMxDDdr0AsY6LSs/BuIQv/UA/XDXv3QTGY6aWvUPWlB1O7uYEwsdxZaq4ropTMKzlf212d3EWsCMGAJyETXUkgYzhxi95ohfn+
    wFl1Pn8t+wDLAtlr6vC1blJXcl0rnaPLuaGTjuJMfMZ+UBBS5Ezv4UPgFAxnQaVZ1eg2Q9fE3OA4MEW+4FWTCMSP9SdUgknCH6xfbval72RocVXbbq6Eqcd0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=_GnF6dH6mMMA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=k9_Xz8984WQXazR9EfEA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755438AbeEHQVI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 12:21:08 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:60231 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755072AbeEHQVH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 12:21:07 -0400
Date: Tue, 8 May 2018 09:21:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/32] 4.9.99-stable review
Message-ID: <20180508162103.GA18520@roeck-us.net>
References: <20180508074008.800421598@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
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

On Tue, May 08, 2018 at 10:10:40AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.99 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu May 10 07:39:44 UTC 2018.
> Anything received after that time might be too late.
>

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
