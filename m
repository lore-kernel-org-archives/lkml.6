Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F124C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BE3218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTGiFtbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbeLTOfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:35:03 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42918 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733267AbeLTOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:34:56 -0500
Received: by mail-ed1-f52.google.com with SMTP id y20so1924757edw.9;
        Thu, 20 Dec 2018 06:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Pjht520TEwF0aB8D0Lv/he+18DgT7hCbUV8W5F+bkU=;
        b=vTGiFtbdHwbm6mKg62U3mgvEPfZMgoqz+bQlj1CNfE2uBKCMoxKqf2en+7JS8F0gXm
         ANXjv3sHfpEijtGPGxGsSh+iZBQ/F2vnCBCYkRTD+X3VFazglBwkKKD1ki0Ild9Ym82M
         y7h1Xz3hrDmkBkxcU86vCgrPZnuIF3eSmwHAGuQ/+lJcLLL/e9tm0/qWdTFjZEUoMdRW
         CFzRfitCnlUrJvXw8hHiI1eJWKqrGRvl3WyEzMBTfNpwZWYAYTu3oonzqX5PDXrESui3
         v2djn0YTI6CbvuZth4ojqhM3dllwfCbcMCMqEDtUDfYXak6nlqSjEn9jnp0S6noJogsv
         Lkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Pjht520TEwF0aB8D0Lv/he+18DgT7hCbUV8W5F+bkU=;
        b=CiDDSoiOzsMCdaQXr4FwnCW4lRREasiMw00LEKo6/VIS/km8ViO9EYFsBTHYtG1Iia
         2u7mM0J/kMGdFj+sWXB51EzU9E6685VXpcAFOEdliQGGzp8LZekju3Xl6CQwtGCiJvYZ
         hmE7x4Pdtb1KfNJn1asb1JB44+alafdRNa9oYBfe44rEvolkjSL/o7QUjn3HgGQBjkLh
         bEvOeHJkgG7vEQDLRrQWSR1qFwEf929MKVHKeRiPOlVTOJRi7c3WVeM9/E21a6qdKsZQ
         Ohn6IIS5SAOTZaIYeqqQQ6pFnrOyv35bNuEQeZwjC0ekicjgJinaXZ3WhWmR/2VF+kxh
         Cgyg==
X-Gm-Message-State: AA+aEWbLNrcTQvf9f4gOWEBqvSSBBNLQUIdXsz0gCtRAruUXg1VMgapB
        AdQqux52s7aE+A5FVAVO2lzqXyJoYlycqIMuhmM=
X-Google-Smtp-Source: AFSGD/VuZU9Fkj3UAkgDCJWpfalRy17LEhiGfX6UnjRHpbuzoMAcMBZj5Dul/XE0AMxQfvcXpzqGGqbRlUX1QrRp0MU=
X-Received: by 2002:a17:906:ca03:: with SMTP id jt3-v6mr19621802ejb.165.1545316493540;
 Thu, 20 Dec 2018 06:34:53 -0800 (PST)
MIME-Version: 1.0
References: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com>
 <20181220091207.GA25942@splinter> <CAF=yD-LJe_YjH-ssVb1c+yvEvKSDgBzUFMD8NxWKCKOEJPw30w@mail.gmail.com>
 <20181220141609.GA861@splinter>
In-Reply-To: <20181220141609.GA861@splinter>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 20 Dec 2018 09:34:17 -0500
Message-ID: <CAF=yD-K6Y=Jt=KNLOtg-_c32bnp__c_3RM4XvO6Q-Zye-nd4=A@mail.gmail.com>
Subject: Re: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764
 __skb_flow_dissect
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Willem de Bruijn <willemb@google.com>,
        Michael S Tsirkin <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 9:16 AM Ido Schimmel <idosch@idosch.org> wrote:
>
> On Thu, Dec 20, 2018 at 09:04:25AM -0500, Willem de Bruijn wrote:
> > On Thu, Dec 20, 2018 at 6:15 AM Ido Schimmel <idosch@idosch.org> wrote:
> > >
> > > +Willem
> > >
> > > On Thu, Dec 20, 2018 at 08:45:40AM +0100, Christian Borntraeger wrote:
> > > > Folks,
> > > >
> > > > I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
> > > > Maybe someone has a quick idea.
> > > >
> > > > [85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318
> > >
> > > I managed to trigger this warning as well the other day, but from a
> > > different call path:
> > >
> > > [280155.348610]  fib_multipath_hash+0x28c/0x2d0
> > > [280155.348613]  ? fib_multipath_hash+0x28c/0x2d0
> > > [280155.348619]  fib_select_path+0x241/0x32f
> > > [280155.348622]  ? __fib_lookup+0x6a/0xb0
> > > [280155.348626]  ip_route_output_key_hash_rcu+0x650/0xa30
> > > [280155.348631]  ? __alloc_skb+0x9b/0x1d0
> > > [280155.348634]  inet_rtm_getroute+0x3f7/0xb80
> >
> > inet_rtm_getroute builds a new packet with inet_rtm_getroute_build_skb
> > here without dev or sk.
>
> Ack
>
> >
> > > Problem is the synthesized skb for output route resolution does not have
> > > skb->dev or skb->sk set. When a multipath route is hit and
> > > net.ipv4.fib_multipath_hash_policy is set the flow dissector is called
> > > with this skb and the warning is triggered.
> > >
> > > I plan to fix it by setting skb->dev to net->loopback_dev.
> >
> > The device can be chosen based on iif in inet_rtm_getroute? A first
> > thought, I don't know this code very well.
>
> Yes, but iif is for input routes. I'm talking about output routes.
>
> > Let me know if you want me to take a stab at that patch. IPv6 probably
> > will need the same.
>
> Yes, I'll try it now and post later today if everything is OK. IPv6 is
> using flow info and not an skb, so no problem there. I also checked
> other getroute implementations and none of them call into the flow
> dissector with an skb, so I think we're fine.
>
> >
> > > I assume we
> > > want to keep this warning to prevent call paths which will otherwise
> > > silently fallback to standard flow dissector instead of the BPF one.
> >
> > Indeed, the warning is there to sniff out paths that do not follow
> > what I thought was an invariant. If there are too many exceptions, I
> > may have to revisit that assumption. But for now, let's see if we can
> > address these edge cases.
>
> Ack
>
> >
> > > I'm not familiar with tap code, so someone else will need to patch this
> > > case, but it looks like:
> > >
> > > tap_sendmsg()
> > >     tap_get_user()
> > >         skb_probe_transport_header()
> > >             skb_flow_dissect_flow_keys_basic()
> > >                 __skb_flow_dissect()
> > >
> > > skb->dev is only set later in the code.
> >
> > tap_get_user uses sock_alloc_send_pskb (through tap_alloc_skb) to
> > allocate the skb. So skb->sk should be set at the time of
> > skb_probe_transport_header. I'm not sure how this path triggers the
> > warning.
>
> Maybe it's:
>
> tap_sendmsg()
>     tap_get_user_xdp()
>         build_skb()
>             skb_probe_transport_header()
>                 skb_flow_dissect_flow_keys_basic()
>                     __skb_flow_dissect()

Oh, indeed. I completely overlooked that path.

I will call skb_set_owner_w there and will audit the other users of build_skb.
