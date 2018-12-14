Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB8DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7649C206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeLNTHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:07:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59346 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbeLNTHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:07:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C21E14DE5F41;
        Fri, 14 Dec 2018 11:07:06 -0800 (PST)
Date:   Fri, 14 Dec 2018 11:07:05 -0800 (PST)
Message-Id: <20181214.110705.1283167545212637328.davem@davemloft.net>
To:     fw@strlen.de
Cc:     christophe.gouault@6wind.com, linux@stwm.de,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com
Subject: Re: INFO: rcu detected stall in xfrm_hash_rebuild
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181214162333.utlut746n3butkuf@breakpoint.cc>
References: <20181214143532.43zgy2hwkdskwfn2@breakpoint.cc>
        <CADdy8HpgzxLB-6QA+D5JfvhJmjyFUoFM1fQfz0rFAO6LEvRBAQ@mail.gmail.com>
        <20181214162333.utlut746n3butkuf@breakpoint.cc>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 11:07:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>
Date: Fri, 14 Dec 2018 17:23:33 +0100

> Christophe Gouault <christophe.gouault@6wind.com> wrote:
>> The main use cases I have encountered and tried to address with the
>> hash-based lookup were network operator use cases:
>> - a lot of dynamic /32 <=> /32 policies (protecting GTP tunnels)
>> - or a lot of dynamic policies with the same prefix lengths (e.g. /16 <=> /24)
>> and a few non-hashed policies stored in the linked list.
> 
> Thanks for the detailed information.
> 
> [..]
> 
>> Could you verify how the configuration time would behave in such use
>> cases if the hash-based lookup was replaced by a tree-based lookup?
> 
> I won't send a patch to remove your work, at least not at this time.
> 
> In case I'd do this removal (thresholds, hash table, or both)
> i will make these tests to see how large the impact is.

Florian, thanks for working so hard on this.

The operational feedback is absolutely essential for figuring out how
to move forward on this issue, otherwise we'll just keep going back
and forth on the approach.
