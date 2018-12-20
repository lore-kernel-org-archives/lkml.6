Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2812176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbeLTKpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:45:41 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:39562 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeLTKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:45:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 40EAE608A3A5;
        Thu, 20 Dec 2018 11:45:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6C2j1tvITbBT; Thu, 20 Dec 2018 11:45:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D18A2608A3AD;
        Thu, 20 Dec 2018 11:45:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dYOE1HfC68eR; Thu, 20 Dec 2018 11:45:38 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 835F8608A3A5;
        Thu, 20 Dec 2018 11:45:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] jffs2: Fix integer underflow in jffs2_rtime_compress
Date:   Thu, 20 Dec 2018 11:45:37 +0100
Message-ID: <2142335.HPRDAJu19m@blindfold>
In-Reply-To: <cae86ca1-91f9-6728-df64-40580145220d@huawei.com>
References: <20181215162350.12489-1-richard@nod.at> <cae86ca1-91f9-6728-df64-40580145220d@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 20. Dezember 2018, 11:43:08 CET schrieb Hou Tao:
> 
> On 2018/12/16 0:23, Richard Weinberger wrote:
> > The rtime compressor assumes that at least two bytes are
> > compressed.
> > If we try to compress just one byte, the loop condition will
> > wrap around and an out-of-bounds write happens.
> > 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> >  fs/jffs2/compr_rtime.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > It seems that it doesn't incur any harm because the minimal allocated
> size will be 8-bytes and jffs2_rtime_compress() will write 2-bytes into
> the allocated buffer.

Are you sure about that? I saw odd kernel behavior and KASAN complained too.

Thanks,
//richard


