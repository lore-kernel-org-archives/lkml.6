Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2002674-1524925481-2-10165954160163871303
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
    1524925480; b=QRpbpuIbUmV3wn+vTfYC6s3visn30TOMU4MGh/wCYWAnxnRnBw
    UHwZFd8ZKa0dICJQ6BBhDoFLFz61gN1YP0sgK+eeI1nzZt4AROD1MbmUxXPENW+l
    XvI+8q05GBKMjJdWnIUiLAdEdGPuWe6yry9qfvIbNRntCQ2olYtWhTPHpgrSF5Hc
    lx4x2FdadAN/ddudI7pjGbs1Idd79FU1Gqc5i1rp1GMJip9e/pHpllfJQ35xAjrU
    NkremOkny2w9zUGiC21WnngY3uAsTSnSrfSAR4GnVAkmI8UCxN4l9O/LAQkTdsmi
    Psx+rxXcauqOoQS+J49AIpm6YjgQFMSvqUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524925480;
    bh=ce8JviP6FuD62FvcOZkK6MLnzAx5dBKFE0Uw80WWRkY=; b=Hg/d9DEq0gs2
    qUw2tVyKT47Uu7FwKcVrF9T5+NdDK2uJUFHHhN0KATMRMocN6Au+bn+VNUJZSxnw
    NrgozQEGbmERWY/1/pe8rX3peCGBDiaOiNlLQSQZfTqqbCLRfGDDdky6Xv8vuMzn
    o8e5y1zZADC+D/i/0qzIZf8dhOJ24keo9Rm1w2W46bCWs8nXTWeZ+hXQVXv8Ec4y
    Eu/NIhOcdBnW+LBSYBLXHRm3l/JCZzuKEWMDiaNaK8cB8xSpGSFT91vSBJ8uszXT
    XKsKoGrTFqA20vbUxSmU/XGqD7bfkjVfRj026C1zT2QQydZQgv2//MUMrW1bvaYH
    KNMgIjx9zQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GFd1B9cG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rxM6LT5J;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GFd1B9cG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rxM6LT5J;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCyhsmY0oqw3RmVeNKiiP+PrG2zwrzBf5OC3F3TLKovEQEIkwcZU04oNkcG8vsZqZFuxkmGJ5bu6H7mAjDOpedtBJeR2IjliJQwOCqC3Lrvv8gQzCQDA
    86h/9h3ZRARhx37tcBHD5zedcr90rta8C8FJ6UpDoUTpzj1oRQzY/Sgjmw9aLRh8JuYErkImdlPsy278DKNeldam6tcshQYWktWEDsKd4gncoW8w7ogoW/am
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=28HZq395EAYA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=8nm5TD73BZbFqXAjQKIA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeD1OYh (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 10:24:37 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32834 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeD1OYg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Apr 2018 10:24:36 -0400
X-Google-Smtp-Source: AB8JxZpBOznnJjIdhQR0rqQRCrfwb7epgiHjI4H7555pC+nHXPRNtLO37VPFH63TqWVrESH0HyVQ3Q==
Subject: Re: [PATCH 3.18 00/24] 3.18.107-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180427135631.584839868@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1915f577-2049-19bd-0078-10b233561114@roeck-us.net>
Date: Sat, 28 Apr 2018 07:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 06:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.107 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:56:20 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
