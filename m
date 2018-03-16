Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3998809-1521236452-2-15601589102458295029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521236451; b=Tmri1BcirJ7DIz6cOABcOYs/bR7Y8w+4Aogox3fT4slmiBd
    FIq0YOVU/GI0h91clAkNuPweliVSUiGmpNSDb3aS/yAH7j+RNv1C9SqsJ06ej5Y8
    1uC7o/gCkZfBAKbk3SKVDmvPUb6ABtCx3HoiixSP9VcKXZTRV+u9HBJ6sAPSTETX
    jktooDfDa2JZefQYMDxdqiUnXFW/ilWGa7BxbtdgFM3+3xazS1EgRyIF6dwXDuIl
    OuHhUIdD/5FUT9fktW7fcFdb+zPFzElptrVWAKm9HQgTVyZxFJuK2T8wjoBhE+0y
    dAWsqA4py+TQ2dqiOd4Pa6iih7qXVbFWUTr//Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521236451; bh=MrtuGhUrIMNdmWeucl6LuzxMmDbiCybDoCzRlTvaGLY=; b=G
    Li7DDWD6wK/ldJVsKLcaaEo9hD5lJeB7d5TjvrsbfmcwjShpYaZhBXP4i+Bmz6ao
    OXF55RBK7gI4I2n8kzc7Jw3IqmL3O+6dXbgwlyY4vhD4pgwwwz1tiC3Ekd0Gh40o
    nqKSCWT7lWrO0Vv+MX/Wr8nKmmwDe3DU9PTCv4hSJ9WDqJd6IEvb3s9ihTO8pRhZ
    T+NyYpCuD7E2WEAK0C4/CLhMNc8rhpfV0ptgMVECvGntLdpzqr10vovdoGHoeady
    uPTHX8AdbuUIXBLmUor/F6nAY+HODbMkd0MpJkKCL+jQgWLuIr9+85rsbVqWV/7H
    0lCxY5tWQRR9Mf48u0gSQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeCPVkt convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 16 Mar 2018 17:40:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5435 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPVks (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 17:40:48 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Mar 2018 14:40:47 -0700
Subject: Re: [PATCH 02/14] mm/hmm: fix header file if/else/endif maze
To: Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Ralph Campbell <rcampbell@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-3-jglisse@redhat.com>
 <20180316140959.b603888e2a9ba2e42e56ba1f@linux-foundation.org>
 <20180316211801.GB4861@redhat.com>
 <20180316143537.0d49a76ec48ec0ab034af93b@linux-foundation.org>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <48f31a69-c4f8-5e50-00e8-0def08f750a3@nvidia.com>
Date: Fri, 16 Mar 2018 14:40:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316143537.0d49a76ec48ec0ab034af93b@linux-foundation.org>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 02:35 PM, Andrew Morton wrote:
> On Fri, 16 Mar 2018 17:18:02 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> 
>> On Fri, Mar 16, 2018 at 02:09:59PM -0700, Andrew Morton wrote:
>>> On Fri, 16 Mar 2018 15:14:07 -0400 jglisse@redhat.com wrote:
>>>
>>>> From: Jérôme Glisse <jglisse@redhat.com>
>>>>
>>>> The #if/#else/#endif for IS_ENABLED(CONFIG_HMM) were wrong.
>>>
>>> "were wrong" is not a sufficient explanation of the problem, especially
>>> if we're requesting a -stable backport.  Please fully describe the
>>> effects of a bug when fixing it?
>>
>> Build issue (compilation failure) if you have multiple includes of
>> hmm.h through different headers is the most obvious issue. So it
>> will be very obvious with any big driver that include the file in
>> different headers.
> 
> That doesn't seem to warrant a -stable backport?  The developer of such
> a driver will simply fix the headers?

Right. For this patch, I would strongly request a -stable backport.  It's 
really going to cause problems if anyone tries to use -stable with HMM,
without this fix.

thanks,
-- 
John Hubbard
NVIDIA

> 
>> I can respin with that. Sorry again for not being more explanatory
>> it is always hard for me to figure what is not obvious to others.
> 
> I updated the changelog, no respin needed.
> 
