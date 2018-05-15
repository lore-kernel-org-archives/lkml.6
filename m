Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2709797-1526391928-2-13096255177152078576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526391928; b=M+vGEGvrJIAaKcFuaXpnQ8ENyB9t7xjJIsB/WZhxVJPec7OOdl
    or/BvhINRZunxkhUIxd74v774da8w6r8uD0Q7jsfik2fCHClGX7sjhVsgRntUJmd
    dLEcN8HDp6nXiNQO5npxc0/r5V5qGUBEH0WPC06BUmdK2UW9PgcZ8MzHM/RKLNCk
    AjwheiXXluEyL7PKfTBexIGWNIDId+tHyATpXGSWlIuERIO+erzR4Y/8RYSRJGVB
    uLybvA3FXWsAAYV+0BO1DC465QNRPyybrXcCsY2APzNdzDUTW0sxv2nay/a3VHRF
    1CDyLQCyxoIGjJggMlCNovkRnfs1oQISEH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526391928;
    bh=tXd+FJxcEAQnR9tOGvPl65p2cdO6hvYXbDROJY3SeqQ=; b=CNCGH3eRVYl7
    ohyRMcwPVPm8ZgyjKirUoFJm7NpABCs6d3fLioEX2dkEZxjdL9wRySywCuomAQtL
    0bFHNZMzJqRm4ydRYF36e0VmLpoOCIHtFAo1qElde+/jrkwyJ+Ghwkjt+NfqvlTe
    hnR5U8lY5+uZDbcqGtBysN7cwTi9PyvMoxu6BtJSpF1dF5pPqrIVh9/iklMA2Txm
    tnxSfxLchioqOwDjSQ8kt8B/i1JwqF3UcLRumAKsND4z+KUhWuxgTlUq3yED8bsZ
    jD42saLQQt1DBIwoVZ1hWPTIdhymVynp7yZRpBNFU8oOlalCmVPNBBVobgt2aFcQ
    7xmRBKOwGQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG4mrzGbPqI77W/Rv+HkCHxBA5yUjuEC1Mdnvw/rZTIIkVxN+4OnYPiJvoTDDhIJFbWqGmQmfmWRccOhn+geDVJVUxNH8rFdqnYp6Xd4Z5sT4/nwUaPL
    d+TO801qqjNRPSKG5o6KOCKpYvXv2Mn0avCUikkcZQl+FDDnDLTp25iW67SQGQDgxwrrrX4NfMaA/IwYe34osHgMbRcDyoFonxVd25WwqX7jq8sRCGm4NxTI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=gu6fZOg2AAAA:8 a=eIBIuoMophxdxgQBlmsA:9 a=QEXdDO2ut3YA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeEONpZ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 09:45:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752491AbeEONpY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 09:45:24 -0400
Subject: Re: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as
 non-spinnable in percpu_rwsem_release()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
 <1526326267-22501-3-git-send-email-longman@redhat.com>
 <CAOQ4uxiL+x0Q8jgUZFOmrM5yndE0sDRRTSci2B-y5Y-r+QMCxA@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <bf390812-6fbe-97d9-040a-70eba61b3d81@redhat.com>
Date: Tue, 15 May 2018 09:45:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxiL+x0Q8jgUZFOmrM5yndE0sDRRTSci2B-y5Y-r+QMCxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/15/2018 01:42 AM, Amir Goldstein wrote:
> On Mon, May 14, 2018 at 10:31 PM, Waiman Long <longman@redhat.com> wrote:
>> The percpu_rwsem_release() is called when the ownership of the embedded
>> rwsem is to be transferred to another task. The new owner, however, may
>> take a while to get the ownership of the lock via percpu_rwsem_acquire().
>> During that period, the rwsem is now marked as writer-owned with no
>> optimistic spinning.
>>
> Waiman,
>
> Thanks for the fix. I will test it soon.
>
> For this commit message I suggest that you add parts of the reproducer
> found here:
> https://marc.info/?l=linux-fsdevel&m=152622016219975&w=2
>
> Thanks,
> Amir.
Sure. I will add that to the commit log.

Cheers,
Longman
