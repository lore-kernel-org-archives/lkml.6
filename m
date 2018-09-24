Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10E8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A4F20883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A4F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeIXMcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 08:32:50 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38728 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIXMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 08:32:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CC15B606D4AB;
        Mon, 24 Sep 2018 08:32:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UWARRYvGv9Js; Mon, 24 Sep 2018 08:32:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8E9C9605A919;
        Mon, 24 Sep 2018 08:32:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1w4Pb28oasFn; Mon, 24 Sep 2018 08:32:15 +0200 (CEST)
Received: from blindfold.localnet (089144196103.atnat0005.highway.a1.net [89.144.196.103])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id CE843605A916;
        Mon, 24 Sep 2018 08:32:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Lars Persson <lists@bofh.nu>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martinbayern@outlook.com
Subject: Re: [PATCH 4.9 069/101] ubi: fastmap: Correctly handle interrupted erasures in EBA
Date:   Mon, 24 Sep 2018 08:32:12 +0200
Message-ID: <1657546.ePJIJPgWtA@blindfold>
In-Reply-To: <CADnJP=sJE6hpG6inp5Yu+5P2F-d0=6GP-2dAXJTmBOb_rPzgvw@mail.gmail.com>
References: <20180701160757.138608453@linuxfoundation.org> <2076412.mQRaXglRsh@blindfold> <CADnJP=sJE6hpG6inp5Yu+5P2F-d0=6GP-2dAXJTmBOb_rPzgvw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lars,

Am Sonntag, 23. September 2018, 15:49:42 CEST schrieb Lars Persson:
> Hi Richard
> 
> Sorry, I assumed this omission from -stable was a mistake.
> 
> The timing for our boot increased from 45 seconds to 55 seconds on one
> chip and 42 seconds to 48 seconds on another chip. The regression was
> completely fixed by applying the extra patches. The way I see it the
> first patch is a significant slow-down so the second patch is required
> to restore performance.

okay, this is not good. Let's put the performance patch also into -stable
to get rid of that regression.
Usually I'm rather conservative with adding non-trivial material to -stable.
As history has shown, Fastmap is special. ;-)

Out of interest, what flashes are these? I'm interested in page vs. erase size.
Did you give UBIFS bulk-read try?

Greg, I'll send another mail which will state what patches are needed.

Thanks,
//richard



