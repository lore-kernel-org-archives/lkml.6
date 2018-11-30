Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B4DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1202082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytheb-org.20150623.gappssmtp.com header.i=@bytheb-org.20150623.gappssmtp.com header.b="Y/MY45wS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1202082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bytheb.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeLAA6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:58:44 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:35839 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeLAA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:58:44 -0500
Received: by mail-qk1-f172.google.com with SMTP id w204so3171594qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytheb-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9aZYvoHboDCva6KKk3fmSs5QqHEQci1WU7LbghdvoWg=;
        b=Y/MY45wSbGJBiDeek4/qugqbDfpGgITNvlcFDUXXYG0gl/stvnv1uXdFRCl7Nwu/M7
         eys1oWqtR+B94/9YAFW3k3h5nBJ7ew0w5El4Hu8eIrZn6u+tuoSrE0XFODHOlhF1lJjJ
         ZGJ6GVhuOJxROj4/7e2qt3WR6Zr1W90wJj/Vn9PwbQMp83q91cMfXrTki37+1a8JwKs3
         bKVumP8UcPyI0Lnb0ZmsJWJZhuXI4zxq7Us5GQqOcXAZVgFrDLbGdqzwHKGq/nZ9O4xc
         SOTtDaUYzIMupfvo7oHwsjyrHuobQ5gPNeUdZUTS/ouwvf26B6tIa4RCqC0a3DZe2JeH
         I4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=9aZYvoHboDCva6KKk3fmSs5QqHEQci1WU7LbghdvoWg=;
        b=D1s+3Fy9kxQjbO8Rd6ZAxGmjisZx+XotzDEWLXdtRcUxAEsHZCvEvWQFbBqOl3hwqh
         aYtt8Pcqp1jLc5ardImNlFtsVRpMPtULPKPOyPPNccmaYkdQpht3+d6Kcu7q8UCZBjjY
         zAVxlOFMngKd1nrMb4T83eXftrO75X4BNVp3Wc4prnfatCUCeh51eQSQ8hL4d5OHLFK7
         n4ZPErny5rPUQW92f2QdMMsbJrB8unsgjkdmWVUdbN4CLlkkfq0NF38HLXKvz/AjdRui
         ZoxXRea5I+oTG4B1h+0uQd4VZCVH1TpwqjxZE3goEDevdZBp8r+hLeoud0/HKKi8XwPV
         fmCw==
X-Gm-Message-State: AA+aEWbptsH33UAUN0BD/QS7WtnbnwbjQVIZMNQxLBgS8sfYFOQd3RIj
        uRnCtbWkZaRBckWalDu8G5MVTA==
X-Google-Smtp-Source: AFSGD/VxCae0mxTd2GAqjjRnk5L+5Wfhn8hWcJZfncTcJ+tHgtbZh0cTp/BbkB054l2ie6e8FvY1qg==
X-Received: by 2002:a37:3b8b:: with SMTP id i133mr5449051qka.28.1543585760731;
        Fri, 30 Nov 2018 05:49:20 -0800 (PST)
Received: from dhcp-25.97.bos.redhat.com (047-014-005-015.res.spectrum.com. [47.14.5.15])
        by smtp.gmail.com with ESMTPSA id v32sm3801921qta.37.2018.11.30.05.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 05:49:19 -0800 (PST)
From:   Aaron Conole <aconole@bytheb.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
References: <20181125180919.13996-1-aconole@bytheb.org>
        <20181125180919.13996-2-aconole@bytheb.org>
        <20181127020608.4vucwmhrtu2cxrwu@ast-mbp.dhcp.thefacebook.com>
        <f7tftvmd2ey.fsf@dhcp-25.97.bos.redhat.com>
        <20181128051001.wcsgqx3d6c2aszp6@ast-mbp.dhcp.thefacebook.com>
        <f7to9a99gsh.fsf@dhcp-25.97.bos.redhat.com>
        <20181129041948.pepdcksplt6xppk3@ast-mbp>
Date:   Fri, 30 Nov 2018 08:49:17 -0500
In-Reply-To: <20181129041948.pepdcksplt6xppk3@ast-mbp> (Alexei Starovoitov's
        message of "Wed, 28 Nov 2018 20:19:50 -0800")
Message-ID: <f7twoou65gi.fsf@dhcp-25.97.bos.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Nov 28, 2018 at 01:51:42PM -0500, Aaron Conole wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> 
>> > On Tue, Nov 27, 2018 at 09:24:05AM -0500, Aaron Conole wrote:
>> >> 
>> >>   1. Introduce flowmap again, this time, basically having it close to a
>> >>      copy of the hashmap.  Introduce a few function calls that allow an
>> >>      external module to easily manipulate all maps of that type to insert
>> >>      / remove / update entries.  This makes it similar to, for example,
>> >>      devmap.
>> >
>> > what is a flowmap?
>> > How is this flowmap different from existing hash, lpm and lru maps?
>> 
>> The biggest difference is how relationship works.  Normal map would
>> have single key and single value.  Flow map needs to have two keys
>> "single-value," because there are two sets of flow tuples to track
>> (forward and reverse direction).  That means that when updating the k-v
>> pairs, we need to ensure that the data is always consistent and up to
>> date.  Probably we could do that with the existing maps if we had some
>> kind of allocation mechanism, too (so, keep a pointer to data from two
>> keys - not sure if there's a way to do that in ebpf)?
>
> just swap the src/dst ips inside bpf program depending on direction
> and use the same hash map.

That won't work.  I'll explain below.

> That's what xdp/bpf users already do pretty successfully.
> bpf hash map is already offloaded into hw too.

While this is one reason to use hash map, I don't think we should use
this as a reason to exclude development of a data type that may work
better.  After all, if we can do better then we should.

>> forward direction addresses could be different from reverse direction so
>> just swapping addresses / ports will not match).
>
> That makes no sense to me. What would be an example of such flow?
> Certainly not a tcp flow.

Maybe it's poorly worded on my part.  Think about this scenario (ipv4, tcp):

Interfaces A(internet), B(lan)

When XDP program receives a packet from B, it will have a tuple like:

source=B-subnet:B-port  dest=inet-addr:inet-port

When XDP program receives a packet from A, it will have a tuple like:

source=inet-addr:inet-port  dest=gw-addr:gw-port

The only data in common there is inet-addr:inet-port, and that will
likely be shared among too many connections to be a valid key.

I don't know how to figure out from A the same connetion that
corresponds to B.  A really simple static map works, *except*, when
something causes either side of the connection to become invalid, I
can't mark the other side.  For instance, even if I have some static
mapping, I might not be able to infer the correct B-side tuple from the
A-side tuple to do the teardown.

I might too naive to see the right approach though - maybe I'm
over-complicating something?

>> That lets us use xdp as a fast forwarding path for
>> connections, getting all of the advantage of helper modules to do the
>> control / parsing, and all the advantage of xdp for packet movement.
>
> From 10k feet view it sounds correct, but details make no sense.
> You're saying doing nat in the stack, but that _is_ the packet movement
> where you wanted to use xdp.

The thing I want to use the stack for are things that will always be
slow anyway, or require massive system input to do correctly.  Here are
some examples:

1. Port / address reservation.  If I want to do NAT, I need to reserve
   ports and addresses correctly.  That requires knowing the interface
   addresses, and which addresses are currently allocated.  The stack
   knows this already, let it do these allocations then.  Then when
   packets arrive for the connection that the stack set up, just forward
   via XDP.

2. Helpers.  Parsing an in-flight stream is always going to be slow.
   Let the stack do that.  But when it sets up an expectation, then use
   that information to forward that via XDP.

So I would use the stack for the initial handshakes.  Once the handshake
is complete, and we know where the packet is destined to go, all that
data is shoved into a map that the XDP program can access, and we
do the data forwarding.

Hope it helps.
