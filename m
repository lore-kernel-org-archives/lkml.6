Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465145-1524502403-2-3148103982426449414
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
    1524502402; b=g0lYUFwwCCbN656G/99EtRCIoTpAoQ0hw4XZahXXyvITDLHnSs
    WR7WaFNGfREFkdf+90U86EaBdE3fe5ismsVqv58qiSknoMdT+V9M76kSlGKVCZZE
    ZwFuvjqrRoe3NPt1kXDpa7AzSjMiCNO/Rsa0DqEkNqIVDZh7k23BqTGQ5llmn6rI
    d3v/KiyvmhfsaYwbd7gQfyXM22EnYqIsOfA7m5fAYF4Nile3/8b5PZnKeaRgh9Gm
    APtDNot2/hV6YLYcI3K7ffMUfmMh0qcXazLI9v7fIVwKunmWNnq5qPen4DhYmXmR
    ZXP5dRTdC0RBIO0WG2zUOncYCKmBEgYptpFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524502402; bh=8I1FhLAAtw66egA+FMPYkuapRT9GC9
    4m6AVqTmnPX6c=; b=Z8A9lz/66jZH+lxZ7QpGmFQW7W2LSFka8Rzl8oGT5Incys
    dFJsjHCHDfYA6f5hsa6LXzQLMoCasbLDqDtJyJr31hRzxQmxYdjoTaPha/w3QalU
    KZtVx2vl+4e02OcaLWH2TETLhC9o20pGLS0Bf03yNPc7nZ5RSNuXbpl4tXcuIvz1
    fSCWuc2QbtNMEW+dQz847k4KwcNNIAD8yeO/jR0Yi4cZHk61w+4r5p0/naFy+77u
    f8Aklrbg/q4sGAlfcx01uoiSNSdYULG2GP50nLTh5H/+vGGnSLaj9nwnMbN9XKn3
    4OvD0m0BH+TnPZhEfuc95xRZkLJZCsD74eubPq2A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=FEWcqKIg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=FEWcqKIg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGKZGkVC4l8dHJzrQcqEG3eU6LaMxJCeYMgNzOorrT+o7VV7no5uF0eeGUhc3IwGY03iFI4e2FY1jx63W8SNMzPRrpbDV3jnc5R7dgnrDL8bubn0O1eh
    eV0brjsXMb6o2XIHUc9HZfRJl5a3ov27WGSvpADwEawy9mD2ByGbJ2VcF7vyyaKsefAMzAkl6ulVt4CrxPWQqnu7O+AvCsP2gTKGDq811HCGmHBc2VsfHa2l
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=BKw5nfpAfisA:10 a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8
    a=6Wf6Ckla_FyIXlXL3hIA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932092AbeDWQxI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 12:53:08 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:42703 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755434AbeDWQxF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 12:53:05 -0400
Date: Mon, 23 Apr 2018 09:53:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/97] 4.4.129-stable review
Message-ID: <20180423165303.GB12958@roeck-us.net>
References: <20180422135304.577223025@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
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

On Sun, Apr 22, 2018 at 03:52:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.129 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:52:47 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.128-98-ge41c167:

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
