Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAA1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212DE20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L28U+PqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212DE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeLECtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:49:35 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:43864 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLECtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:49:35 -0500
Received: by mail-io1-f54.google.com with SMTP id f10so9646901iop.10;
        Tue, 04 Dec 2018 18:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PCBvX9s5iUr4KG02Mf7F60KrJg0h+OuE4z4iGyRamW4=;
        b=L28U+PqZfYnyR2dk5speoap7xelQ0W1IgC4VmYkoo9IZW1pU/Ay/WOsg8XTK0KH2fr
         luF6OiTcxhkvAZP61tgZjCUeKOmnA/IvcGhzzD2RZKWVroJ6js2ZmxkXWw1mGU1gmfN9
         rU9biH8B5cG1m1ej5GaS9cpMZ/VccMaq0sb4rnP26VtqSG1h/bCO4oO5EEvtRlcR6893
         EoGLD5Se2XUJ2WPPJUxgAeMzi80E625tug8+5HJzGKNnsEKK9OylGAAFStm+Yut7qu3e
         YxcliAa0X0GrJPuvXgTOUW9JNrBTARlA2R6kDU5pTupzoV+FBz9Kz5YZqVCgyeCLmbcJ
         /1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PCBvX9s5iUr4KG02Mf7F60KrJg0h+OuE4z4iGyRamW4=;
        b=HbNEjLbIpneMoQ+O3bYqB770KP8IOycxfUUd7nBQ4OpBigYoUaeEVUZmWeB/fasYwM
         gghww27gMQNIEVNtgJp6hyWuDchqKAG4dqnfXzVKZaUXJ4iYZE1y7xZxwMP/ukTGrT5P
         N8gbkQf1X7u7/l1cTgm/7xh0cbjd4pIiWnTR3XyejU3GJB/jYZB/PD4ziJjhUdBRxYtX
         rpdR4t+VjdKResFJNHw+i2zEqqHe7Td6Dw72TccFtvOVTIQrTsl9FH1TZ+evEIyUE4X5
         qqodroeDWMBDShgQFJ6cDJxAaHtOm6qvM1CFSVMWrRgElZmaihEbwsbTIi4d7Oa31wb+
         +5YA==
X-Gm-Message-State: AA+aEWbdIRIxWZdiTPNfGHASKrEaexactTNlBGcocNa21OzRZS/FPui1
        UwWy10j61kRil8xEIfQGXE0=
X-Google-Smtp-Source: AFSGD/W8buFKZV/dysYKtQP09yyBr69wnyIvdMXmb/rnT7/qWEJbDAVeZoiifgb4R78KcakDtg48Gg==
X-Received: by 2002:a6b:3b47:: with SMTP id i68mr19376206ioa.133.1543978173629;
        Tue, 04 Dec 2018 18:49:33 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:ffc9])
        by smtp.gmail.com with ESMTPSA id l25sm7263736ioj.68.2018.12.04.18.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 18:49:32 -0800 (PST)
Date:   Tue, 4 Dec 2018 18:49:30 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Aaron Conole <aconole@bytheb.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Rony Efraim <ronye@mellanox.com>,
        Simon Horman <horms@verge.net.au>,
        Marcelo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [RFC -next v0 1/3] bpf: modular maps
Message-ID: <20181205024928.57xcrgspllcr7umo@ast-mbp.dhcp.thefacebook.com>
References: <20181125180919.13996-1-aconole@bytheb.org>
 <20181125180919.13996-2-aconole@bytheb.org>
 <20181127020608.4vucwmhrtu2cxrwu@ast-mbp.dhcp.thefacebook.com>
 <f7tftvmd2ey.fsf@dhcp-25.97.bos.redhat.com>
 <20181128051001.wcsgqx3d6c2aszp6@ast-mbp.dhcp.thefacebook.com>
 <f7to9a99gsh.fsf@dhcp-25.97.bos.redhat.com>
 <20181129041948.pepdcksplt6xppk3@ast-mbp>
 <f7twoou65gi.fsf@dhcp-25.97.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7twoou65gi.fsf@dhcp-25.97.bos.redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:49:17AM -0500, Aaron Conole wrote:
> 
> While this is one reason to use hash map, I don't think we should use
> this as a reason to exclude development of a data type that may work
> better.  After all, if we can do better then we should.

I'm all for improving existing hash map or implementing new data types.
Like classifier map == same as wild-card match map == ACL map.
The one that OVS folks could use and other folks wanted for long time.

But I don't want bpf to become a collection of single purpose solutions.
Like mega-flow style OVS map.
That one does linear number of lookups applying mask at a time.

It sounds to me that you're proposing "NAT-as-bpf-helper"
or "NAT-as-bpf-map" type of solution.
That falls into single purpose solution category.
I'd rather see generic connection tracking building block.
The one that works out of skb and out of XDP layer.
Existing stack-queue-map can already be used to allocate integers
out of specified range. It can be used to implement port allocation for NAT.
If generic stack-queue-map is not enough, let's improve it.

> >> forward direction addresses could be different from reverse direction so
> >> just swapping addresses / ports will not match).
> >
> > That makes no sense to me. What would be an example of such flow?
> > Certainly not a tcp flow.
> 
> Maybe it's poorly worded on my part.  Think about this scenario (ipv4, tcp):
> 
> Interfaces A(internet), B(lan)
> 
> When XDP program receives a packet from B, it will have a tuple like:
> 
> source=B-subnet:B-port  dest=inet-addr:inet-port
> 
> When XDP program receives a packet from A, it will have a tuple like:
> 
> source=inet-addr:inet-port  dest=gw-addr:gw-port

first of all there are two netdevs.
one XDP program can attach to multiple netdevs, but in this
case we're dealing with two indepedent tcp flows.

> The only data in common there is inet-addr:inet-port, and that will
> likely be shared among too many connections to be a valid key.

two independent tcp flows don't make a 'connection'.
That definition of connection is only meaningful in the context
of the particular problem you're trying to solve and
confuses me quite a bit.

> I don't know how to figure out from A the same connetion that
> corresponds to B.  A really simple static map works, *except*, when
> something causes either side of the connection to become invalid, I
> can't mark the other side.  For instance, even if I have some static
> mapping, I might not be able to infer the correct B-side tuple from the
> A-side tuple to do the teardown.

I don't think I got enough information from the above description to
understand why two tcp flows (same as two tcp connections) will
form single 'connection' in your definition of connection.

> 1. Port / address reservation.  If I want to do NAT, I need to reserve
>    ports and addresses correctly.  That requires knowing the interface
>    addresses, and which addresses are currently allocated.  The stack
>    knows this already, let it do these allocations then.  Then when
>    packets arrive for the connection that the stack set up, just forward
>    via XDP.

I beg to disagree. For NAT use case the stack has nothing to do with
port allocation for NATing. It's all within NAT framework
(whichever way it's implemented).
The stack cares about sockets and ports that are open on the host
to be consumed by the host.
NAT function is independent of that.

> 2. Helpers.  Parsing an in-flight stream is always going to be slow.
>    Let the stack do that.  But when it sets up an expectation, then use
>    that information to forward that via XDP.

XDP parses packets way faster than the stack, since XDP deals with linear
buffers whereas stack has to do pskb_may_pull at every step.
The stack can be optimized further, but assuming that packet parsing
by the stack is faster than XDP and making techincal decisions based
on that just doesn't seem like the right approach to take.

