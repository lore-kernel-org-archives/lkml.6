Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474721-1526335679-2-10774213091716636203
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
    1526335678; b=Lis+i6MT0Irl2Twx417R8tw+3A72r+FrI1xphNc9kF57aIbDsx
    cGbn4Pp1v7eVjytuYzVRmqPPW/1zrlNgrjBw7+6v7xmPC23pyM+jaX+v9oZrZc3p
    B3dTguF5A9P5aR/0Hk+fZY46LtXQkIM3PkUbyvnNA4AQaSHUpUuNaLhbMqCIdFCT
    RPdQdNK/JlArWhvDC0LN+CxGNWMfLwSBmwx1i5JKxXYYyG5g3D1sgaMUUgYIR4Lx
    pBb4cKtv/40iNm5iOG/8MgncLqWEE6YIddeIgjipMcCtxG7wmx0NtclUQwxsOItH
    wVwQutbt+2buZT59ujQWdXnv9wYNYi+O2cxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526335678;
    bh=0IVHeXt3FarxTkrTK443p7C8BfSRsNApRW0pUYRw7qE=; b=nBFn4PNFiFrS
    F+9T/a1DgCNLglPcfbGWweatYuMrCErHDqa0Y4S3aZRxbM3lnV6DCfWwNOB6U/K9
    oXI0DtBsQ/9i1jl4RB2NLTgPshxb3kU8PBdIep5yQB2mRhOK+13B0J2GqjX0VIZV
    Q/JtMqO5kodnAW6LIEPuLVb8sF363cCqBaPXBaNx99TJ1C5wWSRspOuE06B+J7GF
    J6Oe2ZS7pC0uAB9sezOqUXmfwdIUeLzd8EVwFuhfQCu/oMJdNbnFtHcQ5m0AfSQT
    4hTsHntsj0/jCIvAOewxWioaEYM0H2yTXvCpXttAYyiS4bMr4LKYQd1YyK85o6Ue
    PIfCJ95vcA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfJGVSd7WFVkh32tAwgcGfMzndLXsF8J6Klq2RaTnj0tc9I68JsXz1v8LsCO9IKju+9Em+tLxb8DbYN7RiOBURrx9/XXaw0oSrngLvx7AJPV4/RuGeBTW
    ncWaJA1ZlLQvdpRJULV5mn77aYF2YuJk5rNSAWJ0wyYrg/Xb83Xp1Ot//a2bLzwXseFvyMDz7+k5Nd3n5GhB81Cn++ilfh3X3MLBuszhynnVqkBjA6fhs/yE
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=0U73VwB4dlIA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeENWHz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 18:07:55 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:44901 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeENWHz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 18:07:55 -0400
Subject: Re: [PATCH 3.18 00/23] 3.18.109-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180514064704.046463679@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <c0b05c2d-f22d-1572-1172-4de6a6764b7c@kernel.org>
Date: Mon, 14 May 2018 16:07:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 12:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.109 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:46:49 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.109-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
