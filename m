Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FDCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C4F208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C4F208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeHUJoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:44:20 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:52960 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeHUJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:44:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 85274606D4A1;
        Tue, 21 Aug 2018 08:25:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X11Epb2vHBnL; Tue, 21 Aug 2018 08:25:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 40AF0605A917;
        Tue, 21 Aug 2018 08:25:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J137MLaYxJF4; Tue, 21 Aug 2018 08:25:32 +0200 (CEST)
Received: from blindfold.localnet (089144202104.atnat0011.highway.a1.net [89.144.202.104])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B0296605A915;
        Tue, 21 Aug 2018 08:25:31 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Liu Song <liu.song11@zte.com.cn>
Cc:     dedekind1@gmail.com, adrian.hunter@intel.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: Re: [PATCH] ubifs: remove unnecessary check in ubifs_log_start_commit
Date:   Tue, 21 Aug 2018 08:25:30 +0200
Message-ID: <6703427.thn4Ct9gCO@blindfold>
In-Reply-To: <1534821442-178518-1-git-send-email-liu.song11@zte.com.cn>
References: <1534821442-178518-1-git-send-email-liu.song11@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liu Song,

Am Dienstag, 21. August 2018, 05:17:22 CEST schrieb Liu Song:
> The value of c->lhead_offs cannot exceed max_len which much
> smaller than c->leb_size. So the check will never be true.
> Just remove it.

Please explain in more detail why this case is never ever possible.
Removing such code needs a good justification. 

In general I don't much like such changes for two reasons:
1. They don't fix a problem
2. They are likely to introduce very hard to debug new issues if they are wrong

Thanks,
//richard


