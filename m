Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145571-1525495364-2-6930638707220666907
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525495363; b=dNquw8/KfBvZZFOvvTn/UI/qXogABYt3iFlTngnlJLcDsI1Lez
    QCr/y48r/3fzuji02sdklH6N3XxTNxcgQ6c+feb0LUbaek6RdKFO3YtsL7Byq9x2
    UzcoQYDh3vCOF2gdbWZUWSCvuTtuduhso1OOLXoe6FtdmSJ7628Cey6+yxht6lO4
    Q2VB7hnrEU7Ohmd4XITJF96ayU6BPKut5aOnS5V26lPGhH2JBTxU+MIFiI2UDxOb
    7Q/sKtYRPurLU9DOWwhBSre2fepS2eh/TZPwiv+F9WmCF3WdAwFhxmrkfUWsuGpC
    BtPb5crvYCgT0hjaR/alUbQbzRC3FIdEKNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525495363;
    bh=Z8zpIhh9WVLgnfIGRPDjAIM4fM4d+dKFqptmLstJI9A=; b=KgiFDhe3fpln
    GnuUQS4Zm3pxW0aOHPbIGreAsxbZzfZjQ/yb4GaEJW5cUqh1J8tW5X5mAbnbBE80
    FHZL+4SZPwjpJvtd1UdorOr35dWK2uOOLMJKN5RIr13VI3VbkAYysspD1yv1SIst
    QJjmOdW6qSvtIjYZpKufFhiulgIlSFlbOn1td/iMF9HKK3nU6aueEx/+bwn3Feaq
    lJNJXf45RiQgo92niGi7aZZRv9NMyChKxKM1DzgEOqWqUsAg8LtYSs7TmCF6W2KC
    k5bNLI9ElG74CkmlFuQvQWslT3DQy3ypIE0ACX/6Krlh56VRHrFuZyUGZrhijK3+
    N8YuIMA4YQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMlv/rM/0A+mGSBaZSOKM4Ya7swJl8oGlrw686uUkiIm1f1bC9Gn3IDiyPFQJ3W1vi1C461oxnB2mR1cvmBfXEWy85Km2qvtWwnm1RdkF6GUx/raQxW7
    mP1BfnYsouQJoBP7cQL+xHcTxvDQF9EusA676s8CNQYiKFye2n554aP+A3bpvq8PBpZez6zL1qBdMKu23P9A9laZLOctUZUqsR+/HTu0zPj3DfH8ZhYKH/LV
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=-OLwKGikQ9vXiKCKYdEA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750764AbeEEEml (ORCPT <rfc822;linux@kroah.com>);
        Sat, 5 May 2018 00:42:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:35021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeEEEmk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 May 2018 00:42:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,364,1520924400";
   d="scan'208";a="36994747"
Subject: Re: [PATCH v13 3/3] mm, powerpc, x86: introduce an additional vma bit
 for powerpc pkey
To: Ram Pai <linuxram@us.ibm.com>
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
 <1525471183-21277-3-git-send-email-linuxram@us.ibm.com>
 <1e37895e-5a18-11c1-58f1-834f96dfd4d5@intel.com>
 <20180505011243.GB5617@ram.oc3035372033.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <7d1de723-f001-ebbe-6026-91bef88c566d@intel.com>
Date: Fri, 4 May 2018 21:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180505011243.GB5617@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/04/2018 06:12 PM, Ram Pai wrote:
>> That new line boils down to:
>>
>> 		[ilog2(0)]	= "",
>>
>> on x86.  It wasn't *obvious* to me that it is OK to do that.  The other
>> possibly undefined bits (VM_SOFTDIRTY for instance) #ifdef themselves
>> out of this array.
>>
>> I would just be a wee bit worried that this would overwrite the 0 entry
>> ("??") with "".
> Yes it would :-( and could potentially break anything that depends on
> 0th entry being "??"
> 
> Is the following fix acceptable?
> 
> #if VM_PKEY_BIT4
>                 [ilog2(VM_PKEY_BIT4)]   = "",
> #endif

Yep, I think that works for me.
