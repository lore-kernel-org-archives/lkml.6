Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3119161-1527021918-2-13258748217299502399
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
    1527021918; b=JfB49TQXnRhJsXhU5yIXs/b2le3jDTFfGxuF29Di4RX5D2CIpa
    z/S5ESikgVsoLol19EjpvwZucratP8uEMeZweHjk63LYvd2vmcQMPiOxxi7p2Rhw
    9S1JJ4C46KBzMAeuOr4CHaGT1ircCV3id6xfcWpoQxrV4AZ/EOA536BFiKYRp0ud
    xTkbFXe8HHxpV2tXuQXPbOIqL9yhfTEIuIKvTlfbSbe5AKSEQHzNCrHqPcCwzJMA
    cB9L7YlFlZXKn1M8nsuTKOd15rqe0tibhXVQY1akvFKjE9D4kqIF+ir4xJY9y4DE
    6d3eQzSP9znAYRCZx1nE8ZfJjLHzfIEUghGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527021918;
    bh=lyHSQNzxhV1keXtSIxNvZtdghFuxBfJa6XUlHjUf7FA=; b=MAw1F/Sq2UwV
    cCG04DCPYkCK3jDMgeoSvGsT9b/L3Vvk0kGshGiWmmIWhETTSRPJQSUft+vnvXHC
    S5BA+IaGYpvGx4PdDMeBXDeEkA+QGij2O+DxpvGZsctnN6DSeOmrcuOihHlCTn1t
    uR0Vt00bvKrMXPikCpyWh2AwOXxPbVknL16+qZbC3SL8RDe8ciJ07iPJnXX0AeYm
    PfMIdUAsMAVtGDHWw9IVo2sVh7mnduB5Qr59vdzV1FZIWpJQK69zhUCsH96uot8p
    Qj6wiJ5dQY+rUzE75kuLOarWuoxMGXnN3e9LXj+LLIKH6W8FCnmP9xuq6cHGHh2x
    ANcXH6TRPw==
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
X-CM-Envelope: MS4wfEex49Mu5SIIV9CZinT2CVm67wBdpK1b3DvB+S/u2uTQXvWjMUdYNe+8p8n8eTVLu4Mt6i0mVTK16NBGqSzgtEA6yIy47XqX9s/2exsThctrg0mLK8YX
    DfmeyFJ8y2fwu11xmXwo7oI0L/oX2c1ubyXvNn82t2kyZ7cpb+aJiHaFhVuaYc3Rn+lTqaFZxtrhevNBuPh2N8K6zBWRDP2ZilFLLjeeVR26hGAL+Oeh04U/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=UIbBetWhaY0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeEVUpP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:45:15 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:48524 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbeEVUpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 16:45:15 -0400
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180521210503.823249477@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <7b374b54-7cba-8575-92ad-cfdb8a06b509@kernel.org>
Date: Tue, 22 May 2018 14:45:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/21/2018 03:10 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.11 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue May 22 21:04:14 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.11-rc1.gz
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
