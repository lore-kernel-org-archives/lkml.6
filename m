Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09070C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9682D2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veDgC1zS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9682D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbeGaXjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:39:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41465 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbeGaXjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:39:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so9725337pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XOgYa2JMBfUd+BYFAACjpWha32kLil2yShoK65f+9kM=;
        b=veDgC1zSMFcy1Ppeuw3MSJJyXe8lFO58aQ8IaTu5vUu1NqgKtn4fmBPnJsSILcYOTz
         fIgatLuEx58ZQfN6Y3vt4JUpQOWynJktTdy1gzsg/SMsYHLxf+JqQgiBxKChKOHZod3r
         NGaa03j2YRYOa2txlnnpCAoY380v6oHeYQKWFOn2qgLpI41RjVQZbkMyyFdw2VB8mZAK
         QcRCNFqOGS4wmKY/bSyOMGo5yTJrrWUmBMWSi8GTUtGVn6R94/HPiXM9yhNBut62t5DV
         vwfWgGTbVwLJY1fFZqWQ0CCoGyBnt74JD5cU30eOjWAZ0T/25My7NImObFfFjwnt71Pu
         zCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XOgYa2JMBfUd+BYFAACjpWha32kLil2yShoK65f+9kM=;
        b=MP2PYtg+7xSrwVPanBeGlTqDncS5/Amzh6XwhLDP1PLbrDpoPZLR6pMuufAtd89k/4
         UiyTuO/Ko3052IPsnP4NRdcAXZdHo3pMH7NlrJDBx7ZjkvlsppYUFIJ5r2z1ERPcCKcp
         iHm7tf0VJxuDUF/OcWaeB5RE5mZxN7t3BP8ExlI+SyJyn7C3T1KLAUEpxtnNfYkatJQr
         Sgu7Q/ntxe4nMCiMk+rfb+crwWpV/WhQXQuraQQA0PYjZutj2r+fqSVvHdbFEQOwm4z0
         jscmm9FqJuzFA1DNS8RTvshK7OUfJ8UHaOWSxzyF666Q+cKxnVUn/UnMZpipHVUW4fK9
         NyjQ==
X-Gm-Message-State: AOUpUlGa1ee90S+iZ+nH42y9fLwoHA5JDiu7mgaqCq7SGfBzAp8BQs6q
        yiYzpTTTezU4vD19L58pouXOeA==
X-Google-Smtp-Source: AAOMgpf1AcY5PNm68cDnbDcyO/NjAU+ay9YM/6fI708et26py/gjKzprGSJLH3p6ofVDy8E1CAunjw==
X-Received: by 2002:a65:6109:: with SMTP id z9-v6mr21925146pgu.243.1533074212983;
        Tue, 31 Jul 2018 14:56:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id f18-v6sm38443951pff.29.2018.07.31.14.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:56:52 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:56:51 -0700
From:   Joel Fernandes <joelaf@google.com>
To:     Y Song <ys114321@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2] Add BPF_SYNCHRONIZE_MAPS bpf(2) command
Message-ID: <20180731215651.GA141321@joelaf.mtv.corp.google.com>
References: <CAADnVQL4twmGF3d26TgLsQJvnqLnM0F6hqL_42DSs95OuZ1y9A@mail.gmail.com>
 <20180731020122.GA22311@joelaf.mtv.corp.google.com>
 <20180731020629.GB22311@joelaf.mtv.corp.google.com>
 <CAH3MdRU5nn5g0bexrLWU3-UrxSJfrVF0-A2v2VJGAeBDKY=+Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3MdRU5nn5g0bexrLWU3-UrxSJfrVF0-A2v2VJGAeBDKY=+Zg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:03:18PM -0700, Y Song wrote:
> On Mon, Jul 30, 2018 at 7:06 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Mon, Jul 30, 2018 at 07:01:22PM -0700, Joel Fernandes wrote:
> >> On Sun, Jul 29, 2018 at 06:51:18PM +0300, Alexei Starovoitov wrote:
> >> > On Thu, Jul 26, 2018 at 7:51 PM, Daniel Colascione <dancol@google.com> wrote:
> >> > > BPF_SYNCHRONIZE_MAPS waits for the release of any references to a BPF
> >> > > map made by a BPF program that is running at the time the
> >> > > BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command is
> >> > > to provide a means for userspace to replace a BPF map with another,
> >> > > newer version, then ensure that no component is still using the "old"
> >> > > map before manipulating the "old" map in some way.
> >> > >
> >> > > Signed-off-by: Daniel Colascione <dancol@google.com>
> >> > > ---
> >> > >  include/uapi/linux/bpf.h |  9 +++++++++
> >> > >  kernel/bpf/syscall.c     | 13 +++++++++++++
> >> > >  2 files changed, 22 insertions(+)
> >> > >
> >> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> > > index b7db3261c62d..5b27e9117d3e 100644
> >> > > --- a/include/uapi/linux/bpf.h
> >> > > +++ b/include/uapi/linux/bpf.h
> >> > > @@ -75,6 +75,14 @@ struct bpf_lpm_trie_key {
> >> > >         __u8    data[0];        /* Arbitrary size */
> >> > >  };
> >> > >
> >> > > +/* BPF_SYNCHRONIZE_MAPS waits for the release of any references to a
> >> > > + * BPF map made by a BPF program that is running at the time the
> >> > > + * BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command
> >> >
> >> > that doesn't sound right to me.
> >> > such command won't wait for the release of the references.
> >> > in case of map-in-map the program does not hold
> >> > the references to inner map (only to outer map).
> >>
> >> I didn't follow this completely.
> >>
> >> The userspace program is using the inner map per your description of the
> >> algorithm for using map-in-map to solve the race conditions that this patch
> >> is trying to address:
> >>
> >> If you don't mind, I copy-pasted it below from your netdev post:
> >>
> >> if you use map-in-map you don't need extra boolean map.
> >> 0. bpf prog can do
> >>    inner_map = lookup(map_in_map, key=0);
> >>    lookup(inner_map, your_real_key);
> >> 1. user space writes into map_in_map[0] <- FD of new map
> >> 2. some cpus are using old inner map and some a new
> >> 3. user space does sys_membarrier(CMD_GLOBAL) which will do synchronize_sched()
> >>    which in CONFIG_PREEMPT_NONE=y servers is the same as synchronize_rcu()
> >>    which will guarantee that progs finished.
> >> 4. scan old inner map
> >>
> >> In step 2, as you mentioned there are CPUs using different inner maps. So
> >> could you clarify how the synchronize_rcu mechanism will even work if you're
> >> now saying "program does not hold references to the inner maps"?
> 
> The program only held references to the outer maps, and the outer map
> held references to the inner maps. The user space program can add/remove
> the inner map for a particular outer map while the prog <-> outer-map
> relationship is not changed.

My definition of "reference" in this context is protection by rcu_read_lock.

So I was concerned the above map-in-map access isn't protected as such when
Alexei said "program doesn't have reference on inner map" in the above steps.
Maybe I misunderstood what is the meaning of reference here.

To make the map-in-map thing to work for Chenbo/Lorenzo's usecase, both the
access of outer map at key=0 and the inner map have to protect by
rcu_read_lock so that the membarrier call will work.

So basically step 0 in the steps above should be rcu_read_lock protected to
satisfy Chenbo/Lorenzo's usecase.

I know today the entire program is run as preempt disabled (unless something
changed) so this shouldn't be a problem, but in the future if the verifier is
doing similar things at a finer grainer level, then the above has to be
taken into consideration.

Does that make sense or am I missing something?

thanks,

- Joel


