Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B48C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2487320831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WrhoJ3CX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2487320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJYPJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:09:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37317 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeJYPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:09:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id c15-v6so7347330eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 23:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u5XkkSagAeajJv7AxfwwqXQyLWpG4fQzel6rrOXzfTk=;
        b=WrhoJ3CXtMS9pUMC+2NoWU3/69pWr6mggrQOA1U7vfchMPXLvW7+ILzJQ2ZTR5/nsR
         NaTIv6x5H51+g79JKsbaP59gYtNd3cjQvS0aGKAgdpa0z+7vugLicDeeHOhQTA65+3xj
         aDrdKDl4L6y4H2KIPlGT0+f8N9bGEYA/ltCG/ei/lawgXtD/ub3Cu2JZIqPA5ysoV8eQ
         0KquFjdiKi6tmtzEq8MJPBjGFaMc7ifLmo5iAor0HQGDhVhD8/jIsKa6z2/NyxU3Xmfq
         lDBGY5IaJz2nsWxBGF9lglqRYqixn9EVMjLyXDbvEuBw/iCgJrkUVZ6ciXMe1vWAjLrB
         i4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u5XkkSagAeajJv7AxfwwqXQyLWpG4fQzel6rrOXzfTk=;
        b=DJv5DEaKE/K1yokVVQBuQhMYdbEq3ZsPddMScQHMiyz1R7ni51neQOrgHz8VxXmrwW
         753LZmRnNzXTIogCyqgrhNE79tMbTzz8OjdrsSJ/AN1zrctgNVjgOOUhcdgctMvWK9I6
         l3ih2rWZHqyg4Ddor+KF0zIj+pOlj0jZUSJfUKrafmWb7EkOfOnwro59pMtfUL0A9SVc
         E+qTj3b7iRmxgZ5q8YNGRpA2/7JN6+gINxljjDqyB0TAj9ciquMNZoBmYxxBNjEzHtlu
         s/z/8qmHhOn5yZX8WW/if1mw1m45qmGlw82vyLE4MOx5/grySAP8GCFAs7YJdOXJWHUM
         +QrA==
X-Gm-Message-State: AGRZ1gLm7UFj1prwpcBBpt+OD5aC3vFfIsy2mXmS4zpvmBn2fW41cRmj
        2aYCxQ3nBepmlk5m1CM+vzU4ZpfPhKu8eqEJuIpnag==
X-Google-Smtp-Source: AJdET5fjRILr9SRkqMA4xlLq7RmhT5W+t8SNMWzdh09IyUmEY4144NZlh/d/lpKCzsK5H5B6Jncd7Sjf4BluiCB9daY=
X-Received: by 2002:aa7:d2d0:: with SMTP id k16-v6mr539086edr.292.1540449487664;
 Wed, 24 Oct 2018 23:38:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:931d:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 23:37:47
 -0700 (PDT)
In-Reply-To: <a2fa755a-048b-459a-b526-2fe27cbb6574@arista.com>
References: <20181025034853.23573-1-vasilykh@arista.com> <a2fa755a-048b-459a-b526-2fe27cbb6574@arista.com>
From:   Vasiliy Khoruzhick <vasilykh@arista.com>
Date:   Wed, 24 Oct 2018 23:37:47 -0700
Message-ID: <CAL0zPMMhCxJSuvyV-D7f=bxczHEo1_Wz8OhUU6Ste=eY86xTrg@mail.gmail.com>
Subject: Re: [PATCH] netfilter: conntrack: fix calculation of next bucket
 number in early_drop
To:     Dmitry Safonov <dima@arista.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 9:52 PM, Dmitry Safonov <dima@arista.com> wrote:
> On 10/25/18 4:48 AM, Vasily Khoruzhick wrote:
>>
>> If there's no entry to drop in bucket that corresponds to the hash,
>> early_drop() should look for it in other buckets. But since it increments
>> hash instead of bucket number, it actually looks in the same bucket 8
>> times: hsize is 16k by default (14 bits) and hash is 32-bit value, so
>> reciprocal_scale(hash, hsize) returns the same value for hash..hash+7 in
>> most cases.
>>
>> Fix it by increasing bucket number instead of hash and rename _hash
>> to bucket to avoid future confusion.
>>
>> Fixes: 3e86638e9a0b ("netfilter: conntrack: consider ct netns in
>> early_drop logic")
>> Cc: <stable@vger.kernel.org> # v4.7+
>> Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
>
>
> Nice work!
>
> Reviewed-by: Dmitry Safonov <dima@arista.com>

Oops, found a bug in it - 'bucket' should be moved outside of the
loop. I'll send v2 tomorrow morning.

>
>> ---
>>   net/netfilter/nf_conntrack_core.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/netfilter/nf_conntrack_core.c
>> b/net/netfilter/nf_conntrack_core.c
>> index ca1168d67fac..a04af246b184 100644
>> --- a/net/netfilter/nf_conntrack_core.c
>> +++ b/net/netfilter/nf_conntrack_core.c
>> @@ -1073,19 +1073,22 @@ static unsigned int early_drop_list(struct net
>> *net,
>>         return drops;
>>   }
>>   -static noinline int early_drop(struct net *net, unsigned int _hash)
>> +static noinline int early_drop(struct net *net, unsigned int hash)
>>   {
>>         unsigned int i;
>>         for (i = 0; i < NF_CT_EVICTION_RANGE; i++) {
>>                 struct hlist_nulls_head *ct_hash;
>> -               unsigned int hash, hsize, drops;
>> +               unsigned int bucket, hsize, drops;
>>                 rcu_read_lock();
>>                 nf_conntrack_get_ht(&ct_hash, &hsize);
>> -               hash = reciprocal_scale(_hash++, hsize);
>> +               if (!i)
>> +                       bucket = reciprocal_scale(hash, hsize);
>> +               else
>> +                       bucket = (bucket + 1) % hsize;
>>   -             drops = early_drop_list(net, &ct_hash[hash]);
>> +               drops = early_drop_list(net, &ct_hash[bucket]);
>>                 rcu_read_unlock();
>>                 if (drops) {
>>
>
> --
>           Dima
