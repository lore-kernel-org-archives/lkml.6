Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1986038-1524529944-2-9283142101684538584
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
    1524529943; b=IFXUyo7TAe6AHtwp4tBvAxkNhQsX+TPpueD5T69vGUOfbv9b79
    Pb+vsCSm9lVGv9x9UIIlDhEMgKKQyfG/d/XCSsTHrGwuEPfB4afhJ3g5nKyTFI56
    MHyAk4lrppiW7i5meM65iIN7SX19jBHJE9kRwwm8eI8/AC+1ywxj1WzZVnCsSsL0
    +vCCVwTCQqIghkYAizLBEUEdEXyBRQU/jyqdORqLU0hHpcdy0se2wqt2YFOi+DYj
    GFQ2LIm6t8Oakig1JQ6vVBkbU9EdF9yjRhzhRZoFvud6QjA51VDSaorEyLCXk73g
    7h1H5gGt3tbYR/jUzhOgcHwkphGMVDrmu94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524529943;
    bh=VxhK1Q/K0mzgklnQoPOQeR1YNWDoKP4nR/MCNtiRdXY=; b=nRXvDp1gLrvs
    7f0mWBZ4RiQz5H132WZxs+u/mPTKXV7iWv6XgnIEllPSbHQbArUWHXDcD2q9emDr
    OZnUwovl3rOJMt+PxrGr3QQjabvhcGHuzw9d2Bai2LNMBGFFpGXpWay5IdPjAvE0
    XHeWtC7BgaaHXPg5CMkU6kxlMil4vGp2jB6hTczDDj/rDgOy46rSW4+TGI45VIvd
    PNuIKyG6bFWIZZF8CR5J7pepG4BpiqSXBvIUn7ob7Vm+4+vOf+wZoG6FSEpIZg0P
    VvF78NkdD+/QvTXcrzQeSaFt8kd/IzzurshSsf9ZrSi/0xIK+4rpK9B7qkIbp+r2
    J2gXxAJUXQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfLjGUIUXH1/oaeO4M4qdW79QBvnIVCNK+Q//7UHHdQhzV8GupOsEloG7kJYywIApO63WZnGHDA29F/OMyR7hBoGVwNgAUvd/s81mPjznPpA4IgtlX0pq
    rfW/r8Xs6Ol6VzXD2nkCD6wPuOzxDfYHijhr0uen+CBZ6DuPd8UfElQubY/V9DKsz53PLnN0przA/3nsziDny3+3e1ZfS8J0IOPTBQ9D0tV7i3phg6GYIbmC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xRDiy12qv0EA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=iOFjt-bxZ3NhdY6RLL0A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932635AbeDXAcU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 20:32:20 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:44749 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeDXAcU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 20:32:20 -0400
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180422135104.278511750@linuxfoundation.org>
 <20180423180312.GA27081@kroah.com>
 <4527fda9-f123-f8b7-8294-991a0a66af16@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f603cd95-c0a6-c283-09cf-f9d3cd4a5a53@kernel.org>
Date: Mon, 23 Apr 2018 18:32:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4527fda9-f123-f8b7-8294-991a0a66af16@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/23/2018 02:07 PM, Shuah Khan wrote:
> On 04/23/2018 12:03 PM, Greg Kroah-Hartman wrote:
>> On Sun, Apr 22, 2018 at 03:50:20PM +0200, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.16.4 release.
>>> There are 196 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.4-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
>>> and the diffstat can be found below.
>>
>> There is a -rc3 out now, to fix some issues reported with -rc1 and -rc2
>> (I forgot to announce -rc2, sorry.):
>>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.4-rc3.gz
>>
>>
>>
> 
> I just tried rc1 - will try rc3. Has the lock problem seen already: ( I will
> try rc3 and if I setill see the problem, will start bisect)
> 

rc3 looks good. Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
