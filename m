Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04A7C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEBC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfAULf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:35:28 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:37390 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfAULf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:35:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B9950611C98F;
        Mon, 21 Jan 2019 12:35:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U6xOsyJSP6cU; Mon, 21 Jan 2019 12:35:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 60D6A611C999;
        Mon, 21 Jan 2019 12:35:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yd9eQdsat66J; Mon, 21 Jan 2019 12:35:25 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id F0757611C98F;
        Mon, 21 Jan 2019 12:35:24 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     yang.yang29@zte.com.cn
Cc:     richard.weinberger@gmail.com, dwmw2@infradead.org,
        wang.yi59@zte.com.cn, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn
Subject: Re: [PATCH] jffs2: check dstlen for jffs2_zlib_compress()
Date:   Mon, 21 Jan 2019 12:35:24 +0100
Message-ID: <3151900.SLYxvDXFDr@blindfold>
In-Reply-To: <201901211659107381808@zte.com.cn>
References: <201901211659107381808@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 21. Januar 2019, 09:59:10 CET schrieb yang.yang29@zte.com.cn:
> Thanks for reply.
> But I think if (*dstlen < 2) is not good enough.

Not enough in terms of what?
My patch does what the commit message says, it fixes the out of bound access.
What do I miss?

> Because if  the length of data_in is equals to 2, the length of output compressed data is also 2.
> So there's no meaning to do all the compress calculates.
> 
> And I had do an experiment:
> If dstlen equals to 3, and data_in has 3 same bytes, the length of output compressed data will be 2. 
> Which means compress is effective.

This is a different issue and a possible further optimization.

Thanks,
//richard



