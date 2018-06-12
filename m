Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3FCAEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE672089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE672089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934894AbeFLWfK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:35:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34274 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934314AbeFLWfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:35:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A1C0920731; Wed, 13 Jun 2018 00:35:07 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4AF07203EC;
        Wed, 13 Jun 2018 00:35:07 +0200 (CEST)
Date:   Wed, 13 Jun 2018 00:35:06 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     NeilBrown <neil@brown.name>
Cc:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        linux-mtd@lists.infradead.org, boris.brezillon@free-electrons.com,
        frieder.schrempf@exceet.de, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        marek.vasut@gmail.com, prabhakar.kushwaha@nxp.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Message-ID: <20180613003506.2b521e94@bbrezillon>
In-Reply-To: <87sh5riqxx.fsf@notabene.neil.brown.name>
References: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180611114916.351ed272@bbrezillon>
        <87r2ldj7xi.fsf@notabene.neil.brown.name>
        <20180612092248.4e6a3e92@bbrezillon>
        <87sh5riqxx.fsf@notabene.neil.brown.name>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 08:24:26 +1000
NeilBrown <neil@brown.name> wrote:

> On Tue, Jun 12 2018, Boris Brezillon wrote:
> 
> >
> > Just because you managed to solve the problem in one driver does not
> > mean the problem does not exist for others. I read this datasheet [1]
> > several times and couldn't find a way to say 'I want to keep the CS
> > asserted between 2 transactions', so I think we really need this patch.  
> 
> I agree that my experience doesn't necessarily generalize.  As the patch
> carried by signed-off-by (even though I only wrote little parts of it) I
> wanted to make it clear that I had no desire to promote the patch -
> maybe I stated that too strongly.

If that's a problem, we can drop your SoB.

> 
> Thanks for the link to the data sheet.  I had a bit of a look, but
> reading these things must be an art that I haven't fully mastered yet -
> it would probably take me a few days to really understand it.
> The Programmable Sequence Enginine (Section 10.2.5.3.1) seems
> interesting. I wouldn't be surprised that that lets you do interesting
> things.

It does.

> 
> It is obviously quite a powerful unit and it is surprising - to me -
> that it might not allow arbitrarily long messages, but I cannot justify
> the time to really dig in and see if that is the case.

Unfortunately it does not allow you to manually control the CS signal,
and when it comes to data transfers you're limited by the TX/RX FIFO
size.

> Maybe you are right.  I have no particular objections to the patch, I
> just don't want to be seen as speaking in favour of it.

Okay.
