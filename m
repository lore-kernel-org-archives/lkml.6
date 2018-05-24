Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2350608-1527184422-2-17816373766060748628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527184421; b=OQFsGDiCkdYyjUSM4kEjqK6lO2tOvuCdLd6BC+4lyPrTFgB1Z+
    lmAVGNzT/2EGMPLdxeXYh9CYnb1aQiN8MaOv1mpz0Fj+dculTeDIdybvy/FW9Lo5
    N5muq3uW49HDCEn058josj7wHqyivkNHtdzzA3rMJiUvxD/BvtiVotlJASJWmmsk
    Zr0z+Jb3mXpg9Mho4q+eJbB+18VFb1tDi57pE4BE8iIO+j5TwD3MW+FCGm9F9Nkz
    dkJ1T2AsVsTcGiYOCRotT3/tmQTaovIh3UQgHSM6IhJgXGu30y7cPzj6wdqlhZq/
    U5niCb1lWq5911AIaWdxUlBKNHCSwmC+tEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527184421; bh=RZh/orBxd8EiMBLsipbSi+f8NZrXPveFe8x2+B5/o5
    8=; b=MKAlHGeymuDVVSS+0ZKvlzcIxF0miJpisO17QNj2pAWPazWFK+wIFLDD/w
    AyHvdO6L9Lkk6pT/wR0zOfdHMP1rQ7ciWTZUk8Iee9pH2Ri+f6CbNOdGVO5ohXQS
    AVgJyd1aZ6JBOH9/l7Pa6WvYd4D4ZbCNXvUhiMfiJwB/4yLhN4NZuUHKzq+GQYhx
    KRVN1iV39+4GY3nYDxaKmfad8ZCpbuz77nYrKgvYExL0jjM/T0hdtjStqWQAfhbY
    ePrrbfhK8poNINeoV6Bg22brDIVJRBa1pJZ5qotyHwze55jrOKNpLCdJYWj7fMO1
    h56DrY/iwnYYZF/uMrTyTWw9C/kA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linux-foundation.org header.i=@linux-foundation.org
    header.b=emGzJkbL x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=at0PGoPP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linux-foundation.org header.i=@linux-foundation.org
      header.b=emGzJkbL x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=at0PGoPP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAhsBBn0gz4FkbQlEk+SLyA8P1nN0Ekr9ABgmHMmR4XbnogpNDly59w+/+HMzvG2Q07S1qVMyToU5NeQxGM3UPQGDurooa6DIMmOENFKmm9MyW4HlO6K
    oeLcyrXc3rgBd5wCRIzm2HrXAghzwocxRFQbrg5yFRrhIDkLO2kAlPJNjJQ3PwLsIImTt364PYwrnesuQFDVJJPehNFzQ/zz/sCEGlqKdOcah8infqiRuCSc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=R4ayLD03AAAA:8 a=VwQbUJbxAAAA:8 a=kAdJWrUr-JonDoMVUH4A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=qJlm0-shE6CLU_iKUWNr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032113AbeEXRxj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 13:53:39 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36154 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030467AbeEXRxi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 May 2018 13:53:38 -0400
X-Google-Smtp-Source: AB8JxZr6G6OLCYdoG/N9ZA511ZVvUws71F3ryaCA93qaEcF3DjG8i8EYpXQ8KxV98ZBTABHfv1GHGn46yF797QivG8Y=
MIME-Version: 1.0
References: <20180523172500.anfvmjtumww65ief@linux-n805> <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
 <20180524170700.wblnybinjzx5rwky@linux-n805>
In-Reply-To: <20180524170700.wblnybinjzx5rwky@linux-n805>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 May 2018 10:53:26 -0700
Message-ID: <CA+55aFwhkOnHngHpQ3wif5iy7PtOAVdjTcwce=kgBq0TCgmfJA@mail.gmail.com>
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

On Thu, May 24, 2018 at 10:23 AM Davidlohr Bueso <dave@stgolabs.net> wrote:

>          tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
> -       if (tbl == NULL)
> -               return -ENOMEM;
> +       if (unlikely(tbl == NULL)) {
> +               size = min(size, HASH_DEFAULT_SIZE) / 2;
> +
> +               tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
> +               if (tbl == NULL)
> +                       tbl = bucket_table_alloc_retry(ht, size,
GFP_KERNEL);
> +       }

This doesn't seem to be taking 'param->min_size' into account.

I'm not sure that matters, but right now, if you have nelem_hint set and a
min_size, the min_size is honored (if you have just min_size it's already
ignored because the rhashtable always starts with HASH_DEFAULT_SIZE). So I
could imagine that somebody uses it to guarantee something. The docs say
that "min_size" is the minimum size for *shrinking* not for initializing,
so I guess it's debatable.

Also, wouldn't it make sense to make this all be a while loop? Or are you
just depending on the knowledge that HASH_DEFAULT_SIZE / 2 is already
guaranteed to be so small that there's no point? A comment to that effect
would be good, perhaps.

                    Linus
