Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2569430-1526995747-2-12183756797462465999
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
    1526995747; b=brtQgelrB/lk3RgNQGr3E2zoM6kYvkijZnNd3iv4w05N9c4oRl
    5Qd76eF8bZfPrl/2fZh6y1I5Jj93VCcQVEjOhGLRAatwfDlQU37hdCpK3P+TkOqL
    /f0F0sBbDTMyKs5Y2aBg2uNOt4typ/e+S6qOiGzORK8rN31+PXM086q0HSNn9qty
    1+OBYRTF4rBz2swqWzCMuaHA6RpDJxvZW5t9Milsi1IyWePJC5EZbQmnrtBkv9K9
    ZNU6yIjSa+S/+sRbXUOvxyfxWhecnWMAlIzegpuvqN7+AF30/IWt+oOYTNsAcBuF
    M7u9vZzdup340zBJUAYFpXUWsOKTZRpxPGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526995747;
    bh=bS8UmxBxxA03L3fUtucsbErhkSLnoHzNn7f2CoXi+04=; b=XgjlEuq/QOU8
    fobwV1Kbb7hmlE8kVTwsANDBifEz1qBE/fSKI2ICHC3C3GqpLH69HYQGo9TNGDhG
    tYeAWLjI3HYzzrcI+DZ9KHXd2LwymNAhJB60nGae2h8l4vg9KH7o3RuViUMhFnsI
    ySJDNxuE27MpiIo07LIJL/FU96i50voiF9LqaDYTPqLXhPw72hk62yhWx/1oyAEw
    mY1QUe+CaYLbcRIZNHJda2I1gNhJpWlvY0PjE5ciimM1/zP3qKM75lEps69b9gRo
    0ADw3FYUBdIjocE2hgkCf+jMQpmCPfhTp4kDVbTIkkf2B4ypDLBW1wof2B7f86VK
    iphHNNZwVA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=pMBL9otu x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=NFz+0ZHJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=pMBL9otu x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=NFz+0ZHJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE3fo5mNsRx9LmEgJaZx+f+mP1gn9C80zyHePYwBO/EZejzFB11XR0vfNBnI7wecTl5W7te/rBoN4Bo0h37xOw6ZwzQrahh7om7ymNAZsIfwlqtaAYgo
    2vG5R3uROXTQWRF36MKQkRcxzCDNtkXjivi/Gu8cdVSGzEj/LlIY9UlSvSlpixMLuEH2uSLKLSMOl1xutA859fBN0x5wShgLtfBXKHMym66ndd+xha4mVFky
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=ptgvbpQxxUAA:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=HoCkWmlCV56ydFt2py0A:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeEVN27 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 09:28:59 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:34857 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVN2x (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 09:28:53 -0400
X-Google-Smtp-Source: AB8JxZqFPRxOoVLOsY309mliO97cxcqZ+RZjeLJI2Ymiz1fATuFWEsNm0P3xS00xUSl1pEYCRf1qOA==
Subject: Re: [PATCH 4.9 00/87] 4.9.102-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180521210420.222671977@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f8c236fa-710d-9a83-e645-d188006f31fb@roeck-us.net>
Date: Tue, 22 May 2018 06:28:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/21/2018 02:10 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.102 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue May 22 21:03:57 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
