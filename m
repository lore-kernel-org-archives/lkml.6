Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342CFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F792156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F792156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeI0Jkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:40:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37696 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeI0Jkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:40:55 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DF4B3145796F2;
        Wed, 26 Sep 2018 20:24:50 -0700 (PDT)
Date:   Wed, 26 Sep 2018 20:24:50 -0700 (PDT)
Message-Id: <20180926.202450.236688165629228809.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: Avoid constant logical operation warning in
 qed_vf_pf_acquire
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180924221703.26454-1-natechancellor@gmail.com>
References: <20180924221703.26454-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 20:24:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 24 Sep 2018 15:17:03 -0700

> Clang warns when a constant is used in a boolean context as it thinks a
> bitwise operation may have been intended.
> 
> drivers/net/ethernet/qlogic/qed/qed_vf.c:415:27: warning: use of logical
> '&&' with constant operand [-Wconstant-logical-operand]
>         if (!p_iov->b_pre_fp_hsi &&
>                                  ^
> drivers/net/ethernet/qlogic/qed/qed_vf.c:415:27: note: use '&' for a
> bitwise operation
>         if (!p_iov->b_pre_fp_hsi &&
>                                  ^~
>                                  &
> drivers/net/ethernet/qlogic/qed/qed_vf.c:415:27: note: remove constant
> to silence this warning
>         if (!p_iov->b_pre_fp_hsi &&
>                                 ~^~
> 1 warning generated.
> 
> This has been here since commit 1fe614d10f45 ("qed: Relax VF firmware
> requirements") and I am not entirely sure why since 0 isn't a special
> case. Just remove the statement causing Clang to warn since it isn't
> required.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/126
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
