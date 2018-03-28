Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2466908-1522245849-2-1185422915217004149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522245848; b=rZWccXvVsZdYOTD2U9ndMsGJTzbZPjgQGaquw0sLNxoHp1+
    yBIaLdsfSERTHV61OjWPYCNc7vqUC/l4AbTJmXJTtbkCMtE0DXH0+6fd0KWh7TIr
    xbWgpYKUrQh5uieIv52DgDsu/W9kY5oJhqYd3uAzXLRvYvH4toxAyf6LXH+uORFu
    LSIHQOzX6fN2t/nTvUwuALONY9nyNbGKbsKfHrhJI785PrkxfYeFwMI5WLFNUpn1
    xmQMC244JtzAv193f2fuQj2tcdFA+CPUxAwew1FVi/Jr/NaMzpqqIqSw6ZrG27Lu
    WqczfCPgnGAhdkT2KGmX/nfK/+0B9PxrzlSXjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522245848; bh=P/qNIyjSw0567WBpb82m5CLju3bfDojMkEWPQoylsXY=; b=Z
    99YRWLD46eddKoyx0/2c5YODuAYdhUOR+2xCunRazleRrm9eOboRZ1GbPTlfCtNb
    VNHSdpBKkSOnAKtOixhD0fu2x+14S72iPt5S9Hhp8gOOcMjLEU/y5mUwZt0wkuHS
    m6ZhlCBra5KXYhOWJdoK1Sgxs6513v2Ih9JlRkF9zG7sUf9TztgmxLhtEC1Eqbtu
    FHWmBAtKcLPWKVk9nQXdLBMS1VQYtgNiJUnXENJ1FIisxfho04jFPrZV3mazpnkI
    j5KgWrHterAxRJmD1U2s1niSAnezgeC0mS2jDvcPawm+p7vKgaG0F+EO0HJubPMT
    Fs3/bjaKLqlSVmyjKR/lg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=i0hgnhiJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZvBORmcD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=i0hgnhiJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZvBORmcD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL3Xr/kSIjBY9nC1TgTNuH6UQin6h+WQw3eLPtrIt1Y0FJxGmER0T7vrV939jg3l+SqvXI+22B5QZO7/TfTD4de6fDvbd6bko9JLjdo6xWuWktbY1xff
    sxZtxlv8ha1VhNwyy/2SGDWDJYPorcvzLYkd8hlnqAkNRiZbyqq4OTQQa/Zw4nAngY333XpiIYqDilhWXk5VVtEeave0lMtwRpKjIC+M0fdpSiQ3t189873B
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=ONKqiAgnDjwA:10
    a=v2DPQv5-lfwA:10 a=wSFAT0bzRL9SllPayaAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeC1OEF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 10:04:05 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:46544 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbeC1OEE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 10:04:04 -0400
X-Google-Smtp-Source: AIpwx48Qy7vsU8Fbqw8nrCWAD1PlX4DFulO77pwRUKKAvx1A3aTdcHn0VKeFBkgwOseyDzbiirC34Q==
Subject: Re: [PATCH 4.9 00/67] 4.9.91-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180327162726.702411083@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d00e9129-8dca-4ab7-0aee-8a543d562e81@roeck-us.net>
Date: Wed, 28 Mar 2018 07:04:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/27/2018 09:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.91 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 29 16:27:08 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Guenter
