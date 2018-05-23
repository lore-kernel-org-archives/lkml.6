Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-540074-1527101561-2-2717199980859332085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527101560; b=Zvz9vhBTtetBZAwy/Pb4qqd0Ywmx4FzpJYNudQis8YoYcO05YI
    oHcme9WOhsWYWzoVaE24sJclC+/r8pCDWqiF6TNFKvHzhOGnBqsN6AYWznna+QIR
    AaIRBaKW0SM2mfC/+SMoR3gAkceSw7+YByn+NO+Il7UruuRau46R4oVPscRR3GJi
    HI34RQ+g5JOzTQANvbKV+WwUXpP6CtONar7C55poxjSq+Yjt4IonH89RAxbQh/vy
    FJCJPnf/cAKVDAeSwqQRCwTvdE1G1KeRRopXUsmicouMcS+GuwoIJPf2VtBxgwvN
    gYCTvda+8FxKmVnZbgyVRvDiUSQxXhKARBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527101560; bh=yRiuSQOkiBwF3bFBlnZ8Zp6VMhLraDxU7n/YW02W4b
    Q=; b=f6ZuXCiCIQkGuf5tEFWxdULiloptYopI4FTMybKa8OtnMVzLOQIzPd5Ahg
    LqAwBDIcr+hZ2GW4bqyKZWz6xQjRN7HVj2nXz21rmCNwf/dcr9jhPwakbw6rSvr+
    hofQ1N0xKi/3PwcMgV1SpOiqA5pWrL08l6Hc6WFnYMpU/pSwrz/o5wQJIpilsWII
    mM/s3DpbsrAKvC2x98AhIa4L97V1GI0Z4UE1NeTSkOjelyvnpZqJ/XGDIGoRC8le
    ocO4dhaGoWQZh51OQurBk7Ig32hegWPFt4iA81zMsLym9GAV3Z2d+wq1yT0gyCIP
    Mk4YneXN+u2a7+eExqBqxe7iL7+Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linux-foundation.org header.i=@linux-foundation.org
    header.b=L69sxDuC x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=WZihyr9K;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linux-foundation.org header.i=@linux-foundation.org
      header.b=L69sxDuC x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=WZihyr9K;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDgZ2haAsgjwF3zqrUgOedarQwjWA1/Bn5P/0JYFMpv0cjeege/ZIj+sS8UBTP5+wFaxNFdAofEquNtySvdf/k4RfPOMu6kfiqpH1T8Bu4xLhKIXt3Pq
    vMus492mhgvHT/U8mrpOZIvuO7wVMYHz6Kv28arUWQJPxLvypanWep2CuHtywLMJ7BJWVsTwHlFg2SSH77HCkuxkeVdCIX1+Fl/mRfby3+GLT7thVsCuI4Mh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=R4ayLD03AAAA:8 a=VwQbUJbxAAAA:8 a=MfRkhUB_lGFpGwn_GSgA:9
    a=JztYj-414tML0hGw:21 a=outNZhL3CmQmIwTb:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=qJlm0-shE6CLU_iKUWNr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeEWSwi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 14:52:38 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:40644 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934066AbeEWSwh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 14:52:37 -0400
X-Google-Smtp-Source: ADUXVKJufocE9CvZ6mjHKXWn/vldbit4YuTK50MzGY/EL8L1u7vlimHMKhzkcWeX5U8PnFKQcvyWnfaZpHq8b0hCM6I=
MIME-Version: 1.0
References: <20180523172500.anfvmjtumww65ief@linux-n805> <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
 <20180523183103.cdgv4slom62y56wi@linux-n805>
In-Reply-To: <20180523183103.cdgv4slom62y56wi@linux-n805>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 May 2018 11:52:25 -0700
Message-ID: <CA+55aFwJtj5ucfx3T-g9VnNgWG7EqHS9+oFMSv8oyv11Yaa2UQ@mail.gmail.com>
Subject: Re: semantics of rhashtable and sysvipc
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 11:47 AM Davidlohr Bueso <dave@stgolabs.net> wrote:

> Note that even if the allocation was guaranteed, there are still param
validations
> and rhashtable_init() can return -EINVAL.

So?

It's not going to happen, because you're not going to give garbage
parameters.

Why would you add a BUG_ON() for something that cannot happen? You might as
well sprinkle them randomly in every damn place.

And even if somebody screws up the parameters because they are being
stupid, then SO WHAT? rhashtable_init() won't initialize the pointers, and
we'll get a NULL pointer dereference.

And hey, we'll probably get it later during boot, once the system is
actually up and running, and that NULL pointer dereference might even get
logged in the system logs now because the machine booted successfully, and
mnaybe it will even get sent to a distro and debugged.

So at what point was there _any_ advantage in doing a BUG_ON() for a crazy
case?

Really.

                Linus
