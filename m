Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1017744-1523538967-2-5387638446396952046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523538967; b=nseAktVgqPLs2zhn9eyqiO4uaKdRCDo84s3vie1IfU7ZF8B81r
    xnscRkpPQOcSZxxGf/eljZL+9q4MbwK8MbjD5XIFnUXiXUZAaStchTrXp6vKn1JL
    zhoGqBj0nM3vjvEEHvonmuN3Wmv5jJdOgd4e7VzSExNSxGou4qpenvvpFbvqMyg/
    rwC7KufG7EhY44Y24OMDR2EfByMdke5oOS3glgYmnh4tk0eOZE3t/vABNnlArnzy
    qDjfUy9AGsAGNhcdHOfua7VMxcY2t2J5KxsAGFvFAGtYbW1pge6gHJCD8hFn7cvh
    GSohNAVOIHknzzxA9NYHv8daf1WW1a2kGPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523538967;
    bh=HVveTVjbzMGtwJgbFU45ZjG1X6XUBUfBsbsa2VFElaY=; b=DcN+X72qG46B
    h5mn/ZcOBsrg5A0XT53oNvtowBfgh8NxA24Kay9NheGgluwx6sM/RMvbNoJ1JFpd
    s699C+iuLfNqKGzAq0HF83A6F8TITqFtucdWgWZj/UpFQxAkl4wp9F8HJ+fzBCc3
    ytxohJPpQYX1NuF+9PHgoO+s8B25tn3qB0OY1xQ1h3sPc3F/yD8xxI7tAw8pFpQJ
    ogeJMB712H/NdiX88aJkQFPa5eDvPWeVXB2jPGvHH4uoNC9txiAHAGElDqwcDioq
    X+AvekBhzh5+inwrDNbFEoI1roqe5CWAntrByqB8GCmwErpwP36W9Ks5lvfBeVtN
    GIfGAZlkfg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HeBo/Pzv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S72vOSzT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HeBo/Pzv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S72vOSzT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDtu3BJOpAp9T+2HxerKxLxaD28yYNP3jJtmJMCTh1VzCjbaHsem5VmvTKo15FNzQrOfrneNGDxow0BJ+489zdLtzfumAgR+Mx4XIdj2UnfR5VH/Kuiq
    yUjL9doZkmZTWaRhnVYw2A5sg40oOniTR7zqNziZtJdpc0vv9IEFj9XWuXm/ZKRqp7P2yT/8NO1yZfHHj9de2kLkmdPNFP8Zi/cLnQ/fK0AHpImukVb89kLo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=vPLX6U1NJuQA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=wSFAT0bzRL9SllPayaAA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeDLNQF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 09:16:05 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42124 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeDLNQE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 09:16:04 -0400
X-Google-Smtp-Source: AIpwx48c8pGpqS1Gx8PGPZuE0hy2vDSROiu38Z/tCgCsIsDblq7SBSZOXXWHWEmmLXMNCIY72n1LfQ==
Subject: Re: [PATCH 4.4 000/190] 4.4.128-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180411183550.114495991@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6abf059c-701d-de7a-2f02-3eec6c4a9117@roeck-us.net>
Date: Thu, 12 Apr 2018 06:16:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 11:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.128 release.
> There are 190 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Apr 13 18:34:54 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
