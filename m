Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB9C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7D925460
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lakedaemon.net header.i=@lakedaemon.net header.b="JseEuHbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7D925460
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lakedaemon.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753835AbeGAQsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:48:23 -0400
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:35401 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753710AbeGAQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:48:17 -0400
X-MHO-RoutePath: amFjMjk5NzkyNDU4
X-MHO-User: 4a9b326c-7d4c-11e8-aa1a-954dbaed88ca
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 108.39.81.162
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [108.39.81.162])
        by outbound1.eu.mailhop.org (Halon) with ESMTPSA
        id 4a9b326c-7d4c-11e8-aa1a-954dbaed88ca;
        Sun, 01 Jul 2018 16:32:08 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 0A7A38007B;
        Sun,  1 Jul 2018 16:32:05 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 0A7A38007B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1530462725;
        bh=ml2d/AVS8vKLhmI8nzKTS0KLbnpnlT+TSRcX/+UR3gY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JseEuHbDpstExzoaVxSucibFsxmqzBYa1Yev0PccEubRyo2WGKPW/3UOQIpHX+T8E
         u15aYCzbytLVWXSIfiS6dzjC+UuQvy1LWVKDkV/qW/rUAhxRMM1KVJbaPrUqCpe1sG
         YXm6a2c+9Rq9l9JMSGCZX15qu+SmjO+JLMfliLlQmfW5xiAe0SXg/na8uvlfChvcOk
         HlLEvZgrKc32I1swYGHJqQHzEdu0A+D4bWauJpDMtEzACgqk+8k0kwbUdf6n8e70oU
         b8HZy5EPNluebzhM1bWCquK07X1iKTn3TZ8BfdVA7yecOgACKIDKbMx2AkaW2OF5tr
         uHW+fEsaFfRCA==
Date:   Sun, 1 Jul 2018 16:32:04 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH] crypto: testmgr: add test vectors for skein
Message-ID: <20180701163204.GE26205@io.lakedaemon.net>
References: <20180620105714.18359-1-j.m.torrespalma@gmail.com>
 <20180620181051.GC76265@gmail.com>
 <20180620221247.GA25379@randy-betty>
 <20180701091611.z24lln7cyho6ktlb@gondor.apana.org.au>
 <20180701094719.GC9956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701094719.GC9956@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Jul 01, 2018 at 11:47:19AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 01, 2018 at 05:16:11PM +0800, Herbert Xu wrote:
> > On Thu, Jun 21, 2018 at 07:12:47AM +0900, Juan Manuel Torres Palma wrote:
> > > On Wed, Jun 20, 2018 at 11:10:51AM -0700, Eric Biggers wrote:
> > > > Also, can you describe the users of Skein in the kernel?  If there are no users,
> > > > there's no need to move it out of staging, or even have it in the kernel at all
> > > > anymore.  I say that as someone who has had to volunteer to fix critical bugs
> > > > found by fuzzing in crypto algorithms for which it's unclear why they are in the
> > > > kernel at all, as there are no apparent users.
> > > 
> > > To be honest I'm not aware of anyone actually using Skein.
> > > 
> > > So by this are you suggesting that we drop support? If not removed, I believe
> > > it's better to use test vectors as regression tests for further modifications.
> > 
> > Let's just remove skein.  In fact staging should never add generic
> > crypto algorithms.

The original reason was that I was testing an automated method for
making a massive number of style changes to cryptographic code (convert
to kernel coding style), while being able to automatically determine
that no changes had been made to the resulting object code.  The purpose
being, if you chose to place trust in Werner Dittman's implementation,
you could programatically prove that the re-styled code in the kernel
was the exact same when it came to the resulting machine code.  Thus,
you could extend your trust to the code in the kernel.

That's how ./scripts/objdiff.sh came to be.  If you look at the first 20
- 22 commits in the history of drivers/staging/skein, you can try it
yourself.

> Ok, I'll go drop it.  I forgot why we added it in the first place, it
> has been there for 4 years and not moved out, so it's not a problem to
> drop it now.

Yes, that was me that added it.  In the intervening time, unfortunately,
Skein / Threefish hasn't picked up adoption anywhere afaict.  For
example, it's not one of the candidates for replacing SHA1 within git.
So, as much as I hate to delete it, I agree that it's time to drop it.

I'll submit a patch to that effect soon.  Thanks for adding me to the
Cc.

Thanks,

Jason.
