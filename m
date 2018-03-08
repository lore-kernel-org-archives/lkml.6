Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988500-1520516162-2-7964052813540617756
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520516161; b=Jg4F///0EHvBmmU5C9lrHt2uetzfYkV6aD0l/N2+9StvyG/
    Y6wybe6pwnzAZNycxnuKNdr3AsYCHw7/EVLL41mx3NuYEozGz74clmouUus6dB3c
    PPbMeAuvnGt1nxkcQMJuFuNNuc7ek6jLcNXMFPvEX3O3aGhDYFt7lxDzqd2HnjXu
    LqiRO8rEvgY9+vUucA+o5Xr+lSKSkOMmK2y7/dzF7uKOzyqvSPGmR29vPev6MdMi
    XDiJinsJb39P/XrPxSS/CZ+X+oFxm94EcDian3Px+jqbTmskLfkGfQ2fxDmnBykw
    /1+hl4r7TuDytG6n5wo/vhiwDPwHj9fDx0Xkcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520516161; bh=WK+aYc04UbLM7EOYdKBzUGcAupHe1OIKC2mBmmRnwlM=; b=f
    aLmjdfiVY1Zz4v49xR51PGjPoL6GoUa1Rvl4FjqfoYu/s6/PWIckXIvun+lTlaZo
    w/JewY2tO2hEgUHDZ/VfBb3hYmzN/C3Abfw3c2BxjB/jTMRZvS4zleJ0yNjGjfqh
    5TUKPzsCSbNcN0E3CeWE9K6ZAhG0TcAWBsov+gB4GMWrwRwII58flaJe0jW4DoZz
    J+43fpwWuILU4mk6q9WEui68n7SqwiSffg3DafwLQrOoKomBLTt/eSL9CgAfkuR2
    QN7F3nJ+RlSvC1TXrcZcqymfMnfKbvXYwISL0t27DIIgF24lN1RS3njChwiAroJ9
    t7V/CHrc0ZsQcZqJZu76w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755812AbeCHNf6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 08:35:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755256AbeCHNf5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 08:35:57 -0500
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc: Alex Shi <alex.shi@linaro.org>, sre@kernel.org,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180308122715.GB21514@amd> <20180308132139.apabmgw4magrp3d7@pali>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <07d4709b-df73-0107-ce0f-5af55e34913e@arm.com>
Date: Thu, 8 Mar 2018 13:35:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308132139.apabmgw4magrp3d7@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08/03/18 13:21, Pali Rohár wrote:
> On Thursday 08 March 2018 13:27:15 Pavel Machek wrote:
>> Hi!
>>
>>> Resent without non-upstream patches.
>>>
>>> This backport patchset fixed the spectre issue, it's original branch:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
>>> A few dependency or fixingpatches are also picked up, if they are necessary
>>>  and no functional changes.
>>>
>>> No bug found from kernelci.org and lkft testing. It also could be gotten from:
>>>
>>> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only
>>>
>>> Comments are appreciated!
>>
>> Not entirely related to this patched, but... I have few older ARM
>> boards here, and Nokia N9000 I really care about.
>>
>> AFAICT Meltdown is arm64 only?
> 
> IIRC ARMv7 is not affected by meltdown.
> 
>> Spectre affects the older boards, too, right? Was there any work done
>> on that? cpuinfo says "ARMv7" for N900.
> 
> I remember that I saw some spectre patches for ARMv7 on LKML.
> 
> In general for ARMv7 it is problematic as mitigation needs to change IBE

Not quite. IBE is part of ACTLR, which is an implementation defined
register, so generalizing this statement to "ARMv7" is plain wrong. Case
in point: A9, A12/A17 do not need any bit to be set. A8 needs IBE to
allow BPIALL to work, A15 needs it for ICIALLUI to perform a BP
invalidation.

	M.
-- 
Jazz is not dead. It just smells funny...
