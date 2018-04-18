Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-732471-1524065962-2-15539666247382225525
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
    1524065962; b=iRlXNyryd+Gky+WZzWngmlHk6BiE3zoGqJF1/cVshPBENpFmWf
    dAM/XgLcclhxR3oiAK+b4aLVA4f5iXrYkP08CwTRRF2QGz/WY+VzKgcHRH91Urmp
    hkCoN8Ckq3rB/t/6h9ZzpNPyvdD3wcmnuUTYZ6ead6zqfOEJWg+uzj8xjrb1XCTo
    exFojN2fCZUTJGB6czw2WkECYStir3Q/QwRw54RtKhe6jdwlNI27fduXg0zgm6Vm
    TezvIK3U0DNp9/lMFBfruBfZtYbiTVnFPpwQq5KF86O99QGljrOGor45D0z1CvmI
    WE/Y+HQ2ZR/xfhKxv1omhVr77/TMvbNGLxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524065962; bh=wRsofm5bCa3gtbO5kOtxRbNKIavfSj
    h5jYGdwhieZWk=; b=WYZWJX6Pwz6Uv2USzZ/xmHLag56xUfgIcLr1B7tb7Nziug
    W++h6s2zGE/x+c4hUIeSpgVUhAiruJVbHfPbJqUGiml/zuZR1lBg8Mkrhx1s1d1w
    Kc0t/+OuFGkoG22+RWxmSWFTTJVaoSREfHsDp4H6ozCi9Q7thnRnIfepghfOoOWS
    dkNnW/je2hPUgnpHf+Z/47ggMq/alg+2X0P36/D//2PNq0vE/TsdKRS7jyTXgpml
    UIsLA1U3/8FAO34a+y4XhLYak8t/a12+5KAjBXrZ2mXjjds/5LdJR68KI6PGSrKs
    3cD5nGuAUhjlaGzG7ErcUZJwiuwSf+Zlr2MWFpLw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=CbVah0nS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=CbVah0nS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPcsFxi4qZ4Si5wfB5OjTT0APUKkVfWOPQVI4VnsZMjec2aL/l1BeODYHUyd9XNyZlCMfNnqHLC85KjEUZtc6qUVM6FllfH3kVauEtUyHOfQCYbdsdsq
    QyTUNZtaTwSFMSslI0mxQoSyJR/8BYqGve/B1JIVcbdRsXY+FVmOSnF67RTyEvCqUqenLooDITtltWHFxGm2+pQM6ERD+ScvigofYuZQc56seajtW5p1pkWH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=thLpXNZmclIA:10 a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8
    a=1b5lKWMfu9MZRVoLIYsA:9 a=CjuIK1q_8ugA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeDRPjU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 11:39:20 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:37439 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeDRPjT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 11:39:19 -0400
Date: Wed, 18 Apr 2018 08:39:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/53] 4.15.18-stable review
Message-ID: <20180418153917.GC8888@roeck-us.net>
References: <20180417155723.091120060@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
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

On Tue, Apr 17, 2018 at 05:58:25PM +0200, Greg Kroah-Hartman wrote:
> ------------------------
> NOTE, this is the last expected 4.15.y release.  After this one, the
> tree is end-of-life.  Please move to 4.16.y at this point in time.
> ------------------------
> 
> This is the start of the stable review cycle for the 4.15.18 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Apr 19 15:57:06 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
