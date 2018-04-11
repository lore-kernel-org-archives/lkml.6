Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2881586-1523467628-2-15141677000786459641
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
    1523467628; b=QEPUgnXsxwR49J5fCkIsMEDS5saB+Lex1hhlLPNYdjFIYX029/
    PR5y2V8E/TzjGGGt/B26Ernbgq5cgOApFqRT1BJIKPgwDKdRz0lsxwgFwUV/nQl6
    JmF+2wjc+9shdJH81o2lQ1C+BuAqkVgXFhHlwD+s0+97Vg8LG4uZou7kACr6ug93
    mpElqkE7SuJTOIH6reiWOBXRRnUQOQRFiq7t4ljjZ4NsiQDBxXyle5fCm/EniTin
    EMvalSWMenag7sH12E4U5XQ6IItzMBCmHFyuEhMZlTvVw6eemePo3kM2/FQlpG+U
    4ZvbOrkIrF225B4kkuk1yVhcZmcU1w0KMDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523467628; bh=m/eWz+Tyy1483bc/E/pGvajHIR8j8o
    yEmzKgjUiDnDA=; b=Vo5KfFN1h8uflJApqoSw7laaOmSu27TbSzM/xlvpTDc68Y
    fVvMbTY2Sw34pizroITDUk45md9wOIjvLgiNMnUdgvpjCEer4PcORAs8TTsAJTxu
    pPgVGUWb8+Rnu9a+2fNjS7/b59LW2bvMmmzzcShqYNCHIGc2cNsx0mguViOLeV3V
    BugZmV/jygfMmvj5IrqnsmVj+QRzH9BGAcHXMrFTjHxKxCKDT8OLhve0YtjlNMXd
    daAqqt2QvVkwEYTn360/Uv6JnqPme08o0XN83DZgsfSYifj6a2HTNZ20b3GUIiGT
    egcGX5TJ4Qu+Na7rjZ5vXTkgpsQCQ3QEFLwYCxzg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FUmx4pr9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j2EVCnry;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FUmx4pr9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j2EVCnry;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI/Gy5Y+NUQy47mkApCKOW+iaAU3vAke46VypNkkb0cgwcYlnaH/GFro/RxvsuQBm2tcsJyDuAfn5HCoV73AfgD5Tg3J3EYjnhuLQZwFCMvlFe9+q071
    olOzmBuvfq6K8I6jTUWspKt3zvzBWZ9N89n8y/9nulpv/DWNNqoTXrB+svcHTC7ZAF68703056y4nm7TtjaBXtbqgdePlwOA+gRZZY8nIv+y10KQXSBqH6LU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=KEt-YquFfz8A:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=t_Pz6wbiR3skUA0DZMoA:9 a=CjuIK1q_8ugA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeDKR0y (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 13:26:54 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:37578 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeDKR0w (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 13:26:52 -0400
X-Google-Smtp-Source: AIpwx48jRqxxdIbzF8WhmqjrlrM0cjFodTTAb42oFbgvcJEpRq1lc6I5vyKgiAmcns1mHHBZp/QEKA==
Date: Wed, 11 Apr 2018 10:26:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/168] 4.15.17-stable review
Message-ID: <20180411172650.GB27459@roeck-us.net>
References: <20180410212800.144079021@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 12:22:22AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.17 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Apr 12 21:27:22 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
