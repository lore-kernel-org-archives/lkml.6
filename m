Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E03C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBC62083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131533;
	bh=D09tVidnnfp13rRhl6Vak0dqmu4Y8aaegrij5rbK55Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FqR+rVdBAqOOVjIuNlrfxaeNLTWjL8cUf9HlMn4NBySfCfoukPwlb3Mdh+LMlDYH9
	 apo8oiNEO4JtXbX/mU/YHX2vehu6urQliUhS8sCgBlC+zS8uE6hK+Bkn+IGsRnh/Tv
	 TZAp7eoNqIcHfLvGFG5mMZYtyc5yIwCIdAZFqPX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfBYVwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:52:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbfBYVWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E116D217F4;
        Mon, 25 Feb 2019 21:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129774;
        bh=D09tVidnnfp13rRhl6Vak0dqmu4Y8aaegrij5rbK55Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NiJFiox1m+2uKEs+jQG+bGt8ZoGcx4uGLuN6sfDTKrEkamAn41EGN5YuImMEQsGrm
         dm2YwOTVhwniu05pCnMmurWzMahPfcrRg+Mduq2nNEaNQIq7HMtwgws2kVc5KmSmyx
         +t12XsUwRcg4f63GEEbMst2nzcDdHTqbIDnPtsXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dien Pham <dien.pham.ry@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/152] mfd: bd9571mwv: Add volatile register to make DVFS work
Date:   Mon, 25 Feb 2019 22:10:18 +0100
Message-Id: <20190225195045.466762601@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b0aff01e7aa6ad2d6998ef1323843212d1db8b04 ]

Because BD9571MWV_DVFS_MONIVDAC is not defined in the volatile table,
the physical register value is not updated by regmap and DVFS doesn't
work as expected. Fix it!

Fixes: d3ea21272094 ("mfd: Add ROHM BD9571MWV-M MFD PMIC driver")
Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
[wsa: rebase, add 'Fixes', reword commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/bd9571mwv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index 503979c81dae1..fab3cdc27ed64 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -59,6 +59,7 @@ static const struct regmap_access_table bd9571mwv_writable_table = {
 };
 
 static const struct regmap_range bd9571mwv_volatile_yes_ranges[] = {
+	regmap_reg_range(BD9571MWV_DVFS_MONIVDAC, BD9571MWV_DVFS_MONIVDAC),
 	regmap_reg_range(BD9571MWV_GPIO_IN, BD9571MWV_GPIO_IN),
 	regmap_reg_range(BD9571MWV_GPIO_INT, BD9571MWV_GPIO_INT),
 	regmap_reg_range(BD9571MWV_INT_INTREQ, BD9571MWV_INT_INTREQ),
-- 
2.19.1



