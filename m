Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BFBC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1942075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVk+HWxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1942075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJZGVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:21:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38155 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeJZGVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:21:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id k19-v6so8033357oiw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x09gQi54aERPFy6DLYU0hJUZ+AhWmZkO0Y3K+S+fsn0=;
        b=LVk+HWxWYFidNVirDU2GQQH6uAV0aPl4sBojHu4Vu9SzDmDXqN4g3lhXh9AXrgXw7e
         t55m2/S4+KNkn/Nydxi8g/LajCL/l2IKVzYpc6BOD0Nz8BNXur5CsXza8TiNdG9hqX7f
         iS0X+bFd5STxAUkeO94+3uFRgzTSvkpXWAn+8BcbaVIHn6rFxq+3cfTSHLemCuZKsnZM
         QYrNeCJvNhVFKjGkv6z1vE9gzEqwof/+pwF5kUFe48/pdwr3kDuV3QB04nHVSGZerq50
         rY+De4Gb6DnnnSPDsHVSlqdymZBVbHauHbpy/ATN1JUQuTRLGTx7zQNSWKLMHGrHifOw
         Insw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x09gQi54aERPFy6DLYU0hJUZ+AhWmZkO0Y3K+S+fsn0=;
        b=sODJC6vh/jYUp/Xq0Nv8LJC3mT57W5dlso2FBagdubGxTOe9TCQ0vT1P642aPH9ocK
         /+3v5ROxrKNa07w9GYtJZe/kvS+s0zREFH9Brlk+SvsbrBi+U7dXqK/MO5roAIhRfTj8
         8uSt/0rxkY0qISCpLbkpFWXnxv1vFbZ7mUYVsjR4fTETBuDTlS8mgBh5DJ5tbUbUZgRP
         ZkEZOCN9jdf5Jhrl6tS4I0n935PTEgu5QaZ8GEeEAZOV6hvH4GYAxiezFv2SZcnT7KaD
         gRIG4jjbPfufo767HM1PAFaRyRS/GYL1pB2KdnEvt0igWT3FOZRPKW/l/H2j5Lj49cSy
         JI3Q==
X-Gm-Message-State: AGRZ1gLDgy7SIKQKMeF1J7Nt8sFq9BiGeruXL9NyvQpx+c3T0QrzYEO3
        uPHufmRhvv7eb5YR0sDA7QrR/kSl9c8K/X49Db5cN5yVDNE=
X-Google-Smtp-Source: AJdET5doKOmK4y/RQoXw3noBaKStltCe2E9pW+YDG+31ywQCnsaLpP1cuwukJ+Pfi1PZ1bpwbEmK9Gdl2kUU6LUHltQ=
X-Received: by 2002:aca:ebcd:: with SMTP id j196-v6mr575518oih.206.1540504021928;
 Thu, 25 Oct 2018 14:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181025211352.112096-1-brendanhiggins@google.com> <d787249c-0679-065a-62cb-ee9f87b1fba3@gmail.com>
In-Reply-To: <d787249c-0679-065a-62cb-ee9f87b1fba3@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 25 Oct 2018 14:46:50 -0700
Message-ID: <CAFd5g44jmpDyeh--=Hd2fAexzik4gMYLMdNhAMqxWqnjSh4KeA@mail.gmail.com>
Subject: Re: [PATCH v1] net: ipv6: fix racey clock check in route cache aging logic
To:     eric.dumazet@gmail.com
Cc:     "David S . Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:40 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 10/25/2018 02:13 PM, Brendan Higgins wrote:
<snip>
> >
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 2a7423c394560..54d28b91fd840 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -1734,7 +1734,7 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
> >                       rt6_remove_exception(bucket, rt6_ex);
> >                       return;
> >               }
> > -     } else if (time_after(jiffies, rt->dst.expires)) {
> > +     } else if (time_after(now, rt->dst.expires)) {
> >               RT6_TRACE("purging expired route %p\n", rt);
> >               rt6_remove_exception(bucket, rt6_ex);
> >               return;
> >
>
>
> I do not think there is a bug here ?
>
> As a matter of fact, using the latest value of jiffies is probably better,
> since in some cases the @now variable could be quite in the past.

Then why do we pass the `now` parameter in at all and use it at all,
like here: https://elixir.bootlin.com/linux/latest/source/net/ipv6/route.c#L1764
?

I am still skeptical that we should check jiffies in each check, but
we should at least be consistent.

Cheers
