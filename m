Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2180492-1521841341-2-10675602192059981345
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
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
    t=1521841341; b=Zwm201/WO407dyYxB8L+O0FquKwmYMFCaTRQWbiEAkkW0G7
    hpEnHzUf+an3lPjIiBnQ2DMflvj/XvCYE7ACnJYPstK7LYGvCiXS8iwNs3NJEFTo
    CPNsKjqLYgrxA14Rl/lBo9+yEwNeKmGsPNXiMr50AH10qLGJTTR+TCzTnaL2HNcQ
    6sTeNJ1w0Ocr9klue6KIWq51LFJ9N5NOG+fbL3xHup9CJ0U2QTdtucLAjoD/A6MU
    n3aUB3cUvXJ3hTyxjZDR95ROKnAKtpE131UqZzGSJ9bKZRSVYoKfKIRtNdKS7qCP
    GQrc433nDONV/r/Jy72CJt+5LjtL9JMiN2Kk6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521841341; bh=6fVNgtNQQlBerDPivD/zkAjFZxxgWRQxUj9KaQ9NqYM=; b=M
    8B5qMyV+ipRvdcIt/oERSdlpAmC0EaorFNRSKNTkrYCG5F3Zk7fYR8HiQwCycHeG
    eofH4PkdSWhs5mJd9/93uTqLyztoWIEA7MiweUF3yulaTvsjWLs6vXcy6W0BkPGg
    q/F/0+W/oGP274edvpvZcfuG98yMsqjDxcfb+QrhSHTDQLU+u2VDlFQHL19W514b
    sNNWn/gFnbkQceBhvWJDD20pXmglY6HhUAwaGdCkJB+Vd0eujy3gGUH83RZgZpjw
    k5uGhycsOkNRaCPInNjM6ZbmT6LXYKYxMXnweENjLsX66DKbSAZWVQEZIvUoa4+9
    e3RAuhrjwuJk36JWXHE1Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=nW3ygtag x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=nW3ygtag x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeCWVlz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 17:41:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60634 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeCWVlw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 17:41:52 -0400
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
From: NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com>
Organization: Oracle Corporation
Message-ID: <1091a91e-f8ee-b091-6d95-78b33520fb2d@oracle.com>
Date: Fri, 23 Mar 2018 14:41:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <87lgeio4tb.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8841 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=890
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803230239
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/23/2018 2:33 PM, ebiederm@xmission.com wrote:
> NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com> writes:
>
>> Thanks!
>>
>> Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
> Does this look like it will address the issue you have been fighting
> with pids?

We do use IPC shared memory but it is a single large one, shared by multiple
levels. We are currently looking into using a similar solution based on 
file locks.
When a new level is created, a file representing that level could be 
created in
a common path which could be locked by the init process of that level.
Parent levels could query the locking pid of that file to get the pid 
translation
of the init process of the required level. Then it could open a file 
descriptor
and use the translate_pid API for further translations.

Thanks,
Nagarathnam.
>
> Eric

