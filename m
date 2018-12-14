Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CE3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A8A2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="lvcKKFdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbeLNQFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:05:24 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:38066 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbeLNQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:05:23 -0500
Received: by mail-lf1-f53.google.com with SMTP id p86so4641996lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zsV169bVt4sxL8RcTXAl41qWZ0+iht/BBaciEJSQZ6Q=;
        b=lvcKKFduE7SfsxCEnBSUsMCvy9ZNwkrqrZ3qifDLfMN7l+VR6pmp2KjvbXI4GJi+4Q
         Y3HQpdFYlAuvA5BbyndY6easq0Olnm7+nwUekxWiRN3g1ZkRAfFpt51AVTkggyJVs0Ds
         dQ/5mG0TykfC6PwQQM2hciu9GxnQRz9P8WON03CkKrwuy3gQCz3BALKFcTtWTRO3hHcD
         vM+d9n3P3ybSJt1MobDinYsLR3AIufSB1lybzcZcR9Gapysy/3PyE3mwx38alSgQFZ9F
         cJXgUkFCQuIsMaB8jVTPeaNd6+kxyu46soj6sCmjYzjv5Ljh46AzyIsRb05RjIWi5YGi
         ZJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zsV169bVt4sxL8RcTXAl41qWZ0+iht/BBaciEJSQZ6Q=;
        b=VJ2ZKNL70ukHnZ4Mz0/S6VZW+yJ6shwvEXh1jIOeVedcdTVniYPBQ0gp2JLEFKlhLJ
         vM5XGGQKRar8HRWkAp2ibHFyKfAC2H8vu9xnB7bebse7vU48sIpbdhFN/614rKjWfeBi
         mFQ0dnVFveyE0jc0YZZ5o7vsXBg4vkU2Pt+WNLhb0+u346fetpIoAn7L/SzHr3k9Uid1
         H1BPZwn0CrUV3SwLlqvnWRFHCqU59QnsH+VJNQHf8od5BKCQa+Yp7gH+4fuWschUJxxg
         ini+nc+px7kG4KShf7umtb7YNoXHU/DG44l1buhbLZ6hx+QXwTCEaFrwz9F7r01p4RuR
         ixjA==
X-Gm-Message-State: AA+aEWax9dZtbRYpUtQvipHvSPwMm2u++x0Zmw86kMEuChucpK0KEc9w
        IE3wRxTWyo3JqjLoXT6857UsiEqiJtZvKa/Ekmyuwg==
X-Google-Smtp-Source: AFSGD/W9hz9zs0qGFrwzOSe/iFeyxdYAXHB4qtay7YfrgF/csukpHYNVWT6Trg5L8wKcdU+rv/eVX+QfkWIm78dp19c=
X-Received: by 2002:a19:1019:: with SMTP id f25mr2107054lfi.54.1544803521178;
 Fri, 14 Dec 2018 08:05:21 -0800 (PST)
MIME-Version: 1.0
References: <00000000000075fe86057ca6367e@google.com> <20181210124724.iuver2va3yjdsokf@breakpoint.cc>
 <20181210.095856.580441946779980596.davem@davemloft.net> <2559562.n5nkmlqv4s@stwm.de>
 <20181214143532.43zgy2hwkdskwfn2@breakpoint.cc>
In-Reply-To: <20181214143532.43zgy2hwkdskwfn2@breakpoint.cc>
From:   Christophe Gouault <christophe.gouault@6wind.com>
Date:   Fri, 14 Dec 2018 17:04:51 +0100
Message-ID: <CADdy8HpgzxLB-6QA+D5JfvhJmjyFUoFM1fQfz0rFAO6LEvRBAQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in xfrm_hash_rebuild
To:     Florian Westphal <fw@strlen.de>
Cc:     Wolfgang Walter <linux@stwm.de>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 14 d=C3=A9c. 2018 =C3=A0 15:35, Florian Westphal <fw@strlen.de> a =
=C3=A9crit :
> Ok.  An alternative would be to remove the support for
> policy hash table thresholds (which decide what kinds of policies
> go to exact table and which ones go into inexact ones), i.e.
> partially revert 880a6fab8f6ba5b5abe59ea6
> ("xfrm: configure policy hash table thresholds by netlink").
>
> This would remove the need for the rehashing support that
> re-sorts the policies into either exact/inexact lists) when the
> those tunables are changed.
>
> We could also easily convert the exact table to an rhashtable
> then if we wanted to.
>
> I guess we should probably wait to get some operational feedback on the
> inexact storage first to see if it really improves things enough to
> make threshold tuning unneccessary.
>
> Christophe, whats your take?

Hi Florian,

The main use cases I have encountered and tried to address with the
hash-based lookup were network operator use cases:
- a lot of dynamic /32 <=3D> /32 policies (protecting GTP tunnels)
- or a lot of dynamic policies with the same prefix lengths (e.g. /16 <=3D>=
 /24)
and a few non-hashed policies stored in the linked list.

This solutions gives good performance for both lookup *and*
configuration with a big number of SPs. The lookup time is essential,
but so is the IKE negotiation rate. And the configuration time has a
direct impact on it.

I have not yet had time to benchmark the new tree-based implementation.

Could you verify how the configuration time would behave in such use
cases if the hash-based lookup was replaced by a tree-based lookup?

Regards
Christophe
