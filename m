Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2886532-1524001902-2-15132974988601694603
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524001902; b=f1FBiASyqG7dRtBPTyLWAsCywvjGW0P0V8R/KV55ojaMH4Pn3H
    gyEe488fk4g5AZ/X4Xg6UJsKwNtT+6RbwZs7CVUJHuBO0oTY/RjcXLSbgvC0uU0x
    1PP8V5sRfiCgWR/77Yjh7eNvaT84/9wZD3qdgoinSpIXkNoVkcCGXjParRKVGGGd
    HdojSIgH1v7EM1yVw5Yg/UfNIvXiD7yScTeEBzf5JOpD4aoEefPFi5P2jt0g6Av2
    7BnSom/x258b8nvKNVCjx/7gNkRYf3/IiUBGUoYgRbRYo+GTcaKBRaCge7M262b3
    AE7X+lxBa/As6rTcNyMEGDG4QBbFLrWFZtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524001902;
    bh=BNfTp4EjTulrx686tzwHxp4wRjJqJ1WK3vc79VoEZbM=; b=uNFnlfTeZZMK
    UCtF6ONhbF6RzFQ/rpXghyxUN7Pas0fd4rv5sbKmnhjPXTNaN4Cx+kmI5OZprake
    mWfRY6FJYpy5y8bvMCw2NFZ60LqsZoeJIdwdu4yICYukA180on3zaREw5XHWJefP
    MG9GRDqE7IxQqWzZcYkSh8UtETJbW14MRZhXmm/U4FrIXygQqDfGPkl0mSqTwkjf
    3f42/KLsAJiWnh+04ZSbpsANMghhR0HjmpjkGAZXBCUTz1u1RWCTI+p75SLZnWqG
    Ac6djmRvvbM0KByQ6LKPkM/0uFRobiv7mKQ+EnTSLqmgzNw7clyhCQDXFBqp0+aK
    BPJ84QM3CA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.alibaba.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.alibaba.com header.result=pass header_org.domain=alibaba.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.alibaba.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.alibaba.com header.result=pass header_org.domain=alibaba.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA7vR8LevOMrvmM7eJNUqtAZmKaxDLCeoaKnZbf4jpFvXBNk+9KGP6hlILNwvVS3nYkb7cQ+kXKuLGWkTmji/fe/zfwnyOiLwN6giBJp+SmPGcj/E7bu
    rjD6KjWjUt2s3R9OeOuzFwOr0E0G9X0utH8IbrR741M9Fh2CgOcLY0XqLQrB7GxX8+Afcjlxq3DS6WZnIVORo7AfnMRKsj2/ns9V8lLgS49pfAXBgwamULJO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=BqgCfznX7MUA:10
    a=Kd1tUaAdevIA:10 a=ZZnuYtJkoWoA:10 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8
    a=pGLkceISAAAA:8 a=uSFyZe5Q6MhbDNqlsKYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDQVvl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 17:51:41 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53062 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751878AbeDQVvk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Apr 2018 17:51:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0T.N0LQB_1524001878;
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: viro@zeniv.linux.org.uk, nyc@holomorphy.com,
        mike.kravetz@oracle.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180417143144.b7ffb07fad28875bad546247@linux-foundation.org>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <8f01845c-51dd-20a6-1d75-64f9de0ccb0b@linux.alibaba.com>
Date: Tue, 17 Apr 2018 14:51:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417143144.b7ffb07fad28875bad546247@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/17/18 2:31 PM, Andrew Morton wrote:
> On Wed, 18 Apr 2018 05:08:13 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> Since tmpfs THP was supported in 4.8, hugetlbfs is not the only
>> filesystem with huge page support anymore. tmpfs can use huge page via
>> THP when mounting by "huge=" mount option.
>>
>> When applications use huge page on hugetlbfs, it just need check the
>> filesystem magic number, but it is not enough for tmpfs. So, introduce
>> ST_HUGE flag to statfs if super block has SB_HUGE set which indicates
>> huge page is supported on the specific filesystem.
>>
>> Some applications could benefit from this change, for example QEMU.
>> When use mmap file as guest VM backend memory, QEMU typically mmap the
>> file size plus one extra page. If the file is on hugetlbfs the extra
>> page is huge page size (i.e. 2MB), but it is still 4KB on tmpfs even
>> though THP is enabled. tmpfs THP requires VMA is huge page aligned, so
>> if 4KB page is used THP will not be used at all. The below /proc/meminfo
>> fragment shows the THP use of QEMU with 4K page:
>>
>> ShmemHugePages:   679936 kB
>> ShmemPmdMapped:        0 kB
>>
>> With ST_HUGE flag, QEMU can get huge page, then /proc/meminfo looks
>> like:
>>
>> ShmemHugePages:    77824 kB
>> ShmemPmdMapped:     6144 kB
>>
>> With this flag, the applications can know if huge page is supported on
>> the filesystem then optimize the behavior of the applications
>> accordingly. Although the similar function can be implemented in
>> applications by traversing the mount options, it looks more convenient
>> if kernel can provide such flag.
>>
>> Even though ST_HUGE is set, f_bsize still returns 4KB for tmpfs since
>> THP could be split, and it also my fallback to 4KB page silently if
>> there is not enough huge page.
>>
>> And, set the flag for hugetlbfs as well to keep the consistency, and the
>> applications don't have to know what filesystem is used to use huge
>> page, just need to check ST_HUGE flag.
>>
> Patch is simple enough, although I'm having trouble forming an opinion
> about it ;)
>
> It will call for an update to the statfs(2) manpage.  I'm not sure
> which of linux-man@vger.kernel.org, mtk.manpages@gmail.com and
> linux-api@vger.kernel.org is best for that, so I'd cc all three...

Thanks, Andrew. Added cc to those 3 lists.



