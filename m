Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 676EDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28204208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28204208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbeFNIHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:07:18 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:48122 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeFNIHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:07:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 219A860A04BF;
        Thu, 14 Jun 2018 10:07:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0IGnJxIcKGDn; Thu, 14 Jun 2018 10:07:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D22C560A04C3;
        Thu, 14 Jun 2018 10:07:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ScAmLpeKw-ko; Thu, 14 Jun 2018 10:07:14 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B266760A04BF;
        Thu, 14 Jun 2018 10:07:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, marek.vasut@gmail.com,
        dedekind1@gmail.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, thomas.petazzoni@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org
Subject: Re: [PATCH 2/2] ubi: introduce ubi.nocheck parameter to skip CRC check when attaching ubi vol
Date:   Thu, 14 Jun 2018 10:07:14 +0200
Message-ID: <4831753.6lg8f61FNt@blindfold>
In-Reply-To: <20180614100436.40741c67@bbrezillon>
References: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com> <1588647.N1yrutfcI7@blindfold> <20180614100436.40741c67@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Juni 2018, 10:04:36 CEST schrieb Boris Brezillon:
> On Thu, 14 Jun 2018 09:29:42 +0200
> Richard Weinberger <richard@nod.at> wrote:
> 
> > Quentin,
> > 
> > Am Montag, 11. Juni 2018, 12:20:37 CEST schrieb Quentin Schulz:
> > > If we go for a per-image flag, adding nocheck to the ioctl makes sense,
> > > otherwise we have to find a way to select only one or more volumes for
> > > which the nocheck flag should be set. That being said, I'm not sure a
> > > per-image flag is the way we want to go.
> > > 
> > > What are your thoughts on this?  
> > 
> > I like that approach a lot more, please send a patch. :-)
> 
> I don't think the approach you're talking about has been mentioned by
> Quentin in this email :-). To clarify the discussion, we're talking
> about adding a new flag to VTBL entries telling whether the CRC should
> be skipped or not.

Hehe yes. Too many discussions on and off-list in parallel. ;)

Thanks,
//richard
