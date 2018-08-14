Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C4C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E262172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E262172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbeHNTxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:53:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52454 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733064AbeHNTxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:53:03 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E3EF513CED779;
        Tue, 14 Aug 2018 10:05:03 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:05:03 -0700 (PDT)
Message-Id: <20180814.100503.1519932338963499861.davem@davemloft.net>
To:     jcline@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, konrad.wilk@oracle.com, jamie.iles@oracle.com,
        liran.alon@oracle.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: sock_diag: Fix spectre v1 gadget in
 __sock_diag_cmd()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180813222313.3510-1-jcline@redhat.com>
References: <20180813222313.3510-1-jcline@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Aug 2018 10:05:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jcline@redhat.com>
Date: Mon, 13 Aug 2018 22:23:13 +0000

> req->sdiag_family is a user-controlled value that's used as an array
> index. Sanitize it after the bounds check to avoid speculative
> out-of-bounds array access.
> 
> This also protects the sock_is_registered() call, so this removes the
> sanitize call there.
> 
> Fixes: e978de7a6d38 ("net: socket: Fix potential spectre v1 gadget in sock_is_registered")
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: konrad.wilk@oracle.com
> Cc: jamie.iles@oracle.com
> Cc: liran.alon@oracle.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
> 
> Since commit e978de7a6d38 didn't apply cleanly to v4.14, this won't
> either since it reverts that change. To apply cleanly there, the change
> to sock_is_registered() needs to be dropped.

Applied, thank you.
