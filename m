Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E3DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4540D20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4540D20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeKSO26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:28:58 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:43358 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbeKSO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 09:28:58 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gOapY-0002vV-0m; Mon, 19 Nov 2018 12:06:36 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gOapW-0005F5-U3; Mon, 19 Nov 2018 12:06:34 +0800
Date:   Mon, 19 Nov 2018 12:06:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH] rhashtable: detect when object movement between tables
 might have invalidated a lookup
Message-ID: <20181119040634.qlvsrviznd5npiek@gondor.apana.org.au>
References: <87muqbtev6.fsf@notabene.neil.brown.name>
 <20181116055551.zxfydbpoicslsfkg@gondor.apana.org.au>
 <878t1tece0.fsf@notabene.neil.brown.name>
 <20181119035415.yavhqymqiqp3mmcl@gondor.apana.org.au>
 <20181119035635.2tizfk3vrmxfrr6e@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119035635.2tizfk3vrmxfrr6e@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:56:35AM +0800, Herbert Xu wrote:
>
> I take that back.  Because of your shift which cancels out the
> shift in NULLS_MARKER, it would appear that this should work just
> fine with RHT_NULLS_MARRKER(0), no? IOW, it would appear that
> 
> 	RHT_NULLS_MARKER(0) = RHT_NULLS_MARKER(RHT_NULLS_MARKER(0))

My emails to Neil are bouncing:

	neilb@suse.com
	  host smtp.glb1.softwaregrp.com [15.124.2.87]
	  SMTP error from remote mail server after RCPT TO:<neilb@suse.com>:
	  550 Cannot process address

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
