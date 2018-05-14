Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1071218-1526315283-2-12160474813401005866
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
    1526315282; b=HBVp/7dQ40lRqDUxZMuYCUu/gkT53K2x6kwNAKtzq/nAA/hFEw
    Xu/LQXY8yWv891FMbK61HhKmfbovBWD0RxVpxUwZwEfRfOBU70LpXBZkZKEbUa7V
    wgcNVunUYtuGRySG4DJ+q0PgV3udnmKM8xNYi5Ca/BkJUvcwvqsEEDBv9Wf1vTiK
    eEMGh5sC59YloUViFsFBmfHvQ32rAts/rPITcYq/klMxV+8g4tvF7hK34oo9tTeb
    t06pFGBtC32n7zRavivNn/t6yqmlh59nJ5MC2XIxGnQZ7W9qXayLJyMDklxihls0
    V7VDGR2xNSS21LFndYzzDlt2YM9FMlnkG5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526315282; bh=UztWLzDXt4jO4sePbLYNUL/wMQsXM9
    BP8kUWwed1T/8=; b=Hmm7mIH/2HMG5mumBLyBexX610qsg/RqRVVtPKGUdlMvuf
    GWFrhAxiAajqgYAURL4Hmu0R8oa0sM99ktDkESN7RWaiL/9xmuDvEL5sxURH/gUn
    Rq94YdYvI+csKaSdmiV/ggmh/7hI4dt+OJaxUj9SNpUiIrsbY8qpXFuB12dF2bJr
    A4IPywPo1lbcSA8h8UEv4uXpGQ59sT1Hp5pHFARf60UJXhOXrDGx1iAtpN/O/sPl
    dQR9GbVMMPSdZRXA4xFC6j0/7AwNmje03asaQoSwFHuCZylqW1czjq5pknvSDZLg
    r3r+fcsY17tYSolqMsIgdjvGY6OOnlxendJd6hXQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=X6a2St2p
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
      header.d=roeck-us.net header.i=@roeck-us.net header.b=X6a2St2p
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
X-CM-Envelope: MS4wfAH4E2UPNaZCK8eyWZFPQellMc8jCRbiMOyedwtM82hdGfuS/P9QatAopEMKt5cFATrXFigVv6q/ksA3vNezl6/OVLFPbhzyxMjH3JxubVohJWtz6QCa
    Thr6zk6he9yLWYENicot8RO84ZJnlhmXEF6hCcrf0HIYguvxY7V0SmiJc7OXb9ZWHgzdyGzvvupvNVu09qpWaJs6tcfabPQgDZfts8ctRcUISxOEVcSKieA9
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=9wKpNP2GB4IA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=34C3MGnS9yvJAtfHq-UA:9 a=CjuIK1q_8ugA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeENQ2B (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:28:01 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:32782 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbeENQ2A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 12:28:00 -0400
Date: Mon, 14 May 2018 09:27:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/72] 4.16.9-stable review
Message-ID: <20180514162758.GE31622@roeck-us.net>
References: <20180514064823.033169170@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
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

On Mon, May 14, 2018 at 08:48:17AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.9 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:47:58 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 143 pass: 142 fail: 1
Failed builds: 
	m68k:allmodconfig
Qemu test results:
	total: 139 pass: 139 fail: 0

Building m68k:allmodconfig ... failed:

ERROR: "__udivdi3" [drivers/mtd/nand/nand.ko] undefined!
ERROR: "__divdi3" [drivers/mtd/nand/nand.ko] undefined!

The problem is caused by upstream commit 3057fcef3853 ("mtd: rawnand: Make
sure we wait tWB before polling the STATUS reg"). This is one of the "bug
for bug compatible with upstream" situations, meaning the upstream build
is broken as well.

Details are available at http://kerneltests.org/builders/.

Guenter
