Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B5E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeLNQXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:23:42 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:57920 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727795AbeLNQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:23:42 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gXqFR-0000cG-Fu; Fri, 14 Dec 2018 17:23:33 +0100
Date:   Fri, 14 Dec 2018 17:23:33 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Christophe Gouault <christophe.gouault@6wind.com>
Cc:     Florian Westphal <fw@strlen.de>, Wolfgang Walter <linux@stwm.de>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: INFO: rcu detected stall in xfrm_hash_rebuild
Message-ID: <20181214162333.utlut746n3butkuf@breakpoint.cc>
References: <00000000000075fe86057ca6367e@google.com>
 <20181210124724.iuver2va3yjdsokf@breakpoint.cc>
 <20181210.095856.580441946779980596.davem@davemloft.net>
 <2559562.n5nkmlqv4s@stwm.de>
 <20181214143532.43zgy2hwkdskwfn2@breakpoint.cc>
 <CADdy8HpgzxLB-6QA+D5JfvhJmjyFUoFM1fQfz0rFAO6LEvRBAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADdy8HpgzxLB-6QA+D5JfvhJmjyFUoFM1fQfz0rFAO6LEvRBAQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Gouault <christophe.gouault@6wind.com> wrote:
> The main use cases I have encountered and tried to address with the
> hash-based lookup were network operator use cases:
> - a lot of dynamic /32 <=> /32 policies (protecting GTP tunnels)
> - or a lot of dynamic policies with the same prefix lengths (e.g. /16 <=> /24)
> and a few non-hashed policies stored in the linked list.

Thanks for the detailed information.

[..]

> Could you verify how the configuration time would behave in such use
> cases if the hash-based lookup was replaced by a tree-based lookup?

I won't send a patch to remove your work, at least not at this time.

In case I'd do this removal (thresholds, hash table, or both)
i will make these tests to see how large the impact is.
