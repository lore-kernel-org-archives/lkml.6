Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE62EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB862070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865329;
	bh=EYK7mi8qqtdPUhIo+BK/iu4R2l6ptpNTXxKsPhvIttg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MfYouupSfkCZfkiW40aA3zm0m9+NCex0FJ43dQZ8c945M1DD7hJx6OSyzmwl/AePO
	 fMiPMxiWWe+CvBjR46PFlpko38upQd3wC58NOG8qfO2gyDSfnv321Bl0Pr9xEgoPYI
	 LIy1VzFUUOV/hxNcspff/icUxPj+PYRv7S1Jwmtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeLZWgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbeLZWgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA05921901;
        Wed, 26 Dec 2018 22:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863771;
        bh=EYK7mi8qqtdPUhIo+BK/iu4R2l6ptpNTXxKsPhvIttg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bt/xbZ4la+705aWEsgO7yi/+T8WiNpvCproPwijruzCUrIRqJDl2ZHTSFsKn48PFr
         AT2SHFbaUjiVXPiLagFRB8dr1vT3jYcOfh/pC/N6jD/hDVOeRlE9wCxnSbmjgUKlCl
         jERPb8L/5nzp8k6ao/Yf+s6stgceMwqF/ZZtx6v8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 08/97] ARM: imx: update the cpu power up timing setting on i.mx6sx
Date:   Wed, 26 Dec 2018 17:34:28 -0500
Message-Id: <20181226223557.149329-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

[ Upstream commit 1e434b703248580b7aaaf8a115d93e682f57d29f ]

The sw2iso count should cover ARM LDO ramp-up time,
the MAX ARM LDO ramp-up time may be up to more than
100us on some boards, this patch sets sw2iso to 0xf
(~384us) which is the reset value, and it is much
more safe to cover different boards, since we have
observed that some customer boards failed with current
setting of 0x2.

Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6sx")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-imx/cpuidle-imx6sx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index 243a108a940b..fd0053e47a15 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -110,7 +110,7 @@ int __init imx6sx_cpuidle_init(void)
 	 * except for power up sw2iso which need to be
 	 * larger than LDO ramp up time.
 	 */
-	imx_gpc_set_arm_power_up_timing(2, 1);
+	imx_gpc_set_arm_power_up_timing(0xf, 1);
 	imx_gpc_set_arm_power_down_timing(1, 1);
 
 	return cpuidle_register(&imx6sx_cpuidle_driver, NULL);
-- 
2.19.1

