Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0382C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067E321A78
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067E321A78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeGAJQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:16:15 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:53570 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeGAJQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:16:14 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fZYSr-000068-0O; Sun, 01 Jul 2018 17:16:13 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fZYSp-00080J-S1; Sun, 01 Jul 2018 17:16:11 +0800
Date:   Sun, 1 Jul 2018 17:16:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] crypto: testmgr: add test vectors for skein
Message-ID: <20180701091611.z24lln7cyho6ktlb@gondor.apana.org.au>
References: <20180620105714.18359-1-j.m.torrespalma@gmail.com>
 <20180620181051.GC76265@gmail.com>
 <20180620221247.GA25379@randy-betty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620221247.GA25379@randy-betty>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 07:12:47AM +0900, Juan Manuel Torres Palma wrote:
> On Wed, Jun 20, 2018 at 11:10:51AM -0700, Eric Biggers wrote:
> > Also, can you describe the users of Skein in the kernel?  If there are no users,
> > there's no need to move it out of staging, or even have it in the kernel at all
> > anymore.  I say that as someone who has had to volunteer to fix critical bugs
> > found by fuzzing in crypto algorithms for which it's unclear why they are in the
> > kernel at all, as there are no apparent users.
> 
> To be honest I'm not aware of anyone actually using Skein.
> 
> So by this are you suggesting that we drop support? If not removed, I believe
> it's better to use test vectors as regression tests for further modifications.

Let's just remove skein.  In fact staging should never add generic
crypto algorithms.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
