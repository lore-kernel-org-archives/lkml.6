Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA9C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8D024371
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8D024371
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeGAJrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:47:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeGAJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:47:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A94DBC8;
        Sun,  1 Jul 2018 09:47:21 +0000 (UTC)
Date:   Sun, 1 Jul 2018 11:47:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH] crypto: testmgr: add test vectors for skein
Message-ID: <20180701094719.GC9956@kroah.com>
References: <20180620105714.18359-1-j.m.torrespalma@gmail.com>
 <20180620181051.GC76265@gmail.com>
 <20180620221247.GA25379@randy-betty>
 <20180701091611.z24lln7cyho6ktlb@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701091611.z24lln7cyho6ktlb@gondor.apana.org.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 05:16:11PM +0800, Herbert Xu wrote:
> On Thu, Jun 21, 2018 at 07:12:47AM +0900, Juan Manuel Torres Palma wrote:
> > On Wed, Jun 20, 2018 at 11:10:51AM -0700, Eric Biggers wrote:
> > > Also, can you describe the users of Skein in the kernel?  If there are no users,
> > > there's no need to move it out of staging, or even have it in the kernel at all
> > > anymore.  I say that as someone who has had to volunteer to fix critical bugs
> > > found by fuzzing in crypto algorithms for which it's unclear why they are in the
> > > kernel at all, as there are no apparent users.
> > 
> > To be honest I'm not aware of anyone actually using Skein.
> > 
> > So by this are you suggesting that we drop support? If not removed, I believe
> > it's better to use test vectors as regression tests for further modifications.
> 
> Let's just remove skein.  In fact staging should never add generic
> crypto algorithms.

Ok, I'll go drop it.  I forgot why we added it in the first place, it
has been there for 4 years and not moved out, so it's not a problem to
drop it now.

thanks,

greg k-h
