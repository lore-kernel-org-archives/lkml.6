Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1017744-1523538931-2-11001569974877634072
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
    1523538930; b=YlqOvlnEmm9CTBx+za0jw3DPT3yuEiyyHZtsMh4RmPR66p7KfF
    x0Qil1dkKRHQK8oU1snxf4+xEkP6ny6bgjb9N55QAa6Kico/A6pmquljjPI7o5sk
    NvvpFXrj4R5Ll17iyYXoVWCBK/ljZaE3uZKiCDko7rt6MhsXObNXMYhrYyYRliGn
    GiqNPoI0POzb3nW2jeq2Rm9Ge8TARVsM7jipoGfmW9bd47AO4qAWTggXiV1084A5
    QjNR1HL4QKq2LFwdBMXm9fqRjDHkDVAAPmHg1VvkKxZNR7+pZbFQwgte/EMUTJye
    53l6KYT1q5wwzQLO3i0MO8zP3LE78LkI/B6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523538930;
    bh=+prdy4MRJXStZ9F2ztIg9hQftgWG2H4odYZpXGnwSNM=; b=WfQYDC1klVyH
    LIV6URFpH8sDjj70HYQTdGAoRbkDhKN162WGISM+rlXbMz6qMf6fMPtKF9N7eT4F
    wgTMVmD4GrNHILniN86IDTcWQxVcbLmMDXIW5TSRaQS31eKe156aEEDeHZz526MY
    MFwFTM1HCF82WL70VGGJTlc1miZqF+0yQSrF2jy7ZeCC95C6stXIkcdc9VTLfH6N
    AOLdau/yIWO0IfD0rnsWJBuTE+Bm11aWmOajEkEutahpiAeKVeDnqYHsfk4LzU5m
    NdN2JPA7tqiK/UUfl9D0+7FZxXNC8Mc+2hfcd6uTc3ezANH9rG6Sd3EVoUtPPjHD
    b9pdByGpTA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nE4N2CE/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QX0SvB3S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nE4N2CE/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QX0SvB3S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJasXsdoXNpNDl4cbb2NqMiDOxwmHpqkws98FO0vmHtoxWXGdMdVqlcC/plR4qWpOOz4pmjm15L4CzqxMZzTJdjOn50aOa045bBTGj3DqSOAQtOXl44I
    pLXEG5BQSeaNP9VLA3Pc0vDvHTxtWrQaUVU3OWeGxytnMqNj34u56djhQxC8U/A3LdWedEqmQoo+h4wtbEEDgcT09dFWg9ilGG8qq5RLY9aoxWvVD1osFXLW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=USzuPbOPRRIA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=8nm5TD73BZbFqXAjQKIA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753054AbeDLNPN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 09:15:13 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:45414 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbeDLNPL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 09:15:11 -0400
X-Google-Smtp-Source: AIpwx4+3NqKdW94KtqYFeAnH/7qXbQs+wHklPHTfhbxBhhDopO/9VRvE729b4kB3GhhX86e0WlTQAQ==
Subject: Re: [PATCH 3.18 000/121] 3.18.105-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180411183456.195010921@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cfd7bfd8-4051-5ce8-7a60-db14d36eb69d@roeck-us.net>
Date: Thu, 12 Apr 2018 06:15:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 11:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.105 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Apr 13 18:34:28 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
