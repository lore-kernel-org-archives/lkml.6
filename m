Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67696C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266920879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730562;
	bh=M/Mw1T9gpUbpJFs3VlOHoiSn+QL/PPNu/qEEfXLuRjY=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=qUPDGF7o28skhHEgZ6QWg56MY225teDm8vFrzyY2U+Bi8VdVAGlULrq1SklpwShBN
	 yVAPg8AL+QOc/NCP4mGbgP34obZbNKubDGxXNNOnmkOLjbVdrwKAEKB3XWFgd1ZGAa
	 ULEwjBtyhwYeREwRlyhGb3iyY7Gy4dnN5C2CZmCo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3266920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeLMTtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbeLMTtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:49:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C197F20870;
        Thu, 13 Dec 2018 19:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730559;
        bh=M/Mw1T9gpUbpJFs3VlOHoiSn+QL/PPNu/qEEfXLuRjY=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=XpVmNQDU2M9OdMm+uOO02WyUulpqOIB/vm13EBESp6UDdJnzzn+XkuCW1dD+yYIaI
         Si5sAUswxc5urTzs7ux1iNwxAXicS3bdyQlBYe46BorCalh5SeZvr6p+uk+c1/tLxN
         kb4NRkpuorquWc97MQ0p5Mnq5N0a9SXnK+NGbaGE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181206215858.3880-6-sboyd@kernel.org>
Subject: Re: [PATCH 5/8] clk: hisilicon: Remove usage of CLK_IS_BASIC
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20181206215858.3880-1-sboyd@kernel.org> <20181206215858.3880-6-sboyd@kernel.org>
Message-ID: <154473055912.19322.5502157577797157208@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Leo Yan <leo.yan@linaro.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Date:   Thu, 13 Dec 2018 11:49:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-12-06 13:58:55)
> This flag doesn't look to be used by any code, just set in various clk
> init structures and then never tested again. Remove it from these
> drivers as it doesn't provide any benefit.
>=20
> Cc: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Jianguo Sun <sunjianguo1@huawei.com>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

