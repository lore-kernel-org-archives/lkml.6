Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2CBC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915D820878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byEniV0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915D820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbeGKDmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:42:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33906 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbeGKDmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:42:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so17471942pfn.1;
        Tue, 10 Jul 2018 20:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q7Y75uj1UkNREmNHpqg+hHQeBTh89/acHdiUiRMRvT4=;
        b=byEniV0zak3BwMrcKfCAqkM0Pd5S+7mOjApRaPMiba9OjxfooUchTZ884lIFm4Ow+p
         D0vrq7L5JThYQirieV2zhovmWg6jAtAluSs3NaT2l1xZ1I1kWalFTAdEeB6o8KmjO6e0
         m2o5eacqvD8ceDkT4p24UTCN6JsCNR110N9fwUu+B59HByyhJamRgT6XeOqSIjMmTdZO
         AzfGWRmY6RTCeewJGDee8QTBlc1e0phVHjgkHy3KoeL8NKL9cU3isT+CXfBc0rDNZndU
         LyN8/WJrDyEv3iIpc1HfpWATyNCm+3Y4ozK0v9KjoY5NX/RxUCnsJKrFH5a4hGcDAhvk
         2WFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q7Y75uj1UkNREmNHpqg+hHQeBTh89/acHdiUiRMRvT4=;
        b=FieL7CpbonQgbfTcysI6/FTq+SEFQ1aRS8rQ59Zjf7HqWr+AnYpW8U7TW8V42LV/CH
         gKNQYhuXLCAujaPblgV6F6gHYI8sKPcKpPD6DL4Mdr2qf/m+FYJx6jBxKrqXxQ4Z3+7R
         nZHZzqYGh2/q1J9ape990o7e8aRdpSNk5VQ4R1w1Fru9rx1x+bTwDVPUqs4qyrz0GZaN
         GsktzfVgdxygOdNEruJjjkV1pvYF/q3nN6WKwXuLY8PIx4YWkDuvuG6z4U3zw/Ep4bdM
         CKQuKIGGD9N5gvDVJKQ+rPxaTS6dB6FyJDLNLlD3fGF88FkjaKiaD7g2Nermj/PvHc4R
         lUsQ==
X-Gm-Message-State: APt69E0uq/X5BBmvW7+H8sFlxXtu9SpIz/GIYxJmK3SntkqXJhCPyT2D
        EB4/1tSRKj0U8ulmKs/1+M8=
X-Google-Smtp-Source: AAOMgpf1jTyS3r3xadq2jN72gmHp1Y4C/L34kLB4GFPjNNS71KslrE/zk8+czlkfPerGl1VexmtGOw==
X-Received: by 2002:a63:ff21:: with SMTP id k33-v6mr18533664pgi.38.1531280422204;
        Tue, 10 Jul 2018 20:40:22 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:52b2])
        by smtp.gmail.com with ESMTPSA id t78-v6sm35602180pfa.160.2018.07.10.20.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 20:40:21 -0700 (PDT)
Date:   Tue, 10 Jul 2018 20:40:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenzo Colitti <lorenzo@google.com>
Cc:     Chenbo Feng <fengc@google.com>, dancol@google.com,
        mathieu.desnoyers@efficios.com, Joel Fernandes <joelaf@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180711034017.o2ehf27tv5hpl3td@ast-mbp.dhcp.thefacebook.com>
References: <20180707203340.GA74719@joelaf.mtv.corp.google.com>
 <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuet+pjqM8zghmXYdA9f10bsYOzMuSQhSYXG5wbrNmFEqpQ@mail.gmail.com>
 <20180709221005.sintsjkle4xpkcyk@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuetaKNaJVWcu10ZcsiXiK4X+-2z3eFaz1pF8DSxdQ_mEnQ@mail.gmail.com>
 <20180709223439.uc2a6hyic35inwye@ast-mbp.dhcp.thefacebook.com>
 <CAMOXUJ=QmkjTqbWqPRxb=R7f6EpsHBkDQ4MhrSD=VPiDTj7RiA@mail.gmail.com>
 <20180710235252.mioihpgtu4n3syaq@ast-mbp.dhcp.thefacebook.com>
 <CAKD1Yr07uxpd95oGAE7QxfrS_qWuiLcUmy7nsEsC0CzVhV2-rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKD1Yr07uxpd95oGAE7QxfrS_qWuiLcUmy7nsEsC0CzVhV2-rg@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 11:46:19AM +0900, Lorenzo Colitti wrote:
> On Wed, Jul 11, 2018 at 8:52 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > we need to make sure we have detailed description of BPF_SYNC_MAP_ACCESS
> > in uapi/bpf.h, since I feel the confusion regarding its usage is starting already.
> > This new cmd will only make sense for map-in-map type of maps.
> > Expecting that BPF_SYNC_MAP_ACCESS is somehow implies the end of
> > the program or doing some other map synchronization is not correct.
> > Commit log of this patch got it right:
> > """
> >  For example, userspace can update a map->map entry to point to a new map,
> >  use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
> >  complete, and then drain the old map without fear that BPF programs
> >  may still be updating it.
> > """
> 
> +1 for detailed documentation. For example, consider what happens if
> we have two map fds, one active and one standby, and a map-in-map with
> one element that contains a pointer to the currently-active map fd.

yes. that's exactly the use case that folks use.

> The kernel program might do:
> 
> =====
> const int current_map_key = 1;
> void *current_map = bpf_map_lookup_elem(outer_map, &current_map_key);
> 
> int stats_key = 42;
> uint64_t *stats_value = bpf_map_lookup_elem(current_map, &stats_key);
> __sync_fetch_and_add(&stats_value, 1);
> =====
> 
> If a userspace does:
> 
> 1. Write new fd to outer_map[1].
> 2. Call BPF_SYNC_MAP_ACCESS.
> 3. Start deleting everything in the old map.
> 
> How can we guarantee that the __sync_fetch_and_add will not add to the
> old map? 

without any changes to the kernel sys_membarrier will work.
And that's what folks use already.
BPF_SYNC_MAP_ACCESS implemented via synchronize_rcu() will work
as well whether in the current implementation where rcu_lock/unlock
is done outside of the program and in the future when
rcu_lock/unlock are called by the program itself.

> Will the verifier automatically
> hold the RCU lock for as long as a pointer to an inner map is valid?

the verifier will guarantee the equivalency of future explicit
lock/unlock by the program vs current situation of implicit
lock/unlock by the kernel.
The verifier will track that bpf_map_lookup_elem() is done
after rcu_lock and that the value returned by this helper is
not accessed after rcu_unlock. Baby steps of dataflow analysis.

