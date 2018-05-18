Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3958489-1526650205-2-11277821268445682335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526650205; b=MfB22XRi9hWf/ZGPr8iixqwKneecV/23LjVfl1/xLjNT7aCnsz
    JSeetztAFEeuQhMO47QTqOhJQzPKlMn4f1OwgKDR3uSzV/DRvMVZ4ZQA/dLekmeU
    kKoU5tA/lzXsDY++hx4G6MS76Huw0gB5IaVGRkAYYy0B8fslAhpG7jeVw8CYmNbc
    LzhO6DrzXuPvge6BB3O+xlHI1KuG/+wO/geJCbSGz1KlP8zLtuyajm50qv7zMuE2
    dAlfw6g+I9spC/sXHK+rYn5Qgv4Mc0LbFjZpsXjMfJ3juiWC0s/8jb0uq6ufWSA+
    rb7moSZ7WMKCcRZCbnhjOXgHkr1AuJBtgvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526650205;
    bh=GLP63es6ZvzGu33zsOdiWbJTewbbEcsawco9sLEHfxE=; b=XxckpItarS40
    OGgypKlUOP2pSWkOTOFlFheSavNvFohhZ+GlMT9b8s9J8S+s6FKhhW3u8q/Tm7Ch
    AI52IOkB+wDXOv9EvM9R7FeZCBDGZWueDuCKYRFiJhHUS2M7pZ5K9BrVeI1v83Qw
    ZnBHK7KlPSLZ8LNPjX8fBa+zS+e2IiRn1QbFZERktNFBGYYoFD20JQWrJzwgbkaE
    sAMFmtpArCwo5vChQqQIHdZyd6xhdcu1C10hirKpCEA+1jCssna2df70PngKbypA
    DRx1APNAWhJvFb2xntRW9hsC9RnKKfftx8i8ErtRDYFr116A8NB7vwqLOF+4qnuW
    dJnIIDFQ3A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=u43wXU1M x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=cmOPryV5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=u43wXU1M x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=cmOPryV5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMr01CIvDFHjmNSWXYhA6pKIhF3r1m2U7ivInzSZvuUll3CT+UjUHxbJ4tWrExWTu5+Mj5JguxnHLqdYhVFQeqe3H8yb/73qqmNLwdjgyRF18WhcgcX2
    yyoGHG4Ql0mFodVK88XQuzYEY0Oql9X7rn0r2kU0sCXFgred/OdeapvWrdR0Uopd2cqsOyYJt7c+/4pn8E73hw57v2bAHSddniGTgpCKOWI6j2q1F/JQDZaX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=cED_tJPvky8A:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=C8WneFEsvtWr4Du1M7oA:9 a=QEXdDO2ut3YA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeERNaA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 09:30:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36053 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeERNaA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 09:30:00 -0400
X-Google-Smtp-Source: AB8JxZpibKSO2onvKKa5KqzumZsPYaybvsh9WiMNpCI7FbZ4U/TVLzvps1TssL9+wmDn7C1ySPKBQw==
Subject: Re: [PATCH 4.16 00/55] 4.16.10-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180518081457.428920292@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <41f4df0b-53b6-cf63-2d01-bae3c9b45c07@roeck-us.net>
Date: Fri, 18 May 2018 06:29:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 01:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.10 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun May 20 08:14:42 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.16.9-56-gde63ee0:

Build results:
	total: 143 pass: 142 fail: 1
Failed builds:
	xtensa:allmodconfig
Qemu test results:
	total: 139 pass: 139 fail: 0

Build failure:

include/linux/mlx5/driver.h: In function ‘mlx5_get_vector_affinity_hint’:
include/linux/mlx5/driver.h:1284:13: error: ‘struct irq_desc’ has no member named ‘affinity_hint’

The build failure is inherited from mainline with 'net/mlx5: Fix
mlx5_get_vector_affinity function' and affects all non-SMP builds with that
driver enabled. Still not fixed in mainline.

Details are available at http://kerneltests.org/builders/.

Guenter
