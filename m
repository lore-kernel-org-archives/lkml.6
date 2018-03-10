Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3497703-1520698472-2-3232893495216600649
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520698472; b=qYWyvccfCVvplitoV5TlGF3DYEvHzMm7ecKj5xB9a2PC8Md
    gRpSgkFi1yk+2KBxr+RvuxzzHCm8ordkkcFuyC/4hR4U3nF5aFTHLgiHRztVyx++
    7FS0j7ujlvXJnVMGM0DLWZXmfO+083kTzf2TtNM+i+ahgYhYTXtaUKjQYsmMiq78
    DvzKVC0a7sAqDAqFmDlejmi24eqzypSgvRwsyzko1SrzHEMABpvTEsoBLb60H0vu
    QFEJwlZANiIY+1feWU/sXOCOdn3fE04jhyNCiAAM3B3Sn54JO3c2eqjzVWRIYcAO
    DrIQ4vU+Jq17hdy5KmJfsTMkjYLDlcAexJ2asyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520698472; bh=pBShsKSQc9aN6aNFxXLXW+noMykaiMd9wbC5enT2Ib4=; b=c
    t+6SaZ6Oh/3aDaRalegxnO0Q2tCFBqMfpiawfnm60URWe1Kek7VadWQA+dci+SYN
    f0rFeh9YGW7oXxhpUT6T6xEcWTedYJ6guxDocaTDpiFYKgqP+ut+fDYmXYlRrn4k
    VNGYtHETg6uxpWzYLgTynQ5Xt6NSf5krvumLZTbFbB3HJs8/Iv39IqFACcETDHP9
    q//7z+a6LoTBHOkVEzoY2I1Q/zmyRb7uneLozV0OSpUNxH9CBanK9rwfkOil3N/n
    kNUJi+MQvlcXoyXSQ1eH6W1xqLJi5GbPphIurLF2Wn0SlpRzK62QNl9jHNStLU+h
    ujVYhWXB9Vpfdor20ypug==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932396AbeCJQOa (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 11:14:30 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:25205 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932329AbeCJQO3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 10 Mar 2018 11:14:29 -0500
Subject: Re: [PATCH 4.14 1/4] powerpc/mm/slice: Remove intermediate bitmap
 copy
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
 <20180310001043.GD13963@kroah.com>
 <39af0017-6a9c-a032-8167-40b5f30840f8@c-s.fr>
 <20180310145258.GA6874@kroah.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <84cf5fef-a940-cb2a-431e-5a550f725c4f@c-s.fr>
Date: Sat, 10 Mar 2018 17:14:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310145258.GA6874@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 10/03/2018 à 15:52, Greg Kroah-Hartman a écrit :
> On Sat, Mar 10, 2018 at 08:27:54AM +0100, christophe leroy wrote:
>>
>>
>> Le 10/03/2018 à 01:10, Greg Kroah-Hartman a écrit :
>>> On Fri, Mar 09, 2018 at 04:48:59PM +0100, Christophe Leroy wrote:
>>>> Upstream 326691ad4f179e6edc7eb1271e618dd673e4736d
>>>
>>> There is no such git commit id in Linus's tree :(
>>>
>>> Please fix up and resend the series.
>>
>> I checked again, it is there
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/mm/slice.c?h=next-20180309&id=326691ad4f179e6edc7eb1271e618dd673e4736d
> 
> That is linux-next, which has everything and the kitchen sink.  It is
> not Linus's tree.  Please wait for these things to be merged into
> Linus's tree before asking for the to be merged into the stable tree.
> That's a requirement.
> 

Oops, sorry, I thought everything on kernel.org was official.

Once it is in, do I resend the patches or do I just ping you ?

Thanks
Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
