Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474708-1526335362-2-11586974044930552201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526335361; b=jlD/DgMkRS6QZ7m8LGnu7mVgpE9yFO1zJghf9TNhmcaWYs34+I
    bKE5cn46huv/s7BC0y15ddWNV32iI7WlofqEF649CHiQHQhwyX64N4NUKsvBbcoI
    Hb+x0nMjbtQBfVx3Hl02NVEkZ9XUqJzswWwe8IKkpNDb0XCrGC3neOePT+C21Rzc
    IsvvzfdbcM5zB0+nlU+TEpCjmrnw5blS+d2cc0YsjrfpJGWOGWxCbElIIw7zHDbk
    aVjelVAOW7rHH57Ef9q1hgCKnPriXyBVtWqXg0Rz0abxLnjmwHYGkx8D5S/XOBJp
    uwpWQjDcd0lsmyfqPR0c8V0tDBZFjpDlsA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526335361;
    bh=TH++E4bTOmzmmcwPrubrs0uzRQXCCQ1Eqs6fiKE6dRs=; b=PFbj6bdaOUbA
    FGFaqBCyZeuelPR4fd/MbPg3Tvi5DkKDEjcfpRBvu8cpw1jHfvzv6Ekc15+/mGB7
    n5Sc4lpVus6JrgkxsRxs26rYKJ525I/X7TVKhWNAJmHXHkzdipR3VzoJEeyROpm5
    cI91flQipO7JlL0KwRPr37i8eO5pK//CIcx83LYwWlSGouGRARfzh71skmbhLjVb
    jNDvHB9TkWqud63ugq8eT7UrAzBt+j96jdMsPUESa4J+VwEwPGkYHjVZjUvXQ6D4
    /kKDg1KUta7lPsk5zh2idxdBwNk352/JV3zaJs6BQGXRgnsKvTgIWOVAKEPOx2bt
    qQrHeexfpw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHJ5GNdBZRJbXK6Z9HQrI7BEIL97Ifn/tcusLFIImqv4zWzRzFw386dCAggiLjaASorKQ15flbY5uULi/zJpFcRtTrjL6VVaoqzFaEeOSuW5HkqWNx8m
    j2mh4XGqzBoNEM/unb7n2NRpS+oRQHmR6aYH7+eJM3rAPRbk/JzUD3KNzdQ3b5WA79n6nEmXdhci1cytugQBj3HjoRTlTAb/upCePFoy3LHk40087q3kMeFZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=UNgQRUVOudEA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeENWCj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 18:02:39 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38079 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeENWCi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 18:02:38 -0400
Subject: Re: [PATCH 4.14 00/62] 4.14.41-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180514064816.436958006@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <0061e2c1-3df8-3c6a-aa35-ed11a904285c@kernel.org>
Date: Mon, 14 May 2018 16:02:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 12:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.41 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:47:52 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.41-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
