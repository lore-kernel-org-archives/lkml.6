Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2289356-1527183228-2-11928815807542992799
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
    1527183227; b=BsPDxEVZC6rKkPdxOGaMvj/gE0c1B4dwQUr8g7z69URK0+rWcZ
    bS+oRxOoAUR54FytExKMRETPcd18jmHJ0j3VZMo9fodpYLPd4XNvE9quZDt8LPan
    92QsiWijS1Jx/vOysN967TDtaYO26fLqsna0/WzxvQAz1rfetMVu69t3Gwjx6ERh
    4t8hjB2xlf7Rkr3lIxZMahpr1qoxxVY+61UimWcKZHm/gN6cIqZDy/qh12Sui/J3
    cV/tu4dcVb0+nrMf8vMDMLDcyhG/tRrEyEV9PoAlRjbcsmVWB2uChY6J9ENLjRTN
    t8H1gHrpDPnVE7+rCR8MJTVF1Momd7DVwntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527183227; bh=XET7qxSoyV2XStWzKU77GUSMYo1fxz
    HWK68bZ+w3mTA=; b=RkSqudk/XK2kbL0FQI31sBExum2gW4HpYccKDjO1StEczN
    JL5xjH3CfVwzwFCnTEJIBX2yZVtxCnvpk7bZAaDbdNYpd1mmh16cMvROqKGzmqf9
    VQ9zw+acgzyUSk0sLKr02KQQ3u1xORW6xeYUqbUr7z3iWotvXVWKnaHr7S8eqz6R
    75R98L+WUfgfj+1/cuROwM+muq7iSRgl9Fm1ry8bQaBiTUmIQdFrtxS1At+iCRsA
    L3pIvLb+peS4riou3Bg9ljXz37126bjuu7fMRsv0i+ldksWQ7bbM/ylzA4cgWYhI
    nktd4pWOqZ5sIurpPjohj2ayL5qAZ6l6FzwC0uFw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=eZ+GEG/a
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
      header.d=roeck-us.net header.i=@roeck-us.net header.b=eZ+GEG/a
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
X-CM-Envelope: MS4wfOFdnmXqb4eI6svgz9kBkwqXxpemXznBm8+AHQNN8OrAVPg/y8OOVe9ydYojLPPFS4ztWjKm/Twh5HMYM3Tg76Mt+hrbKHox7F98dB6vcSh0hsKdtott
    6SyFk3w26cUTfLJSDlYcohksqgsB/3MV8OBifl8OVT20nUi43bmAATLxd2Xc337fx1WZGBPmauMcCXCdn/1G9JBbYs1P3t8ovw7OeBMX/EbShXFF4wZYX5HU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=6xLPOHPkGDIA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=QS_D01sM24LactPzg84A:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967069AbeEXRdp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 13:33:45 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50248 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966288AbeEXRdp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 13:33:45 -0400
Date: Thu, 24 May 2018 10:33:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/165] 4.14.44-stable review
Message-ID: <20180524173343.GD11172@roeck-us.net>
References: <20180524093621.979359379@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
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

On Thu, May 24, 2018 at 11:36:46AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.44 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:35:46 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.43-165-g04c5715:

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
