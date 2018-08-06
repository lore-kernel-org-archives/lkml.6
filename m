Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66FAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC0C21A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC0C21A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbeHFWbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:31:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732733AbeHFWbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:31:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D2CEAE9D;
        Mon,  6 Aug 2018 20:20:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6A0AB1E0A3B; Mon,  6 Aug 2018 22:20:17 +0200 (CEST)
Date:   Mon, 6 Aug 2018 22:20:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
Message-ID: <20180806202017.lrzihv42b4mtcgrn@quack2.suse.cz>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <CACT4Y+aYZumcc-Od5T1AnP4mwn8-FaWfxvfb93MnNwQPqG8TDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aYZumcc-Od5T1AnP4mwn8-FaWfxvfb93MnNwQPqG8TDw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-08-18 10:46:35, Dmitry Vyukov wrote:
> I guess it would be useful to have such extensive comment for each
> SLAB_TYPESAFE_BY_RCU use explaining why it is needed and how all the
> tricky aspects are handled.
> 
> For example, the one in jbd2 is interesting because it memsets the
> whole object before freeing it into SLAB_TYPESAFE_BY_RCU slab:
> 
> memset(jh, JBD2_POISON_FREE, sizeof(*jh));
> kmem_cache_free(jbd2_journal_head_cache, jh);
> 
> I guess there are also tricky ways how it can all work in the end
> (type-stable state is only a byte, or we check for all possible
> combinations of being overwritten with JBD2_POISON_FREE). But at first
> sight it does look fishy.

The RCU access is used from a single place:

fs/jbd2/transaction.c: jbd2_write_access_granted()

There are also quite some comments explaining why what it does is safe. The
overwrite by JBD2_POISON_FREE is much older than this RCU stuff (honestly I
didn't know about it until this moment) and has nothing to do with the
safety of RCU access.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
