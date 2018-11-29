Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD4CC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2EA206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHU2s8BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2EA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeK2PXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:23:52 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46014 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeK2PXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:23:51 -0500
Received: by mail-pf1-f177.google.com with SMTP id g62so352731pfd.12;
        Wed, 28 Nov 2018 20:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l6qTF1Vr6exiqQT5k4E6k6Ymf0bd5wzrn4t9MHPDzxg=;
        b=BHU2s8BRxh1t5k88ifQUD6Ms83Ks6fYXDERt9zlbGJym2wTOsMnPH1XWwcqTU1HpUm
         jrNa23TxzS5PMxxlAFHTFg+aTV7yZwPxvKQqTL/FoH4sMIFWBxvayCcmLRZ9jJuHdM6F
         K1S6EeLO/tDEQiJRrxpI/nzPbUGatV2MpAIuxndkTnDy4RdFDSqTp2VShhG147a4wcgI
         5IErky6HD7lVNfapyxSfFl+D3ECwciZ+Vrd5MfP9Z01wylwP9VXwYAKr+Ky4gm6vCsw3
         KRxXK2GhNgVK6VSgPL2Urs4kurAHJYWB+SuGxuQVLGdNUy07kpfWm65f/P1ot9lgcazr
         3CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l6qTF1Vr6exiqQT5k4E6k6Ymf0bd5wzrn4t9MHPDzxg=;
        b=AagiT3LM8mMBBQy/8YWMoFugrOKexNMpkh1dy1V3Sj+ni1U05Pigl150K1wbC8IHvK
         XJVeBOZIKWCtLq/HuZUeN5hSeTZnwkrPNZzW8b8FHizOTUUMpSAKY77FzG+cOh9VwyFk
         CJMccuYYvGqxgUnH83dmtJpMpp+o/ITV6gEM6P6MaJqL20ikIUJ6l17GRAWg6u/2E/Eo
         T3o8D20Vpxm2zg/d1nrR445SevUrzHQlnQApm1vVpIaeRWQs4IDTWnv+SIzuFb3niv3U
         h5a5z6ACVOxcbaUwTsd1HegSuy+I6sFVnxJ2fHeTwTmy+10FVtZ92klVqGS4EgnMuseG
         iW9A==
X-Gm-Message-State: AA+aEWYym2UFk/yKXGYv+86vgMUSIPrvzRNRXWutotbFLGn7yltLN91y
        OdeYysHLoIIfdBXTd1+jayGzwJnB
X-Google-Smtp-Source: AFSGD/U9Es6NQ1OVqYX/dYPTHroboQOSPIqKN76T8AImn4V+N5FWU6ZNdOzpL+cQPmUDnj/1gMpEaA==
X-Received: by 2002:a63:d104:: with SMTP id k4mr34950455pgg.227.1543465193244;
        Wed, 28 Nov 2018 20:19:53 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::7:1eff])
        by smtp.gmail.com with ESMTPSA id x2sm837977pfx.78.2018.11.28.20.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 20:19:52 -0800 (PST)
Date:   Wed, 28 Nov 2018 20:19:50 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Aaron Conole <aconole@redhat.com>
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
Message-ID: <20181129041948.pepdcksplt6xppk3@ast-mbp>
References: <20181125180919.13996-1-aconole@bytheb.org>
 <20181125180919.13996-2-aconole@bytheb.org>
 <20181127020608.4vucwmhrtu2cxrwu@ast-mbp.dhcp.thefacebook.com>
 <f7tftvmd2ey.fsf@dhcp-25.97.bos.redhat.com>
 <20181128051001.wcsgqx3d6c2aszp6@ast-mbp.dhcp.thefacebook.com>
 <f7to9a99gsh.fsf@dhcp-25.97.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7to9a99gsh.fsf@dhcp-25.97.bos.redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 01:51:42PM -0500, Aaron Conole wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> 
> > On Tue, Nov 27, 2018 at 09:24:05AM -0500, Aaron Conole wrote:
> >> 
> >>   1. Introduce flowmap again, this time, basically having it close to a
> >>      copy of the hashmap.  Introduce a few function calls that allow an
> >>      external module to easily manipulate all maps of that type to insert
> >>      / remove / update entries.  This makes it similar to, for example,
> >>      devmap.
> >
> > what is a flowmap?
> > How is this flowmap different from existing hash, lpm and lru maps?
> 
> The biggest difference is how relationship works.  Normal map would
> have single key and single value.  Flow map needs to have two keys
> "single-value," because there are two sets of flow tuples to track
> (forward and reverse direction).  That means that when updating the k-v
> pairs, we need to ensure that the data is always consistent and up to
> date.  Probably we could do that with the existing maps if we had some
> kind of allocation mechanism, too (so, keep a pointer to data from two
> keys - not sure if there's a way to do that in ebpf)?

just swap the src/dst ips inside bpf program depending on direction
and use the same hash map.
That's what xdp/bpf users already do pretty successfully.
bpf hash map is already offloaded into hw too.

> forward direction addresses could be different from reverse direction so
> just swapping addresses / ports will not match).

That makes no sense to me. What would be an example of such flow?
Certainly not a tcp flow.

> That lets us use xdp as a fast forwarding path for
> connections, getting all of the advantage of helper modules to do the
> control / parsing, and all the advantage of xdp for packet movement.

From 10k feet view it sounds correct, but details make no sense.
You're saying doing nat in the stack, but that _is_ the packet movement
where you wanted to use xdp.

