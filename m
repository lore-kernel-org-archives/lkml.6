Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065765-1526314844-2-8034813493539962372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526314844; b=MRjkmJ0+m186PLhGaj6xTENGUhnPj+/bSQHGiSsrgZcK5t8syd
    qFya6jdp6pTFj/pPzZ3nPGh7qZii0LZuMrfPlRyFWBhBURrnYet/AYPLHYz05XR3
    PVblH59tf3WzueV1T9IfOphkj4I3/6tazTPwMHWAS4TrwsJKEQYVEbBejBk12z1F
    5wrDd2epyP7OPWOtwh/jYiqkaSOuRHY5c0o8wTiauXZxB2ZpMbnHtPfZ3UD2RjX3
    xvMJ8YPGSRSKohiKEQgYPol2JF5ZzhrrJumGcy3JTTZewRs1SQPur8gdSzAKEDdx
    /BZH1oYxYdIbXvLEvIm19AEEruEGnjwKXmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526314844; bh=vkM4ee8uezM7fD1g5BOQp+6TaOzqmm
    ANZrc6U0EcM3w=; b=UKB1kWvp5467nWHmjML2qPIoxh2UcXTA017P1rM2m90QNL
    WO2vLSENvpKmMd4/7Z23HW0p2uXEEDC0k11EXRcUiWYBSIxNHpoQTCY/UbclAG/v
    srd9uNKdfKvjd5UI1xWLJTPGyP2NlywF3geLcPiLgRvzxxhJC1L+GhbyNrgrvP8C
    yI//Tt54DaqKMBCdgY7iihDOGg3GQlDmbZqTKcAPJUynIay+G/HWA0Ly9zDdM/1w
    hDSRf2A02xkrRT0KRkDiNhI5LHHjJeFd99oKN5B8C9h/WhlG/fwHFr5arBh4YPAj
    WM+kA/zr7XtOORAv4p13b9UNF0NLPSoqdDK9w5gA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=kQuTb67z
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=kQuTb67z
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
X-CM-Envelope: MS4wfIJCFhcDHr4wJZFvB+IcWLCG3IpqhQQ821J8XoatbuPvXchv4MUF/AblvGHDjkpkRjUQ7oGQCFiseFS1ckcTu+yG8opEX1PwpRCTG1HMJIhXRagFL4DH
    Fesuo1jStnND3xYgYAb6bCSi3Bw7Xoy2263Z/7E0P2HZqgU9ZsODw1f7JN27o+cm3GwF8CZUDDDtZHfhxu/afuXkcLXzjIAifRrXIIMTZJU6OsrFrrAvWHlv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=_yzArvceousA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=HoCkWmlCV56ydFt2py0A:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754927AbeENQU2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:20:28 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:48394 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754922AbeENQU0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 12:20:26 -0400
Date: Mon, 14 May 2018 09:20:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/56] 4.4.132-stable review
Message-ID: <20180514162025.GB31622@roeck-us.net>
References: <20180514064754.853201981@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
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

On Mon, May 14, 2018 at 08:48:05AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.132 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:47:39 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
