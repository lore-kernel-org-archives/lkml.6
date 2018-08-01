Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF52208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vn6qB8CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF52208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbeHAM0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:26:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42966 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbeHAM0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:26:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so8599901plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3M4sBadFEFJG2NUCcJ+Pg/X6EyZYgx2cEKus78QOmEM=;
        b=vn6qB8CPlDWlEJujQzfRSc9tAr4OECHhLP/inJcZ3JaWJq1N6CPnf1gipODZlGJV86
         Xq3188y+M9MkF2R1ITmLLdSrpMda1KvKTC0nCU2wIYJXsXI5Nkx7er6b0SI9GO5/gd5l
         AZwsK5Y8SM2VVvUCXHxdEG+X4rYsx2GD5ds6eEVYVYWJ1hHz4FOHBGKz32fEE6HGbaP+
         KN+AosNmLS8fKq33MZS7zm0fT1IENriGUIqsLhD3b5xjys/x9N9YHfDEjWsqqUVBQaL/
         VAdJG5THH5EgiA2+T2D2xPyBOfNXBjSl0NZyND0DtTqMsr69y+fK4jiWetEg1sIq1XV3
         mOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3M4sBadFEFJG2NUCcJ+Pg/X6EyZYgx2cEKus78QOmEM=;
        b=klTCZMf8pOuURrPrZzOFONRMwJyHWX1WjKW0QVAc9WLEmqruW5DeFJ8HpcHSKpFt2U
         0EY7yOgWD/BXgXJMopMGLoFcrx7vMRXYQ1V3nYaXh5SaDYSWyvtnIaqmeG7xWF+IOX46
         DZt2BjSXiT6lSa2PO2FUPDFi04z9ZN47ncPuI/m73sMY53Z7yYHuoKfnvEIkSOYbT06a
         D7t88k5wiKZEjIxmZTUaIvfZpirRUfVO190hE9tr9IR8nNtNOeMOD0TNL8+uAp24G0uC
         sw2dSUG+D5Atfm9Sjwxhi7AatZMpMsqUN7h9m0CPNAhWXZrcN4lex6wasW40Wwfkrez0
         mk/g==
X-Gm-Message-State: AOUpUlHz8AVyHeyvmeZiKhoa0m5DnodtwU4cA6Lx6WGlWQUA+FY3SEQF
        dY/lPfZ6HaRPi0jcrV2vaseAL0867kzAE0kbSzHKQA==
X-Google-Smtp-Source: AAOMgpfsDynppIxaUY8E2167HXKa4hYqjp0H3PM3GOda035d/tUEsf+4olnpK8zm1fP3avq8dPk0Sk6EuBUEsJtsTDw=
X-Received: by 2002:a17:902:4401:: with SMTP id k1-v6mr22012929pld.97.1533120090255;
 Wed, 01 Aug 2018 03:41:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 03:41:09
 -0700 (PDT)
In-Reply-To: <20180801103537.d36t3snzulyuge7g@breakpoint.cc>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <CACT4Y+aYZumcc-Od5T1AnP4mwn8-FaWfxvfb93MnNwQPqG8TDw@mail.gmail.com>
 <CACT4Y+ZkgqDT77dshHg+hBtc9YPW-eZ8wVQA9LTDQ6q_y99oiQ@mail.gmail.com> <20180801103537.d36t3snzulyuge7g@breakpoint.cc>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 12:41:09 +0200
Message-ID: <CACT4Y+aHWpgDZygXv=smWwdVMWfjpedyajuVvvLDGMK-wFD5Lw@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Florian Westphal <fw@strlen.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 12:35 PM, Florian Westphal <fw@strlen.de> wrote:
> Dmitry Vyukov <dvyukov@google.com> wrote:
>> Still can't grasp all details.
>> There is state that we read without taking ct->ct_general.use ref
>> first, namely ct->state and what's used by nf_ct_key_equal.
>> So let's say the entry we want to find is in the list, but
>> ____nf_conntrack_find finds a wrong entry earlier because all state it
>> looks at is random garbage, so it returns the wrong entry to
>> __nf_conntrack_find_get.
>
> If an entry can be found, it can't be random garbage.
> We never link entries into global table until state has been set up.


But... we don't hold a reference to the entry. So say it's in the
table with valid state, now ____nf_conntrack_find discovers it, now
the entry is removed and reused a dozen of times will all associated
state reinitialization. And nf_ct_key_equal looks at it concurrently
and decides if it's the entry we are looking for or now. I think
unless we hold a ref to the entry, it's state needs to be considered
random garbage for correctness reasoning.


>> Now (nf_ct_is_dying(ct) || !atomic_inc_not_zero(&ct->ct_general.use))
>> check in __nf_conntrack_find_get passes, and it returns NULL to the
>> caller (which means entry is not present).
>
> So entry is going away or marked as dead which for us is same as
> 'not present', we need to allocate a new entry.
>
>> While in reality the entry
>> is present, but we were just looking at the wrong one.
>
> We never add tuples that are identical to the global table.
>
> If N cores receive identical packets at same time with no prior state, all
> will allocate a new conntrack, but we notice this when we try to insert the
> nf_conn entries into the table.
>
> Only one will succeed, other cpus have to cope with this.
> (worst case: all raced packets are dropped along with their conntrack
>  object).
>
> For lookup, we have following scenarios:
>
> 1. It doesn't exist -> new allocation needed
> 2. It exists, not dead, has nonzero refount -> use it
> 3. It exists, but marked as dying -> new allocation needed
> 4. It exists but has 0 reference count -> new allocation needed
> 5. It exists, we get reference, but 2nd nf_ct_key_equal check
>    fails.  We saw a matching 'old incarnation' that just got
>    re-used on other core.  -> retry lookup
>
>> Also I am not sure about order of checks in (nf_ct_is_dying(ct) ||
>> !atomic_inc_not_zero(&ct->ct_general.use)), because checking state
>> before taking the ref is only a best-effort hint, so it can actually
>> be a dying entry when we take a ref.
>
> Yes, it can also become a dying entry after we took the reference.
>
>> So shouldn't it read something like the following?
>>
>>         rcu_read_lock();
>> begin:
>>         h = ____nf_conntrack_find(net, zone, tuple, hash);
>>         if (h) {
>>                 ct = nf_ct_tuplehash_to_ctrack(h);
>>                 if (!atomic_inc_not_zero(&ct->ct_general.use))
>>                         goto begin;
>>                 if (unlikely(nf_ct_is_dying(ct)) ||
>>                     unlikely(!nf_ct_key_equal(h, tuple, zone, net))) {
>>                         nf_ct_put(ct);
>
> It would be ok to make this change, but dying bit can be set
> at any time e.g. because userspace tells kernel to flush the conntrack table.
> So refcount is always > 0 when the DYING bit is set.
>
> I don't see why it would be a problem.
>
> nf_conn struct will stay valid until all cpus have dropped references.
> The check in lookup function only serves to hide the known-to-go-away entry.
