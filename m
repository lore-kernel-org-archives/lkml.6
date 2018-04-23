Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465145-1524502587-2-6720014131694797351
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
    1524502586; b=k5te76xmQ+5ks18yAiop/lnUuEp1y9f9BPH86pra7U73loqVIn
    dVwC+ndeXPlYUD5cfOc+8OD5cm1k8B8cdEmjwiEhXWk+6pNBSR2JnoA+PT8/dUHd
    M9xEkHq0SFxERIXo+rqrpl632pvCMGgA5w8sQekK7NLYyj04lQgz8QNIW90sh2ii
    SdehanD/ZhQBmNaC68qGqt5AvXXB8TsvenjJNrW10WLb1d6oaSgV+owD1QsuBfk8
    k59l6qI4WQ696Dl5FGCqwtA2YxLa73YEjKjraP2oDufyo5qBOV0O+tfusJffsp6G
    +HbPX1Z/tY44F2+rqu8uVfZTfpSuyhunIc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524502586; bh=SpqxcuOu7K/lSXMaHr2kLu9hoMgORi
    5yCMmL9U5dftQ=; b=uUWFpLZJsuyVFlqv3x10J4vZqNB+V9fN6/2fug7ZoUHJtB
    BNLK7xdr9MwYq3mkmKhhMkC/PNwMLkpBxrwA+Pe1to9S4E8Gn6FBMV0m0tZMcOVU
    PbohcmhZg+UHskoIoHKLZoz3OknjNHXtwRIxxT3GcPwyo4UQBWG4E2O1cLXyqAfH
    1Ncq+NEARUtry1oUV68a6M0ymIIgpmAUn+oeiBL0L0VvpYzUJJsqEhg5ITx9aSro
    9GW5PjH9cFRQP5GXyfKtRX7PefoBB6iiInEQK4NzCGhrzaQLgBTAaxkUT44vLxDx
    YkoE1dE9gjJhfywS2KoeF+suB7pa/4zqGIKAoX/Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=YfX1J7et x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=YfX1J7et x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA3mitA41d+XQrObqfACC8MskFwiObJ5BCjMLJqkotbJQ4GBsgUrVn+bonyhPJ+ZXapmYnP54zFooD5Pwlojdl+lDFRDav7lnQMXVp63q47qaYgtGhfS
    3pMEjj9fmM/Qxig/8Vz2E+9hTOfOxeRsUObOzM/E0g7Xkaq0MTeINMT1fTT6yTsccOJEbV9ACZAeZKtcvVyCbxYPkZE9Rg78S/XOTeBUziW4tMkvg9V6Xo35
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=xRDiy12qv0EA:10 a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8
    a=vnMlfY5fncr3XgI0c6oA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbeDWQ4L (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 12:56:11 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:43666 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755624AbeDWQ4H (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 12:56:07 -0400
Date: Mon, 23 Apr 2018 09:56:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
Message-ID: <20180423165605.GE12958@roeck-us.net>
References: <20180422135104.278511750@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
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

On Sun, Apr 22, 2018 at 03:50:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.4 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.16.3-197-g405d1f8:

Build results:
	total: 143 pass: 143 fail: 0
Qemu test results:
	total: 139 pass: 139 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
