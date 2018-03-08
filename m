Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988500-1520516101-2-8091379853129214763
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520516100; b=Eylz77GdPan1/RV333IGhCe6Dj9hsiHCLRepEA7dl7GFVsQ
    G+gEsZBJn3sLXKmzx7/mpRSvPSdlsbOFyGCU7NwsO8oTMBKJT1iiTmGoqzRVil95
    VJ/0V7msm8jV0ETogMelbILzGIOW1g56LCdRUuW4TVDXDEw8geDgt2tIPAhG8L25
    QE1eqCjofh5H67lQED0zaJDjX/0OUjFV7NAbQ4PcGUdkoBOlH25KYENZ2kOhvs4L
    MTLcteN8jqVh4zrc9bIVhMZ5/NXgJVs4FfUM3CK+RSBLZ7cPEPL1TdCDEBA8OIul
    ZxbwhInBATciUwTgO6xjFssYiSUhtd3JpoJa2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520516100; bh=gEDusAy0b0R91kFHWlsarMLtm3VL/V/sfP2F+S53r4s=; b=g
    UkQLnhmdjiQ+DYuJxRUu5O+WI0MYL7MLw5gAAjymgIQJ9MY+obnjhTTLpeNeLNoZ
    OayRqIEv6tCDb+z0qArTCs8OG3dsfqVRvgCZm/i0CRVNLBWcylLrDLGbKrs4TKrE
    4t7ka4q+VfuuEgL+Dmp4N9e7fJvjndxvC7zOMuZeNJDi5mMsCOaca/KYm2BcmETE
    r8DzjWN9Yw6HGavPbBJTHtPZCY4ir8oSUI78i/LfmMD/TPyxmyeXoIkpaOVY7Z6Q
    hvRUxtT3xbz81FjM+jJ6DKgXDF5NjyiQqwJOgfg4PNghT1kWUkhh8saHhSzdYsHV
    Vue7CgtWR45YvhFMIml2w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F8/S31OS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BcTG8MB0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F8/S31OS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BcTG8MB0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755938AbeCHNea (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 08:34:30 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53077 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755936AbeCHNeC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 08:34:02 -0500
X-Google-Smtp-Source: AG47ELubRx/ztiMbpRUumXS2CEOEPCOkdaRfezsNPah4dbcqKeUHtm75HzKd2I/f4LRRZjbUiRg4Uw==
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc: Alex Shi <alex.shi@linaro.org>, sre@kernel.org,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, patrikbachan@gmail.com, serge@hallyn.com,
        abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180308122715.GB21514@amd> <20180308132139.apabmgw4magrp3d7@pali>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <36c7b85a-dadb-6e05-6c19-58c6ff6ae728@gmail.com>
Date: Thu, 8 Mar 2018 15:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308132139.apabmgw4magrp3d7@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On  8.03.2018 15:21, Pali Rohár wrote:
> On Thursday 08 March 2018 13:27:15 Pavel Machek wrote:
>> Hi!
>>
>>> Resent without non-upstream patches.
>>>
>>> This backport patchset fixed the spectre issue, it's original branch:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
>>> A few dependency or fixingpatches are also picked up, if they are necessary
>>>   and no functional changes.
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
> bit which is not possible on OMAP HS devices. But for Nokia N900 there
> is special code which do it via smc instruction (function
> rx51_secure_update_aux_cr(), see also nokia_n900_legacy_init()).
> 

I *think* N900 should be safe from spectre attack as a side effect of 
thumb2 errata (430973) workaround (BTB is flushed on every context 
switch), but don't quote me on that one, lets more knowledgeable than me 
to confirm first.

Ivo
