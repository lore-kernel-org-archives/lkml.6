Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133472-1524681403-2-10465456341099443716
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524681402; b=glw+DvaowkAcArtCmaO7WyQ8svX1GLaw2olI9afh7LapMdWAEa
    yy6QZ8VeyxhM0KKqZU2/6vv/2KlHNWdmtJ6C/GZ/5fd+QibzFUAlCW2hIt8tkPGj
    qFUGAXGF+E3UVgRDmCZaO0TN0BoeN3UAfrbYPsKkNVxOrOpKnKlPiwpmmOFlinak
    UdNoHziRm0RD/0RnD6qN0yhrnSB1nixGWrf7xwIFC4cZzVd/J5QvNqDo4uGPJmp3
    nh6Njy2G/qThFD1vYfWR+3EoEsB3j4zUoDFUCW9uRwl99ayzt/KWi2mrwnxS7s2q
    8wHHEHcayi9BgYfmOcwVYqGC+oxOEXWvBAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524681402;
    bh=gOenu3Qu6YzsrKtRkLlyGx6JtccXI//OG5QGjEl1sG0=; b=BUJf0sLean2F
    2gmbIiJg/dOVEcviYM0urcrRm8ogn56HRC+4Qt1xcbQG9UIb3Zqd4M0/lqh+TyyV
    eF19CvCsFaAVM4PDdx2JEjeWz6QqLoAUAv5AxzEEYxXQna4QKrI5YjhRohEZCNXp
    gdDyNkT1++ETzBLdJmmpz3Q4bNAvF1B7DG2o4u+J+9TcAjG5HKqxsKH8uX2KC8HZ
    c43SQA8WMdVj/D7oADd7Y8S1J7GvMIjfwlXPvfzIM3wsGf9liQnuijbG0AKjM4IP
    2XjaEPKMG3n6nejgCr/Icg9t/zb4MIYEPvPoGu0QJkuXWjBvub15C54Mo9W6gCzU
    tXTkFZ/Ujg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPNnUCIw4mQIVTdpUaYQprh1scZyhb1HDQGhzJhImhFgt5DrDAHLBDIWnkS3ZRs6fZcf6pP8GtnsPt/DBowrwpLZckMGRrbMKZuugi69oT5zG6huA6Y3
    9Ctjac/MqvXH2imSITZAhjgDiV6qFQiYYblGSeG5JbH9Dzx6lYkOhBs8nZoQv80aC9mjeWxfi4ALNhutB7GhxsdqoEq0Et/QesiUCQbg4ClzmytIB37nfBoJ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=hoiGki7t42oA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756015AbeDYSg1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 14:36:27 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:42693 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756389AbeDYSgX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 14:36:23 -0400
Subject: Re: [PATCH 4.16 00/26] 4.16.5-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180425103314.842517924@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <dff2603d-7a14-34ac-63d9-d3b1751ec6c3@kernel.org>
Date: Wed, 25 Apr 2018 12:36:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/25/2018 04:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.5 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Apr 27 10:33:04 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
