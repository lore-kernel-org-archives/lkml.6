Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CD522C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA66208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA66208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754774AbeFNIEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:04:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42431 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752833AbeFNIEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:04:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9689E203EB; Thu, 14 Jun 2018 10:04:49 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4FBC0207EB;
        Thu, 14 Jun 2018 10:04:36 +0200 (CEST)
Date:   Thu, 14 Jun 2018 10:04:36 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, marek.vasut@gmail.com,
        dedekind1@gmail.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, thomas.petazzoni@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org
Subject: Re: [PATCH 2/2] ubi: introduce ubi.nocheck parameter to skip CRC
 check when attaching ubi vol
Message-ID: <20180614100436.40741c67@bbrezillon>
In-Reply-To: <1588647.N1yrutfcI7@blindfold>
References: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
        <2085970.qGmQXvoWho@blindfold>
        <20180611102037.n5kkdq4mcoixmvti@qschulz>
        <1588647.N1yrutfcI7@blindfold>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 09:29:42 +0200
Richard Weinberger <richard@nod.at> wrote:

> Quentin,
> 
> Am Montag, 11. Juni 2018, 12:20:37 CEST schrieb Quentin Schulz:
> > If we go for a per-image flag, adding nocheck to the ioctl makes sense,
> > otherwise we have to find a way to select only one or more volumes for
> > which the nocheck flag should be set. That being said, I'm not sure a
> > per-image flag is the way we want to go.
> > 
> > What are your thoughts on this?  
> 
> I like that approach a lot more, please send a patch. :-)

I don't think the approach you're talking about has been mentioned by
Quentin in this email :-). To clarify the discussion, we're talking
about adding a new flag to VTBL entries telling whether the CRC should
be skipped or not.

> Having a volume flag will reduce complexity a lot.

That's my opinion as well.
