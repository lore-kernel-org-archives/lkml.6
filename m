Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2547C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0333218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfADUvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:51:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48564 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADUvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:51:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A6DCF14C5C7E6;
        Fri,  4 Jan 2019 12:51:16 -0800 (PST)
Date:   Fri, 04 Jan 2019 12:51:16 -0800 (PST)
Message-Id: <20190104.125116.1758539198737883869.davem@davemloft.net>
To:     peng.hao2@zte.com.cn
Cc:     qiang.zhao@nxp.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, wen.yang99@zte.com.cn,
        julia.lawall@lip6.fr, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND PATCH v5] soc/fsl/qe: fix err handling of
 ucc_of_parse_tdm
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1546448993-17397-1-git-send-email-peng.hao2@zte.com.cn>
References: <1546448993-17397-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Jan 2019 12:51:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>
Date: Thu, 3 Jan 2019 01:09:53 +0800

> From: Wen Yang <wen.yang99@zte.com.cn>
> 
> Currently there are some issues with the ucc_of_parse_tdm function:
> 1, a possible null pointer dereference in ucc_of_parse_tdm,
> detected by the semantic patch deref_null.cocci,
> with the following warning:
> drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
> 2, dev gets modified, so in any case that devm_iounmap() will fail
> even when the new pdev is valid, because the iomap was done with a
>  different pdev.
> 3, there is no driver bind with the "fsl,t1040-qe-si" or
> "fsl,t1040-qe-siram" device. So allocating resources using devm_*()
> with these devices won't provide a cleanup path for these resources
> when the caller fails.
> 
> This patch fixes them.
> 
> Suggested-by: Li Yang <leoyang.li@nxp.com>
> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>

Applied, thanks.
