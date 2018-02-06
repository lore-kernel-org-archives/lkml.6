Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1311000-1517928503-2-5752893167910060821
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
    t=1517928503; b=TI7Vd2Ae8Svj4oZQsc4uMcYbDr3iuG2iRYdcwzALt2kDqnr
    sAQxR0qQNNfCGe31oePeQBJh/6TG4A75R8KUh48700QssTW2RdKUTYfqy6MFd3rR
    pXCclKlFmfpknteILIK6cBlU8SLx7cj/B+EcnFHG+/2XCrbJmJh4FVjcV7rRSZIk
    xb8TNEFTUcYgvfMPF7yxhdFhxaoTGUVNgQFZscVEw1tj0KkJ+6E/BJANUJNw13TE
    K5XWgqL3OdNgxt9Qgf0xFigAXvOBSWN9E4El1kyKCVeNxGyDc7RBFE0nYwjNsdJN
    evTCrl3ljmDf+vme1JjDTBk9F6RISE7OECfQmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517928503; bh=UgzYReiwpPKQXVvtcAQ4l8gqfuseeJj89DGypppXqQc=; b=n
    bFqKk0h7pTGlr5mFRU0hUFCv72hkrFpEqdTi3yAJ58TEF/W+ItKD+jAGympMjMDX
    mgxVFMNhSsrVHcdAkIHBI33Dh75supRzHlr3jvVvC3apYX6TZyQizihMI2knEP3n
    v6prt5CddkAB/tiY5VOpTAZ4fWd3C/X3PPFcTwPoeNxA3LH+XA+cBKaTlo32in2g
    OuVzGTNgAF4T802QDq1zSu9TiXdBiY/AeqcLVhnWUZw/8rsDnEs3Hhhi5JCf0810
    iJ07a6HqHDHF5SJF8kwDUbx1tyUZe2e2GCZ07mH2di9z//BtXZ3Oy3XQVAK2cm1q
    SB9ff+Vhvkoe4wVIgxxsA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SprYFIqE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VjmrzCU1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SprYFIqE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VjmrzCU1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeBFOsU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 09:48:20 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44496 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeBFOsT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 09:48:19 -0500
X-Google-Smtp-Source: AH8x224Ef6jQdoZDVktwJre9Pffnm3Tbvszs/lLWypVCtZ0qYwYZ8gXDe5XurczxdVBhncYSx4e9JA==
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harsh Shandilya <msfjarvis@gmail.com>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
        linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
        patches@kernelci.org, shuahkh@osg.samsung.com,
        stable@vger.kernel.org, torvalds@linux-foundation.org
References: <20180205182351.774761393@linuxfoundation.org>
 <CALpmF+GKNPabSb1QjBf4nogZRryhU7oD6MRsB8yrU3esT0KxMA@mail.gmail.com>
 <20180206103404.GC10790@kroah.com>
 <CALpmF+G1Cn7-1Oe2xiNXcGq-cvSPj8GPQTEf0AEF7wN-FDLvFQ@mail.gmail.com>
 <20180206131407.GA4222@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9d4d16bb-4384-4332-3988-c20e449dbda5@roeck-us.net>
Date: Tue, 6 Feb 2018 06:48:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180206131407.GA4222@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/06/2018 05:14 AM, Greg Kroah-Hartman wrote:
> On Tue, Feb 06, 2018 at 11:42:15AM +0000, Harsh Shandilya wrote:
>> On Tue 6 Feb, 2018, 4:04 PM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
>> wrote:
>>
>>> On Tue, Feb 06, 2018 at 06:48:53AM +0000, Harsh Shandilya wrote:
>>>> On Tue 6 Feb, 2018, 12:09 AM Greg Kroah-Hartman, <
>>> gregkh@linuxfoundation.org>
>>>> wrote:
>>>>
>>>>> This is the start of the stable review cycle for the 3.18.94 release.
>>>>> There are 36 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>> The whole patch series can be found in one patch at:
>>>>>
>>>>> kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.94-rc1.gz
>>>>> or in the git tree and branch at:
>>>>>    git://
>>> git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>>>>> linux-3.18.y
>>>>> and the diffstat can be found below.
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>>
>>>>
>>>> Builds and boots on the OnePlus 3T, no regressions noticed.
>>>
>>> Yeah!  That device is the only reason I keep this tree alive :)
>>>
>>> thanks for testing and letting me know.
>>>
>>> greg k-h
>>>
>>
>> Guess I should drop my kernel tree for the device and save you the pain of
>> maintaining 3.18 :P
> 
> Heh, maybe :)
> 
>> Atleast CAF has been keeping up with upstream now thanks to your
>> kernel-common merges so there's still hope for MSM platform users :)
> 
> That's good to see. Now if only those platform users would actually
> update their kernels to these new versions :(
> 
>> P.S. common merge should go in cleanly, both the merge conflicts I had were
>> from CAF changes.
> 
> Thanks for letting me know, that's great to hear as I just had a
> question from some companies who are worried that taking stable patches
> will cause tons of merge issues.  It hasn't in my experience, and seeing
> reports of this from others is great news.
> 

 From merging v4.4 and v4.14 into the respective ChromeOS branches, I would conclude
that merging is for the most part easy. Major source of conflicts, if they happen,
is that we may already have picked up additional commits from upstream.

This is only true, though, if merges are done on a release-by-release basis
and if the merge happens shortly after a stable release is available. Otherwise,
as time goes by, merges become more and more difficult (almost exponentially
over time). Wait for more than 2-3 months between merges and it becomes almost
impossible.

For reference, the top of tree for both branches is
	v4.14.16-3823-g597d36f1d331
	v4.4.114-12977-ga207b53fe939
meaning there are _lots_ of patches on top of the mainline stable releases.

Also, overall, the rate of regressions is quite low (if I recall correctly,
somewhere between 3 and 5 in chromeos-4.4, and one so far in chromeos-4.14,
ie below 0.1%).

Guenter
