Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21511C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B79A2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8seunRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B79A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeKBCAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:00:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34880 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeKBCAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:00:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id 81so2578150otj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jnbci8OxpI4eb1LcUGAg6YwFg6MG3YmVabkIDyczYAo=;
        b=f8seunRn+snYRf4zElerT1EgyCdL1ijCY8MFStW0KM22tXWfmfMm4pN33ZDkpiXRJn
         wg4g5kJTR3/OR2+Nl0upoksdIYS2cN6hW6TO0gKBHMOixHJO5+9KHZ6fwILQLXKgRpQg
         ZlGBL+Ldjnfyi6rZ8VcAKrsP0SZ3CbUhLkD6dNgm3gv1M66GthI5ya9Q/i60NciuFBLy
         K12PqvmcpUz8h/Q9jj3e4hcq+vcIXVk1mx+aIHX53bZqi+YVPPoa7rPiresEgRSC2Brj
         +UT1Jqu8HpRgWNbvbVGg8ThaZt5iEgncb1GsUCwttKyAvNeyT2YuKaP6Hr/aEwvdSx5z
         p5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jnbci8OxpI4eb1LcUGAg6YwFg6MG3YmVabkIDyczYAo=;
        b=Ii/4DEyuJBwwQTIjeUdVOeBaLrl6YSVEIOWQ29ZmbVS9WcCjo3Kc8lqqQZjycHg2iG
         bV8T259xGTrX6BtC1/iKWNMSYQIS47iSeOerYzhtvQOpCCtVvpg6FlNzI1rUNwkfpWGy
         tNJInzBdR0n2tiAJOfR6A1N1neCF5jSBHQOZ+EDSJywm9uMekIJGRBV4qd79nLAOhyJ6
         M7Au3rbTtiuQKY3+308lAQwrhUrpKfPVJcJNjCiD+fEkKiqO1KK8mYkYr+50Khmqdrcx
         Ac37kTXu2DIk3wvOzflqe/PNsheVXofgiPIK3m8GuzRlc9VGe3NA4kKC2Mxd7u1oPHcZ
         zyug==
X-Gm-Message-State: AGRZ1gKHAUACmhKOzX1v5yxjhBDefY3RNOW6omRcF1H+QBW+HodtoVzo
        WGxQWkoG+zAcQzC1x4RRLRX5VhexIA/kVFv3Ccvklg==
X-Google-Smtp-Source: AJdET5f1plnBFgUCJt4XGT5r59sYxvDw343K+xZHywyTE7853tRrP3Xasl7pa8EF9JNiwtXmSjcUzCqCzekJ9kNNvQE=
X-Received: by 2002:a9d:40cd:: with SMTP id t13mr4732810oti.98.1541091425279;
 Thu, 01 Nov 2018 09:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181025211352.112096-1-brendanhiggins@google.com>
 <d787249c-0679-065a-62cb-ee9f87b1fba3@gmail.com> <CAFd5g44jmpDyeh--=Hd2fAexzik4gMYLMdNhAMqxWqnjSh4KeA@mail.gmail.com>
 <9ce74f5b-387d-b02f-2efa-f12c1450577c@gmail.com>
In-Reply-To: <9ce74f5b-387d-b02f-2efa-f12c1450577c@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 1 Nov 2018 09:56:54 -0700
Message-ID: <CAFd5g47U0Y4FHaxz5PCzpvCfnzDmGWQze364wA+hxmb3oKo8Sg@mail.gmail.com>
Subject: Re: [PATCH v1] net: ipv6: fix racey clock check in route cache aging logic
To:     eric.dumazet@gmail.com
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 3:15 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 10/25/2018 02:46 PM, Brendan Higgins wrote:
> > On Thu, Oct 25, 2018 at 2:40 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >> On 10/25/2018 02:13 PM, Brendan Higgins wrote:
> > <snip>
> >>>
> >>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> >>> index 2a7423c394560..54d28b91fd840 100644
> >>> --- a/net/ipv6/route.c
> >>> +++ b/net/ipv6/route.c
> >>> @@ -1734,7 +1734,7 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
> >>>                       rt6_remove_exception(bucket, rt6_ex);
> >>>                       return;
> >>>               }
> >>> -     } else if (time_after(jiffies, rt->dst.expires)) {
> >>> +     } else if (time_after(now, rt->dst.expires)) {
> >>>               RT6_TRACE("purging expired route %p\n", rt);
> >>>               rt6_remove_exception(bucket, rt6_ex);
> >>>               return;
> >>>
> >>
> >>
> >> I do not think there is a bug here ?
> >>
> >> As a matter of fact, using the latest value of jiffies is probably better,
> >> since in some cases the @now variable could be quite in the past.
> >
> > Then why do we pass the `now` parameter in at all and use it at all,
> > like here: https://elixir.bootlin.com/linux/latest/source/net/ipv6/route.c#L1764
> > ?
> >
> > I am still skeptical that we should check jiffies in each check, but
> > we should at least be consistent.
>
> Well, this is a case where we do not really care.
>
> When a bug is fixed (you added a Fixes: tag which is good), we want
> to understand the real problem that needs to be fixed on stable kernels.

So by bug you mean user visible bug?
>
> Since this does not seem to be a real issue, I would suggest you send a cleanup
> patch when net-next is open (few days after linux-4.20-rc1 is release)

Sounds good, I will resend shortly.

Thanks!
