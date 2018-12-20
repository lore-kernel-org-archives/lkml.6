Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00574C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41AF21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l22j0+xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbeLTOQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:16:15 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40913 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731305AbeLTOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:16:14 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D87A0C36;
        Thu, 20 Dec 2018 09:16:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 20 Dec 2018 09:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QatfxE
        oJIobX0gpt1C7BLyb+ceu+nWCmsbM10oCqwmw=; b=l22j0+xwEHnYuhBEnU/U/F
        Fjl/GfKAIpDQKp65PSSyCsTI17Z6vOmSsSnKrs+znFgf15oQsgfkJG8XqARTCnh2
        raGVJi2rwh+NRfU6D1A0yc0jfFnsR0UQ5LMQ8hbX4yGS+BdwP3txxRTUVoHVSGwl
        g+PUCN8VSs8tIc8b24kk15xm0IVHGyHHyKcW+6j4y+ea0ZFmXwvSks7gpc4lLE0L
        4mfPYkTt0RJWaGfjim/uLdjol/eQ286mQZlKg7StwXAH/6akC7SXJTHpCNwl2Va+
        N6zNuKZvZCF8C9i6RJTJNde4oCMJBwvJhzwGAt7SBc0dj55EwUxLsux+b+5DiclA
        ==
X-ME-Sender: <xms:K6QbXFkSJxuGs4d5u_6eMivN24N_ewul2rgGVHd_gMQz3qycOGMcjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudejfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehttdertddtredvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehi
    ughoshgthhesihguohhstghhrdhorhhgqeenucfkphepudelfedrgeejrdduieehrddvhe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:K6QbXFG7T2MLg2bkjOhv5-IkmhPazDhNGglkJzXQWue8MuBhgbUeaw>
    <xmx:K6QbXGp0lJkxQfSLcaF_CbYFr7hqH-qxzm6tRgcBBnSpkrcfZTdoMw>
    <xmx:K6QbXJ7WgxFPM3aymxNEDHnfpvgD02mas2KTM_rIf7FCjYM3PiuoEA>
    <xmx:LKQbXD2H6_c1g_gvpsifIkDwERixPaNlQozLT8r0RYLFjYmqeOmBrg>
Received: from localhost (unknown [193.47.165.251])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1603DE4558;
        Thu, 20 Dec 2018 09:16:10 -0500 (EST)
Date:   Thu, 20 Dec 2018 16:16:09 +0200
From:   Ido Schimmel <idosch@idosch.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Willem de Bruijn <willemb@google.com>,
        Michael S Tsirkin <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at
 net/core/flow_dissector.c:764 __skb_flow_dissect
Message-ID: <20181220141609.GA861@splinter>
References: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com>
 <20181220091207.GA25942@splinter>
 <CAF=yD-LJe_YjH-ssVb1c+yvEvKSDgBzUFMD8NxWKCKOEJPw30w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-LJe_YjH-ssVb1c+yvEvKSDgBzUFMD8NxWKCKOEJPw30w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 09:04:25AM -0500, Willem de Bruijn wrote:
> On Thu, Dec 20, 2018 at 6:15 AM Ido Schimmel <idosch@idosch.org> wrote:
> >
> > +Willem
> >
> > On Thu, Dec 20, 2018 at 08:45:40AM +0100, Christian Borntraeger wrote:
> > > Folks,
> > >
> > > I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
> > > Maybe someone has a quick idea.
> > >
> > > [85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318
> >
> > I managed to trigger this warning as well the other day, but from a
> > different call path:
> >
> > [280155.348610]  fib_multipath_hash+0x28c/0x2d0
> > [280155.348613]  ? fib_multipath_hash+0x28c/0x2d0
> > [280155.348619]  fib_select_path+0x241/0x32f
> > [280155.348622]  ? __fib_lookup+0x6a/0xb0
> > [280155.348626]  ip_route_output_key_hash_rcu+0x650/0xa30
> > [280155.348631]  ? __alloc_skb+0x9b/0x1d0
> > [280155.348634]  inet_rtm_getroute+0x3f7/0xb80
> 
> inet_rtm_getroute builds a new packet with inet_rtm_getroute_build_skb
> here without dev or sk.

Ack

> 
> > Problem is the synthesized skb for output route resolution does not have
> > skb->dev or skb->sk set. When a multipath route is hit and
> > net.ipv4.fib_multipath_hash_policy is set the flow dissector is called
> > with this skb and the warning is triggered.
> >
> > I plan to fix it by setting skb->dev to net->loopback_dev.
> 
> The device can be chosen based on iif in inet_rtm_getroute? A first
> thought, I don't know this code very well.

Yes, but iif is for input routes. I'm talking about output routes.

> Let me know if you want me to take a stab at that patch. IPv6 probably
> will need the same.

Yes, I'll try it now and post later today if everything is OK. IPv6 is
using flow info and not an skb, so no problem there. I also checked
other getroute implementations and none of them call into the flow
dissector with an skb, so I think we're fine.

> 
> > I assume we
> > want to keep this warning to prevent call paths which will otherwise
> > silently fallback to standard flow dissector instead of the BPF one.
> 
> Indeed, the warning is there to sniff out paths that do not follow
> what I thought was an invariant. If there are too many exceptions, I
> may have to revisit that assumption. But for now, let's see if we can
> address these edge cases.

Ack

> 
> > I'm not familiar with tap code, so someone else will need to patch this
> > case, but it looks like:
> >
> > tap_sendmsg()
> >     tap_get_user()
> >         skb_probe_transport_header()
> >             skb_flow_dissect_flow_keys_basic()
> >                 __skb_flow_dissect()
> >
> > skb->dev is only set later in the code.
> 
> tap_get_user uses sock_alloc_send_pskb (through tap_alloc_skb) to
> allocate the skb. So skb->sk should be set at the time of
> skb_probe_transport_header. I'm not sure how this path triggers the
> warning.

Maybe it's:

tap_sendmsg()
    tap_get_user_xdp()
        build_skb()
	    skb_probe_transport_header()
	        skb_flow_dissect_flow_keys_basic()
		    __skb_flow_dissect()

