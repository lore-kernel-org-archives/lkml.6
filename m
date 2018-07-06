Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D4123EA9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYUpSlQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D4123EA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeGFPOL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:14:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42035 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932575AbeGFPOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:14:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id u202-v6so10086911lff.9;
        Fri, 06 Jul 2018 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tUynSC6PILAzmKYDXiy6Ufq5XJbWphmXUYidY4E4VnQ=;
        b=sYUpSlQbvew88r8nobV1J9vkQGKlyVPtBHaNCIs+NJvYGSdztfXWfQlRAK7acqMg/1
         /i89f1fFj/2laVpSlEg7r2ywSQ7xoWkS5rFHPOJYvk2NlwRAZ8l91gbhZH+myHBp/vTV
         Sgkn0LdRtll2BeUoRuTh7Q8PgM1yhuLfQphRbif3br4q1VhAdof0zKJBQpzUyNhSR8z3
         2V8mXleGU9pv1qQykjrpXn617gjwgLc8BDOLgXVFBSb2IE05CiyW069SCIjxGM24ZS/C
         8EvDHVI+cfsuLYSr0OL7UzHESRX9zQVFSPQE+LBYBYcCFLtfjaNeEA6uvmRaOPcXi4OR
         pIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tUynSC6PILAzmKYDXiy6Ufq5XJbWphmXUYidY4E4VnQ=;
        b=sREO5M1qg9VLFZfpvo/B783T7Fvd98AwScjEMzPO8wFKDIdVD1Vg+gm7681PDL8KfP
         oKWgQgj0AaULrgaAndH8rfCI3ydYw68t2vh8uswzE0Lt1Wc9pZi/25wGC9rRIjBE27t/
         zGP9vajYGAO/urc684fRrVjoFgieGk4HCNx1ftzNaMyPQRUi/TSrcFVS3vBsuN00wsAe
         bI6GlnVhN+0miIaYbwaXxiqiu6OL/N1I2T0xNCTn4C7vi5SfvfMQ+Sx9aneoAn95f9lA
         7BkXL3hhe33srOYoKTle90++yIgnp2hhKFXwQowONCFsieAsxll6f2t7vTHo07F783iT
         xB1w==
X-Gm-Message-State: APt69E2t+JR6c/m8xCspXudOURa99sTq98GKUFObCRo4MYfkLmBpAXga
        4t2h+i1s5Ki1PX9y2Z0YXoKrhwQt4h7EuT2zDsc=
X-Google-Smtp-Source: AAOMgpfZUI/aBnHbO3x0qAFSr415mDZZTNTw1XQw02kNgRv9HvW4FtxjZcNve9ZTdq2as8eLq7Oghq6Lj67qTugqmZE=
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr7426744lff.11.1530890047451;
 Fri, 06 Jul 2018 08:14:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 08:14:06 -0700 (PDT)
In-Reply-To: <20180706150037.knqt736uq6uyh3bs@breakpoint.cc>
References: <20180706130005.3640993-1-arnd@arndb.de> <20180706135516.viz6pjtkdmcoqq2l@breakpoint.cc>
 <CAK8P3a1o6+dcZuW_iMGzwBBw_dcW41QAQ2Mu4A5Ru9ScnwaYDA@mail.gmail.com> <20180706150037.knqt736uq6uyh3bs@breakpoint.cc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Jul 2018 17:14:06 +0200
X-Google-Sender-Auth: ECKfPZTj6EWbcLPCqsWsr0VqvaM
Message-ID: <CAK8P3a2H44gVZWkC+4vYbg68rr90Fhr12DktEAFMFFOB6fbE9Q@mail.gmail.com>
Subject: Re: [PATCH] netfilter: conntrack: add weak IPV6 dependency
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?TcOhdMOpIEVja2w=?= <ecklm94@gmail.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "Pablo M. Bermudo Garay" <pablombg@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 5:00 PM, Florian Westphal <fw@strlen.de> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
>> and that resulted in a new build failure:
>>
>> net/netfilter/nf_conntrack_proto.o:(.rodata+0x788): undefined
>> reference to `nf_conntrack_l4proto_icmpv6'
>> net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_expire':
>> nf_conntrack_reasm.c:(.text+0x2320): undefined reference to
>> `ip6_expire_frag_queue'
>> net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_init':
>> nf_conntrack_reasm.c:(.text+0x2384): undefined reference to `ip6_frag_init'
>> nf_conntrack_reasm.c:(.text+0x2394): undefined reference to `ip6_frag_init'
>> nf_conntrack_reasm.c:(.text+0x2398): undefined reference to `ip6_rhash_params'
>> net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_expire':
>> nf_conntrack_reasm.c:(.text+0x10bc): undefined reference to
>> `ip6_expire_frag_queue'
>>
>> I don't think we can get CONFIG_NF_DEFRAG_IPV6=y to work with IPV6=m.
>
> Yes, not with current implementation, but I still don't think this
> is unavoidable.
>
> In case this is urgent I'm fine with the patch that adds the dependency,
> otherwise I'd like to try and disentangle nf_conntrack_reasm and ipv6.

I don't think any real users depend on it, but I hit the problem quite
frequently in randconfig testing on linux-next.

       Arnd
