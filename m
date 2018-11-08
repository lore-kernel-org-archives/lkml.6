Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2BBECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0384620825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0384620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeKIAHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:07:41 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:59702 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeKIAHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:07:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7FCAE609F83B;
        Thu,  8 Nov 2018 15:31:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yv7Il87dh3tE; Thu,  8 Nov 2018 15:31:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 37F056094C32;
        Thu,  8 Nov 2018 15:31:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ku-E7VpfV_2b; Thu,  8 Nov 2018 15:31:54 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id EF81B6089E20;
        Thu,  8 Nov 2018 15:31:53 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, juergen.lachmann@harman.com,
        linux-kernel@vger.kernel.org, thomas.roeder@harman.com
Subject: Re: [PATCH 2/2] ubi: Expose the bitrot interface
Date:   Thu, 08 Nov 2018 15:31:53 +0100
Message-ID: <3899237.k0VKClGc8u@blindfold>
In-Reply-To: <20181108152642.03178c6c@bbrezillon>
References: <20181107221619.32498-1-richard@nod.at> <20181107221619.32498-2-richard@nod.at> <20181108152642.03178c6c@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 8. November 2018, 15:26:42 CET schrieb Boris Brezillon:
> On Wed,  7 Nov 2018 23:16:19 +0100
> Richard Weinberger <richard@nod.at> wrote:
> 
> > +/**
> > + * ubi_bitflip_check - Check an eraseblock for bitflips and scrub it if needed.
> > + * @ubi: UBI device description object
> > + * @pnum: the physical eraseblock to schedule
> > + * @force_scrub: force scrubbing if non-zero, schedule erase otherwise
> 
> Are you sure about the "schedule erase otherwise"? I'd say force_scrub
> only influence when the scrub operation is done: either unconditionally
> or depending on the result of ubi_io_read().

True. As often, code and documentation diverged a little.

Thanks,
//richard


