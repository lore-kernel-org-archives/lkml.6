Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12F42087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130092;
	bh=Pra884Ep8Q6WU36LXz6iJVf1WzW2qgSOAcrIAwe6XHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g1K//XNivNF/wuykhRQsYZCKmZLq/rToACuo4uFhjqpECrNUZXGICYexsuYmfVP3t
	 eFG4puuEEU8r+INUBYlZ5J/ZHbPPmSAV+qxuC3JhXna3FWY4UIv1qjnX1y4mboPCJF
	 hx7L83ocV5W9drtWV3oV8Zj5v/4aqI5AngZ64zek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfBYV2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbfBYV2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3922087C;
        Mon, 25 Feb 2019 21:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130088;
        bh=Pra884Ep8Q6WU36LXz6iJVf1WzW2qgSOAcrIAwe6XHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R61KkrxzX5NptDP1VAiZGiUUi+5/QhgJdFncvi5tZRsp/1JZXB91mW7JesIbV9DHR
         jCxeo6CXGhGw0VcCLohcmII+COl5gEcNRsTgxxf822M3l51+DDilqBgyvZsFGm3aOQ
         5MtEx1UzhT3wgPKSOyarSEkQGMQwd2Rofusz7NmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.20 011/183] pinctrl: qcom: qcs404: Correct SDC tile
Date:   Mon, 25 Feb 2019 22:09:44 +0100
Message-Id: <20190225195056.536631247@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit a5a08c35d382a5a8da397260c3febb8dff4bdeef upstream.

The SDC controls live in the south tile, not the north one. Correct this
so that we program the right registers.

Cc: stable@vger.kernel.org
Fixes: 22eb8301dbc1 ("pinctrl: qcom: Add qcs404 pinctrl driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/qcom/pinctrl-qcs404.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -79,7 +79,7 @@ enum {
 		.intr_cfg_reg = 0,			\
 		.intr_status_reg = 0,			\
 		.intr_target_reg = 0,			\
-		.tile = NORTH,				\
+		.tile = SOUTH,				\
 		.mux_bit = -1,				\
 		.pull_bit = pull,			\
 		.drv_bit = drv,				\


