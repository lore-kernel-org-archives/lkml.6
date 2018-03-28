Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3460534-1522279435-2-8972306385055408804
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522279434; b=fDq9+CbtU12+DLStQAmf3zKEDbOsVHuJhdq57S/kvXVOlp/
    Whn1daxqGEKmCMaP63kx7JQ5bT48eU76oJ+DhqL6cO/LM4mURdzd9pPYiYNv0PaZ
    TklnvgCmpd1lvp2VM7RzXIDiWviaPoyRsFsxA2i9+qn5yLZp6sKgxJlH+tCYopEl
    uL76feHyKLIZ8ny8dB8ScOGWQeicf7bblW/uzXxcGewo3H4D2Rg+rqqhctCuRVYA
    9/mav2l+D+GD3Ht0JQWh4kdr91T6lFSsXKHfYDVkAryeNMpwSrKUPqx+YC9eWhBb
    2Ytv0AuaaZd8w8o3ZciGKsciOndE3VuUmDxTM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522279434; bh=FF1LTmxktYjlA2IM9e9Qa0GWIMaD1Ry2Bo7VAD4JahA=; b=t
    79Sh2l0McaoPX4o9lCGJKkhmNayq85CM9IWeG91fA2GrGXTDt65VmT1vZ27BgGk7
    vTH304Ux7viqsu0kZobPlGFj076SF6Ol8dRC+2q/Fr3gy0ROQHoOX5iqPYgGZibC
    iXqBz3GisCJOJ2c9nLbhqBEpBxRs6SI46bH3pEVjVNukro3cNgDKsWOaRMcv49/j
    5KJAIC43PwhCdYFNX/mqKLmMktDRUpglnwLB/ys0ndHGEPqBQsopcuM3ijKwy2S/
    VxeZXQxJYTtyrj7tuVGEC3Pz/8gqBq72lpl3VUgNd5/RycAATCLjUdaDYrhR6Zn7
    0hkdNisvPcgQT1Z4vH9Rg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=hh+E2qlw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=hh+E2qlw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDTHW0mCHEXrLifZzopc2EU0MccoUkfrkcRqpV3Nj6JeG61uLmMpWbeJQ/0tDh1FE5z8azj3YqkLZ2s7Bnt31wJinsqHTBfpr9MDQabdC87Tsuhp+VcZ
    Yfktkn0Di0vmeKaqqbI7w36+4rl0SwW/PlQVz22nl6tn5U7M2Ug8tp1Cvj6D2xTegjUVIQCriPUpdWISmGRLn3Gr//Hkv2P4ARj/sZuiYkFGGn3srjSStOj2
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=PtDNVHqPAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=gSF6oe7wc0hLz9cQGHcA:9
    a=QEXdDO2ut3YA:10 a=SsLxlLYP9IwA:10 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeC1XXm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 19:23:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49198 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1XXk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 19:23:40 -0400
Subject: Re: [REVIEW][PATCH 09/11] ipc/shm: Fix shmctl(..., IPC_STAT, ...)
 between pid namespaces.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>
References: <87vadmobdw.fsf_-_@xmission.com>
 <20180323191614.32489-9-ebiederm@xmission.com>
 <7df62190-2407-bfd4-d144-7304a8ea8ae3@oracle.com>
 <87lgeio4tb.fsf@xmission.com>
 <1091a91e-f8ee-b091-6d95-78b33520fb2d@oracle.com>
 <87woxvajk9.fsf@xmission.com>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <e9c86e8a-3790-05b1-4c3f-6951abf14df2@oracle.com>
Date: Wed, 28 Mar 2018 16:18:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87woxvajk9.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=761
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280233
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/28/2018 04:04 PM, ebiederm@xmission.com wrote:
> NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com> writes:
>
>> On 3/23/2018 2:33 PM, ebiederm@xmission.com wrote:
>>> NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com> writes:
>>>
>>>> Thanks!
>>>>
>>>> Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
>>> Does this look like it will address the issue you have been fighting
>>> with pids?
>> We do use IPC shared memory but it is a single large one, shared by multiple
>> levels. We are currently looking into using a similar solution based on file
>> locks.
>> When a new level is created, a file representing that level could be created in
>> a common path which could be locked by the init process of that level.
>> Parent levels could query the locking pid of that file to get the pid
>> translation
>> of the init process of the required level. Then it could open a file descriptor
>> and use the translate_pid API for further translations.
> Do you want to resend the translate_pid API with file descriptors as it
> was in the lwn article?  That I will apply.

Sure Eric! We are currently implementing and testing the file locks + FD 
based
approach, just to make sure it covers all the requirements. Will resend the
patch with FD based translate_pid API in few days.

Thanks,
Nagarathnam.
>
> Eric

