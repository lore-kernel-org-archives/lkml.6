Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1170116-1517671867-2-14146095793100469780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517671867; b=t7XVpa2UJmR2RUWi94ye1EOySKGg/IjeXD8D/qq4MmRJaNI
    ezVu1M8yZ87idz09NyD07/na3tJeOTwXW1CqoyubYZI054vD3hTPrSHQVFcWaqP7
    4nTZ8HB1FlV8B7Lt/n7LyNJdVgeC+aKIOEif9BbYm2oLn3wYO1mMdFfXLNwz5jyO
    pxEJhjRhT1U1XCO4bcGvxn3icDiEZRD+0ADb+ZwAa9V5blaYFQAY661hi1IAvtgA
    23CVwKLSFOCBD3KY9Gc8p+IjUY4ZLk4sNMV0SLzvIVGIn1B26/A8aGedoUyLAkyr
    n2mXfGOVdDcHBcdRGeWvMRP6xl1WGafFsv3jWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517671867; bh=fx3WS+R5P/SDMZTonOLmgq4kBYn5aozZoNquIAL9WA0=; b=W
    3AX/bpA6zm5sAoLDgdxYjqXBCVaSi+wh38wPO7SzXqaeHC/eDyCy/iIX765xyW7x
    tPbAWtfdvRzDHqAOKkn0kWPlInOP7nXVpyz8lSkwTzyYzXwGSmqMTWnSKOAxCN1T
    JqOMnAJWMqv8IKicFtLWcJZJqjodofVbjaaE4p0FoaqYZJyyuOFY+lgkMjt6sLN9
    SwVD8r5B4hViB8Gjl2Fei4U5Ar8KujijzP0NcGXlJcoOEomTjNgQBtd6xq1pfLAL
    0hKzKnB9c6cFxS5IS0xhQV4nA6NcvlEPUZUDfcjQr42meYLf/cuquvLMADGQJZCC
    YoGitWdNMlvN9VwHjhNPw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Pc1hGIfx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VOjkGKtR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Pc1hGIfx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VOjkGKtR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeBCPbG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 10:31:06 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35374 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeBCPbF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 10:31:05 -0500
X-Google-Smtp-Source: AH8x226pBuauDPuJBtdYvhOAzN4i1pNHouFKD4qxctUCLJnq4sjEQXm954sE2ab8NQxjJamSFGljFQ==
Subject: Re: [PATCH 4.14 000/156] 4.14.17-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180202140840.242829545@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <06924213-3e28-d028-6a79-7cc67d4cf9b4@roeck-us.net>
Date: Sat, 3 Feb 2018 07:31:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/2018 08:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.17 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:42 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
