Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA55C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243EA20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytheb-org.20150623.gappssmtp.com header.i=@bytheb-org.20150623.gappssmtp.com header.b="fMWJBE2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243EA20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bytheb.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeK1BWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:22:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37047 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeK1BWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:22:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so14652710qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytheb-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MEjLDeRU2dXk5wJZxd7AQVmboa9sN/Vlo+zQRTCwzXE=;
        b=fMWJBE2vGOTIEV+J/kA2+fvR01ler+PP1qznbGRf74g3vYY4eq6lgxFnlHczdo9lI6
         X3k5xkMiY6roBZ8rjdqFpNzCxXzjeo5AYBJYUfDSBsAs1JLa53E4BOw6JL5N82Bd2Lj/
         OIKaRE5awfzIOTADifYzlNV2V1fMaWshAuY41llAtbcftkuSCmIzr2215AuM5B86Wmhr
         xtwrdBSNkdlIBVhT7pN0hhgmlfOoaALMNJdqqr84frfcSpqMBc9jI+iuzib5KFEs0X8N
         uG3dI+yMkWQFn2mChrNIX+YCQIGmL+mQo8CM5VfUcwwoBsKxRJ72z1SV4CjUdtAo/+sI
         /2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=MEjLDeRU2dXk5wJZxd7AQVmboa9sN/Vlo+zQRTCwzXE=;
        b=SmYbtmvvqKGFFm0V+cFe8/twhiq7ehN1ryjZHch5tWag2Iq83tI+l8Kp7rbfG/bBTt
         MtwMAhLG3tbaTLh4K1XIDRGFurcBkMZ6kwdQ60EYTkxIkHHG9N+HcyODS/vdR34ALQww
         Xn1Lj44teOtDnIsThTqX158cyzjPm0mWaIO2HnfqWFKU9X5p1YpXiCQJv82ApM2kF2px
         NrxLuR2JvwLj7rAaORizENBLqlD3bN7wBYnWzoVol6FyKMKWTst1Vk4ifimn4DYAC7F7
         5gApvO6T6J167hZD00yjea3HXIIgSil4dUC1Ap/F7ce+uTQJkq84DGCK2fxKbuNG15NT
         2vSA==
X-Gm-Message-State: AA+aEWYak7BJXpjDH25JUA/JXTxBC0ETWUTuWBJ36pyBlk+1zvZv3yxs
        nXEVpjEhifMqCXZuhZptJa/s9g==
X-Google-Smtp-Source: AFSGD/WHpvnycv9aHsJ6AhLXthJLPULMEDXFU9OD53zCynJjV+MUhSzsWPSAiJ6ao6+asynKPXZ3/w==
X-Received: by 2002:a37:4bc3:: with SMTP id y186mr19581739qka.55.1543328647896;
        Tue, 27 Nov 2018 06:24:07 -0800 (PST)
Received: from dhcp-25.97.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k38sm2375697qkh.72.2018.11.27.06.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 06:24:07 -0800 (PST)
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
Date:   Tue, 27 Nov 2018 09:24:05 -0500
In-Reply-To: <20181127020608.4vucwmhrtu2cxrwu@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Mon, 26 Nov 2018 18:06:09 -0800")
Message-ID: <f7tftvmd2ey.fsf@dhcp-25.97.bos.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sun, Nov 25, 2018 at 01:09:17PM -0500, Aaron Conole wrote:
>> This commit allows for map operations to be loaded by an lkm, rather than
>> needing to be baked into the kernel at compile time.
>
> Nack.
> Please see Documentation/bpf/bpf_design_QA.rst

Thanks for the review, Alexei!  I hadn't been aware of this doc, so it's
good to read through it.

I see that the following is there:

   Q: New functionality via kernel modules?
   ----------------------------------------
   Q: Can BPF functionality such as new program or map types, new
   helpers, etc be added out of kernel module code?

   A: NO.

So, I think that means that even changing the helpers would be of no
value (since it would only be useful in the event that the kernel were
compiled with netfilter linked in, rather than as a module - and I doubt
there's any place where that would be true).

BUT, as I wrote in my cover I have some alternative approaches that I've
thought about, and I'm listing here.  Can you let me know if any would
be acceptable?  If none are, is there an alternative approach you would
support?

  1. Introduce flowmap again, this time, basically having it close to a
     copy of the hashmap.  Introduce a few function calls that allow an
     external module to easily manipulate all maps of that type to insert
     / remove / update entries.  This makes it similar to, for example,
     devmap.

  2. Introduce a way to share maps between modules.  IE:
     something like bpf_helper_expose_map(map_id, module_name).  Then have
     netfilter and eBPF share access to the hashmap.  Netfilter and the
     ebpf program will need to agree on the key and value size, and will
     push data in/out.

  3. Introduce an xdp/ebpf hook in the flowmap.
     IE: nft add flowmap xx { .program=foo.o }
     Then that will be called with a context, and can update a shared map
     with userspace.  I haven't though out all the logistics on how to do
     this, but it would put the onus of sharing the information on the
     bpf program writer.

What do you think?
