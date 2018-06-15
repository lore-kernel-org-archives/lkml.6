Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 785A4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38642086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38642086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755559AbeFOEXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 00:23:43 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:56892 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeFOEXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 00:23:42 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fTgGt-0005fX-WD; Fri, 15 Jun 2018 12:23:36 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fTgGp-0002Z1-Ju; Fri, 15 Jun 2018 12:23:31 +0800
Date:   Fri, 15 Jun 2018 12:23:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Herbert <tom@herbertland.com>
Cc:     NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH RFC v2] rhashtable: implement rhashtable_walk_peek()
 using rhashtable_walk_last_seen()
Message-ID: <20180615042331.3dmqi3bumzk6lu5c@gondor.apana.org.au>
References: <87sh63pakb.fsf@notabene.neil.brown.name>
 <CALx6S35sf4oj=x73SfhUxi1e9-u4Stxgr9BAj5E7KKmbufntwg@mail.gmail.com>
 <87r2lmnj2c.fsf@notabene.neil.brown.name>
 <CALx6S36Ce-rXQMzmFYZVPGD10Bo6udvRAHiZ5gWwnzVwoTVv0w@mail.gmail.com>
 <87in6wo636.fsf@notabene.neil.brown.name>
 <871sdjnwkr.fsf@notabene.neil.brown.name>
 <87y3frmhyx.fsf@notabene.neil.brown.name>
 <CALx6S35GgUOd0dPgv7P96wNNTv5pN7fij0pcAoccqcSWZhvY7Q@mail.gmail.com>
 <871sdck9ds.fsf@notabene.neil.brown.name>
 <CALx6S35Yr8th_LFoCLjEqfzti0cp7+7nKZC7KO3dzeQkU7c0nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALx6S35Yr8th_LFoCLjEqfzti0cp7+7nKZC7KO3dzeQkU7c0nw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:41:05AM -0700, Tom Herbert wrote:
> On Mon, Jun 11, 2018 at 7:48 PM, NeilBrown <neilb@suse.com> wrote:
> >
> > rhashtable_walk_last_seen() does most of the work that
> > rhashtable_walk_peek() needs done, so use it and put
> > it in a "static inline".
> > Also update the documentation for rhashtable_walk_peek() to clarify
> > the expected use case.
> >
> > Signed-off-by: NeilBrown <neilb@suse.com>
> 
> Acked-by: Tom Herbert <tom@quantonium.net>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
