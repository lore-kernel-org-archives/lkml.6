Return-Path: <Suzuki.Poulose@arm.com>
X-Cyrus-Session-Id: sloti22d1t05-4201-1526054787-2-16998166047073339616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='217.140.101.70', Host='foss.arm.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Suzuki.Poulose@arm.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526054786; b=Mgt/c7LVzpMqFPdrYFStRM2QLFDedmdyntD8OvyAcWcBeSRQbw
    VWHvhtFWsrQCtf3dKm//bh2FqkNsr0IMp0F3bK4D1mMSPRXKsKHvY/EvQJh9N/T1
    w104QOb08gxmkEmK7egfmI2Oi80I/5tpcrbeckS8CKWQ+vkz6Gls/5hY6V36cRHi
    UpajOD7tKKKccsMxQ4k2hD64oqGem0wc7CQd4sFnUBvokZhQ4m77XPkXPCPZ7iQK
    pEfXqNyeZQ3ryj5pbv7B0zEBJOEKFC63IM5ZzMehO8XOWvu7OOe6w/kOmcryLVTB
    AVyKgI/NelIhqxUJGBxetNhJK9qAmWHQgp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=fm2; t=1526054786; bh=x+/Mo0GL+UaN
    QF4GyCygUg/RkSc834N5QXkvTVvpDzc=; b=nDMBlvqWIgNu+NWW2zQPgClELgpY
    0edSbVBJmG1v1OC3UeH/SNmGBHL6ebPxU+C9/ZSYtLOnb9XfpkEBBj54kkX70byc
    fKw5U2b9rTIZccHLfHuMh7ZMnciy89fh3GKcKGJlTtlDZbmoV8ObZEvuTMzebkcC
    LJ1QavTAYenWd1h4dbBGie6YfuAnsrMFSEsId0GQFIT+4IY4bH7LCa1GooonVqgb
    FQSLsb0e3m+h+pMBMBSoSYBLrW4gtOnUG/mH2toZh5WIBUqQOMuMqG684sjLaYWf
    A9jJfgEa8cWXfEGUy7RqpIpDfj+np3GS3y9SAe6JUIkY45sCivD0yTKMyw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=arm.com;
    iprev=pass policy.iprev=217.140.101.70
    (foss.arm.com,usa-sjc-mx-foss1.foss.arm.com);
    spf=pass smtp.mailfrom=Suzuki.Poulose@arm.com smtp.helo=foss.arm.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=foss.arm.com
    x-ptr-lookup=foss.arm.com,usa-sjc-mx-foss1.foss.arm.com;
    x-return-mx=pass smtp.domain=arm.com smtp.result=pass
    smtp_is_org_domain=yes header.domain=arm.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=arm.com;
    iprev=pass policy.iprev=217.140.101.70
      (foss.arm.com,usa-sjc-mx-foss1.foss.arm.com);
    spf=pass smtp.mailfrom=Suzuki.Poulose@arm.com smtp.helo=foss.arm.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=foss.arm.com
      x-ptr-lookup=foss.arm.com,usa-sjc-mx-foss1.foss.arm.com;
    x-return-mx=pass smtp.domain=arm.com smtp.result=pass
      smtp_is_org_domain=yes header.domain=arm.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK8jGNYomPjx8Hw1P7GYiErqKyqFqZllMljJqvBw3cQANd3rOCHSqT6+dvjr9OsgWAe1vxWZoXDDPMz0m9rd6F0I5dqfMdeSw8xK7BXGMgWZEdICOSIw
    233SQJbWbZeCm/5sIQw7Ccg6rUBLKJnHpQlmUrfe7xBgNTTap/Es9qo9tBqvF6DIc8qnsSsqzyOEuA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=J46x2Qp87nEU+ZW81O/1bg==:117
    a=J46x2Qp87nEU+ZW81O/1bg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=Pu_lP1RU5I1_0jwgmlgA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Subject: Re: [PATCH] [stable 4.9] arm64: Add work around for Arm Cortex-A55
 Erratum 1024718
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will.deacon@arm.com, mark.rutland@arm.com
References: <1526046675-23790-1-git-send-email-suzuki.poulose@arm.com>
 <20180511154721.GC17038@kroah.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <843d0226-f715-6a09-276f-ef14d5a06185@arm.com>
Date: Fri, 11 May 2018 17:06:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511154721.GC17038@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 11/05/18 16:47, Greg KH wrote:
> On Fri, May 11, 2018 at 02:51:15PM +0100, Suzuki K Poulose wrote:
>> commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream
>>
>> Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
>> from an erratum 1024718, which causes incorrect updates when DBM/AP
>> bits in a page table entry is modified without a break-before-make
>> sequence. The work around is to disable the hardware DBM feature
>> on the affected cores. The hardware Access Flag management features
>> is not affected.
>>
>> The hardware DBM feature is a non-conflicting capability, i.e, the
>> kernel could handle cores using the feature and those without having
>> the features running at the same time. So this work around is detected
>> at early boot time, rather than delaying it until the CPUs are brought
>> up into the kernel with MMU turned on. This also avoids other complexities
>> with late CPUs turning online, with or without the hardware DBM features.
>>
>> Cc: stable@vger.kernel.org # v4.9
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Note: The upstream commit is on top of a reworked capability
>> infrastructure for arm64 heterogeneous systems, which allows
>> delaying the CPU model checks. This backport is based on the
>> original version of the patch [0], which checks the affected
>> CPU models during the early boot.
>>
>> [0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose@arm.com
> 
> Now applied, thanks.

Greg,

I have the backport for v4.4 ready. But it needs to cherry-pick a commit
(commit 30b5ba5cf33 : arm64: introduce mov_q macro to move a constant into a 64-bit register)
which adds the assembly helper and that seems to result in a conflict with
an obvious resolution. What do you prefer in this case ?

1) Go ahead with the cherry-pick

Or

2) Fold the pre-req patch (which is about 30 lines of changes) in the back port

Cheers
Suzuki
