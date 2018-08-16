Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B9AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDD321477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHCcB8Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDD321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbeHPFob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:44:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35804 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbeHPFoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:44:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10-v6so1355857pgv.2;
        Wed, 15 Aug 2018 19:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uMsso5hVmh09iPmOe6cZEMF50IlOd/J9fQ7ednVnwM=;
        b=bHCcB8KpNb8AXU6pji2Ay/8uWb9wny06lyDuvkxKwCffEKlin7t00vf1Fpd1As3vn7
         i5nCkdh6h9xoCGwz7+gkE4u3Qkda2L0HDAkn1L4Ro6TM6hKW2WbkF/qaMJWHWZMohEv7
         r/9yCiIWvoeSP/FZQNy5vhNUkxkp0vQ4WLOMt1NeUbin+nZ1tnuAilOOkcoi26naz4FR
         8qwZ7dhKOnmludyXfYGpxnv+wQoz2LjBqYmv/gXcCbfZKpVEUdYz2fbpek9k3htBO47/
         I+5Feb96DmklPOGgmNUzfw0Ylozhq+gj9Cf+MO283A1xMfzrbCJVHjw5BVkILrAwZSMu
         TiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uMsso5hVmh09iPmOe6cZEMF50IlOd/J9fQ7ednVnwM=;
        b=SX5ZJImGfuh/77jfUsSx5Hy+7VM6rGt62cWNgz0TTP9GCO1qJBUAztHwxrcbaHIiVN
         dQ3cIBryKyCc82u0mcqLL5bJgO2rkQU5Tb8BqCNdnieAgLBOTTSGDRx6eqn0RdOHy3QP
         408lO/cx1eXGB/QCBWsRkVh3IF/ZxaSbZNh2VeaZUSV0lIHNRb8y5Azs9jXPaYXazRDx
         P+SHWhBE0Xuy850tLVaKrT6W5kcm5KGOf7yNc14LW+SlCv+arB6KTaKRMXZOPOT50ZZb
         73v98NpiTGEsq5mkGjPEsD3aOh3JWMtsSCUGYArZ9/XiNrIW0I6fkrR6XQDWvoV6YK9B
         4qDA==
X-Gm-Message-State: AOUpUlHHfwZW/6DtFdj32xzNypx4QUb4Yr/J5AC/hBVKUQJCFZJtB2tq
        TB9eV38E6tjcWRKtiKI9v5A=
X-Google-Smtp-Source: AA+uWPySzpK2zVhHla+kWWz7KlAgzbro1pwn7TuZAYlNctNm58FBD6baWa3sl0kX0nGOXCfsbcQsCg==
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr27962334pgp.334.1534387758153;
        Wed, 15 Aug 2018 19:49:18 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:184a])
        by smtp.gmail.com with ESMTPSA id k12-v6sm37748034pfj.30.2018.08.15.19.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 19:49:17 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:49:15 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
Message-ID: <20180816024913.57ykirt7eqrjntfy@ast-mbp.dhcp.thefacebook.com>
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
 <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
 <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
 <20180814121734.105769fa@redhat.com>
 <03ab3b18-9b13-8169-7e68-ada307694bc1@redhat.com>
 <08bf7aec-078a-612d-833f-5b3d09a289d0@gmail.com>
 <aa9cf883-7822-70a7-5ab5-c873b69c2098@redhat.com>
 <20180815053550.5g4f5qeb7r4wtgm5@ast-mbp>
 <0809cbab-9c91-52f1-2abe-124a255d9304@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0809cbab-9c91-52f1-2abe-124a255d9304@redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 03:04:35PM +0800, Jason Wang wrote:
> 
> > > 3 Deliver XDP buff to userspace through macvtap.
> > I think I'm getting what you're trying to achieve.
> > You actually don't want any bpf programs in there at all.
> > You want macvlan builtin logic to act on raw packet frames.
> 
> The built-in logic is just used to find the destination macvlan device. It
> could be done by through another bpf program. Instead of inventing lots of
> generic infrastructure on kernel with specific userspace API, built-in logic
> has its own advantages:
> 
> - support hundreds or even thousands of macvlans

are you saying xdp bpf program cannot handle thousands macvlans?

> - using exist tools to configure network
> - immunity to topology changes

what do you mean specifically?

> 
> Besides the usage for containers, we can implement macvtap RX handler which
> allows a fast packet forwarding to userspace.

and try to reinvent af_xdp? the motivation for the patchset still escapes me.

> Actually, the idea is not limited to macvlan but for all device that is
> based on rx handler. Consider the case of bonding, this allows to set a very
> simple XDP program on slaves and keep a single main logic XDP program on the
> bond instead of duplicating it in all slaves.

I think such mixed environment of hardcoded in-kernel things like bond
mixed together with xdp programs will be difficult to manage and debug.
How admin suppose to debug it? Say something in the chain of
nic -> native xdp -> bond with your xdp rx -> veth -> xdp prog -> consumer
is dropping a packet. If all forwarding decisions are done by bpf progs
the progs will have packet tracing facility (like cilium does) to
show packet flow end-to-end. It works briliantly like traceroute within a host.
But when you have things like macvlan, bond, bridge in the middle
that can also act on packet, the admin will have a hard time.

Essentially what you're proposing is to make all kernel builtin packet
steering/forwarding facilities to understand raw xdp frames. That's a lot of code
and at the end of the chain you'd need fast xdp frame consumer otherwise
perf benefits are lost. If that consumer is xdp bpf program
why bother with xdp-fied macvlan or bond? If that consumer is tcp stack
than forwarding via xdp-fied bond is no faster than via skb-based bond.

