Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360422083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ornddf1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360422083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeHaVp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeHaVp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:45:28 -0400
Received: from localhost (unknown [104.132.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BEC82083A;
        Fri, 31 Aug 2018 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535737016;
        bh=fLM1jphwbCz14Ksx7swYDIH+ACcc/6kPed91kcGdRXw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Ornddf1LehVL/hOPhMHdOuAhF2hpwifZL9dhlE3cLNJ65akaF2H+R7Bg4V1C6cRAp
         PVxjB3/J2vo/OAOC52k1fhJE9hr6g8UiCkt1qLXB9gM9o2K9483EtyiQrN15lPFjVe
         BEVfm1zg3HWkasiWeVZU8+Wwf9L2FdFMeQwfV5Zs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180726004719.GA9896@embeddedor.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20180726004719.GA9896@embeddedor.com>
Message-ID: <153573701576.93865.614018614668737096@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] reset: hisilicon: fix potential NULL pointer dereference
Date:   Fri, 31 Aug 2018 10:36:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2018-07-25 17:47:19)
> There is a potential execution path in which function
> platform_get_resource() returns NULL. If this happens,
> we will end up having a NULL pointer dereference.
> =

> Fix this by replacing devm_ioremap with devm_ioremap_resource,
> which has the NULL check and the memory region request.
> =

> This code was detected with the help of Coccinelle.
> =

> Cc: stable@vger.kernel.org
> Fixes: 97b7129cd2af ("reset: hisilicon: change the definition of hisi_res=
et_init")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Nobody has reviewed, so I guess applied to clk-next unless someone
complains.

