Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065765-1526314897-2-8130524776523128986
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
    1526314897; b=c/zgVPnhDm/JCWcfKLJmkZ/9Uuweie03CdC4uN8PRLahF+V6PN
    AzeHeY8zYNX0sk1EyMhZq3uDHREooQC5mDTXKn311lDdq4tN8rA/bOyKQkO+JjDP
    7OJOMSnQGhIseIRSEFmLHHUOUjPhYZxGOqsVArKRgbdAuH0JRYpN65xQdybRC26w
    M/E0+2/1lDsXav0MSeYCh4onBTVoZtv0S+dyeTGCZpXDtxYGrsEyL5xaK0iYRROJ
    qukrF7/illLshDvo4Cbri3ILOtN6RdOrRZLqgGQstBdliC/w7M3eo3LxPgRCIAuT
    jUzU62sdwMRDr92KbZNX6XbhEf3dA/KuYZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526314897; bh=Y8dClHGxZUl12hVVcPwVfIW4AGqPEB
    UoTGXHr5fbPuI=; b=TAx43QxsXIeLci/g+e7sGRb29DQML24ke9uVgfzL/OJyJd
    JrV0tNYJ74iVk0zhBB7xTHQfV+4t/wG/5JirXxeiJnEiOAD4S1G/z5ntglAtb/Fv
    7VCyU5plpEI59EPeMKM8VMc1eSnT49dPoheSr3wicP9N5UQLGp2vujzwD7aVqO0H
    4cMr8fIt++EUuT0nSsa5ZznzrcWjUxQaY/mH1aiMcc0AQUipWv8NmhdxIgTq6xef
    TGIqfLdUWOwGnjBdDkUoHO0MheDKbbkjLIn9JSZBej90PJQHwwC9iUFGRXot4o5+
    4f698GN8BALWnuz+G6llU5Rb25095lfgNTF9PThQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=DTbNr2yh
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=DTbNr2yh
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
X-CM-Envelope: MS4wfJt1bSgn8rhCB2i3lNnbqa72aBQrY5xIKHk55unK275UOgbloqpZ7iJoBXTUDnyBS/4Lxx7h6WdHZJmmoFXhWnEeSFEB/2ooVyLgHolurlHAswTA3BS+
    XWeEDcFMHnANOQNRCcCdtdtGwWJzOW+j4HxtsKc6KBLwyg/LWYTLAq/JABdhDbC2p37UVLCmdJWCYhsb9ELONy5ct/znw6Uro5GH6xsRiOhSooSo/WwSChjv
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=TttDjgVrrK0A:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=HoCkWmlCV56ydFt2py0A:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755043AbeENQVf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:21:35 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:49609 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754968AbeENQU6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 12:20:58 -0400
Date: Mon, 14 May 2018 09:20:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/36] 4.9.100-stable review
Message-ID: <20180514162056.GC31622@roeck-us.net>
References: <20180514064804.252823817@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
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

On Mon, May 14, 2018 at 08:48:34AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.100 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:47:47 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
